\version "2.18.0"
\language "english"

% time macro used to insert date in header
date = #(strftime "%m/%d/%Y" (localtime (current-time)))

% Variables pulled out of 'header' and 'paper' to make changing them easier
myTitle = "Choir Arrangement"
mySubtitle = "SATB w/Piano and Violin accompaniment" % set to null to remove
myVersion = "(version 2.7)"

myComposer = "Music:  Composer (date range)"
myPoet = "Text:  Lyricist (date range)"
myArranger = "Arranged by ME"

myCopyright = "Copyright information"
myContactInfo = "placeholder"
myTagline = "Enter tagline info here"

% This macro will combine full rests into one clean indicator.
MergeRests = { 
  \revert MultiMeasureRest #'staff-position
  \compressFullBarRests
  \override MultiMeasureRest #'expand-limit = #1
  \override Rest #'staff-position = #0
  \override MultiMeasureRest #'staff-position = #2
}

% Set variables that apply to each voice
global = {
  \key c \major
  \numericTimeSignature
  \time 4/4
  \tempo "Tempo Text" 4=60-212
  \MergeRests
}

% These parts are placeholders only
violin = \relative c'' { \global c1 }
soprano = \relative c'' { \global c1 \bar "|." }
alto = \relative c' { \global c1 }
tenor = \relative c' { \global c1 }
bass = \relative c { \global c1 }
verse = \lyricmode { Temp }

sopranoVerse = \lyricmode { }
altoVerse = \lyricmode { }
tenorVerse = \lyricmode { }
bassVerse = \lyricmode { }

% Function that allows the creation of MIDI rehearsal files
rehearsalMidi = #
(define-music-function
 (parser location name midiInstrument lyrics) (string? string? ly:music?)
 #{
   \unfoldRepeats <<
     \new Staff = "soprano" \new Voice = "soprano" { s1*0\f \soprano }
     \new Staff = "alto" \new Voice = "alto" { s1*0\f \alto }
     \new Staff = "tenor" \new Voice = "tenor" { s1*0\f \tenor }
     \new Staff = "bass" \new Voice = "bass" { s1*0\f \bass }
     \context Staff = $name {
       \set Score.midiMinimumVolume = #0.5
       \set Score.midiMaximumVolume = #0.5
       \set Score.tempoWholesPerMinute = #(ly:make-moment 100 4)
       \set Staff.midiMinimumVolume = #0.8
       \set Staff.midiMaximumVolume = #1.0
       \set Staff.midiInstrument = $midiInstrument
     }
     \new Lyrics \with {
       alignBelowContext = $name
     } \lyricsto $name $lyrics
   >>
 #})

% Pedal shorthand macros
PDn = \sustainOn
PUp = \sustainOff
Ped = \PUp\PDn

right = \relative c'' { \global c1 }
left = \relative c { \global \set Staff.pedalSustainStyle = #'bracket c1\PDn \bar "|." }

%%% This pulls in specific content and replaces all that is listed above.
\include "content.ly"

\paper {
  #(set-paper-size "letter") % Without this line paper size defaults to a4
  top-margin = 0.4\in
  left-margin = 0.5\in
  right-margin = 0.5\in  
  bottom-margin = 0.4\in
  
  two-sided = ##f % set to true for hole-punched copies
  inner-margin = 0.4\in
  outer-margin = 0.4\in
  binding-offset = 0.2\in
  
  #(define fonts
     (make-pango-font-tree
      "Perpetua"
      "Arial Narrow"
      "Alex Brush"
      (/ staff-height pt 20)))
  
  system-system-spacing #'basic-distance = #15     % sets spacing between staves
}


\header {
  title = \markup {
    \abs-fontsize #36
    \typewriter
    \myTitle 
  }
  
  subtitle = \markup { \sans \mySubtitle }
  
  subsubtitle = \markup {
    \abs-fontsize #10
    \sans
    \myVersion 
  }
  
  composer = \markup { \sans \myComposer }
  poet = \markup { \sans\myPoet } 
  arranger = \markup { \sans \myArranger }
  
  copyright = \markup \abs-fontsize #8 {
    \center-column {
      \bold \line { "Copyright" \char ##x00A9 \myCopyright }
      \line { "Revision Date:" \italic \date }
      \bold \myContactInfo 
      \null 
    }
  }
  
  tagline = \markup \abs-fontsize #7 { \myTagline }
}


\paper {
  #(set-paper-size "letter") % Without this line paper size defaults to a4
  top-margin = 0.4\in
  left-margin = 0.5\in
  right-margin = 0.5\in  
  bottom-margin = 0.4\in
  
  two-sided = ##f % set to true for hole-punched copies
  inner-margin = 0.4\in
  outer-margin = 0.4\in
  binding-offset = 0.2\in
  
  #(define fonts
     (make-pango-font-tree
      "Perpetua"
      "Arial Narrow"
      "Alex Brush"
      (/ staff-height pt 20)))
  
  system-system-spacing #'basic-distance = #15     % sets spacing between staves
}




violinPart = \new Staff \with {
  instrumentName = "Violin"
  shortInstrumentName = "Vl."
  midiInstrument = "violin"
} \violin


choirPart = \new ChoirStaff 
<<
  \new Staff \with {
    midiInstrument = "choir aahs"
    instrumentName = \markup \center-column { "Soprano" "Alto" }
    shortInstrumentName = \markup \center-column { "S." "A." }
  }
  << 
    \new Voice = "soprano" 
    { \voiceOne \soprano } 
    
    \new Voice = "alto" 
    { \voiceTwo \alto } 
  >>
  \new Lyrics \with {
    \override VerticalAxisGroup #'staff-affinity = #CENTER
  } \lyricsto "soprano" \verse 
  
  \new Staff \with {
    midiInstrument = "choir aahs"
    instrumentName = \markup \center-column { "Tenor" "Bass" }
    shortInstrumentName = \markup \center-column { "T." "B." }
  }
  << 
    \clef bass
    \new Voice = "tenor" 
    { \voiceOne \tenor } 
    
    \new Voice = "bass" 
    { \voiceTwo \bass } 
  >>
>> 

% This section is used to add context to the rehearsal parts
choirPartMIDI = \new ChoirStaff 
<<
  \new Staff \with {
    midiInstrument = "choir aahs"
    midiMaximumVolume = 0.5
    midiMinimumVolume = 0.3
  }
  << 
    \new Voice = "soprano" 
    { \voiceOne \soprano } 
    
    \new Voice = "alto" 
    { \voiceTwo \alto } 
  >>
  
  \new Staff \with {
    midiInstrument = "choir aahs"
    midiMaximumVolume = 0.5
    midiMinimumVolume = 0.3
  }
  << 
    \clef bass
    \new Voice = "tenor" 
    { \voiceOne \tenor } 
    
    \new Voice = "bass" 
    { \voiceTwo \bass } 
  >>
>> 


pianoPart = \new PianoStaff \with {
  instrumentName = "Piano"
  shortInstrumentName = ""
} <<
  \new Staff = "right" \with {
    midiInstrument = "acoustic grand"
  } \right
  \new Staff = "left" \with {
    midiInstrument = "acoustic grand"
  } { \clef bass \left }
>>


%%% Full score, octavo for publication
\book {
  \header {
    title = \markup {
      \abs-fontsize #30
      \typewriter
      \myTitle 
    }
    
    subtitle = \markup {
      \sans
      \abs-fontsize #11
      \mySubtitle
    }
  }
  
  \paper {
    #(set-paper-size "octavo")
    top-margin = 0.5\in
  }
  
  \score {
    <<
      \violinPart
      \choirPart
      \pianoPart
    >>


    \layout {
      #(layout-set-staff-size 16)					% staff size, default is 20
      \set Score.markFormatter = #format-mark-box-alphabet 		% use a box and letters for rehearsal marks
      %\override Score.BarNumber #'break-visibility = ##(#f #t #t) 	% add bar numbers to every measure but the first
      \override Score.BarNumber #'font-shape = #'italic 
      \override LyricSpace #'minimum-distance = #1.0			% sets the spacing between words in the lyric line
      
      % Add padding above and below lyrics  
      \context {
        \Lyrics
        \override VerticalAxisGroup #'nonstaff-relatedstaff-spacing
        #'padding = #1.5	% adds some space above lyrics
        \override VerticalAxisGroup #'nonstaff-unrelatedstaff-spacing
        #'padding = #2.2	% adds some space below lyrics
      }
      
      % Removes staves when they are empty
      \context {
        \Staff \RemoveEmptyStaves 				% remove empty staves except from first system
        \override VerticalAxisGroup #'remove-first = ##t  	% remove empty staves from the first system
      }
      
    }
    
    
    % this change comes from lsr.di.unimi.it/LSR/Item0fbe.html?id=438
    % outputs a seperate midi file for each voice on a staff
    \midi { 
      % remove 'Staff_performer from Staff context
      \context { 
        \Staff
        \remove "Staff_performer"
      }
      
      % and put it in Voice context for separate tracks
      \context { 
        \Voice
        \consists "Staff_performer"   
      }
    }
  }
}

%%% Full score, full-sized for accompanist
\book {
  \bookOutputSuffix "full"
  \score {
    <<
      \violinPart
      \choirPart
      \pianoPart
    >>
    
    
    \layout {
      %#(layout-set-staff-size 17)					% staff size, default is 20
      \set Score.markFormatter = #format-mark-box-alphabet 		% use a box and letters for rehearsal marks
      %\override Score.BarNumber #'break-visibility = ##(#f #t #t) 	% add bar numbers to every measure but the first
      \override Score.BarNumber #'font-shape = #'italic 
      \override LyricSpace #'minimum-distance = #1.0			% sets the spacing between words in the lyric line
      
      % Add padding above and below lyrics  
      \context {
        \Lyrics
        \override VerticalAxisGroup #'nonstaff-relatedstaff-spacing
        #'padding = #1.5	% adds some space above lyrics
        \override VerticalAxisGroup #'nonstaff-unrelatedstaff-spacing
        #'padding = #2.2	% adds some space below lyrics
      }
      
      % Removes staves when they are empty
      \context {
        \Staff \RemoveEmptyStaves 				% remove empty staves except from first system
        \override VerticalAxisGroup #'remove-first = ##t  	% remove empty staves from the first system
      }
      
    }
  }
}


%%% Choir music only
\book {
  \bookOutputSuffix "choir"
  \score {
    <<
      \choirPart
    >>
    
    
    \layout {
      %#(layout-set-staff-size 17)					% staff size, default is 20
      \set Score.markFormatter = #format-mark-box-alphabet 		% use a box and letters for rehearsal marks
      %\override Score.BarNumber #'break-visibility = ##(#f #t #t) 	% add bar numbers to every measure but the first
      \override Score.BarNumber #'font-shape = #'italic 
      \override LyricSpace #'minimum-distance = #1.0			% sets the spacing between words in the lyric line
      
      % Add padding above and below lyrics  
      \context {
        \Lyrics
        \override VerticalAxisGroup #'nonstaff-relatedstaff-spacing
        #'padding = #1.5	% adds some space above lyrics
        \override VerticalAxisGroup #'nonstaff-unrelatedstaff-spacing
        #'padding = #2.2	% adds some space below lyrics
      }
      
      % Removes staves when they are empty
      \context {
        \Staff \RemoveEmptyStaves 				% remove empty staves except from first system
        \override VerticalAxisGroup #'remove-first = ##t  	% remove empty staves from the first system
      }
      
    }
  }
}


%%% Soloist music only
\book {
  \bookOutputSuffix "solo"
  \score {
    <<
      \violinPart
    >>
    
    
    \layout {
      %#(layout-set-staff-size 17)					% staff size, default is 20
      \set Score.markFormatter = #format-mark-box-alphabet 		% use a box and letters for rehearsal marks
      %\override Score.BarNumber #'break-visibility = ##(#f #t #t) 	% add bar numbers to every measure but the first
      \override Score.BarNumber #'font-shape = #'italic 
      \override LyricSpace #'minimum-distance = #1.0			% sets the spacing between words in the lyric line
      
      % Add padding above and below lyrics  
      \context {
        \Lyrics
        \override VerticalAxisGroup #'nonstaff-relatedstaff-spacing
        #'padding = #1.5	% adds some space above lyrics
        \override VerticalAxisGroup #'nonstaff-unrelatedstaff-spacing
        #'padding = #2.2	% adds some space below lyrics
      }
      
      % Removes staves when they are empty
      \context {
        \Staff \RemoveEmptyStaves 				% remove empty staves except from first system
        \override VerticalAxisGroup #'remove-first = ##t  	% remove empty staves from the first system
      }
      
    }
  }
}

% Rehearsal MIDI files:
\book {
  \bookOutputSuffix "soprano"
  \score {
    <<
      \rehearsalMidi "soprano" "soprano sax" \sopranoVerse
      
      % comment out the following lines if you want the part by itself
      \choirPartMIDI
      \pianoPart
    >>
    \midi { }
  }
}

\book {
  \bookOutputSuffix "alto"
  \score {
    <<
      \rehearsalMidi "alto" "soprano sax" \altoVerse
      
      % comment out the following lines if you want the part by itself
      \choirPartMIDI
      \pianoPart
    >>
    \midi { }
  }
}

\book {
  \bookOutputSuffix "tenor"
  \score {
    <<
      \rehearsalMidi "tenor" "tenor sax" \tenorVerse
      
      % comment out the following lines if you want the part by itself
      \choirPartMIDI
      \pianoPart
    >>
    \midi { }
  }
}

\book {
  \bookOutputSuffix "bass"
  \score {
    <<
      \rehearsalMidi "bass" "tenor sax" \bassVerse
      
      % comment out the following lines if you want the part by itself
      \choirPartMIDI
      \pianoPart
    >>
    \midi { }
  }
}
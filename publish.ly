\version "2.18.0"
\language "english"

% time macro used to insert date in header
date = #(strftime "%m/%d/%Y" (localtime (current-time)))

% Variables pulled out of 'header' and 'paper' to make changing them easier
myTitle = "Choir Arrangement"
mySubtitle = "SATB w/Piano and Violin accompaniment" % set to null to remove
myVersion = "(version 2.7)"

myComposer = "Music:  Composer F. Music (1844 - 1899)"
myPoet = "Text:  Lyricist O. Words (1877 - 1930)"
myArranger = "Arranged by Brent M. Boylan"

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


violin = \relative c'' {
  \global
  
  c1
  
  \bar "|."
}


soprano = \relative c'' {
  \global
  
  %R1*8
  c1
  
  \bar "|."
}


alto = \relative c' {
  \global
  
  %R1*8
  c1
  
  \bar "|."
}


tenor = \relative c' {
  \global
  
  %R1*8
  c1
  
  \bar "|."
}


bass = \relative c {
  \global
  
  %R1*8
  c1
  
  \bar "|."
}


verse = \lyricmode {
  Temp
  
}


right = \relative c'' {
  \global
  
  c1
  
}

% Pedal shorthand macros
PDn = \sustainOn
PUp = \sustainOff
Ped = \PUp\PDn


left = \relative c {
  \global
  \set Staff.pedalSustainStyle = #'bracket
  
  c1\PDn 
  
  \bar "|."
}


%%% This pulls in specific content and replaces all that is listed above.
%\include "content.ly"


\header {
  title = \markup {
    \vspace #8 \left-align \center-column {
      \abs-fontsize #46 \override #'(font-name . "Alex Brush") \bold
      \myTitle
      
      \abs-fontsize #20 \override #'(font-name . "Arial Narrow") \bold
      \mySubtitle
      
      \vspace #4
      \abs-fontsize #14 \override #'(font-name . "Arial Narrow")
      \myComposer
      
      \abs-fontsize #14 \override #'(font-name . "Arial Narrow")
      \myPoet
      
      \vspace #2
      \abs-fontsize #18 \override #'(font-name . "Arial Narrow")
      \myArranger
      
      \vspace #25
      \fill-line {
        
        \column {
          \vspace #.9
          \override #'(line-width . 30)
          \abs-fontsize #7 \wordwrap {
            Visit our website to learn more about
            other great arrangements.
          }
        }
        
        \abs-fontsize #8 \column  {
          \bold \fontsize #4 \caps "As A River Publishing"
          "P.O. Box 33, Manti, UT  84642"
          \bold \fontsize #2 "asariver.com"
        }
        
        
      }
    
    
    }
  }
  tagline = ##f
}

\paper {
  #(set-paper-size "octavo")
  
}

\markup \null


\markup {
  \fill-line {
    \column {
      \left-align {
        \vspace #36
        \override #'(line-width . 70)
        \left-align \abs-fontsize #11 \wordwrap   { 
          
          This is where I will say nice things about
          myself so people will want to buy more of
          my music. It will be witty and fun and include
          things about myself, my family, my hobbies,
          etc.
        }
        
        \vspace #2
        \override #'(line-width . 70)
        \left-align \abs-fontsize #11 \wordwrap   {
          
          Does this make a new paragraph? Or do I need to
          use another tag? Now can have even more
          great information about myself for people
          to read.
          
        }

        
      }
    }
  }
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


\bookpart {
  \header {
  title = \markup {
    \abs-fontsize #42  % 18 to 22
    \override #'(font-name . "Alex Brush") % change title font here
    \myTitle 
  }  % change variable above
  
  subtitle = \markup {
    \abs-fontsize #14
    \override #'(font-name . "Arial Narrow")
    \mySubtitle 
  }
  
  % I like to include a version number and update manually as changes are made
  subsubtitle = \markup {
    \abs-fontsize #12
    \override #'(font-name . "Arial Narrow")
    \myVersion 
  }
  
  composer = \markup {
    \override #'(font-name . "Arial Narrow")
    \myComposer
  } % For arrangements, my preference is to include the words Music: and Text:
  
  poet = \markup {
    \override #'(font-name . "Arial Narrow")
    \myPoet
  } % followed by the names, birth, and death years, if known
  
  arranger = \markup {
    \override #'(font-name . "Arial Narrow")
    \myArranger
  } % Comment out or delete this line if not needed
  
  copyright = \markup \abs-fontsize #8 {
    \center-column {
      \line { "Copyright" \char ##x00A9 \myCopyright }
      \line { "Revision Date:" \italic \date }
      %\myContactInfo 
      \null 
    }
  }
  
  tagline = \markup {
    \column {
      \fill-line {
        \abs-fontsize #7 \column  {
          \bold \caps "As A River Publishing"
          "P.O. Box 33, Manti, UT  84642"
          \bold "asariver.com"
        }
        
        \column {
          \override #'(line-width . 20)
          \abs-fontsize #7 \wordwrap {
            Visit our website to learn more about
            other great arrangements for your choir.
          }
        }
      }
    }
  }
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


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

% Pedal shorthand macros
PDn = \sustainOn
PUp = \sustainOff
Ped = \PUp\PDn

right = \relative c'' { \global c1 }
left = \relative c { \global \set Staff.pedalSustainStyle = #'bracket c1\PDn \bar "|." }


%%% This pulls in specific content and replaces all that is listed above.
\include "content.ly"

\paper {
  #(set-paper-size "octavo")
  #(define fonts
     (make-pango-font-tree
      "Perpetua"
      "Arial Narrow"
      "Alex Brush"
      (/ staff-height pt 20)))
}

\header {
  \markup {
    \vspace #7 \left-align \center-column {
      \abs-fontsize #46 \typewriter
      \myTitle
      
      \vspace #1
      \abs-fontsize #16 \sans
      \mySubtitle
      
      \vspace #1
      \override #'(thickness . 4 )
      \draw-hline
      
      \vspace #-0.6
      \override #'(thickness . 4 )
      \draw-hline
      
      \vspace #3
      \abs-fontsize #16 \sans
      \myComposer
      
      \abs-fontsize #16 \sans
      \myPoet
      
      \vspace #2
      \abs-fontsize #16 \sans
      \myArranger
      
      \vspace #8
      
      \line{ \epsfile #X #80 #"As a river.eps"}
      
      \vspace #3
      
      \override #'(thickness . 4 )
      \draw-hline
      
      \vspace #-0.6
      \override #'(thickness . 4 )
      \draw-hline
      
      \vspace #0.5
      
      \fill-line {
        
        \column {
          \vspace #0.3
          \override #'(line-width . 20)
          \abs-fontsize #8 \italic \wordwrap {
            Visit our website to learn more about
            other great arrangements for your choir.
          }
        }
        
        \abs-fontsize #10 \column  {
          \bold \fontsize #2 \caps "As A River Publishing"
          "P.O. Box 33, Manti, UT  84642"
          \bold "asariver.com"
        }
      }
    }
  }
  tagline = ##f
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
    \abs-fontsize #40 \typewriter
    \myTitle 
  }
  
  subtitle = \markup {
    \abs-fontsize #12 \sans
    \mySubtitle 
  }
    
  subsubtitle = \markup {
    \abs-fontsize #10 \sans
    \myVersion 
  }
  
  composer = \markup {
    \sans
    \myComposer
  }
  
  poet = \markup {
    \sans
    \myPoet
  }
  
  arranger = \markup {
    \sans
    \myArranger
  } 
  
  copyright = \markup \abs-fontsize #9 {
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
        \abs-fontsize #9 \column  {
          \bold \fontsize #2 \caps "As A River Publishing"
          "P.O. Box 33, Manti, UT  84642"
          \bold "asariver.com"
        }
        
        \column {
          \vspace #1.49
          \override #'(line-width . 50)
          \abs-fontsize #8 \wordwrap {
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
  }
}


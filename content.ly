\version "2.18.0"
%%% This file allows for 'Separation Of Concerns' when creating your music
%%% It is 'include'(d) into the main file in a way that replaces the default
%%% placeholders.

%%% Save the master file with the name of your piece in its own folder. Save
%%% this file in the same folder with the name 'content.ly'

% Variables pulled out of 'header' to make changing them easier
myTitle = "SATB Choir Arrangement"
mySubtitle = "SATB with Piano accompaniment" % set to null to remove
myVersion = "(version 1.0)"

myComposer = "Music: Composer"
myPoet = "Text: Lyricist"
myArranger = "Arranged by Brent M Boylan"

myCopyright = "2014 by Brent M Boylan"
myContactInfo = "ALL RIGHTS RESERVED"
myTagline = \markup {
  \center-column {
    \bold "As A River Publishing"
    "33 South 500 West"
    "Manti, Utah  84642"
    "AsARiver.com"
  }
}

global = {
  \key af \major
  \numericTimeSignature
  \time 3/4
  \tempo "Tempo Text" 4=60-212
  \MergeRests
}

% Music goes here:
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

sopranoVerse = \lyricmode { }
altoVerse = \lyricmode { }
tenorVerse = \lyricmode { }
bassVerse = \lyricmode { }

right = \relative c'' {
  \global
  
  c1
  
}


left = \relative c {
  \global
  \set Staff.pedalSustainStyle = #'bracket
  
  c1\PDn 
  
  \bar "|."
}
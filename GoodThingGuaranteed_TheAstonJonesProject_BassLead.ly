\version "2.18.2"
\include "realbook_style.ly.inc"

originalKey = d
newKey = c

h_title = "Good Thing Guaranteed"    
h_composer = "The Aston Jones Project"
h_meter =  \markup \column {"Funk" #(
  if (not (equal? newKey originalKey))       
        (markup 
          (note-name->markup newKey #f)
          "(orig. "
          (note-name->markup originalKey #f)
          ")"
         )
  ) }


% Intro
chordsIntro = \chordmode {
 \repeat unfold 4 { d2:7 g2:7 }   
}

bassMainGroove  = \relative c {
  d4  fis,4 g16 g r a r a c d \laissezVibrer
}

bassMainFill = \relative c {
  r16 as' g f 
 r f e d 
 r c' b a 
 b c f,8 
}


bassIntro = \relative c {
 \repeat percent 3 { \bassMainGroove  }
 \bassMainFill
}

% Verse
chordsVerse = \chordmode {
  \repeat volta 2 {
    \repeat percent 3 {d2:7 g2:7 } 
  }
  \alternative {
    { 
      d2:7 g2:7 
    }
    { 
      d2.:7 gis8.:7  g16:7 |
    }
  }
  
}

bassVerse = \relative c {
  \repeat volta 2 {
  \repeat percent 3 { \bassMainGroove  }
  }
  \alternative {
    { 
      \bassMainFill 
    }
    { 
      r16 as' g f 
      r f e d 
      r c' b a 
      b c8 g 16~
    }
  }
 
}

% Pre-Chorus
chordsPreChorus = \chordmode {
  g1:7 | g1:7 | e1:7 \break
  \time 2/4  a2:7 
  \time 4/4 s1 
}

bassPreChorusLick = \relative c'' {
  r16 as\1 g f
  r16 c\2 b\2 a\2
  r16 as\3 g\3 f\3
  f\3 g\3 g8\3
}

bassPreChorus = \relative c {
  g'4 b,4 c16 c r d r d e g~ |
  g4 b,4 c16 c r d r d' e <as e,>~ | 
  4 d,,4 cis8 c16 b~ b4 | 
  \time 2/4  a8 a16 a r a8 a16 
  \time 4/4 
<< \bassPreChorusLick
  \new TabStaff 
  \with {
    stringTunings = #bass-tuning
    } {
      \transpose c c, {
        \bassPreChorusLick
    }
    }
  
  >>}

% Chorus
chordsChorus = \chordmode {
  \repeat percent 7 {d2:7 g2:7 }
}

bassChorus = \relative c {
 \repeat percent 7 { s1 }
}

% Bridge
chordsBridge = \chordmode {
  b1:sus4.13 | 
  bes1:maj7 | 
  e:m9 | 
  e2:m9 fis:7 | \break
  b2.:sus4.13 ~ s16 bes8.:sus4.13 |
  a2.:sus4.13 f8:m9 e8:m9 ~ |
  e1:m9 | 
  \time 2/4  a2:13-
  \time 4/4 s1
}

bassBridge = \relative c {
  b4~b8. fis'16 b4~b8 fis16 b,16 | 
  bes4~bes8. f'16 bes f bes,8~bes8 d16 b |
  \grace d16 e8 e,~e4~e8 b'16 b d b d b | 
  \grace d16 e8 e,~e4 fis'4. fis16 cis |
  b4.~b16 cis16 b'4~16 bes8.  |
  a4.~16 e16 a,4 g8 e8 ~ |
  e4 g8. g16 a8 b16 e,16~e4  |
  \time 2/4  a8 a16 a r16 a8 a16
  \time 4/4 
  r16 as''\1 g f
  r16 c\2 b\2 a\2
  r16 as\3 g\3 f\3
  g4\3
  
}

% end
\parallelMusic chordsEnd,bassEnd {

  \sectionLabel \markup { \rounded-box { End } }
  \repeat volta 3 {
    \repeat percent 4 {
      \chordmode  { d2:7 g2:7} |
      \relative c { s1  }  |
    } 
  }
  \alternative {
    { 
      \chordmode  { d2:7 g2:7} |
      \relative c { s1  }  |
    }
    { 
      \chordmode  { d2:7 g2:7} |
      \relative c { 
         r16 as' g f 
        r f e d 
        r c' b a 
        <c, e'> <cis f'> <d fis'>8 
        }  |
      }
  }

}


\book {

% Set the output suffix to the new key if it is different from the original key
#(if (not (equal? newKey originalKey)) #{
  \bookOutputSuffix  #(note-name->string newKey)
#})

\score {
  
  \header {
    title = \h_title  
    composer = \h_composer
    meter =  \h_meter
  }

  <<
    \new ChordNames 
    \chordmode {
      \tempo 4 = 72
      \transpose \originalKey \newKey { 
        s1
        \chordsIntro \break
        \repeat volta 2 {
          \chordsVerse
          \chordsPreChorus
          \chordsChorus
          \alternative {
            { s1 }
            { s1 }
          }
        }
        \chordsBridge \break
        \chordsEnd
      }
      
    }
    
    \new Staff  {
      \context Voice = "bass" 
      \clef bass   
      \numericTimeSignature
      \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
      \transpose \originalKey \newKey { 
        \key g \major { 
          \sectionLabel \markup { \rounded-box { Intro } }
          s1 \bar "||"
          \bassIntro 
          
          \repeat volta 2 {
            \sectionLabel \markup { \rounded-box { Verse } }
            \bassVerse \break
            \sectionLabel \markup { \rounded-box { Pre-Chorus } }
            \bassPreChorus \break
            \sectionLabel \markup { \rounded-box { Chorus } }
            \bassChorus
            \alternative {
              { s1 }
              \relative c { r2 r4 a8 b }
            }
          } \break
          \sectionLabel \markup { \rounded-box { Bridge } }
          \bassBridge
          \bassEnd
        }
         
      }
    }

  >>
}
}

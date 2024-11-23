\version "2.18.2"
\include "realbook_style.ly.inc"

originalKey = d
newKey = d

myheader = \header {
    title = "Sound of Muzak"    
    composer = "Porcupine Tree"
    meter =  \markup \column { "Rock" #(
    if (not (equal? newKey originalKey))       
            (markup 
            (note-name->markup newKey #f)
            "(orig. "
            (note-name->markup originalKey #f)
            ")"
            )
    ) }
}

\score  {
    \myheader
    \compressMMRests \relative c{   
        \clef bass
        \tempo 4 = 95
        
        \time 7/4 

        \section
        \sectionLabel "Intro"
        R1*7/4 * 2 |
        \section
        \sectionLabel "Verse"
        R1*7/4 * 4
        \section
        \sectionLabel "Pre-Chorus"
        R1*7/4 * 4
        \break

        \section
        \sectionLabel "Chorus"
        \numericTimeSignature
        \time 4/4
        \repeat volta 2 {    
            d8. 16 r a d f~8 e c[ a] |
            d8. 16 r a d f~8 e c16 a c r | \break
            c8. 16 r a c g'~8 c, g[ c] |
            bes8. 16 r f bes bes~8 f bes[ c] |
        }
        \break

        \section \sectionLabel "Interlude"
        \time 7/4
        R1*7/4 * 2
        
        \section \sectionLabel "Verse"
        R1*7/4 * 4
        
        \section \sectionLabel "Pre-Chorus"
        R1*7/4 * 4
        \break
        
        \section \sectionLabel "Chorus"
        \numericTimeSignature
        \time 4/4
        R1*8^\markup "Groove" |
        R1*8^\markup "Groove" |
        \break
        
        \section \sectionLabel "Break"
        \time 7/4
        R1*7/4 * 2
        \break
        
        \section \sectionLabel "Solo"
        \time 7/4
        d2~4 c1 | g2~4 bes2~8 a bes c |
        d2~4 c2~8 g' c, d | g,2~4 bes2~8 a c f \bar "||"
        \break

        d2~8 a c2~8 g' c, d | g,2~4 bes2~8 a bes f' |
        d2~8 a c2~8 g' c, d | g,2~4 bes2~8 a bes f' \bar "||"
        \break

        d2~8 a c2~8 g' c, d | g,2~4 bes2~8 a bes f' |
        d2~8 a c2 g'8 c, bes a | g2~4 bes2~8 a c f |
        \break
        
        \section \sectionLabel "Verse"
        \time 4/4
        R1*8^\markup "Guitar only"

        \section \sectionLabel "Chorus"
        R1*8^\markup "Groove" |
        R1*8^\markup "Groove" |
        R1*8^\markup "Groove" |

        \section \sectionLabel "End"
        s1

    }



}
% Kid Charlemange - Steely Dan (Bass)
%
% transcription by Pieter Kitslaar
%

\version "2.14.0"
#(ly:set-option 'midi-extension "mid")

% first, define a variable to hold the formatted date:
date = #(strftime "%d-%m-%Y" (localtime (current-time)))

#(use-modules (ice-9 popen))
#(use-modules (ice-9 rdelim))
%commit =
%#(let* ((port (open-pipe* OPEN_READ "git" "rev-parse" "--short" "HEAD"))
 %       (str  (read-line port)))
  % (close-pipe port)
  % str)

%combined_version = #(string-append "commit: " commit " date: " date)

\header {
  title = "Kid Charlemange (Bass)"
  subtitle = "Steely Dan"
  date = \date
  %tagline = \combined_version
  composer = "D. Fagen & W. Becker"
  arranger = "transcription by Pieter Kitslaar"
  %meter = "* Notes sound octave lower than written"
}

\layout {
  \context {
    \Voice
    \remove "Note_heads_engraver"
    \consists "Completion_heads_engraver"
    \remove "Rest_engraver"
    \consists "Completion_rest_engraver"
  }
}

% taken from http://lilypond.1069038.n5.nabble.com/Function-to-add-articulation-to-all-notes-td208433.html
addArticulation = 
#(define-music-function (event music) (ly:event? ly:music?) 
   (define (add mus) 
     (if (not (memq 'articulations ; Don't add staccato if there already exist an articulation 
                (map car (ly:music-mutable-properties mus)))) 
         (ly:music-set-property! mus 'articulations (list event)))) 
   (for-some-music 
    (lambda (mus) 
      (cond 
       ((music-is-of-type? mus 'event-chord) (add mus)) 
       ((music-is-of-type? mus 'note-event) (add mus)) 
       (else #f))) 
    music) 
   music) 

% short-hand to easily add staccato expresion marks to a collection of music
% usage: \S {c4 a g}
S =
#(define-music-function
     (parser location note)
     (ly:music?)
   #{
     \addArticulation \staccato #note
   #})

M = 
#(define-music-function
     (parser location txt)
     (markup?)
   #{
     \mark \markup { \box #txt }
   #})

bass_line = \relative c {
   \M "Intro"
    r1 r1
    \relative c'' {
    
    r8 es8 \prall
    r16 es16 \prall ~16   r16
    es4 \prall r4 |
    
    r8 es8 \prall
    r16 es16 \prall ~16  r16
    es4 \prall
    }
    
    r8 f,8|

\break
        
            
     a8 \M "Verse" r8
     r16 \xNote {a16} a16 a
     r4
     r16 \xNote {a16} a16 a16 |
     
     g16 g16 r8
     r16 \xNote{d'16} d16 g16
     r8 r16 \xNote{d16} 
     d d g d | 
     
     f8 f
     r16 f d a~
     a d c c
     r d c a |
     
     bes8 bes
     r16 d c d r
     r f f <f bes>8\glissando <a d>\glissando \grace{<d g>} |
     
     a,8 a
     r16 e a a
     r8 r16 a16 
     e8 a16 a |
     
     g'16 g r \xNote {g}
     d d g g
     r8 r16 \xNote{g}
     d d g d |
     
     f8 \xNote{f}
     r16 d c a
     r8 r16 d
     c c r c
     bes8 bes
     r16 d bes g'
     e8 d16 bes
     e,8 e'16 e |
     
     
     % Pre Chorus
     f8 \M "Pre-Chorus" f16 f
     c c  f g~
     g8 g16 g
     d d g8 |
     
     a8 a16 a
     e e a16 r
     g16 g r g
     d d g r |
     
     d4 ~
     d8 g8
     f2 |
     
     e4
     r8 a8
     f8~f16 e16 ~
     e8 
     d8 |
     
     \break
     
     % Interlude
     c8 \M "Interlude" r8
     r16 c'16^P ( bes) d,^T
     bes'8^P bes^P bes16^P (c) r c |
     
     c, c'\glissando bes d,-0
     bes' \glissando c d,-0 c
     r16 a e e 
     g e b' g |
     
     \break
     
     % Verse 2
     a8 \M "Verse" r8
     r16 e16 a a
     r4
     r16 e a e |
     
     g8 g 
     r16 \xNote{d'} d g
     r8 r16 \xNote{d}
     d d g d |
     
     f8 f8
     r16 d c a
     r16 d c c~
     c f, c' f, |
     
     bes8 8
     r16 d c d~
     d g f f 
     <f bes>8 \glissando <c' f> \glissando \grace{<d g>} |
     
     a,8  a16 a
     r e a a~
     a8 r16 a
     e8 a16 a |
     
     g'16 r g g
     d d g g~
     g8 r16 d
     b b g' g |
     
     r8 f
     r16 d c a
     \xNote{a} d c c
     r16 d c f, |
     
     bes8 8
     r16 g' es es
     e e d b
     e,8 e'16 e16 |
     
     % Pre-Chorus
     f8 \M "Pre-Chorus" f16 f
     c c f g~
     g8 g16 g
     d d g r |
     
     a a r a
     e e a e
     g8 g16 g
      d d r a |
      
     d4 ~
     d8 g
     f2 |
     
     e4
     r8 a8
     f8~f16 e16 ~
     e8 
     d16 a |
     
     \break
     
     % Chorus
     
     d16 \M "Chorus" d r d
     a' a d \glissando (e)
     e, e r e
     b'8 e16 b |
     
     d,8 d16 a'
     r a d r
     e, e r e
     b' b e r |
     
     d, r r d
     a' a d r
     e, e r e
     b' b e d,|
     
     f8 f16 f
     c c f f
     g g r g
     g,16 r r bes^T \glissando
     
     c c'16^P~ <c,  c'>16-T \glissando bes
     bes'16^P \glissando c c,^T e,^T 
     e8^T  e'^P 
     e,16^T e^T g^T r |
     
      c c'16^P~ <c,  c'>16-T \glissando bes
     bes'16^P \glissando c c,^T e,^T 
     r16 e^T  e'^P e,16^T 
     g8 c16 g |
     
     \break
     
     % Verse
     a16 \M "Verse" r8.
     r16 e a a
     r4
     r16 e a e |
     
     g r g r
     r e' d g
     r8. g16
     d d g d |
     
     f r f r
     r d c a
     r d8.
     c8 b8 |
     
     bes8 bes
     r16 d c d~
     d d f f
     bes r16 r16. <bes f>32 \glissando |
     
     <c'~ g~ a,,>8 <c g a,,>
     r16 e,,, a a
     r8. a16
     e e a a |
     
     g' g r g
     d d g g~
     g8 r16 g
     d d g d |
     
     f8 f8
     r16 a, r d
     c c g' e
     f f a a |
     
     bes r bes bes
     r g des d
     e e d b
     e,8 e'16 e |
     
     \break
     
     % Pre-Chorus
     f8 \M "Pre-Chorus" f16 f
     c c f g~
     g8 g16 g
     d d g8 |
     
     a8 a16 a
     e e a a
     g8 g16 g
     d d g d |
     
     d4 ~
     d8 g
     f4 r8 f |
     
     e4
     r8 a8
     f8~f16 e16 ~
     e8 
     d8 |
     
     % Chorus
     
     d16 \M "Chorus"d r d
     a' a d r
     e, e e b'~
     b b e r |
     
     d,16  d r d
     a' a d r
     e, e,8 b''16~
     b b e r |
     
     d,16 d r d
     a' a d r
     e, e r e
     b' b e r |
     
     f, r f f
     c c f f
     g g r \xNote{g}
     d d r c~ |
     
     
     % Interlude
     
     c c'16^P ( bes) \xNote{c,^T}
     bes'16^P \glissando (c) r c, 
     e, e g g
     a a bes \glissando c~ |
     
      c c'16^P ( bes) \xNote{c,^T}
     bes'16^P \glissando (c) \tuplet 3/2 {c, bes r}
     \tuplet 3/2 {e, r e} g8
     a es'16 d |
     
     \break 
     
     % Bridge
     e \M "Bridge" r r e
     r8 a, ~
     a8  b
     c16 des r d~|
     
     d8. d16
     a a d a
     c8 c8
     r16 c c'8|
     
     b,16 r r b
     r \xNote{b} e,8
     r16 e^T e8^T
     g16^T as^T~as a~^T | 
     
     a8. a16
     a8 d8
     g8 g16 g
     d d g d |
     
     f8 f16 f
     c c f r
     e8 e16 e
     b b e r |
     
     \time 2/4
     d8 d
     b r16 e,^T |
     
     \time 4/4
     
     e8^T e^T
     r16 e^T fis^T g^T
     g^T g^T fis8^T 
     e16^T r r a \glissando |
     
     \tuplet 3/2 {d8 d16} d8
     r16 d d'8
     d, d
     r16 d d' d, |
     
     c8 c
     r16 a g e 
     r d' c8
     c16 r b e, |
     
     e2 e |
     
     a8^T a^T
     r16 a^T r a^T
     a^T r8.
     r16 a^T a^T e^T |
     
     g8^T g8^T
     r8 g'16 g16
     r8 g16 \xNote{g}
     d d g g |
     
     f8 f8
     r16 d c a~
     a8 r16 d
     c8 r16 d |
     
     bes8 d16 des
     r8 es
     e r16 d
     b8 e,|
     
     f'8. d16
     c8 f8
     g8 r16 g
     d8 g |
     
     a8 r16 a
     e8 a
     g16 g r g
     d d g g |
     
     d4~
     d8 g
     f2 |
     
     e4~
     e8 a8
     f8~f16 e16~
     e8 d |
     
     
     
     
     
     
      
     
     
     
     
     
     
     
     
     
    
    
}

\score {
  {
      \key a \minor
      \time 4/4
      \tempo 4 = 95
      
      \clef bass
      \bass_line
    
  }
  \layout {}
  \midi {}
}

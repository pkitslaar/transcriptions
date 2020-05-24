% Flashlight by Parliament
%
% Transcription of legendary mini moog bass line by Bernie Worrell
%
% Notation is adapted to be played on bass guitar with use of 
% octave pedal for lower range notes.
%
% transcription by Pieter Kitslaar
%

\version "2.14.0"
#(ly:set-option 'midi-extension "mid")

% first, define a variable to hold the formatted date:
date = #(strftime "%d-%m-%Y" (localtime (current-time)))

#(use-modules (ice-9 popen))
#(use-modules (ice-9 rdelim))
commit =
#(let* ((port (open-pipe* OPEN_READ "git" "rev-parse" "--short" "HEAD"))
        (str  (read-line port)))
   (close-pipe port)
   str)

combined_version = #(string-append "commit: " commit " date: " date)

\header {
  title = "FLASHLIGHT (Bass)"
  subtitle = "Parliament"
  date = \date
  tagline = \combined_version
  composer = "G. CLINTON, W. COLLINS and B. WORRELL"
  arranger = "transcription by Pieter Kitslaar"
  meter = "* Notes sound octave lower than written"
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

bass_line = \relative c' {
    
    r1| r2 r8  
    bes8 \glissando c8 r8 |
   
    r2 
    %\ottava #-1
    bes4 \glissando \grace { a32 \glissando ges32 \glissando des32 \glissando} c8 
   % \ottava #0
    
    r8|\break
    
    r2 r4 r16 
    g'16 bes8 | 
    \M "A" 
    \S {c c bes bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | \S {c c bes bes g g ges ges |f4} 
    
    r4 r16 
    g16 a8 bes b | c16 ees c8 \S{ bes bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | c16 f c8 \S{bes bes g g ges ges | f4} 
    
    r4 r16 
    %\ottava #-1
    a,16~8 bes8 b | c16 c' c,8 
   % \ottava #0
    \S {bes' bes g g ges ges | f4 }
    
    
    r4 r16 
    aes16 a8 bes b | c16 ees \S {c8 bes bes g g ges ges} | 
    %\ottava #-1
    \S{ f8. f16 ees8. ees16 d8. d16 des8 c} |
    
    \M "B"
    
    c16 c'16 c,8 
    %\ottava #0
    \S {bes' bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | \S{ c c bes bes g g ges ges | f4} 
    
    r4 r16 
    %\ottava #-1
    a,8. bes8 b | c16 c' c,8
    %\ottava #0
    \S{bes' bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | c16 c'\S{  c,8 bes bes g g ges ges | f4} 
    
    r4 r16 
    ges'8 f ees16 c8 | \S{ c c bes bes g g ges ges | f4} 
    %\ottava #-1
    f16 \glissando c8. 
    %\ottava #0
    r16 
    
    
    \grace g'16 a8. bes8 b | \S{ c c bes bes g g ges ges} | 
    %\ottava #-1
    \S{ f f ees ees d d des des } | 
    
    c16 c' c,8 
    \S{ d d ees ees e16 e' e,8 | f4} 
    %\ottava #0
    
    r4 r16 
    \grace g16 a8. bes8 b | \S{ c c bes bes g g ges ges | f4} 
    
    \tuplet 3/2 {r8 \grace ees'16 f8 ees8} c4 r4 |
    
    \break
   \M "C"
   
    r2 r4 
    \ottava #1
    \grace d'16 \glissando ees4 |
    
    r2
    \grace f16 \glissando \( ges16 \glissando f16 \glissando ges16 \glissando f16~f4 \) |
    \ottava #0
    
    r2
    ees4 c | f, ees c8 bes g16 ees16 c8 | 
    
    r2 
    \ottava #1
    ees'16 ees'16~4.\prall |
    
    r2 
    bes'4 \prall  a \prall |
    \ottava #0
    
    r2 
    \grace c,16 ees4 c | bes f ees8 c f,16 ees c8 |
    
    r2 
    \ottava #1
    ees'16 \glissando ees'8.\prall r4 |
    
    r4 r8 
    \pitchedTrill ges8 \startTrillSpan f  ~ 4\stopTrillSpan f4 |
    
    \ottava #0
    r2 
    ees4 c |
    bes f8 ees c bes 
    %\ottava #-1
    f16 ees c8 |
    \ottava #1
    
    r2 
    ees'' \prall |
    
    r4 r8 
    a,,8 a c16 d f4 |
    \ottava #0
    
    r2 r8 
    ees'16 r16 c8 ees16 r16 |
    bes8 c16 r16 g8 bes ees,16 f g bes ees, c8. | 
    \ottava #0
    
    \break
    \M "D"
    
    r8
    \S{ c bes bes g g ges ges | f4} r4 r2 |
    
    \S{c'8 c bes bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | \S{ c c bes bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | \S{ c c bes bes g g ges ges | f4} 
    
    r4 r16
    ges'16 f ges f ees c bes | \S{ c8 c bes bes g g ges ges | f4} 
    
    r4 r16 
    g16 a8 bes b | \S{ c c bes bes g g ges ges} |
    %\ottava #-1
    \S{f f ees ees d16 d' d,8 des des} | 
    
    c16 c' c,8 \S{ d d ees ees e e |  f4} 
    %\ottava #0
    
    r4 r16 ges'16 f ges f ees c bes | \S{ c8 c bes bes g g ges ges|  f4} 
    %\ottava #-1
    f16 ees c f16~4~16 
    %\ottava #0
    a16 bes8 |
    
    \M "E"
    \S{ c^"Everybody's got a little light..." c bes bes g g ges ges | f4} 
    g16 bes d c16~4~16 
    
    g16 bes g | \S{ c8 c bes bes g g ges ges | f4} 
    
    r16 
    ges'16 f ees16~4 ges16 f ees c | % 70
    \S{ f8 ees c bes g g ges ges | f4} 
    
    r4 
    %\ottava #-1
     a,8. a16 bes8 b | \S{ c8. c16 d8. d16 ees ees r16 ees e8. e16} |
    \S{ f8. f16
    %\ottava #0
      a8 a bes16 g bes8 b16 g b8 | c c bes bes g g ges ges | f4 }
    
    r16 
    ees' c bes'16~2\prall |
    
    r8 
    \S{c, bes8. bes16 g8. g16 ges8. ges16 | f4} 
    
    r4 r16
    %\ottava #-1
    a,8. bes8 b | 
    \M "F"
    \S{ c^"Da da da de..." c d16 c d8 ees ees e16 ees e8 }| 
    %\ottava #0
    \S{ f f g16 f g8 a a bes b | c c' bes bes g g ges ges | f} 
    
    r8 
    \ottava #1
    g'16 ees16 c16 bes'16~2\prall |
    \ottava #0
    
    r16 
    g,, bes8 c4 g ges | f 
    
    r4 r8 
    %\ottava #-1
    a,8 bes b | 
    \S{ c8 r8 r16 c16 d8 ees8 r16 ees16 e8. r16} |
    %\ottava #0
    \S{ f8. f16 a8. f16 bes8 bes16 f b8 b16 f} |
    
    \M "G"
    \S{ c'8 c bes bes g g ges ges |f4}
    \ottava #1
    g''16 ees c bes'16\prall~4~16  
    \ottava #0
    
    g,,16 bes8 | \S{ c c bes bes g16 bes g8 ges16 a ges8| f4} 
    
    r4 
    c''2\prall
    
    \S{ c,8 c bes bes g g ges ges | f4} 
    g'16 ees c bes'16\prall~4~16  
    
    a,16 bes r16| \S{c8 c bes bes 
    %\ottava #-1
    g g ges ges16 ees} | 
    \S{ f8 f16 d ees8 ees16 des d8 d16 c16 des r16 des8} | 
    \S{ c8 c16 c d8 d16 d ees8 ees16 ees e8 e16 e | f4} 
    %\ottava #0
    f'16 ees c bes'16\prall~2 |
    
    %\ottava #-1
    \S{ c,8 c bes bes g g ges ges | f4}
    %\ottava #0
    
    r4 r16 
    ges'16 f ges f ees16 c bes |
    %\ottava #-1
    \S{ c8 c d d ees ees16 c e8 e16 c | f4} 
    %\ottava #-2
    f,16 ees c16 bes'16\prall~4\prall 
    
    r16 
    ges16 bes8 | \S{ c8 c bes bes g g ges ges}|
    %\ottava #-1
    \grace ees16 \S{f8 f ees ees d16 ees d8 des des} |
    
    \M "H"
    \S{c16 c' c,8 d d ees ees16 ees16 
    %\ottava #0   
    e8 e| f4} 
    
    g'	16 ees16 c bes'16\prall~4~16 
    
    g,16 bes8 | \S{ c c bes bes g g ges ges | f4} 
    
    r4 r16
    ges'16 f ges f ees c bes |
    
    \M "I"
    \S{c8 c bes bes g g ges ges} |
    %\ottava #-1
    \S{f f ees ees d d des des} |
    
    \S{c c d d ees ees e e} | 
    \S{f f 
     %\ottava #0
     a a bes bes b b} |
    
    \S{c16 c' c,8 bes bes g g ges ges} |
    %\ottava #-1
    \S{f f ees ees d d des des} |
    
    \S{c c d d ees ees e e} |
    %\ottava #0
    \S{f16 f' f,8 g g a a bes b} |
    
    \M "J"
    c c'16 bes16~4 
    
    r2 | r16 
    c,16 f ees16~ees4 
    
    r16 
    g,16 a8 bes b |
    c16 c16 c'16 bes16~8 
    
    r8 r4 r16 
    %\ottava #-1
    f,16 ges8 | 
    \S{f8 r8 ees8 r8 d8. d16 des8. des16 | c8} 
    %\ottava #0
    
    r8 r4 r8 
    \grace c' c'16 bes16~4 |
    
    r2 r16 
    ges16 r16 f16 r16 ees16 c8|
    
    r2 
    %\ottava #-1
    c16 bes16 g8 ~\tuplet 3/2 {8 ges4} | 
    \tuplet 3/2 {r8 f4} ees8 
    
    r4 
    a,8 bes b | 
    \M "K"
    \S{ c8 c d d ees ees e e} |
    \S{ f f16 f 
    %\ottava #0    
    a8 a16 a bes8 bes b b} |
    
    \S{ c16 c' c,8 d d ees ees e e} | 
    \S{f8 f a a bes bes} 
    a16 bes16 c a |ees'2\prall 
    
    r4 
    c16 bes g16 f16~|f4 
    
    r4 r16 
    aes,16 a8 bes b | 
    
    \M "L"
    c 
    %\ottava #-1
    a, bes b c 
    %\ottava #0
    a' bes b | 
    c d ees e f16 f, a8 bes b |
    
    \S{ c c bes bes g g ges ges16 ges16} |
    \S{ f8 f a a bes bes b b16 b16} |
    
    \S{c8 c bes bes g g ges ges} |
    %\ottava #-1
    \S{f f ees ees d d des des} |
    
    \S{c c d d ees ees e e}|
    \S{f f 
    %\ottava #0  
    a16 g a8 bes bes16 g b8 c} |
    
    \S{c8 c d d ees8 ees16 c16 e8 e16 c16} | 
    %\ottava #-1
    ges'16( f ees f ees c bes c bes g f g f ees )  f8  \bendAfter -5  ~ \M "M" f4 
    %\ottava #0
    
    \S{c'8 c bes bes g g | f4} 
    
    r4 r16 
    f16 a r16 bes8 b |
    \S{c c bes bes g g ges ges | f4}
    
    r4 
    bes'4 ges16( f ees bes) |
    \S{c8 f ees c bes g ges ges} |
    %\ottava #-1
    \S{f f ees ees d d des des} |
    
    \M "N"
    
    \S{c c d d ees ees 
     %\ottava #0
     e e}| 
    
    \S{f16\> f16 r16 f16 a8. bes16 r16 a16 b8 r16 c16~8} |
    \S{c8 c8 bes bes g g ges ges\!} |

}

\score {
  {
      \key f \minor
      \time 4/4
      \tempo 4 = 104
      
      \clef bass
      \bass_line
    
  }
  \layout {}
  \midi {}
}

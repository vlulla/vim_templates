\version "2.18.2"
\header {
  title="<<<TITLE HERE>>>"
  piece="<<<PIECE HERE>>>"
  arranger = "<<<ARRANGER>>>"
  enteredby = "Vijay Lulla (<<<Today's date>>>)"
}

\layout {
  \context {
    \Score
      \override BarNumber.break-visibility = ##(#f #t #t)
      \override MultiMeasureRest.expand-limit = #1
      %% \override SpacingSpanner.base-shortest-duration = #(ly-make-moment 1/20)
  }
}

voiceconsts = {
  \key c \major
  \numericTimeSignature
  \compressFullBarRests
  \tempo "<<<TEMPO HERE>>>" 4 = 60
}

showLastLength = R1*8 %% last few measures %% Comment to typeset whole score!

\book {
  \score {
    \new Staff {
      \new Voice {
	\relative c' {
	  \voiceconsts
	  %% \set Score.markFormatter = #format-mark-circle-numbers
	  \time 4/4 \clef treble
	  c4 d4 e4 f4 %% TODO: start here!
	}
      }
    }
  }
}

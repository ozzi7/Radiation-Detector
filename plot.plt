filepath = ".//detections.txt"

while (1) {
        set title "Gamma and beta detections on the ground floor"
        set xtics
        set ytics 1
        set y2tics 1
        set grid ytics
        set grid xtics
        set key opaque
        set key right top
        set key box
        set xlabel "minute"
        set ylabel "detections per minute"
        set ytics mirror
        set autoscale y

        samples(x) = $0 > 4 ? 5 : ($0+1)
        avg5(x) = (shift5(x), (back1+back2+back3+back4+back5)/samples($0))
        shift5(x) = (back5 = back4, back4 = back3, back3 = back2, back2 = back1, back1 = x)
        init(x) = (back1 = back2 = back3 = back4 = back5 = sum = 0)

        set style data linespoints

        plot sum = init(0), \
			filepath using 2:3 title 'Detections' with points pt 7 lc rgb 'forest-green', \
			'' using 2:(avg5($3)) title "Running mean over 5 minutes" pt 7 ps 0.5 lw 1 lc rgb "blue", \
			'' using 2:(sum = sum + $3, sum/($0+1)) title "Cumulative mean" pt 1 lw 1 lc rgb "dark-red"
        pause 1
}

#lang racket

#|

1

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

SOLUTION

(+ 3 5 6 9 10 12 15 ...)
(+ (+ 3 5 6 9 10 12 15) (+ 18 20 ...) ...)
(+ (+ 0 3 0 5 0 6 0 9 0 10 0 12 0 15) (+ 15 3 15 5 15 6 ...) (+ 30 3 30 5 ...) ...)
(+ (+ 0 0 0 0 0 0 0 3 5 6 9 10 12 15) (+ 15 15 15 ... 3 5 6 ...) (+ 30 30 30 ... 3 5 6 ...) ...)
(+ (+ 0 0 0 0 0 0 0) (+ 3 5 6 9 10 12 15) (+ 15 15 15 ...) (+ 3 5 6 ...))
(+ (* 7 0) (* 7 15) ... (* 7 975) (* 66 (+ 3 5 6 9 10 12 15)) (+ 993 995 996 999))
(+ (* 7 15 0) (* 7 15 1) ... (* 7 15 66) (* 66 (+ 3 5 6 9 10 12 15)) (+ 993 995 996 999))
(+ (* 7 15 (+ 0 1 2 ... 66)) (* 66 (+ 3 5 6 9 10 12 15)) (+ 993 995 996 999))
(+ (* 7 15 (quotient (* 66 67) 2)) (* 66 (+ 3 5 6 9 10 12 15)) (+ 993 995 996 999))
(+ (* 7 15 (* 33 67)) (* 66 (+ 3 5 6 9 10 12 15)) (+ 993 995 996 999))
|#

(define (generate n)
  (define (generate-inner n i)
    (if (< i n)
        (cons i (generate-inner n (add1 i)))
        empty))
  (generate-inner n 0))

(foldl + 0 (filter (λ (n) (or (zero? (remainder n 3))
                              (zero? (remainder n 5))))
                   (generate 1000)))

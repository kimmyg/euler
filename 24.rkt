#lang racket

; nth permutation of a sequence

(require rackunit)

(define (ref l i)
  (if (empty? l)
      #f
      (if (zero? i)
          (first l)
          (ref (rest l) (sub1 i)))))

(define (rem l i)
  (if (empty? l)
      #f
      (if (zero? i)
          (rest l)
          (cons (first l) (rem (rest l) (sub1 i))))))

(check-equal? (rem (list 1 2 3) 1) (list 1 3))

(define (! n)
  (define (!-inner n acc)
    (if (zero? n)
        acc
        (!-inner (sub1 n) (* n acc))))
  (!-inner n 1))

(check-equal? (! 4) 24)

(define (nth-permutation xs n)
  (if (zero? n)
      xs
      (let-values ([(i j) (quotient/remainder n (! (sub1 (length xs))))])
        (cons (ref xs i) (nth-permutation (rem xs i) j)))))

(check-equal? (nth-permutation (list 1 2 3 4) 0) (list 1 2 3 4))
(check-equal? (nth-permutation (list 1 2) 1) (list 2 1))

(nth-permutation (list 0 1 2 3 4 5 6 7 8 9) 999999)
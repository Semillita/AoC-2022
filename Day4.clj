(ns aoc.Day4
  (:gen-class))

(require '[clojure.string :as string])

(defn readLines [] (string/split (slurp "Input4.txt") #"\n"))

(defn parseRanges [line] (map (fn [x] (Integer/parseInt x)) (subvec (re-find (re-matcher #"((\d+)-(\d+),(\d+)-(\d+))" line)) 2 6)))

(defn overlapWhole [nums] (or (and (<= (nth nums 0) (nth nums 2)) (>= (nth nums 1) (nth nums 3))) (and (<= (nth nums 2) (nth nums 0)) (>= (nth nums 3) (nth nums 1)))))

(defn overlapPart [nums] (or (and (<= (nth nums 0) (nth nums 2)) (>= (nth nums 1) (nth nums 2))) (and (<= (nth nums 0) (nth nums 3)) (>= (nth nums 1) (nth nums 3)))))

(defn overlapAny [nums] (or (overlapWhole nums) (overlapPart nums)))

(defn -main
  [& args]
  (def lines (readLines))
  (println (count (filter identity (map overlapWhole (map parseRanges lines)))))
  (println (count (filter identity (map overlapAny (map parseRanges lines))))))
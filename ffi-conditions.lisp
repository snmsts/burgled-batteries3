(in-package #:python3.cffi)

;; Python must have been initialized for our macroexpansions to work.
(eval-when (:compile-toplevel :load-toplevel)
  (.initialize)
  #+(and sbcl unix); python will fail sbcl's sigpipe-handler.
  (sb-unix::enable-interrupt sb-unix::sigpipe #'sb-unix::sigpipe-handler))

(defpyexception "BaseException" (python-condition)
    (("args" :initarg :args)))
(defpyexception "Exception" () ())
(defpyexception "ArithmeticError" () ())
(defpyexception "LookupError" () ())
(defpyexception "AssertionError" () ())
(defpyexception "AttributeError" () ())
(defpyexception "EOFError" () ())
(defpyexception "EnvironmentError" ()
    (("errno" :initarg :errno)
     ("strerror" :initarg :strerror)
     ("filename" :initarg :filename)))
(defpyexception "FloatingPointError" () ())
(defpyexception "IOError" () ())
(defpyexception "ImportError" () ())
(defpyexception "IndexError" () ())
(defpyexception "KeyError" () ())
(defpyexception "KeyboardInterrupt" () ())
(defpyexception "MemoryError" () ())
(defpyexception "NameError" () ())
(defpyexception "RuntimeError" () ())
(defpyexception "NotImplementedError" () ())
(defpyexception "OSError" () ())
(defpyexception "OverflowError" () ())
(defpyexception "ReferenceError" () ())
(defpyexception "SyntaxError" ()
    (("filename" :initarg :filename)
     ("lineno"   :initarg :lineno)
     ("offset"   :initarg :offset)
     ("text"     :initarg :text)))
(defpyexception "SystemError" () ())
(defpyexception "SystemExit" () ())
(defpyexception "TypeError" () ())
(defpyexception "ValueError" () ())
#+windows (defpyexception "WindowsError" () ())
(defpyexception "ZeroDivisionError" () ())

(eval-when (:compile-toplevel :load-toplevel)
  (.finalize))

(defmethod print-object ((condition base-exception) stream)
  (write (first (slot-value condition 'args)) :stream stream))

(defmethod print-object ((condition environment-error) stream)
  (write (slot-value condition 'strerror) :stream stream))

#+(or) (burgled-batteries3:run "1+")

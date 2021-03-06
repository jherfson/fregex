program test

use fexp

print*, "Regexp, String, Result, expected result"
print*, "Foo, FooBar, ", match("Foo", "FooBar"), "true"
print*, "Poo, FooBar, ", match("Poo", "FooBar"), "false"
print*, "Bar, FooBar, ", match("Bar", "FooBar"), "true"
print*, "Par, FooBar, ", match("Par", "FooBar"), "false"
print*, "Foo, Foo, ", match("Foo", "Foo"), "true"
print*, "Fo, Foo, ", match("Fo", "Foo"), "true"
print*, "Foo, Fo, ", match("Foo", "Fo"), "false"
print*, "ooB, FooBar, ", match("ooB", "FooBar"), "true"
print*, "ooP, FooBar, ", match("ooP", "FooBar"), "false"
print*, "., FooBar, ", match(".", "FooBar"), "true"
print*, "P., FooBar, ", match("P.", "FooBar"), "false"
print*, "^Foo, FooBar, ", match("^Foo", "FooBar"), "true"
print*, "^Bar, FooBar, ", match("^Bar", "FooBar"), "false"
print*, "Foo$, FooBar, ", match("Foo$", "FooBar"), "false"
print*, "Bar$, FooBar, ", match("Bar$", "FooBar"), "true"
print*, ".*o, FooBar, ", match(".*o", "FooBar"), "true"
print*, "o*o, FooBar, ", match("o*o", "FooBar"), "true"
print*, "P*o, FooBar, ", match("P*o", "FooBar"), "true"
print*, "Fo*o, FooBar, ", match("Fo*o", "FooBar"), "true"
print*, "Po*o, FooBar, ", match("Po*o", "FooBar"), "false"
print*, ".+o, FooBar, ", match(".+o", "FooBar"), "true"
print*, "o+o, FooBar, ", match("o+o", "FooBar"), "true"
print*, "P+o, FooBar, ", match("P+o", "FooBar"), "false"
print*, "Fo+o, FooBar, ", match("Fo+o", "FooBar"), "true"
print*, "Po+o, FooBar, ", match("Po+o", "FooBar"), "false"
print*, ".?o, FooBar, ", match(".?o", "FooBar"), "true"
print*, "o?o, FooBar, ", match("o?o", "FooBar"), "true"
print*, "P?o, FooBar, ", match("P?o", "FooBar"), "true"
print*, "Fo?o, FooBar, ", match("Fo?o", "FooBar"), "true"
print*, "Po?o, FooBar, ", match("Po?o", "FooBar"), "false"
print*, "F[po]o, FooBar, ", match("F[po]o", "FooBar"), "true"
print*, "F[op]o, FooBar, ", match("F[op]o", "FooBar"), "true"
print*, "F[qp]o, FooBar, ", match("F[qp]o", "FooBar"), "false"
print*, "F[^po]o, FooBar, ", match("F[^po]o", "FooBar"), "false"
print*, "F[^op]o, FooBar, ", match("F[^op]o", "FooBar"), "false"
print*, "F[^qp]o, FooBar, ", match("F[^qp]o", "FooBar"), "true"
print*, "F\do, FooBar, ", match("F\do", "FooBar"), "false"
print*, "F\wo, FooBar, ", match("F\wo", "FooBar"), "true"
print*, "F\do, F5oBar, ", match("F\do", "F5oBar"), "true"
print*, "F\wo, F5oBar, ", match("F\wo", "F5oBar"), "true"
print*, "F\Do, FooBar, ", match("F\Do", "FooBar"), "true"
print*, "F\Wo, FooBar, ", match("F\Wo", "FooBar"), "false"
print*, "F\Do, F5oBar, ", match("F\Do", "F5oBar"), "false"
print*, "F\Wo, F5oBar, ", match("F\Wo", "F5oBar"), "false"
print*, "F[po]*o, FooBar, ", match("F[po]*o", "FooBar"), "true"
print*, "F[56]*o, F5oBar, ", match("F[56]*o", "F5oBar"), "true"
print*, "F[46]*o, F5oBar, ", match("F[46]*o", "F5oBar"), "false"
print*, "F[46]*5, F5oBar, ", match("F[46]*5", "F5oBar"), "true"
print*, "F[46]*5o, F5oBar, ", match("F[46]*5o", "F5oBar"), "true"
print*, "F[op]*o, FooBar, ", match("F[op]*o", "FooBar"), "true"
print*, "F[qp]*o, FooBar, ", match("F[qp]*o", "FooBar"), "true"
print*, "P[qp]*o, FooBar, ", match("P[qp]*o", "FooBar"), "false"
print*, "F[^po]*o, FooBar, ", match("F[^po]*o", "FooBar"), "true"
print*, "F[^op]*o, FooBar, ", match("F[^op]*o", "FooBar"), "true"
print*, "F[^qp]*o, FooBar, ", match("F[^qp]*o", "FooBar"), "true"
print*, "P[^qp]*o, FooBar, ", match("P[^qp]*o", "FooBar"), "false"
print*, "F\d*o, FooBar, ", match("F\d*o", "FooBar"), "true"
print*, "F\w*o, FooBar, ", match("F\w*o", "FooBar"), "true"
print*, "F\d*o, F5oBar, ", match("F\d*o", "F5oBar"), "true"
print*, "F\w*o, F5oBar, ", match("F\w*o", "F5oBar"), "true"
print*, "F\D*o, FooBar, ", match("F\D*o", "FooBar"), "true"
print*, "F\W*o, FooBar, ", match("F\W*o", "FooBar"), "true"
print*, "F\D*o, F5oBar, ", match("F\D*o", "F5oBar"), "false"
print*, "F\D*5, F5oBar, ", match("F\D*5", "F5oBar"), "true"
print*, "F\W*o, F5oBar, ", match("F\W*o", "F5oBar"), "false"
print*, "F\W*5, F5oBar, ", match("F\W*5", "F5oBar"), "true"
print*, "F[po]?o, FooBar, ", match("F[po]?o", "FooBar"), "true"
print*, "F[56]?o, F5oBar, ", match("F[56]?o", "F5oBar"), "true"
print*, "F[46]?o, F5oBar, ", match("F[46]?o", "F5oBar"), "false"
print*, "F[46]?5, F5oBar, ", match("F[46]?5", "F5oBar"), "true"
print*, "F[46]?5o, F5oBar, ", match("F[46]?5o", "F5oBar"), "true"
print*, "F[op]?o, FooBar, ", match("F[op]?o", "FooBar"), "true"
print*, "F[qp]?o, FooBar, ", match("F[qp]?o", "FooBar"), "true"
print*, "P[qp]?o, FooBar, ", match("P[qp]?o", "FooBar"), "false"
print*, "F[^po]?o, FooBar, ", match("F[^po]?o", "FooBar"), "true"
print*, "F[^op]?o, FooBar, ", match("F[^op]?o", "FooBar"), "true"
print*, "F[^qp]?o, FooBar, ", match("F[^qp]?o", "FooBar"), "true"
print*, "P[^qp]?o, FooBar, ", match("P[^qp]?o", "FooBar"), "false"
print*, "F\d?o, FooBar, ", match("F\d?o", "FooBar"), "true"
print*, "F\w?o, FooBar, ", match("F\w?o", "FooBar"), "true"
print*, "F\d?o, F5oBar, ", match("F\d?o", "F5oBar"), "true"
print*, "F\w?o, F5oBar, ", match("F\w?o", "F5oBar"), "true"
print*, "F\D?o, FooBar, ", match("F\D?o", "FooBar"), "true"
print*, "F\W?o, FooBar, ", match("F\W?o", "FooBar"), "true"
print*, "F\D?o, F5oBar, ", match("F\D?o", "F5oBar"), "false"
print*, "F\D?5, F5oBar, ", match("F\D?5", "F5oBar"), "true"
print*, "F\W?o, F5oBar, ", match("F\W?o", "F5oBar"), "false"
print*, "F\W?5, F5oBar, ", match("F\W?5", "F5oBar"), "true"
print*, "F[po]+o, FooBar, ", match("F[po]+o", "FooBar"), "true"
print*, "F[56]+o, F5oBar, ", match("F[56]+o", "F5oBar"), "true"
print*, "F[46]+o, F5oBar, ", match("F[46]+o", "F5oBar"), "false"
print*, "F[46]+5, F5oBar, ", match("F[46]+5", "F5oBar"), "false"
print*, "F[46]+5o, F5oBar, ", match("F[46]+5o", "F5oBar"), "false"
print*, "F[op]+o, FooBar, ", match("F[op]+o", "FooBar"), "true"
print*, "F[qp]+o, FooBar, ", match("F[qp]+o", "FooBar"), "false"
print*, "P[qp]+o, FooBar, ", match("P[qp]+o", "FooBar"), "false"
print*, "F[^po]+o, FooBar, ", match("F[^po]+o", "FooBar"), "false"
print*, "F[^op]+o, FooBar, ", match("F[^op]+o", "FooBar"), "false"
print*, "F[^qp]+o, FooBar, ", match("F[^qp]+o", "FooBar"), "true"
print*, "P[^qp]+o, FooBar, ", match("P[^qp]+o", "FooBar"), "false"
print*, "F\d+o, FooBar, ", match("F\d+o", "FooBar"), "false"
print*, "F\w+o, FooBar, ", match("F\w+o", "FooBar"), "true"
print*, "F\d+o, F5oBar, ", match("F\d+o", "F5oBar"), "true"
print*, "F\w+o, F5oBar, ", match("F\w+o", "F5oBar"), "true"
print*, "F\D+o, FooBar, ", match("F\D+o", "FooBar"), "true"
print*, "F\W+o, FooBar, ", match("F\W+o", "FooBar"), "false"
print*, "F\D+o, F5oBar, ", match("F\D+o", "F5oBar"), "false"
print*, "F\D+5, F5oBar, ", match("F\D+5", "F5oBar"), "false"
print*, "F\W+o, F5oBar, ", match("F\W+o", "F5oBar"), "false"
print*, "F\W+5, F5oBar, ", match("F\W+5", "F5oBar"), "false"
print*, "\d+\.\d*, 1.9, ", match("\d+\.\d*", "1.9"), "true"
print*, "\d+\.\d*, 1.99, ", match("\d+\.\d*", "1.99"), "true"
print*, "\d+\.\d*, 1.999, ", match("\d+\.\d*", "1.999"), "true"
print*, "\d+\.\d*, 1.9999, ", match("\d+\.\d*", "1.9999"), "true"
print*, "\d+\.\d*, 1.99999, ", match("\d+\.\d*", "1.99999"), "true"
print*, "\d+\.\d*, 11.99999, ", match("\d+\.\d*", "11.99999"), "true"
print*, "\d+\.\d*, 111.99999, ", match("\d+\.\d*", "111.99999"), "true"
print*, "\d+\.\d*, 1111.99999, ", match("\d+\.\d*", "1111.99999"), "true"
print*, "\d+\.\d*, 11111.99999, ", match("\d+\.\d*", "11111.99999"), "true"
print*, "\d+\.\d*, 111111.99999, ", match("\d+\.\d*", "111111.99999"), "true"
print*, "^\d+\.\d*, 1.9, ", match("^\d+\.\d*", "1.9"), "true"
print*, "^\d+\.\d*, 1.99, ", match("^\d+\.\d*", "1.99"), "true"
print*, "^\d+\.\d*, 1.999, ", match("^\d+\.\d*", "1.999"), "true"
print*, "^\d+\.\d*, 1.9999, ", match("^\d+\.\d*", "1.9999"), "true"
print*, "^\d+\.\d*, 1.99999, ", match("^\d+\.\d*", "1.99999"), "true"
print*, "^\d+\.\d*, 11.99999, ", match("^\d+\.\d*", "11.99999"), "true"
print*, "^\d+\.\d*, 111.99999, ", match("^\d+\.\d*", "111.99999"), "true"
print*, "^\d+\.\d*, 1111.99999, ", match("^\d+\.\d*", "1111.99999"), "true"
print*, "^\d+\.\d*, 11111.99999, ", match("^\d+\.\d*", "11111.99999"), "true"
print*, "^\d+\.\d*, 111111.99999, ", match("^\d+\.\d*", "111111.99999"), "true"

print*, "a\d+\.\d*, a1.9, ", match("a\d+\.\d*", "a1.9"), "true"
print*, "a\d+\., a1.9, ", match("a\d+\.", "a1.9"), "true"
print*, "a\d+, a1.9, ", match("a\d+", "a1.9"), "true"
print*, "a, a1.9, ", match("a", "a1.9"), "true"

print*, '\\, \, ', match("\\", "\"), "true"
print*, "\., \, ", match("\.", "\"), "false"
print*, "., \, ", match(".", "\"), "true"

print*, "F[qpo, FooBar, Stops!"
print*, match("F[qpo", "FooBar")

end program test

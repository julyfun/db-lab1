#set page(paper: "us-letter")
#set heading(numbering: "1.1.")
#set figure(numbering: "1")

// 这是注释
#figure(image("sjtu.png", width: 50%), numbering: none) \ \ \

#align(center, text(17pt)[
  *Database System Concepts - Assignment (I)* \ \
  #table(
      columns: 2,
      stroke: none,
      rows: (2.5em),
      // align: (x, y) =>
      //   if x == 0 { right } else { left },
      align: (right, left),
      [Name:], [Junjie Fang],
      [Student ID:], [521260910018],
      [Date:], [2024/3/4],
      [Score:], [],
    )
])

#pagebreak()

#set page(header: align(right)[
  DB Lab1 Report - Junjie FANG
], numbering: "1")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

_Source Code_: #link("https://github.com/julyfun/db-lab1")

#outline(indent: 1.5em)

= Problem 1

== 

The relational algebra expression is:

$
Pi_("ID", "name")("instructor") - Pi_("instructor.ID", "instructor.name")
("instructor" attach(inline(join), br: "instructor.salary < d.salary") rho_("d")("instructor"))
$

The relational algebra expression tree is like:

#import "@preview/syntree:0.2.0": tree

#figure(
  tree($-$,
    tree($Pi_("ID, name")$, "instructor"),
    tree($Pi_("instructor.ID", "instructor.name")$,
      tree(
        $attach(join, br: "instructor.salary < d.salary")$,
        "instructor",
        tree($rho_("d")$, "instructor")
      )
    )
  )
)

==

The relational algebra expression is:

$
Pi_("ID", "name")("student") - Pi_("student.ID", "student.name")
(sigma_("year"=2018)("takes") attach(inline(join), br: "student.ID = takes.ID") "student")
$

The relational algebra expression tree is like:

#figure(
  tree($-$,
    tree($Pi_("ID, name")$, "student"),
    tree($Pi_("student.ID", "student.name")$,
      tree(
        $attach(join, br: "student.ID = takes.ID")$,
        tree(
          $sigma_("year"=2018)$, "takes"
        ),
        "student"
      )
    )
  )
)

==

The relational algebra expression is:

$
Pi_("i.ID", "i.name")(rho_(a_1)("advisor") attach(inline(join), br: a_1."i_id" = a_2."i_id" and a_1."s_id" != a_2."s_id") rho_(a_2)("advisor") attach(inline(join), br: i."ID" = a_1."i_id"), rho_(i)("instructor"))$

The relational algebra expression tree is like:

#figure(
  tree($Pi_("i.ID", "i.name")$,
    tree(
      $attach(inline(join), br: i."ID" = a_1."i_id")$,
      tree(
        $attach(inline(join), br: a_1."i_id" = a_2."i_id" and a_1."s_id" != a_2."s_id")$,
        tree($rho_(a_1)$, $"advisor"$),
        tree($rho_(a_2)$, $"advisor"$)
      ),
      tree($rho_(i)$, $"instructor"$),
    )
  )
)

= Problem 2

The relational algebra expression is:

$
Pi_(A_1, ..., A_n)(R) - Pi_(A_1, ..., A_n)((Pi_(A_1, ..., A_n)(R) times S) - R)
$

The relational algebra expression tree is like:

#figure(
  tree($-$,
    tree($Pi_(A_1, ..., A_n)$, $R$),
    tree($Pi_(A_1, ..., A_n)$,
      tree($-$,
        tree(
          $times$,
          tree($Pi_(A_1, ..., A_n)$, $R$),
          $S$),
        $R$
      )
    )
  )
)

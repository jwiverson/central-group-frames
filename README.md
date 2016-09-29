# central-group-frames
This repository contains code related to the paper "Optimal Line Packings From Association Schemes", by J.W. Iverson, J. Jasper, and D.G. Mixon. The files "gap_code.g" and "sage_code.g" were used in the proof of Theorem 4.6. Their results are summarized in "table_2.g", which lists the groups implicated by Table 2. Finally, "b-prods.g" implements the infinite family of hyperdifference sets described in Sections 5 and 6. After importing that file into GAP with a command like `Read("b-prods.g")`, the user can produce the short, fat matrix promised by Theorem 6.1 with the command `hETF(n)`, where n is any odd integer greater than or equal to 3. This file also contains polycyclic representations of B-products over finite fields, and in particular can be used to further explore the groups created in our paper.



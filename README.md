# central-group-frames
This repository contains code related to the paper "Optimal Line Packings From Nonabelian Groups", by J.W. Iverson, J. Jasper, and D.G. Mixon. The files "gap_code.g" and "sage_code.g" were used in the verification of Table 1. Their results are summarized in "table_1.g", which lists the groups implicated by that table. Finally, "b-prods.g" implements the infinite family of hyperdifference sets described in Sections 4 and 5. After importing that file into GAP with a command like `Read("b-prods.g");`, the user can produce the short, fat matrix promised by Theorem 5.1 with the command `hETF(n);`, where n is any odd integer greater than or equal to 3. This file also contains polycyclic representations of B-products over finite fields, and in particular can be used to further explore the groups created in our paper.

The version posted here reflects minor changes made during the revision process for that paper. First of all, the name of the paper has been changed from "Optimal Line Packings From Association Schemes", and many of the results have been renumbered. We have updated the comments appropriately. At a more meaningful level, we have updated the GAP code used to verify Table 1 (called Table 2 in the original version). During revision, we realized that the GAP command "<" does not correctly compare irrational real numbers. In the original version, we used that command to check inequalities that may or may not have involved irrational numbers, so there was a possibility for error. The version posted here uses the package FUtil (http://www.math.rwth-aachen.de/~Frank.Luebeck/gap/FUtil/index.html) to make those comparisons instead. As it turns out, the final results were the same as the ones we had originally obtained. In particular, there was no need to run the Sage code again.

The earlier code is still available in the "version-1" branch.

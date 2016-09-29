good:=[];

for o in [2..1023] do		#o is the order of a group
	div:=DivisorsInt(o);	#the divisors are ordered according to size
	l:=Length(div);
	j:=2;
	d0:=div[j];		#d0 is the dimension of an irreducible character
	while 2*d0^2 <= o do
		D:=2;		#D is the number of characters with dimension d0 in a hyperdifference set
		while D*d0^2 < o do
			d:=D*d0^2;
			if IsInt(d*(d-1)/(o-1)) then
				Add(good,[o,d0,D]);
			fi;
		D:=D+1;
		od;
	j:=j+1;
	d0:=div[j];
	od;
od;


#here is the result:
[ [ 34, 2, 3 ], [ 46, 2, 9 ], [ 64, 2, 7 ], [ 64, 2, 9 ], [ 66, 2, 10 ], [ 70, 2, 6 ], [ 78, 2, 14 ], [ 96, 2, 5 ], 
  [ 96, 2, 19 ], [ 106, 2, 9 ], [ 111, 3, 5 ], [ 141, 3, 4 ], [ 142, 2, 12 ], [ 146, 2, 29 ], [ 154, 2, 34 ], 
  [ 162, 2, 23 ], [ 166, 2, 25 ], [ 177, 3, 16 ], [ 178, 2, 15 ], [ 190, 2, 7 ], [ 196, 2, 10 ], [ 196, 2, 39 ], 
  [ 214, 2, 18 ], [ 222, 2, 13 ], [ 226, 2, 25 ], [ 246, 2, 49 ], [ 250, 2, 21 ], [ 256, 2, 30 ], [ 256, 2, 34 ], 
  [ 260, 2, 28 ], [ 260, 2, 37 ], [ 260, 4, 7 ], [ 266, 2, 40 ], [ 274, 2, 49 ], [ 276, 2, 25 ], [ 276, 2, 44 ], 
  [ 276, 4, 11 ], [ 285, 3, 8 ], [ 286, 2, 19 ], [ 286, 2, 24 ], [ 291, 3, 29 ], [ 296, 2, 15 ], [ 296, 2, 59 ], 
  [ 300, 2, 23 ], [ 300, 2, 52 ], [ 300, 4, 13 ], [ 316, 2, 9 ], [ 316, 2, 70 ], [ 320, 2, 22 ], [ 320, 2, 58 ], 
  [ 322, 2, 27 ], [ 324, 3, 17 ], [ 324, 3, 19 ], [ 326, 2, 75 ], [ 330, 3, 21 ], [ 336, 3, 15 ], [ 345, 3, 24 ], 
  [ 346, 2, 69 ], [ 346, 2, 75 ], [ 351, 3, 14 ], [ 351, 3, 25 ], [ 358, 2, 30 ], [ 358, 2, 51 ], [ 366, 2, 55 ], 
  [ 370, 2, 72 ], [ 378, 3, 13 ], [ 378, 3, 29 ], [ 386, 2, 14 ], [ 386, 2, 44 ], [ 388, 2, 43 ], [ 388, 2, 54 ], 
  [ 394, 2, 33 ], [ 396, 2, 20 ], [ 396, 2, 79 ], [ 396, 4, 5 ], [ 404, 2, 39 ], [ 404, 2, 62 ], [ 408, 3, 33 ], 
  [ 429, 3, 12 ], [ 430, 2, 36 ], [ 430, 2, 88 ], [ 430, 2, 91 ], [ 435, 3, 7 ], [ 446, 2, 89 ], [ 456, 2, 49 ], 
  [ 456, 2, 65 ], [ 456, 3, 39 ], [ 460, 2, 34 ], [ 460, 2, 81 ], [ 466, 2, 39 ], [ 466, 2, 70 ], [ 470, 2, 84 ], 
  [ 474, 2, 11 ], [ 476, 2, 19 ], [ 476, 2, 100 ], [ 476, 4, 25 ], [ 478, 2, 106 ], [ 482, 2, 65 ], [ 494, 2, 51 ], 
  [ 496, 2, 25 ], [ 496, 2, 99 ], [ 502, 2, 42 ], [ 505, 5, 9 ], [ 514, 2, 81 ], [ 518, 2, 47 ], [ 526, 2, 100 ], 
  [ 538, 2, 45 ], [ 540, 3, 11 ], [ 540, 3, 49 ], [ 546, 2, 109 ], [ 550, 2, 61 ], [ 554, 2, 79 ], [ 561, 3, 25 ], 
  [ 562, 2, 102 ], [ 562, 2, 132 ], [ 566, 2, 85 ], [ 573, 3, 16 ], [ 574, 2, 48 ], [ 576, 2, 69 ], [ 576, 2, 75 ], 
  [ 582, 2, 21 ], [ 590, 2, 62 ], [ 591, 3, 59 ], [ 596, 2, 30 ], [ 596, 2, 119 ], [ 609, 3, 57 ], [ 610, 2, 51 ], 
  [ 610, 2, 58 ], [ 610, 5, 7 ], [ 622, 2, 115 ], [ 630, 2, 102 ], [ 638, 2, 49 ], [ 640, 2, 18 ], [ 640, 2, 142 ], 
  [ 646, 2, 54 ], [ 646, 2, 129 ], [ 651, 3, 39 ], [ 652, 2, 70 ], [ 652, 2, 93 ], [ 657, 3, 32 ], [ 657, 3, 41 ], 
  [ 664, 2, 13 ], [ 664, 2, 153 ], [ 666, 2, 100 ], [ 666, 2, 114 ], [ 666, 2, 119 ], [ 668, 2, 29 ], [ 668, 2, 138 ],
  [ 682, 2, 57 ], [ 694, 2, 135 ], [ 696, 2, 35 ], [ 696, 2, 139 ], [ 706, 2, 94 ], [ 712, 2, 79 ], [ 712, 2, 99 ], 
  [ 714, 3, 69 ], [ 717, 3, 20 ], [ 718, 2, 60 ], [ 736, 2, 49 ], [ 736, 2, 135 ], [ 742, 2, 114 ], [ 746, 2, 149 ], 
  [ 750, 2, 107 ], [ 754, 2, 63 ], [ 760, 2, 69 ], [ 760, 2, 121 ], [ 766, 2, 34 ], [ 766, 2, 115 ], [ 771, 3, 49 ], 
  [ 771, 3, 60 ], [ 778, 2, 28 ], [ 778, 2, 37 ], [ 786, 3, 35 ], [ 790, 2, 66 ], [ 796, 2, 40 ], [ 796, 2, 159 ], 
  [ 796, 4, 10 ], [ 800, 2, 47 ], [ 800, 2, 153 ], [ 801, 3, 25 ], [ 801, 3, 64 ], [ 802, 2, 178 ], [ 804, 2, 55 ], 
  [ 804, 2, 146 ], [ 806, 2, 184 ], [ 818, 2, 43 ], [ 826, 2, 25 ], [ 826, 2, 69 ], [ 834, 2, 98 ], [ 846, 2, 169 ], 
  [ 848, 2, 91 ], [ 848, 2, 121 ], [ 861, 3, 24 ], [ 862, 2, 72 ], [ 862, 2, 154 ], [ 862, 2, 205 ], [ 866, 2, 130 ], 
  [ 870, 2, 99 ], [ 870, 3, 44 ], [ 870, 6, 11 ], [ 874, 2, 97 ], [ 876, 3, 14 ], [ 885, 3, 68 ], [ 886, 2, 15 ], 
  [ 891, 3, 10 ], [ 891, 3, 89 ], [ 895, 5, 6 ], [ 896, 2, 45 ], [ 896, 2, 179 ], [ 898, 2, 52 ], [ 898, 2, 75 ], 
  [ 903, 3, 82 ], [ 914, 2, 187 ], [ 921, 3, 64 ], [ 934, 2, 78 ], [ 939, 3, 67 ], [ 946, 2, 135 ], [ 946, 2, 189 ], 
  [ 958, 2, 22 ], [ 958, 2, 58 ], [ 964, 2, 27 ], [ 964, 2, 214 ], [ 966, 2, 145 ], [ 970, 2, 81 ], [ 974, 2, 35 ], 
  [ 976, 2, 75 ], [ 976, 2, 169 ], [ 981, 3, 49 ], [ 981, 3, 60 ], [ 987, 3, 87 ], [ 996, 2, 50 ], [ 996, 2, 199 ], 
  [ 1002, 2, 91 ], [ 1002, 2, 231 ], [ 1005, 3, 28 ], [ 1006, 2, 84 ], [ 1011, 3, 45 ], [ 1018, 2, 198 ] ];



checkSizes:=function(v)
	#Input:		A vector v=[o,m,d] consisting of a group order o=|G|, a positive integer m
	#		meant to give the dimension of an irreducible character, and another positive
	#		integer d meant to give the size of a hyperdifference set.
	#Output:	Let M=m^2*d, which would be the dimension of an ETF with the parameters given by v.
	#		This algorithm checks every nonabelian group G of order o to determine if all of its 
	#		conjugacy classes other than {1} have size c satisfying the inequality
	#			o/c >= o/|[G,G]| + (o-M)/(o-1),
	#		as would be necessary for G to contain a hyperdifference set with the parameters
	#		given by v. If such a group G exists, the program returns true. Otherwise, it
	#		returns false.

	local o,m,d,M,k,G,gg,allGood,C,c;

	o:=v[1];
	m:=v[2];
	d:=v[3];
	M:=m^2*d;

	for k in [1..NrSmallGroups(o)] do
		G:=SmallGroup(o,k);

		if IsAbelian(G) then
			continue;
		fi;

		gg:=Order(DerivedSubgroup(G));

		allGood:=true; #indicates the inequality worked for all conjugacy classes checked so far

		for C in ConjugacyClasses(G) do
			if One(G) in C then
				continue; #ignore the conjugacy class {1}
			fi;

			c:=Size(C);

			if o/c < o/gg + (o-M)/(o-1) then
				allGood:=false; #the inequality failed
				break; #no need to check the other classes
			fi;
		od;

		if allGood then
			return true; #none of the classes failed the inequality, so we have a "good" group
		fi;
	od;

	#if the program gets this far, none of the groups worked
	return false;
end;



better:=Filtered(good,v->checkSizes(v));

#here is the result
better:=[ [ 64, 2, 7 ], [ 64, 2, 9 ], [ 96, 2, 5 ], [ 96, 2, 19 ], [ 162, 2, 23 ], [ 250, 2, 21 ], [ 256, 2, 30 ], 
  [ 256, 2, 34 ], [ 300, 2, 23 ], [ 300, 2, 52 ], [ 300, 4, 13 ], [ 320, 2, 22 ], [ 320, 2, 58 ], [ 324, 3, 17 ], 
  [ 324, 3, 19 ], [ 336, 3, 15 ], [ 378, 3, 13 ], [ 378, 3, 29 ], [ 396, 2, 20 ], [ 396, 2, 79 ], [ 396, 4, 5 ], 
  [ 408, 3, 33 ], [ 456, 2, 49 ], [ 456, 2, 65 ], [ 456, 3, 39 ], [ 540, 3, 11 ], [ 540, 3, 49 ], [ 576, 2, 69 ], 
  [ 576, 2, 75 ], [ 640, 2, 18 ], [ 640, 2, 142 ], [ 696, 2, 35 ], [ 696, 2, 139 ], [ 750, 2, 107 ], [ 800, 2, 47 ], 
  [ 800, 2, 153 ], [ 896, 2, 45 ], [ 896, 2, 179 ] ];



testGroup:=function(G,v)
	#Input:		A group G, and a vector v=[o,k,d] consisting of o=|G|, a positive integer k|o, meant
	#		to give the dimension of an irreducible character of G, and another positive integer
	#		d, meant to give a number of irreducible characters of G with degree k.
	#Output:	This program checks that G satisfies a number of conditions which must hold if there
	#		is a hyperdifference set of d irrecudible characters with degree k for G. Let M=k^2*d
	#		be the dimension of any ETF associated with such a hyperdifference set. First, we check
	#		that G is nonabelian. Second, that the conjugacy classes of G other than {1}
	#		all have sizes c satisfying the inequality
	#			o/c >= o/|[G,G]| + (o-M)/(o-1).
	#		Third, that G actually has d irreducible characters of degree k. Fourth, that
	#			Sum_{\chi \in Irr(G), \chi(1)=k} |\chi(x)|^2 >= (o-M)/(o-1)
	#		for all x≠1. If all four conditions are satisfied, the program returns "true". If any fail, 
	#		it returns "false".

	local o,k,d,M,gg,allGood,classes,r,C,c,goodGuys,vals2,sum,j;

	o:=v[1];
	k:=v[2];
	d:=v[3];
	M:=k^2*d;


	#Check that G is abelian
	if IsAbelian(G) then
		return false;
	fi;


	#Check the conjugacy sizes
	gg:=Order(DerivedSubgroup(G));

	allGood:=true; #indicates the inequality worked for all conjugacy classes checked so far

	classes:=ConjugacyClasses(G);
	r:=Length(classes);

	for C in classes do
		if One(G) in C then
			continue; #ignore the conjugacy class {1}
		fi;

		c:=Size(C);

		if o/c < o/gg + (o-M)/(o-1) then
			allGood:=false; #the inequality failed
			break; #no need to check the other classes
		fi;
	od;

	if not(allGood) then
		return false;
	fi;


	#Compute the character table and check that G has enough characters of the required size
	goodGuys:=Filtered(Irr(G),chi->DegreeOfCharacter(chi)=k);

	if Length(goodGuys) < d then
		return false;
	fi;


	#Check the final inequality on the characters of degree k
	vals2:=List(goodGuys,chi-> List(ValuesOfClassFunction(chi),z->z*ComplexConjugate(z)) ); #absolute values squared
	sum:=Sum(vals2); #Sum_{\chi \in Irr(G), \chi(1) = k} |\chi(x)|^2, as x ranges over G

	j:=2;
	while j<=r do
		if sum[j] < (o-M)/(o-1) then
			#the inequality failed
			return false;
		fi;
	j:=j+1;
	od;


	#If the program makes it this far, the group has passed the test	
	return true;
end;



bestGroups:=[];
best:=[];
for v in better do
	for k in [1..NrSmallGroups(v[1])] do
		G:=SmallGroup(v[1],k);
		if testGroup(G,v) then
			AddSet(bestGroups,[v[1],k]);
			AddSet(best,v);
			break;
		fi;
	od;
od;


#here are the results
best:=

best:=[ [ 64, 2, 7 ], [ 64, 2, 9 ], [ 256, 2, 30 ], [ 256, 2, 34 ], [ 320, 2, 22 ], [ 320, 2, 58 ], [ 576, 2, 69 ], 
  [ 576, 2, 75 ], [ 640, 2, 18 ], [ 896, 2, 45 ], [ 896, 2, 179 ] ];

bestGroups:=[ [ 64, 73 ], [ 256, 543 ], [ 320, 95 ], [ 320, 893 ], [ 576, 218 ], [ 640, 197 ], [ 896, 196 ], [ 896, 4673 ] ];

bGroup:=function(d,B)
	#Input:		A dimension d, and a bilinear function B(a,b) on F_{2^d}. In other words, B is a function
	#		that eats two elements of F_{2^d} and spits out another element in the same field.
	#Output:	A pc group isomorphic to the B-product F_{2^d} x_B F_{2^d}. As a set, that group is equal
	#		to the Cartesian product F_{2^d} x F_{2^d}, with multiplication given by
	#		(u,v)*(x,y) = (u+x, v+y+B(u,v) ).
	#Note:		The group will have 2d generators. Of these, the first d correspond to a basis for the first 
	#		factor of F_{2^d}, as returned by Basis(GF(2^d)), and the second d correspond to the same 
	#		basis for the second factor.

	local e,basis,a,j,coeffs,aj,i,c,ci,bij,k,r,F,f,coll;

	basis:=Basis(GF(2^d));
	e:=BasisVectors(basis);

	#store the coefficients for the powers
	#using notation B(e_j,e_j) = sum_{i=1}^d a[j][i]*e_i
	a:=[]; #a list of the coefficients
	j:=1;
	while j < d+1 do
		coeffs:=Coefficients(basis, B(e[j],e[j]) );
		aj:=[];
		i:=1;
		while i < d+1 do
			if coeffs[i] = Z(2)^0 then
				Add(aj,1);
			else
				Add(aj,0);
			fi;
		i:=i+1;
		od;
		Add(a,aj);
	j:=j+1;
	od;


	#store the coefficients for the conjugates
	#using notation B(e_j,e_i) - B(e_i,e_j) = sum_{k=1}^d b_{i,j}^k*e_k
	#and c[i][j-i][k] = b_{i,j}^k
	c:=[]; #a list of the coefficients
	i:=1;
	while i < d+1 do
		ci:=[];
		j:=i+1;
		while j < d+1 do
			coeffs:=Coefficients(basis,B(e[j],e[i])-B(e[i],e[j]));
			bij:=[];
			k:=1;
			while k < d+1 do
				if coeffs[k] = Z(2)^0 then
					Add(bij,1);
				else
					Add(bij,0);
				fi;
			k:=k+1;
			od;
			Add(ci,bij);
		j:=j+1;
		od;
		Add(c,ci);
	i:=i+1;
	od;

	
	#make the free group and the collector
	F:=FreeGroup(IsSyllableWordsFamily, 2*d);
	f:=GeneratorsOfGroup(F);
	r:=[]; #a list of 2d copies of 2
	i:=1;
	while i < 2*d+1 do
		Add(r,2);
	i:=i+1;
	od;
	coll:=SingleCollector(F,r);


	#set the powers
	j:=1;
	while j < d+1 do
		SetPower(coll,j,Product( List([1..d], i -> f[i+d]^a[j][i]) ) );
	j:=j+1;
	od;

	j:=d+1;
	while j < 2*d+1 do
		SetPower(coll,j,f[j]^0);
	j:=j+1;
	od;
	

	#set the conjugates
	i:=1;
	while i < d+1 do
		j:=i+1;
		while j < d+1 do
			SetConjugate( coll, j, i, f[j]*Product( List([1..d], k -> f[k+d]^c[i][j-i][k] ) ) );
		j:=j+1;
		od;
	i:=i+1;
	od;


	#return the group
	return GroupByRws(coll);

end;



bEmbed:=function(arg)
	#Input:		The first argument is a bilinear map B, as in the documentation for bGroup. The second argument
	#		is an instance G of bGroup(n,B). The third (optional) argument is
	#		the dimension n used to construct G.
	#Output:	A function emb(x,y) that accepts two elements of the field GF(2^d) and returns
	#		the corresponding element of G.
	#Note:		Passing the dimension saves some processing time. Passing invalid arguments may result
	#		in an infinite loop.

	local G,B,n,try,order,k,emb;

	B:=arg[1];
	G:=arg[2];
	if Length(arg) = 3 then
		n:=arg[3];
	else
		order:=Order(G);
		k:=0;
		try:=1;
		while not(try = order) do
			k:=k+1;
			try:=4*try;
		od;
		n:=k;
	fi;

	emb:=function(x,y)
		local conv,a,f,e,error,d,g,c1,c2;
	
		conv:=function(a)
			if a=0*Z(2) then
				return 0;
			else
				return 1;
			fi;
		end;

		a:=BasisVectors(Basis(GF(2^n)));

		f:=GeneratorsOfGroup(G);
		e:=Coefficients(Basis(GF(2^n)),x);
		error:=Sum([2..n],k->Sum([1..k-1],j->e[j]*e[k]*B(a[j],a[k])));	#this is the error in making (x,0)
										#if we just multiplied f[1]^e[1] ... f[n]^e[n]
		d:=Coefficients(Basis(GF(2^n)),error);
		g:=Coefficients(Basis(GF(2^n)),y);

		c1:=List([1..n],j->conv(e[j]));
		c2:=List([1..n],j->conv(d[j]+g[j]));
		

		return Product([1..n],j->f[j]^c1[j])*Product([1..n],j->f[n+j]^c2[j]);
	end;

	return emb;
end;



bfGroup:=function(d,B)
	#Input:		A dimension d, and a bilinear form B(a,b) on F_{2^d}. In other words, B is a function
	#		that eats two elements of F_{2^d} and spits out an element of F_2.
	#Output:	A pc group isomorphic to the B-product F_{2^d} x_B F_2. As a set, that group is equal
	#		to the Cartesian product F_{2^d} x F_2, with multiplication given by
	#		(u,v)*(x,y) = (u+x, v+y+B(u,v) ).
	#Note:		The group will have d+1 generators. Of these, the first d correspond to a basis for F_{2^d},
	#		as returned by Basis(GF(2^d)), and the last corresponds to the nontrivial element of F_2.

	local e,basis,a,j,coeffs,aj,i,c,ci,bij,k,r,F,f,coll;

	basis:=Basis(GF(2^d));
	e:=BasisVectors(basis);

	#store the coefficients for the powers
	#using notation B(e_j,e_j) = a[j]*Z(2)^0
	a:=[]; #a list of the coefficients
	j:=1;
	while j < d+1 do
		if B(e[j],e[j]) = Z(2)^0 then
			Add(a,1);
		else
			Add(a,0);
		fi;
	j:=j+1;
	od;


	#store the coefficients for the conjugates
	#using notation B(e_j,e_i) - B(e_i,e_j) = c[i][j-i]
	c:=[]; #a list of the coefficients
	i:=1;
	while i < d+1 do
		ci:=[];
		j:=i+1;
		while j < d+1 do
			if B(e[j],e[i])-B(e[i],e[j]) = Z(2)^0 then
				Add(ci,1);
			else
				Add(ci,0);
			fi;
		j:=j+1;
		od;
		Add(c,ci);
	i:=i+1;
	od;

	
	#make the free group and the collector
	F:=FreeGroup(IsSyllableWordsFamily, d+1);
	f:=GeneratorsOfGroup(F);
	r:=[]; #a list of d+1 copies of 2
	i:=1;
	while i < d+2 do
		Add(r,2);
	i:=i+1;
	od;
	coll:=SingleCollector(F,r);


	#set the powers
	j:=1;
	while j < d+1 do
		SetPower(coll,j,f[d+1]^a[j]);
	j:=j+1;
	od;

	SetPower(coll,d+1,f[d+1]^0);
	

	#set the conjugates
	i:=1;
	while i < d+1 do
		j:=i+1;
		while j < d+1 do
			SetConjugate( coll, j, i, f[j]*f[d+1]^c[i][j-i] );
		j:=j+1;
		od;
	i:=i+1;
	od;


	#return the group
	return GroupByRws(coll);

end;



bfEmbed:=function(arg)
	#Input:		The first argument is a bilinear map b, as in the documentation for bfGroup. The 
	#		second argument is an instance G of bfGroup(d,b). The third (optional) argument is
	#		the dimension d used to construct G.
	#Output:	A function emb(x,y) that accepts an element x of GF(2^d) and an element y of GF(2),
	#		and returns the corresponding element of G.
	#Note:		Passing the dimension saves some processing time. Passing invalid arguments may result
	#		in an infinite loop.

	local b,G,n,try,order,k,emb;

	b:=arg[1];
	G:=arg[2];
	if Length(arg) = 3 then
		n:=arg[3];
	else
		order:=Order(G);
		k:=0;
		try:=2;
		while not(try = order) do
			k:=k+1;
			try:=2*try;
		od;
		n:=k;
	fi;

	emb:=function(x,y)
		local conv,a,f,e,error,c1,c2;
	
		conv:=function(z)
			if z=0*Z(2) then
				return 0;
			else
				return 1;
			fi;
		end;

		a:=BasisVectors(Basis(GF(2^n)));

		f:=GeneratorsOfGroup(G);
		e:=Coefficients(Basis(GF(2^n)),x);
		error:=Sum([2..n],k->Sum([1..k-1],j->e[j]*e[k]*b(a[j],a[k])));	#this is the error in making (x,0)
										#if we just multiplied f[1]^e[1] ... f[n]^e[n]

		c1:=List([1..n],j->conv(e[j]));
		c2:=conv(error+y);

		return Product([1..n],j->f[j]^c1[j])*f[n+1]^c2;
	end;

	return emb;
end;




bbfQuot:=function(arg)
	#Input:		The first argument is an instance G of bGroup(n,B), where B(x,y)=x*y^2 and n is odd.
	#		The second argument is an instance g of bfGroup(n,b), where b(x,y)=Trace(x*y^2).
	#		The third argument is an element a of GF(2^n).
	#		The fourth (optional) argument is n.
	#Output:	A surjective homomorphism f: G -> g given by f(x,y) = (a*x,Trace(a^3*y)).
	#Note:		Passing the dimension saves some processing time. Passing invalid arguments may result
	#		in an infinite loop.

	local G,g,a,n,order,k,try,f,b,emb,bas,gen1,gen2;

	#Establish the input variables
	G:=arg[1];
	g:=arg[2];
	a:=arg[3];
	if Length(arg) = 4 then
		n:=arg[4];
	else
		order:=Order(g);
		k:=0;
		try:=2;
		while not(try = order) do
			k:=k+1;
			try:=2*try;
		od;
		n:=k;
	fi;

	#establish generators for both groups
	f:=GeneratorsOfGroup(G);

	b:=function(x,y)
		return Trace(x*y^2);
	end;

	emb:=bfEmbed(b,g,n);
	bas:=BasisVectors(Basis(GF(2^n)));
	gen1:=List(bas,x->emb(a*x,0*Z(2)));
	gen2:=List(bas,x->emb(0*Z(2),Trace(a^3*x)));

	return GroupHomomorphismByImages(G,g,f,Concatenation(gen1,gen2));
end;



SCN:=function(F)
	#Input:		A finite field F=GF(2^n) of characteristic 2, with n odd.
	#Output:	A self-complementary normal basis for F. That is, a list of the form
	#		[a^(2^0),a^(2^1), ... , a^(2^(n-1))] for an element a in F with the
	#		property that Trace(a^(2^i)*a^(2^j))=delta_{i,j} for all i,j in [0..n-1].
	#Note:		This method is based on the algorithm in the article: C.C. Wang, "An Algorithm to Design 
	#		Finite Field Multipliers Using a Self-Dual Normal Basis", IEEE Trans. Comp. 38(10),
	#		1457 -- 1460, 1989.

	local m,nb,f,n,L,b,ind,ni,i,B;

	m:=Dimension(F);
	nb:=NormalBase(F);

	#check to see if you already have a self-dual basis
	f:=List([0..m-1],j->Trace(nb[1]*nb[j+1]));
	if Length(Positions(f,Z(2)^0)) = 1 then
		return nb;
	fi;

	#now we can assume we do not have a self-dual basis
	f:=List([0..(m-1)/2],j->Trace(nb[1]*nb[j+1]));
	n:=List(Positions(f,Z(2)^0),x->x-1);
	Sort(n);
	L:=Length(n)-1;

	b:=ShallowCopy(Zero([0..m-1])*Z(2));

	#make an indexing function to convert between indices in the paper and indexing in GAP
	#specifically, b_{j} = b[ind(j)], where the left hand has notation as in the paper
	#and the right hand is the corresponding input for GAP.
	ind:=function(j)
		return \mod(j,m)+1;
	end;

	#make another indexing function for the list n
	ni:=function(j)
		return \mod(j,L+1)+1;
	end;

	#set the values of b as described in the paper
	b[ind(0)]:=Z(2)^0;
	b[ind( n[ni(L)] )]:=Z(2)^0;

	if IsInt(n[ni(L)]/2) then #n_L is even

		b[ind( n[ni(L)]/2 )]:=Z(2)^0;
		for i in [1..L-1] do
			if IsInt(n[ni(i)]/2) then #n_i is even
				b[ind( (n[ni(L)] + n[ni(i)])/2 )]:=Z(2)^0;
				b[ind( (n[ni(L)] - n[ni(i)])/2 )]:=Z(2)^0;
			else #n_i is odd
				b[ind( (m + n[ni(L)] + n[ni(i)])/2 )]:=Z(2)^0;
				b[ind( (m + n[ni(L)] - n[ni(i)])/2 )]:=Z(2)^0;
			fi;
		od;		

	else #n_L is odd

		b[ind( (m + n[ni(L)])/2 )]:=Z(2)^0;
		for i in [1..L-1] do
			if IsInt(n[ni(i)]/2) then #n_i is even
				b[ind( (m + n[ni(L)] + n[ni(i)])/2 )]:=Z(2)^0;
				b[ind( (m + n[ni(L)] - n[ni(i)])/2 )]:=Z(2)^0;
			else #n_i is odd
				b[ind( (n[ni(L)] + n[ni(i)])/2 )]:=Z(2)^0;
				b[ind( (n[ni(L)] - n[ni(i)])/2 )]:=Z(2)^0;
			fi;
		od;

	fi;
	
	
	#make the circulant matrix B
	B:=List([0..m-1],i->List([0..m-1],j-> b[ind(j-i)] ));
	
	#invert and multiply to find the self-complementary basis
	return TransposedMat( B^(-1)*TransposedMat([nb]) )[1];

end;



bfRep:=function(arg)
	#Input:		The first input is an instance G of bfGroup(d,B), where B(x,y)=Trace(x*y^2) and d is odd.
	#		The second (optional) input is the dimension d used to make G.
	#Output:	An irreducible representation of G having dimension 2^[(d-1)/2], returned as a homomorphism
	#		with domain G.

	local G,n,order,k,try,m,b,emb,a,u,v,g,x,y,conv,c,d,tr,mo,H,genG,genH;

	#identify the group and the underlying dimension
	G:=arg[1];
	if Length(arg) = 2 then
		n:=arg[2];
	else
		order:=Order(G);
		k:=0;
		try:=2;
		while not(try = order) do
			k:=k+1;
			try:=2*try;
		od;
		n:=k;
	fi;

	m:=(n-1)/2;
	
	b:=function(x,y)
		return Trace(x*y^2);
	end;

	emb:=bfEmbed(b,G,n);

	#produce the field elements x_0, ... ,x_{m-1} and y_0, ..., y_{m-1}
	a:=SCN(GF(2^n));
	
	u:=List([0..m-1],i->a[2*i+1]+a[2*i+2]);
	v:=List([0..m-1],j->a[2*j+1]+Sum([2*j+2..n-1],k->a[k+1]));

	g:=function(y)
		return Sum([0..(n-1)/2],j->y^(2^(2*j)));
	end;

	x:=List(u,alpha->g(alpha));
	y:=List(v,beta->g(beta));

	conv:=function(e)
		if e = Z(2)^0 then
			return 1;
		else
			return 0;
		fi;
	end;

	c:=List(x,alpha->conv(Trace(alpha^3)));
	d:=List(y,alpha->conv(Trace(alpha^3)));

	#produce the translation and modulation matrices, and the group they generate
	tr:=List([0..m-1],k-> KroneckerProduct(IdentityMat(2^k), KroneckerProduct([[0,1],[1,0]], IdentityMat(2^(m-k-1)) ) ));
	mo:=List([0..m-1],k-> KroneckerProduct(IdentityMat(2^k), KroneckerProduct([[1,0],[0,-1]], IdentityMat(2^(m-k-1)) ) ));

	H:=Group(Concatenation([E(4)*IdentityMat(2^m)],tr,mo));

	#make the generators for G and H, and return the homomorphism that maps one to the other
	genG:=Concatenation([emb(Z(2^n)^0,0*Z(2))], List(x,alpha->emb(alpha,0*Z(2))), List(y,alpha->emb(alpha,0*Z(2))) );
	genH:=Concatenation([E(4)*IdentityMat(2^m)], List([1..m],j->E(4)^c[j]*tr[j]), List([1..m],j->E(4)^d[j]*mo[j]) );

	return GroupHomomorphismByImages(G,H,genG,genH);
end;



hETF:=function(n)
	#Input:		An odd number n≥3.
	#Output:	An equiangular tight frame of 2^(2*n) vectors in 2^(n-1)*(2^n-1) dimensions.
	#		The output is a short, fat matrix.

	local B,b,G,g,rho,quots,reps;

	#make the big group, the little group, the quotients, and all the necessary representations
	B:=function(x,y)
		return x*y^2;
	end;

	b:=function(x,y)
		return Trace(x*y^2);
	end;

	G:=bGroup(n,B);
	g:=bfGroup(n,b);
	rho:=bfRep(g,n);

	quots:=List([0..2^n-2],j->bbfQuot(G,g,Z(2^n)^j,n));;
	reps:=List(quots,q->CompositionMapping(rho,q));;

	return TransposedMat(List(G,x->Flat(List(reps,p->Image(p,x)))));
end;


// Written in the D programming language.
/**						   
Copyright: Copyright Felix 'Zoadian' Hufnagel 2014-.

License:   $(WEB boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors:   $(WEB zoadian.de, Felix 'Zoadian' Hufnagel)
*/
module stdx.typetuple;

public import std.typetuple;  
import std.typecons : tuple;



//==============================================================================
/// Converts an array to a Tuple
template ToTuple(alias T) {
	static if(T.length > 1)	 
		enum ToTuple = tuple(T[0], ToTuple!(T[1..$])).expand;
	else
		enum ToTuple = T[0];
}	
unittest {
	static assert(ToTuple!(["a","b","c"]) == tuple("a","b","c").expand);
}

//==============================================================================
/// a TypeTuple with types sorted by T.stringof
template Sorted(alias LESS, T...) {				
	import std.algorithm : sort, SwapStrategy, countUntil;
	import std.range : array;
	enum StringOf(M) = M.stringof;
	enum StringsOfTypes = [staticMap!(StringOf, T)];	
	enum SortedStringsOfTypes = StringsOfTypes.sort!(LESS, SwapStrategy.stable)().array();
	enum SortedTypeIdx(string M) = StringsOfTypes.countUntil(M);
	alias SortedTypeIndices = staticMap!(SortedTypeIdx, ToTuple!SortedStringsOfTypes);
	alias TypeFromIdx(size_t idx) = T[idx];			  
	alias Sorted = staticMap!(TypeFromIdx, SortedTypeIndices);
}	 
unittest {
	static assert(is(Sorted!("a<b", double, long, float, int, uint, char) == Sorted!("a<b", int, char, float, long, double, uint)));
}

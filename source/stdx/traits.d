// Written in the D programming language.
/**						   
Copyright: Copyright Felix 'Zoadian' Hufnagel 2014-.

License:   $(WEB boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors:   $(WEB zoadian.de, Felix 'Zoadian' Hufnagel)
*/
module stdx.traits;

public import std.traits;
import std.typetuple : Filter, staticMap, TypeTuple;

enum isStruct(T) = is(T == struct);	   

enum isClass(T) = is(T == class);	

template NestedStructs(T) { 							
	alias GetMember(string s) = TypeTuple!(__traits(getMember, T, s)); 		
	alias NestedStructs = Filter!(isStruct, staticMap!(GetMember, __traits(allMembers, T)));
}

template NestedClasses(T) { 							
	alias GetMember(string s) = TypeTuple!(__traits(getMember, T, s)); 		
	alias NestedClasses = Filter!(isClass, staticMap!(GetMember, __traits(allMembers, T)));
}

template TemplateInstanceInfo( T ) {
	static if ( is( T t == U!V, alias U, V... ) ) {
		alias U Template;
		alias V Arguments;
	}
}

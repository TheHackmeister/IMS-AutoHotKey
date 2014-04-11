List_LookupID(List,String)
{
	String .= "|"
	Loop, Parse, List,`n
	{
		If InStr(A_LoopField,String)
		{
			return SubStr(A_LoopField, StrLen(String) + 1)
		}
	}
}
	
List_Compare(List,String)
{
	String .= "|"
	Loop, Parse, List,`n
	{
		If InStr(A_LoopField,String)
		{
			return A_Index
		}
	}
}

List_CPUIDLookup(CPU) {
	global CPUList
	return List_LookupID(CPUList,CPU)
}
		

List_ProductIDLookup(Product) {
	global ProductList
	return List_LookupID(ProductList,Product)
}
	
List_CPUCompare(CPU) {
	global CPUList
	return List_Compare(CPUList,CPU)
}
		

		
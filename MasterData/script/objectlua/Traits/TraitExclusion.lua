-- chunkname: @/tmp/or_script/lua_compile/objectlua/Traits/TraitExclusion.lua

require("objectlua.Traits.TraitTransformation")

TraitExclusion = TraitTransformation:subclass()

function TraitExclusion:collectMethodsForSymbolInto(aSymbol)
	return
end

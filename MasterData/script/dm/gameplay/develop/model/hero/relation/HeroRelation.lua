-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/HeroRelation.lua

require("dm.gameplay.develop.model.hero.relation.Relation")

HeroRelation = class("HeroRelation", Relation, _M)

HeroRelation:has("_id", {
	is = "r"
})

function HeroRelation:initialize(id)
	super.initialize(self, id)
end

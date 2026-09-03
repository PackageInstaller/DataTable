-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/GlobalRelation.lua

require("dm.gameplay.develop.model.hero.relation.Relation")

GlobalRelation = class("GlobalRelation", Relation, _M)

GlobalRelation:has("_id", {
	is = "r"
})

function GlobalRelation:initialize(id)
	super.initialize(self, id)
end

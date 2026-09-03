-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/EquipRelation.lua

require("dm.gameplay.develop.model.hero.relation.Relation")

EquipRelation = class("EquipRelation", Relation, _M)

EquipRelation:has("_id", {
	is = "r"
})

function EquipRelation:initialize(id)
	super.initialize(self, id)
end

function EquipRelation:getChangeSkillIds(level)
	level = level or 1

	local specilaEffectId = self:getEffectIdByLevel(level)
	local config = ConfigReader:getRecordById("SkillSpecialEffect", specilaEffectId)

	if config and config.Parameter then
		local parameter = config.Parameter

		return {
			parameter.before,
			parameter.after
		}
	end
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerHeroSkill.lua

TowerHeroSkill = class("TowerHeroSkill", objectlua.Object, _M)

TowerHeroSkill:has("_skillId", {
	is = "rw"
})
TowerHeroSkill:has("_level", {
	is = "rw"
})
TowerHeroSkill:has("_lock", {
	is = "rw"
})
TowerHeroSkill:has("_enable", {
	is = "rw"
})
TowerHeroSkill:has("_owner", {
	is = "r"
})
TowerHeroSkill:has("_group", {
	is = "rw"
})
TowerHeroSkill:has("_effect", {
	is = "rw"
})
TowerHeroSkill:has("_skillPro", {
	is = "rw"
})
TowerHeroSkill:has("_skillProId", {
	is = "rw"
})
TowerHeroSkill:has("_closeEffect", {
	is = "rw"
})
TowerHeroSkill:has("_skillAttrEffect", {
	is = "rw"
})

function TowerHeroSkill:initialize(id)
	super.initialize(self)

	self._skillId = id
	self._level = 0
	self._lock = true
	self._closeEffect = false

	self:updateProById(id)
end

function TowerHeroSkill:updateProById(id)
	self._skillProId = id
	self._skillPro = PrototypeFactory:getInstance():getSkillPrototype(id)
	self._config = self._skillPro:getConfig()
end

function TowerHeroSkill:getName()
	return Strings:get(self._config.Name)
end

function TowerHeroSkill:getType()
	return self._config.Type
end

function TowerHeroSkill:getDesc()
	return self._config.Desc
end

function TowerHeroSkill:getShortDesc()
	return self._config.Desc_short
end

function TowerHeroSkill:getAttrEffects()
	return self._config.AttrEffects
end

function TowerHeroSkill:getSkillRange()
	return self._config.SkillRange
end

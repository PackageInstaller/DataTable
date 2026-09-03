-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/skill/HeroSkill.lua

require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")
require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

HeroSkill = class("HeroSkill", objectlua.Object, _M)

HeroSkill:has("_skillId", {
	is = "rw"
})
HeroSkill:has("_level", {
	is = "rw"
})
HeroSkill:has("_lock", {
	is = "rw"
})
HeroSkill:has("_enable", {
	is = "rw"
})
HeroSkill:has("_owner", {
	is = "r"
})
HeroSkill:has("_group", {
	is = "rw"
})
HeroSkill:has("_effect", {
	is = "rw"
})
HeroSkill:has("_skillPro", {
	is = "rw"
})
HeroSkill:has("_skillProId", {
	is = "rw"
})
HeroSkill:has("_closeEffect", {
	is = "rw"
})
HeroSkill:has("_skillAttrEffect", {
	is = "rw"
})

function HeroSkill:initialize(id)
	super.initialize(self)

	self._skillId = id
	self._level = 0
	self._lock = true
	self._closeEffect = false

	self:updateProById(id)
end

function HeroSkill:createAttrEffect(owner, player, effectName)
	self._owner = owner
	self._skillAttrEffect = SkillAttrEffect:new(effectName)

	self._skillAttrEffect:setOwner(owner, player)
end

function HeroSkill:synchronize(skillData)
	if skillData == nil then
		return
	end

	if skillData.level then
		self._level = skillData.level
	end

	self:setLock(skillData.lock)
	self:setEnable(skillData.enable)

	if skillData.skillId and skillData.skillId ~= self._skillProId then
		self:updateProById(skillData.skillId)
	end

	if not self:getLock() then
		self:rCreateEffect()
	end
end

function HeroSkill:closeEffect()
	self._closeEffect = true
end

function HeroSkill:rCreateEffect()
	if self._closeEffect then
		return
	end

	assert(self._config ~= nil, "Skill with skillId=" .. self._skillId .. " and skillProId=" .. self._skillProId .. " ,config not exsits")

	if not self._config.AttrEffects then
		self._skillAttrEffect:refreshEffects(self._config.AttrEffects, self:getLevel())
		self._skillAttrEffect:rCreateEffect()
	end
end

function HeroSkill:updateProById(id)
	self._skillProId = id
	self._skillPro = PrototypeFactory:getInstance():getSkillPrototype(id)
	self._config = self._skillPro:getConfig()
end

function HeroSkill:setLock(isLock)
	if isLock ~= nil then
		self._lock = isLock
	end
end

function HeroSkill:setEnable(enable)
	if enable ~= nil then
		self._enable = enable
	end
end

function HeroSkill:getConfigId()
	return
end

function HeroSkill:getName()
	return Strings:get(self._config.Name)
end

function HeroSkill:getType()
	return self._config.Type
end

function HeroSkill:getDesc()
	return self._config.Desc
end

function HeroSkill:getShortDesc()
	return self._config.Desc_short
end

function HeroSkill:getAttrEffects()
	return self._config.AttrEffects
end

function HeroSkill:getSkillRange()
	return self._config.SkillRange
end

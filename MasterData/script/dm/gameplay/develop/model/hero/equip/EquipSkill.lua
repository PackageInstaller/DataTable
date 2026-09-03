-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/equip/EquipSkill.lua

require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")
require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

EquipSkill = class("EquipSkill", objectlua.Object, _M)

EquipSkill:has("_id", {
	is = "rw"
})
EquipSkill:has("_level", {
	is = "rw"
})
EquipSkill:has("_owner", {
	is = "r"
})
EquipSkill:has("_effect", {
	is = "rw"
})
EquipSkill:has("_skillPro", {
	is = "rw"
})
EquipSkill:has("_skillAttrEffect", {
	is = "rw"
})

function EquipSkill:initialize(id)
	super.initialize(self)

	self._id = id
	self._level = 0
	self._unlock = false
	self._owner = nil
	self._skillPro = PrototypeFactory:getInstance():getSkillPrototype(id)
	self._config = self._skillPro:getConfig()
end

function EquipSkill:synchronize(skillData)
	if skillData == nil then
		return
	end

	if skillData.level then
		self._level = skillData.level
	end

	if self._owner and self._skillAttrEffect then
		self._skillAttrEffect:removeEffect()
	end
end

function EquipSkill:rCreateEffect()
	self._skillAttrEffect:removeEffect()

	local effects = self:getAttrEffects() or {}

	self._skillAttrEffect:refreshEffects(effects, self:getLevel())
	self._skillAttrEffect:rCreateEffect()
end

function EquipSkill:createAttrEffect(owner, player)
	self._owner = owner
	self._skillAttrEffect = SkillAttrEffect:new(AttrSystemName.kHeroEquipSkill)

	self._skillAttrEffect:setOwner(owner, player)
end

function EquipSkill:getName()
	return Strings:get(self._config.Name)
end

function EquipSkill:getDesc()
	return self._config.Desc
end

function EquipSkill:getAttrEffects()
	return self._config.AttrEffects
end

function EquipSkill:getSkillAttrDesc(style)
	local descs = self._skillPro:getAttrDescs(self._level, style)

	return descs[1]
end

function EquipSkill:getSkillDesc(style, level)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_M
	style.fontSize = style.fontSize or 18
	style.fontColor = style.fontColor or "#FFFFFF"
	level = level or self:getLevel()

	local title = self:getDesc()
	local id = self:getId()

	if level == 0 then
		level = 1
	end

	local desc = ConfigReader:getEffectDesc("Skill", title, id, level, style)
	local getSkillDesc = self:getSkillAttrDesc(style)

	if getSkillDesc then
		local add = "<font face='asset/font/CustomFont_FZYH_M.TTF' size='" .. style.fontSize .. "' color='#ffffff'>，</font>"

		desc = getSkillDesc .. add .. desc
	end

	return desc
end

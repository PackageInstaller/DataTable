-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/skill/HeroSkillList.lua

require("dm.gameplay.develop.model.hero.skill.HeroSkill")

HeroSkillList = class("HeroSkillList", objectlua.Object, _M)

HeroSkillList:has("_skillList", {
	is = "rw"
})
HeroSkillList:has("_owner", {
	is = "rw"
})

function HeroSkillList:initialize(idList, owner)
	super.initialize(self)

	self._owner = owner
	self._skillList = {}

	self:createHeroSkillList(idList)
end

function HeroSkillList:createHeroSkillList(idList)
	for i = 1, #idList do
		local skillId = idList[i]

		if not self._skillList[skillId] then
			local skill = HeroSkill:new(skillId)

			skill:createAttrEffect(self._owner, self._owner:getPlayer(), AttrSystemName.kHeroSkill)

			self._skillList[skillId] = skill
		end
	end
end

function HeroSkillList:synchronize(data)
	for skillId, v in pairs(data) do
		local skill = self._skillList[skillId]

		if not skill then
			self._skillList[skillId] = HeroSkill:new(skillId)
			skill = self._skillList[skillId]

			self._skillList[skillId]:createAttrEffect(self._owner, self._owner:getPlayer(), AttrSystemName.kHeroSkill)
		end

		skill:synchronize(v)
	end
end

function HeroSkillList:getSkillById(id)
	if self._skillList[id] then
		return self._skillList[id]
	end
end

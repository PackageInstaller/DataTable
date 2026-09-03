-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerMasterSkill.lua

TowerMasterSkill = class("TowerMasterSkill", objectlua.Object, _M)

TowerMasterSkill:has("_config", {
	is = "r"
})
TowerMasterSkill:has("_skillProConfig", {
	is = "r"
})
TowerMasterSkill:has("_skillPro", {
	is = "r"
})
TowerMasterSkill:has("_owner", {
	is = "r"
})
TowerMasterSkill:has("_effect", {
	is = "r"
})
TowerMasterSkill:has("_skillProId", {
	is = "rw"
})
TowerMasterSkill:has("_skillAttrEffect", {
	is = "r"
})
TowerMasterSkill:has("_skillType", {
	is = "r"
})
TowerMasterSkill:has("_level", {
	is = "rw"
})
TowerMasterSkill:has("_activeCondition", {
	is = "rw"
})

function TowerMasterSkill:initialize(skillId)
	super.initialize(self)

	self._level = 1
	self._skillType = nil

	self:syncConfig(skillId)
end

function TowerMasterSkill:syncConfig(skillId)
	if not self._skillType then
		local data = ConfigReader:getDataTable("TowerMaster")
		local Master_SkillShowType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")

		for k, v in pairs(data) do
			for i = 1, #Master_SkillShowType do
				local skillId1 = v[Master_SkillShowType[i]]

				if skillId1 == skillId then
					self._skillType = Master_SkillShowType[i]

					break
				end
			end
		end
	end

	self._skillProId = skillId
	self._config = ConfigReader:getRecordById("Skill", skillId)
	self._skillPro = PrototypeFactory:getInstance():getSkillPrototype(skillId)
	self._skillProConfig = self._skillPro:getConfig()
end

function TowerMasterSkill:getQuality()
	return self._config.Quality
end

function TowerMasterSkill:getId()
	return self._config.Id
end

function TowerMasterSkill:getType()
	return self._config.Type
end

function TowerMasterSkill:getBaseType()
	return self._skillProConfig.Type
end

function TowerMasterSkill:getLevel()
	return self._level
end

function TowerMasterSkill:getName()
	return (Strings:get(self._config.Name))
end

function TowerMasterSkill:getMasterSkillDescKey()
	return self._skillProConfig.Desc
end

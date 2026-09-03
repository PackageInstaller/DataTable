-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerMaster.lua

require("dm.gameplay.tower.model.TowerMasterSkill")

TowerMaster = class("TowerMaster", objectlua.Object)

TowerMaster:has("_id", {
	is = "r"
})
TowerMaster:has("_baseId", {
	is = "r"
})
TowerMaster:has("_roleModelId", {
	is = "r"
})
TowerMaster:has("_config", {
	is = "r"
})
TowerMaster:has("_baseConfig", {
	is = "r"
})
TowerMaster:has("_skills", {
	is = "r"
})

function TowerMaster:initialize()
	super.initialize(self)

	self._atk = 0
	self._def = 0
	self._hp = 0
	self._speed = 0
	self._rate = 0
	self._combat = 0
	self._skills = {}
end

function TowerMaster:synchronize(data)
	if data.configId and data.configId ~= "" then
		self._id = data.configId

		self:initConfig()
	end

	if data.rate then
		self._rate = data.rate
	end

	if data.atk then
		self._atk = data.atk * self._rate
	end

	if data.def then
		self._def = data.def * self._rate
	end

	if data.hp then
		self._hp = data.hp * self._rate
	end

	if data.speed then
		self._speed = data.speed
	end

	if data.combat then
		self._combat = data.combat
	end
end

function TowerMaster:initConfig()
	self._config = ConfigReader:requireRecordById("TowerMaster", self._id)

	local enemyId = self._config.Master

	self._baseConfig = ConfigReader:requireRecordById("EnemyMaster", enemyId)

	self:initSkillList()
end

local kConditonKey = {
	TeamSkill5 = "TeamSkillCondition5",
	TeamSkill4 = "TeamSkillCondition4",
	TeamSkill6 = "TeamSkillCondition6",
	TeamSkill3 = "TeamSkillCondition3",
	TeamSkill2 = "TeamSkillCondition2",
	TeamSkill1 = "TeamSkillCondition1"
}
local teamSkillShow = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Master_TeamSkillShow", "content")
local kActionKey = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_MasterSkillShow", "content")

function TowerMaster:initSkillList()
	if not self._config then
		return
	end

	self._teamSkills = {}
	self._skillList = {}

	for i = 1, #teamSkillShow do
		local skillId = self._config[teamSkillShow[i]]
		local conditionKey = kConditonKey[teamSkillShow[i]]
		local condition = self._config[conditionKey]

		if skillId and skillId ~= "" then
			self._teamSkills[skillId] = TowerMasterSkill:new(skillId)

			self._teamSkills[skillId]:setActiveCondition(condition)
			table.insert(self._skillList, self._teamSkills[skillId])
		end
	end

	self._actionSkills = {}

	for i = 1, #kActionKey do
		local skillId = self._config[kActionKey[i]]

		if skillId then
			local skill = TowerMasterSkill:new(skillId)

			table.insert(self._actionSkills, skill)
		end
	end
end

function TowerMaster:getSkillList()
	return self._skillList
end

function TowerMaster:getActionList()
	return self._actionSkills
end

function TowerMaster:getName()
	return (Strings:get(self._baseConfig.Name))
end

function TowerMaster:getFeature()
	return (Strings:get(self._config.Feature))
end

function TowerMaster:getModel()
	return self._baseConfig.RoleModel
end

function TowerMaster:getSpeed()
	return (math.modf(self._speed))
end

function TowerMaster:getAttack()
	return (math.modf(self._atk))
end

function TowerMaster:getDefense()
	return (math.modf(self._def))
end

function TowerMaster:getHp()
	return (math.modf(self._hp))
end

function TowerMaster:getCombat()
	return self._combat
end

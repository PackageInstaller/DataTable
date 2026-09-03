-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterSkill.lua

MasterSkill = class("MasterSkill", objectlua.Object, _M)

MasterSkill:has("_config", {
	is = "r"
})
MasterSkill:has("_skillProConfig", {
	is = "r"
})
MasterSkill:has("_skillPro", {
	is = "r"
})
MasterSkill:has("_owner", {
	is = "r"
})
MasterSkill:has("_effect", {
	is = "r"
})
MasterSkill:has("_skillProId", {
	is = "rw"
})
MasterSkill:has("_skillAttrEffect", {
	is = "r"
})
MasterSkill:has("_skillType", {
	is = "r"
})
MasterSkill:has("_level", {
	is = "rw"
})
MasterSkill:has("_activeCondition", {
	is = "rw"
})

function MasterSkill:initialize(skillId, skillType)
	super.initialize(self)

	self._level = 1
	self._lock = true
	self._enable = true
	self._skillType = nil

	self:syncConfig(skillId, skillType)
end

function MasterSkill:createAttrEffect(owner, player, effectName)
	self._owner = owner
	self._skillAttrEffect = SkillAttrEffect:new(effectName)

	self._skillAttrEffect:setOwner(owner, player)
end

function MasterSkill:syncConfig(skillId, skillType)
	if not self._skillType then
		local data = ConfigReader:getDataTable("MasterBase")
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

	if self._skillType == nil and skillType ~= nil then
		self._skillType = skillType
	end

	self._skillProId = skillId
	self._config = ConfigReader:getRecordById("Skill", skillId)
	self._skillPro = PrototypeFactory:getInstance():getSkillPrototype(skillId)

	local skillConfig = ConfigReader:getRecordById("Skill", skillId)

	self._skillProConfig = self._skillPro:getConfig()
end

function MasterSkill:syncData(skillId, data)
	local effectChange = false

	if data.level and self:getLevel() ~= data.level then
		effectChange = true
		self._level = data.level
	end

	if data.lock ~= nil then
		self._lock = data.lock
	end

	if data.enable ~= nil then
		self._enable = data.enable
	end

	if self._skillProId ~= skillId then
		effectChange = true

		self:syncConfig(skillId)
	end

	if (data.lock or nil) and false and data.lock == false then
		self:rCreateEffect()
	end
end

function MasterSkill:setUnlock(skillId)
	self._lock = false
	self._level = 1
end

function MasterSkill:getTypeById(skillid)
	local showtype = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")
	local costmap = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_Skill_CostMap", "content")
	local configkey

	for k, v in pairs(showtype) do
		local value = ConfigReader:getDataByNameIdAndKey("MasterBase", self:getOwner():getId(), v)

		if value == skillid then
			configkey = v

			break
		end
	end

	return configkey
end

function MasterSkill:rCreateEffect()
	if GameConfigs.closeMasterSkillAttr then
		return
	end

	local effects = self._skillPro:getConfig().AttrEffects

	self._skillAttrEffect:refreshEffects(effects, self:getLevel())
	self._skillAttrEffect:rCreateEffect()
end

function MasterSkill:getUnlockLevel()
	local masterConfig = ConfigReader:getDataByNameIdAndKey("MasterBase", self:getOwner():getId(), "LevelUnlock")
	local condition = masterConfig[self:getTypeById(self._config.Id)]
	local con, contype

	for k, v in pairs(condition) do
		con = v
		contype = k
	end

	return contype, con
end

function MasterSkill:getUnlockUse()
	local masterConfig = ConfigReader:getDataByNameIdAndKey("MasterBase", self:getOwner():getId(), "UseUnlock")
	local condition = masterConfig[self:getTypeById(self._config.Id)]
	local con, contype

	for k, v in pairs(condition) do
		con = v
		contype = k
	end

	return contype, con
end

function MasterSkill:getUpStepDesc()
	return self._config.QualityUpDesc
end

function MasterSkill:getQuality()
	return self._config.Quality
end

function MasterSkill:getId()
	return self._config.Id
end

function MasterSkill:getType()
	return self._config.Type
end

function MasterSkill:getBaseType()
	return self._skillProConfig.Type
end

function MasterSkill:getSkillDescShort()
	local key = self._skillProConfig.Desc_short

	return (Strings:get(key))
end

function MasterSkill:getLock()
	return self._lock
end

function MasterSkill:getEnable()
	return self._enable
end

function MasterSkill:getLevel()
	return self._level
end

function MasterSkill:getCurLevelUpConditon()
	return self:getMasterLevel()
end

function MasterSkill:getLevelUpConditon()
	return self._config.LevelUpConditon
end

function MasterSkill:getName()
	return (Strings:get(self._config.Name))
end

function MasterSkill:getMasterId()
	return self._config.MasterId
end

function MasterSkill:getMasterName()
	local masterConfig = ConfigReader:requireRecordById("MasterBase", tostring(self:getMasterId()))

	return (Strings:get(masterConfig.Name))
end

function MasterSkill:getQualityUpCondition()
	return self._config.QualityUpCondition
end

function MasterSkill:getMasterLevel()
	return self._owner._player:getLevel()
end

function MasterSkill:getQualityUpCost()
	return self._config.QualityUpCost
end

function MasterSkill:getCurLevelUpCost()
	local showtype = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")
	local costmap = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_Skill_CostMap", "content")
	local valuecost

	for k, v in pairs(showtype) do
		local value = ConfigReader:getDataByNameIdAndKey("MasterBase", self:getOwner():getId(), v)

		if value == self._config.Id then
			local configkey = costmap[v]

			valuecost = ConfigReader:getDataByNameIdAndKey("ConfigValue", configkey, "content")

			break
		end
	end

	return valuecost[self._level + 1]
end

function MasterSkill:getLastLevelUpCost()
	local showtype = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")
	local costmap = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_Skill_CostMap", "content")
	local valuecost

	for k, v in pairs(showtype) do
		local value = ConfigReader:getDataByNameIdAndKey("MasterBase", self:getOwner():getId(), v)

		if value == self._config.Id then
			local configkey = costmap[v]

			valuecost = ConfigReader:getDataByNameIdAndKey("ConfigValue", configkey, "content")

			break
		end
	end

	return valuecost[self._level]
end

function MasterSkill:getLevelUpCost()
	return self._config.LevelUpCost
end

function MasterSkill:getMaxLevel()
	return self:getMasterLevel()
end

function MasterSkill:getMasterSkillDesc()
	local key = self._skillProConfig.Desc

	return (Strings:get(key))
end

function MasterSkill:getMasterSkillDescKey()
	return self._skillProConfig.Desc
end

function MasterSkill:getSkillList()
	return self._skillProConfig.SkillList
end

function MasterSkill:getNextSkill()
	return self._config.NextSkill
end

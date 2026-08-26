-- chunkname: @modules/logic/fight/config/StressConfig.lua

module("modules.logic.fight.config.StressConfig", package.seeall)

local StressConfig = class("StressConfig", BaseConfig)

function StressConfig:ctor()
	return
end

function StressConfig:reqConfigNames()
	return {
		"stress_const",
		"stress",
		"stress_rule",
		"stress_identity"
	}
end

function StressConfig:onConfigLoaded(configName, configTable)
	if configName == "stress" then
		self:buildStressConfig(configTable)
	elseif configName == "stress_identity" then
		self:buildStressIdentityConfig(configTable)
	end
end

function StressConfig:buildStressConfig(configTable)
	self.identity2Stress = {}

	for _, stressCo in ipairs(configTable.configList) do
		local identity = stressCo.identity
		local stressDict = self.identity2Stress[identity]

		if not stressDict then
			stressDict = {}
			self.identity2Stress[identity] = stressDict
		end

		local type = stressCo.type
		local stressList = stressDict[type]

		if not stressList then
			stressList = {}
			stressDict[type] = stressList
		end

		table.insert(stressList, stressCo)
	end
end

function StressConfig:buildStressIdentityConfig(configTable)
	self.identityType2List = {}

	for _, stressCo in ipairs(configTable.configList) do
		local identity = stressCo.identity
		local stressList = self.identityType2List[identity]

		if not stressList then
			stressList = {}
			self.identityType2List[identity] = stressList
		end

		table.insert(stressList, stressCo)
	end
end

function StressConfig:getStressDict(identity)
	identity = tonumber(identity)

	return identity and self.identity2Stress[identity]
end

function StressConfig:getStressBehaviourName(behaviour)
	self.behaviour2ConstId = self.behaviour2ConstId or {
		[FightEnum.StressBehaviour.Positive] = 12,
		[FightEnum.StressBehaviour.Negative] = 13,
		[FightEnum.StressBehaviour.Meltdown] = 14,
		[FightEnum.StressBehaviour.Resolute] = 15,
		[FightEnum.StressBehaviour.BaseAdd] = 17,
		[FightEnum.StressBehaviour.BaseReduce] = 18,
		[FightEnum.StressBehaviour.BaseResolute] = 19,
		[FightEnum.StressBehaviour.BaseMeltdown] = 20
	}

	local constId = self.behaviour2ConstId[behaviour]

	if not constId then
		logError("不支持的压力行为:" .. tostring(behaviour))

		return ""
	end

	local constCo = lua_stress_const.configDict[constId]

	return constCo and constCo.value2
end

function StressConfig:getHeroIdentityList(heroCo)
	self.tempIdentityList = self.tempIdentityList or {}

	tabletool.clear(self.tempIdentityList)

	local career = heroCo.career
	local careerStressRuleList = self.identityType2List[FightEnum.IdentityType.Career]

	for _, co in ipairs(careerStressRuleList) do
		if tonumber(co.typeParam) == career then
			table.insert(self.tempIdentityList, co)
		end
	end

	local heroType = heroCo.heroType
	local heroTypeStressRuleList = self.identityType2List[FightEnum.IdentityType.HeroType]

	for _, co in ipairs(heroTypeStressRuleList) do
		if tonumber(co.typeParam) == heroType then
			table.insert(self.tempIdentityList, co)
		end
	end

	local battleTag = string.split(heroCo.battleTag, "#")
	local battleTagStressRuleList = self.identityType2List[FightEnum.IdentityType.BattleTag]

	for _, tag in ipairs(battleTag) do
		for _, co in ipairs(battleTagStressRuleList) do
			if co.typeParam == tag then
				table.insert(self.tempIdentityList, co)

				break
			end
		end
	end

	local heroId = heroCo.id
	local heroIdStressRuleList = self.identityType2List[FightEnum.IdentityType.HeroId]

	for _, co in ipairs(heroIdStressRuleList) do
		if tonumber(co.typeParam) == heroId then
			table.insert(self.tempIdentityList, co)
		end
	end

	return self.tempIdentityList
end

function StressConfig:getHeroIdentityText(heroCo)
	local identityCoList = self:getHeroIdentityList(heroCo)
	local str = ""

	for _, co in ipairs(identityCoList) do
		if co.isNoShow ~= 1 then
			str = str .. string.format("<color=#d2c197><link=%s><u><%s></u></link></color>", co.id, co.name)
		end
	end

	return str
end

function StressConfig:getHeroTip()
	local constCo = lua_stress_const.configDict[16]

	return constCo.value2
end

StressConfig.instance = StressConfig.New()

return StressConfig

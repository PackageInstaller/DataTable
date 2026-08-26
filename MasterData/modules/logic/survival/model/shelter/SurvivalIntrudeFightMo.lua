-- chunkname: @modules/logic/survival/model/shelter/SurvivalIntrudeFightMo.lua

module("modules.logic.survival.model.shelter.SurvivalIntrudeFightMo", package.seeall)

local SurvivalIntrudeFightMo = pureTable("SurvivalIntrudeFightMo")

function SurvivalIntrudeFightMo:init(data)
	self.fightId = data.fightId
	self.status = data.status
	self.stageNo = data.stageNo
	self.beginTime = data.beginTime
	self.endTime = data.endTime
	self.currRound = data.currRound
	self.schemes = {}

	for _, v in ipairs(data.schemes) do
		self.schemes[v.id] = v.repress
	end

	if self.fightId > 0 then
		self.fightCo = lua_survival_shelter_intrude_fight.configDict[self.fightId]
		self.intrudeSchemeMos = {}

		local max = 0

		self.cleanPoints = string.splitToNumber(self.fightCo.cleanLevel, "|")

		for i, v in ipairs(data.schemes) do
			local point = self.cleanPoints[i]

			if max < point then
				max = point
			end

			self.intrudeSchemeMos[i] = SurvivalIntrudeSchemeMo.New()

			self.intrudeSchemeMos[i]:setData(v, point)
		end

		self.maxCleanPoint = max
	end

	self.repressNpcIds = data.repressNpcIds
	self.usedHeroId = {}
	self.usedEquipPlan = {}
	self.maxRound = #data.rounds

	for round, v in ipairs(data.rounds) do
		for _, vv in ipairs(v.heroes) do
			self.usedHeroId[vv.heroId] = round
		end

		self.usedEquipPlan[v.equipPlanId] = round
	end

	self.intrudeMonsterInfo = data.monsters

	SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(self.repressNpcIds)
end

function SurvivalIntrudeFightMo:getIntrudeSchemeMo(id)
	for i, v in ipairs(self.intrudeSchemeMos) do
		if v.survivalIntrudeScheme.id == id then
			return v
		end
	end
end

function SurvivalIntrudeFightMo:canShowBossUI()
	return self.fightId > 0
end

function SurvivalIntrudeFightMo:isNotStart()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local day = weekInfo.day

	return day < self.beginTime
end

function SurvivalIntrudeFightMo:canShowEntity()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local day = weekInfo.day

	return day >= self.beginTime and day <= self.endTime and self.status <= SurvivalEnum.ShelterMonsterFightState.Fail
end

function SurvivalIntrudeFightMo:canFight()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local day = weekInfo.day

	return day == self.endTime and (self.status == SurvivalEnum.ShelterMonsterFightState.NoStart or self.status == SurvivalEnum.ShelterMonsterFightState.Fighting)
end

function SurvivalIntrudeFightMo:needKillBoss()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo.day >= self.endTime and self.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function SurvivalIntrudeFightMo:canSelectNpc()
	return self:canFight() and self.status == SurvivalEnum.ShelterMonsterFightState.NoStart
end

function SurvivalIntrudeFightMo:canEnterSelectNpc()
	return self.status == SurvivalEnum.ShelterMonsterFightState.NoStart
end

function SurvivalIntrudeFightMo:getUseRoundByHeroId(heroId)
	if self.usedHeroId ~= nil then
		for _heroId, round in pairs(self.usedHeroId) do
			if _heroId == heroId then
				return round
			end
		end
	end

	return nil
end

function SurvivalIntrudeFightMo:getUseRoundByHeroUid(heroUid)
	if self.usedHeroId ~= nil then
		for heroId, round in pairs(self.usedHeroId) do
			local heroMo = HeroModel.instance:getByHeroId(heroId)

			if heroMo and heroMo.uid == heroUid then
				return round
			end
		end
	end

	return nil
end

function SurvivalIntrudeFightMo:canShowReset()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo.day >= self.beginTime and (self.status == SurvivalEnum.ShelterMonsterFightState.Fighting or self.status == SurvivalEnum.ShelterMonsterFightState.Fail) and #self.intrudeMonsterInfo > 0
end

function SurvivalIntrudeFightMo:canShowFightBtn()
	return self.status ~= SurvivalEnum.ShelterMonsterFightState.Fail
end

function SurvivalIntrudeFightMo:canAbandon()
	return self.status == SurvivalEnum.ShelterMonsterFightState.NoStart or self.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function SurvivalIntrudeFightMo:isFighting()
	return self.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function SurvivalIntrudeFightMo:setWin()
	self.status = SurvivalEnum.ShelterMonsterFightState.Win
end

function SurvivalIntrudeFightMo:getBattleId()
	return self.fightCo.battleId
end

return SurvivalIntrudeFightMo

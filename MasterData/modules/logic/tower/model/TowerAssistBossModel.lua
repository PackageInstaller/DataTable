-- chunkname: @modules/logic/tower/model/TowerAssistBossModel.lua

module("modules.logic.tower.model.TowerAssistBossModel", package.seeall)

local TowerAssistBossModel = class("TowerAssistBossModel", BaseModel)

function TowerAssistBossModel:onInit()
	self:reInit()
end

function TowerAssistBossModel:reInit()
	self.tempBossDict = {}
end

function TowerAssistBossModel:updateAssistBossInfo(info)
	local id = info.id
	local mo = self:getById(id)

	if not mo then
		mo = TowerAssistBossMo.New()

		mo:init(id)
		self:addAtLast(mo)
	end

	mo:setTempState(false)
	mo:updateInfo(info)
end

function TowerAssistBossModel:onTowerActiveTalent(info)
	local id = info.bossId
	local mo = self:getById(id)

	if mo then
		mo:onTowerActiveTalent(info)
	end
end

function TowerAssistBossModel:onTowerResetTalent(info)
	local id = info.bossId
	local mo = self:getById(id)

	if mo then
		mo:onTowerResetTalent(info)
	end
end

function TowerAssistBossModel:getBoss(bossId)
	local mo = self:getById(bossId) or self.tempBossDict[bossId]

	if not mo then
		mo = TowerAssistBossMo.New()

		mo:init(bossId)
		mo:initTalentIds()

		self.tempBossDict[bossId] = mo
	end

	return mo
end

function TowerAssistBossModel:onTowerRenameTalentPlan(info)
	local id = info.bossId
	local mo = self:getById(id)

	if mo then
		mo:renameTalentPlan(info.planName)
	end
end

function TowerAssistBossModel:cleanTrialLevel()
	local bossMOList = self:getList()

	for _, bossMO in ipairs(bossMOList) do
		bossMO:setTrialInfo(0, bossMO.useTalentPlan)
	end
end

function TowerAssistBossModel:getLimitedTrialBossSaveKey(bossMo)
	local openTowerInfo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if not openTowerInfo then
		return ""
	end

	return "TowerLimitedTrialBoss" .. openTowerInfo.towerId .. "_" .. bossMo.id
end

function TowerAssistBossModel:setLimitedTrialBossInfo(bossMo)
	local curBossLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local savePlan = self:getLimitedTrialBossLocalPlan(bossMo)

	bossMo:setTrialInfo(curBossLevel, savePlan)
	bossMo:refreshTalent()
end

function TowerAssistBossModel:getLimitedTrialBossLocalPlan(bossMo)
	local saveKey = self:getLimitedTrialBossSaveKey(bossMo)
	local allTalentPlanList = TowerConfig.instance:getAllTalentPlanConfig(bossMo.id)
	local firstTalentPlane = allTalentPlanList[1].planId

	return (TowerController.instance:getPlayerPrefs(saveKey, firstTalentPlane))
end

function TowerAssistBossModel:getLimitedTrialBossTalentPlan(towerParam)
	local limitedTrialPlan = 0
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local bossId = curGroupMO and curGroupMO:getAssistBossId() or FightModel.instance.last_fightGroup.assistBossId
	local bossMo = self:getBoss(bossId)

	if towerParam.towerType == TowerEnum.TowerType.Limited then
		local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

		limitedTrialPlan = bossMo and bossMo.trialTalentPlan > 0 and limitedTrialLevel > bossMo.level and bossMo.trialTalentPlan or 0

		return limitedTrialPlan
	else
		return (bossMo or nil) and (bossMo.useTalentPlan or 0)
	end

	return limitedTrialPlan
end

function TowerAssistBossModel:getTempUnlockTrialBossMO(bossId)
	if not bossId or bossId == 0 then
		return
	end

	local assistBossMO = self:getById(bossId)

	if not assistBossMO then
		assistBossMO = self:buildTempUnlockTrialBossMO(bossId)

		self:addAtLast(assistBossMO)

		return assistBossMO
	elseif assistBossMO and assistBossMO:getTempState() then
		return self:buildTempUnlockTrialBossMO(bossId, assistBossMO)
	end
end

function TowerAssistBossModel:buildTempUnlockTrialBossMO(bossId, bossMO)
	local assistBossMO = bossMO or TowerAssistBossMo.New()

	assistBossMO:init(bossId)
	assistBossMO:setTempState(true)

	local bossLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local useTalentPlan = self:getLimitedTrialBossLocalPlan({
		id = bossId
	})

	assistBossMO:setTrialInfo(bossLevel, useTalentPlan)
	assistBossMO:refreshTalent()

	return assistBossMO
end

function TowerAssistBossModel.sortBossList(openInfoMO1, openInfoMO2)
	if openInfoMO1.towerStartTime ~= openInfoMO2.towerStartTime then
		return openInfoMO1.towerStartTime > openInfoMO2.towerStartTime
	else
		return openInfoMO1.towerId < openInfoMO2.towerId
	end
end

TowerAssistBossModel.instance = TowerAssistBossModel.New()

return TowerAssistBossModel

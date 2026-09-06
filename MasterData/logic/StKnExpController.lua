-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/controller/StKnExpController.lua

module("logic.extensions.stknexp.controller.StKnExpController", package.seeall)

local StKnExpController = class("StKnExpController", BaseController)

function StKnExpController:onInit()
	self:onReset()
end

function StKnExpController:onReset()
	self._opCultTypes = {
		"island"
	}

	table.insertto(self._opCultTypes, StKnExpEnum.CultTypeList)
end

function StKnExpController:saveOpCultTypes(arr)
	self._opCultTypes = arr or ""

	local str = self:getOpCultTypesStr()

	print("skt--------->保存完毕：" .. str)
end

function StKnExpController:getOpCultTypesStr()
	local str = ""

	if self._opCultTypes then
		for i, v in ipairs(self._opCultTypes) do
			str = str .. ", " .. v
		end
	end

	return str
end

function StKnExpController:isCanCult(cultType)
	return table.indexof(self._opCultTypes, cultType) ~= false
end

function StKnExpController:sendPM_SaintKnightExpeditionInfoReq(activityId)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionInfoReq(activityId)
end

function StKnExpController:handlePM_SaintKnightExpeditionInfoRes(msg)
	local activityId = msg.activityId
	local mo = self:getSubMo(activityId)

	mo:handlePM_SaintKnightExpeditionInfoRes(msg)
	self:_updateRedInBossTimesClg(activityId)
	self:_updateRedInBossPrizeClg(activityId)
	self:_updateRedInIslandUpgarde(activityId)
	self:updateRedInMining(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes)
end

function StKnExpController:sendPM_SaintKnightExpeditionMiningReq(activityId)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionMiningReq(activityId)
end

function StKnExpController:handlePM_SaintKnightExpeditionMiningRes(msg)
	local activityId = msg.activityId
	local mo = self:getSubMo(activityId)

	mo:handlePM_SaintKnightExpeditionMiningRes(msg)
	self:updateRedInMining(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionMiningRes)
end

function StKnExpController:sendPM_SaintKnightExpeditionUpgardeIslandReq(activityId, islandIdAndNum)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionUpgardeIslandReq(activityId, islandIdAndNum)
end

function StKnExpController:handlePM_SaintKnightExpeditionUpgardeIslandRes(msg)
	local activityId = msg.activityId
	local mo = self:getSubMo(activityId)

	mo:handlePM_SaintKnightExpeditionUpgardeIslandRes(msg)
	self:_updateRedInIslandUpgarde(activityId)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionUpgardeIslandRes, msg)
end

function StKnExpController:sendPM_SaintKnightExpeditionChallengeReq(activityId, zoneId, stageId, form)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionChallengeReq(activityId, zoneId, stageId, form)
end

function StKnExpController:handlePM_SaintKnightExpeditionChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionChallengeRes)
end

function StKnExpController:sendPM_SaintKnightExpeditionBossChallengeReq(activityId, zoneId, simulate, form, saintKnightBuffIds)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionBossChallengeReq(activityId, zoneId, simulate, form, saintKnightBuffIds)
end

function StKnExpController:handlePM_SaintKnightExpeditionBossChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionBossChallengeRes)
end

function StKnExpController:sendPM_SaintKnightExpeditionGainBossPrizeReq(activityId, zoneId, prizeId)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionGainBossPrizeReq(activityId, zoneId, prizeId)
end

function StKnExpController:handlePM_SaintKnightExpeditionGainBossPrizeRes(msg)
	local activityId = msg.activityId
	local mo = self:getSubMo(activityId)

	mo:handlePM_SaintKnightExpeditionGainBossPrizeRes(msg)
	self:_updateRedInBossTimesClg(activityId)
	self:_updateRedInBossPrizeClg(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionGainBossPrizeRes)
end

function StKnExpController:sendPM_SaintKnightExpeditionStageRankInfoReq(activityId, zoneId)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionStageRankInfoReq(activityId, zoneId)
end

function StKnExpController:handlePM_SaintKnightExpeditionStageRankInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_SaintKnightExpeditionStageRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionStageRankInfoRes, msg)
end

function StKnExpController:sendPM_SaintKnightExpeditionBossRankInfoReq(activityId, zoneId)
	SaintKnightExpeditionAgent.instance:sendPM_SaintKnightExpeditionBossRankInfoReq(activityId, zoneId)
end

function StKnExpController:handlePM_SaintKnightExpeditionBossRankInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_SaintKnightExpeditionBossRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SaintKnightExpeditionBossRankInfoRes, msg)
end

function StKnExpController:handlePM_NotifySaintKnightExpeditionChallengeEndRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_NotifySaintKnightExpeditionChallengeEndRes(msg)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifySaintKnightExpeditionChallengeEndRes)
end

function StKnExpController:handlePM_NotifySaintKnightExpeditionBossChallengeEndRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_NotifySaintKnightExpeditionBossChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifySaintKnightExpeditionBossChallengeEndRes)
end

function StKnExpController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.StKnExp)
end

function StKnExpController:getSubMo(activityId)
	return StKnExpModel.instance:getSubMo(activityId)
end

function StKnExpController:enterBattleInStage(activityId, zoneId, stageId)
	local fmtMo = StKnExpModel.instance:getStageFmtMo()

	fmtMo:updateCfg(activityId, zoneId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function StKnExpController:enterBattleInBoss(activityId, zoneId, isSimulate)
	local fmtMo = StKnExpModel.instance:getBossFmtMo()

	fmtMo:updateCfg(activityId, zoneId, isSimulate)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function StKnExpController:updatePetByCult(activityId, petMo)
	local petId = petMo:getPetId()
	local subMo = self:getSubMo(activityId)
	local supportData = StKnExpConfig.instance:getSupportData(activityId, petId)

	petMo.awakeLevel = CharacterConfig.instance:getMaxAwaken(supportData.raceId)
	petMo.summonMasterId = checknumber(supportData.summonMasterId)
	petMo.summonedPetId = checknumber(supportData.summonedPetId)
	petMo.carriedMasterId = checknumber(supportData.carriedMasterId)
	petMo.carriedPetId = checknumber(supportData.carriedPetId)
	petMo.heavenAwakenMasterId = checknumber(supportData.heavenAwakenMasterId)
	petMo.heavenAwakenSummonPetId = checknumber(supportData.heavenAwakenSummonPetId)
	petMo.oracleMasterId = checknumber(supportData.oracleMasterId)
	petMo.oraclePetId = checknumber(supportData.oraclePetId)
	petMo.oraclePetRaceId = checknumber(supportData.oraclePetRaceId)
	petMo.bookSpiritPetId = checknumber(supportData.bookSpiritPetId)
	petMo.bookSpiritRaceId = checknumber(supportData.bookSpiritRaceId)

	local petCo = CharacterConfig.instance:getPetCo(supportData.raceId)
	local skillLevelStrategyId = petCo.skillLevelStrategyId
	local normalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.NORMAL)
	local ultimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.ULTIMATE)
	local passiveSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PASSIVE)
	local psychicedNormalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_NORMAL)
	local psychicedUltimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_ULTIMATE)

	petMo.contractSkillId = checknumber(supportData.contractSkillId)
	petMo.normalSkillLv = normalSkillLv
	petMo.ultimateSkillLv = ultimateSkillLv
	petMo.passiveSkillLv = passiveSkillLv
	petMo.psychicedUltimateSkillLv = psychicedUltimateSkillLv
	petMo.psychicedNormalSkillLv = psychicedNormalSkillLv

	local petLevel = subMo:getCultLevel(StKnExpEnum.CultType_Pet)
	local starGodLevel = subMo:getCultLevel(StKnExpEnum.CultType_StarGod)
	local holyStripeLevel = subMo:getCultLevel(StKnExpEnum.CultType_HolyStripe)
	local cutePetLevel = subMo:getCultLevel(StKnExpEnum.CultType_CutePet)

	if self:isCanCult(StKnExpEnum.CultType_Pet) then
		local petData = StKnExpConfig.instance:getPetLevelData(activityId, petLevel)

		if petData then
			petMo.level = petData.lv
			petMo.talentLevel = petData.talentLv
		end
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	petMo.equipments = {}

	for _, posId in pairs(PetEquipModel.EquipPos) do
		if self:isCanCult(StKnExpEnum.CultTypeEquips[posId]) then
			local level = subMo:getCultLevel(StKnExpEnum.CultTypeEquips[posId])
			local data = StKnExpConfig.instance:getEquLevelData(activityId, firstJobIdx, posId, level)

			if data then
				local obj = {}

				obj.positionId = posId
				obj.defineId = data.defineId
				obj.lv = data.equipmentLv

				table.insert(petMo.equipments, obj)
			end
		end
	end

	if self:isCanCult(StKnExpEnum.CultType_StarGod) then
		local starGodData = StKnExpConfig.instance:getStarGodLevelData(activityId, starGodLevel)

		if starGodData then
			local starGodLv = starGodData.starGodLv

			if supportData then
				if not supportData.fixedStarGodId then
					local fixedStarGodId = {}

					petMo.starGodPlusSlots = {}

					for slot, fillerDefineId in ipairs(fixedStarGodId) do
						local star = {}
						local slotCfg = StargodplusConfig.instance:getSlotCfg(slot)
						local cc = StargodplusConfig.instance:getSlotLvPlanByLv(slotCfg.slotLvPlan, starGodLv)

						if cc then
							star.slot = slot
							star.exp = checknumber(cc.exp)
							star.fillerDefineId = fillerDefineId

							table.insert(petMo.starGodPlusSlots, star)
						end
					end
				end
			end
		end
	end

	local extpropertiesArr = petMo.extpropertiesArr

	if self:isCanCult(StKnExpEnum.CultType_HolyStripe) then
		local holyStripeData = StKnExpConfig.instance:getHolyStripeData(activityId, holyStripeLevel)

		if holyStripeData then
			local attrs = FightingPowerFormula.instance:parseAttrValues(holyStripeData.extproperties) or {}

			extpropertiesArr = AttrMo.addSameAttrs(attrs, extpropertiesArr)
		end
	end

	if self:isCanCult(StKnExpEnum.CultType_CutePet) then
		local cutePetData = StKnExpConfig.instance:getCutePetData(activityId, cutePetLevel)

		if cutePetData then
			local attrs = FightingPowerFormula.instance:parseAttrValues(cutePetData.extproperties) or {}

			extpropertiesArr = AttrMo.addSameAttrs(attrs, extpropertiesArr)
		end
	end

	if self:isCanCult("island") then
		local islandCfg = StKnExpConfig.instance:getIslandCfg(activityId) or {}

		for islandId, islandData in ipairs(islandCfg) do
			local curLevel = subMo:getIslandLevel(islandId)
			local data = StKnExpConfig.instance:getIslandLevelData(activityId, islandId, curLevel)

			if data and not string.nilorempty(data.extproperties) then
				local attrs = FightingPowerFormula.instance:parseAttrValues(data.extproperties) or {}

				extpropertiesArr = AttrMo.addSameAttrs(attrs, extpropertiesArr)
			end
		end
	end

	petMo.extpropertiesArr = extpropertiesArr

	petMo:calcAllAttr()

	return petMo
end

function StKnExpController:getRedIdInBossTimes(activityId, zoneId)
	return string.format("StKnExp_Boss_Times_%s_%s", activityId, zoneId)
end

function StKnExpController:_updateRedInBossTimesClg(activityId)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
	local subMo
	local cfg = StKnExpConfig.instance:getZoneCfg(activityId)

	for _, data in ipairs(cfg or {}) do
		subMo = subMo or self:getSubMo(activityId)

		local zoneId = data.zoneId
		local redId = self:getRedIdInBossTimes(activityId, zoneId)

		RedPointController.instance:setRedPointInfo(redId, (isInTime and subMo:getClgTypeInZone(zoneId) == StKnExpEnum.ClgType_Boss and not subMo:isPassBossClgInZone(zoneId) and subMo:isEnoughBossTimes(zoneId) or nil) and true)
	end
end

function StKnExpController:getRedIdInBossPrize(activityId, zoneId)
	return string.format("StKnExp_Boss_Prize_%s_%s", activityId, zoneId)
end

function StKnExpController:_updateRedInBossPrizeClg(activityId)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
	local subMo
	local cfg = StKnExpConfig.instance:getZoneCfg(activityId)

	for _, data in ipairs(cfg or {}) do
		subMo = subMo or self:getSubMo(activityId)

		local zoneId = data.zoneId
		local redId = self:getRedIdInBossPrize(activityId, zoneId)

		RedPointController.instance:setRedPointInfo(redId, (isInTime and subMo:isCanGetPrizeInBossZone(zoneId) or nil) and true)
	end
end

function StKnExpController:_updateRedInIslandUpgarde(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local subMo = self:getSubMo(activityId)
		local result = subMo:getTryResultAndTipsOneKeyUpgardeIsland(false)

		isActivated = result == GameEnum.ResultCode.Success
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_STKNEXP_ISLAND_UPGARDE, isActivated)
end

function StKnExpController:updateRedInMining(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local subMo = self:getSubMo(activityId)
		local result = subMo:getTryResultAndTipsMining(false)

		isActivated = result == GameEnum.ResultCode.Success
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_STKNEXP_MINING, isActivated)
end

StKnExpController.instance = StKnExpController.New()

return StKnExpController

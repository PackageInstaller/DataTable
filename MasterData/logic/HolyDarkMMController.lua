-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/controller/HolyDarkMMController.lua

module("logic.extensions.holydarkmm.controller.HolyDarkMMController", package.seeall)

local HolyDarkMMController = class("HolyDarkMMController", BaseController)

function HolyDarkMMController:onInit()
	return
end

function HolyDarkMMController:onReset()
	return
end

function HolyDarkMMController:sendPM_HolyDarkMMChallengeInfoReq(activityId)
	HolyDarkMMChallengeAgent.instance:sendPM_HolyDarkMMChallengeInfoReq(activityId)
end

function HolyDarkMMController:handlePM_HolyDarkMMChallengeInfoRes(status, msg)
	HolyDarkMMModel.instance:setChallengeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyDarkMMChallengeInfoRes, msg)
end

function HolyDarkMMController:sendPM_HolyDarkMMChallengeReq(activityId, stageId, form, formPlanId, angleId)
	HolyDarkMMChallengeAgent.instance:sendPM_HolyDarkMMChallengeReq(activityId, stageId, form, formPlanId, angleId)
end

function HolyDarkMMController:handlePM_HolyDarkMMChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function HolyDarkMMController:handlePM_NotifyHolyDarkMMChallengeEndRes(status, msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
end

function HolyDarkMMController:sendPM_HolyDarkMMChallengeResetReq(activityId, stageId)
	HolyDarkMMChallengeAgent.instance:sendPM_HolyDarkMMChallengeResetReq(activityId, stageId)
end

function HolyDarkMMController:handlePM_HolyDarkMMChallengeResetRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyDarkMMChallengeResetRes, status)
end

function HolyDarkMMController:petCollectionProgress(activityId)
	local data = HolyDarkMMConfig.instance:getHolyDarkMMActCfg(activityId)

	if data then
		if not data.petRaceIds then
			local petRaceIds = {}
			local collectionNum = 0

			for _, raceId in pairs(petRaceIds) do
				if HandbookModel.instance:isHasPet(raceId) then
					collectionNum = collectionNum + 1
				end
			end

			local holyPetNum = table.nums(petRaceIds)

			collectionNum = Mathf.Clamp(collectionNum, 0, holyPetNum)

			return collectionNum, collectionNum / holyPetNum
		end
	end
end

function HolyDarkMMController:petOccupiedGridNum(posIds)
	local posXNum = 1
	local posYNum = 1
	local posCfg = posIds

	if #posCfg > 1 then
		table.sort(posCfg, function(a, b)
			return a < b
		end)

		for i = 2, #posCfg do
			local gap = posCfg[i] - posCfg[i - 1]

			if gap < 3 then
				posYNum = posYNum + 1
			elseif gap == 3 then
				posXNum = posXNum + 1
			end
		end
	end

	return posXNum, posYNum
end

function HolyDarkMMController:calculPetHpRate(stageId, creepCfg)
	local monsterInfo = HolyDarkMMModel.instance:getMonsterInfo(stageId)

	if table.nums(monsterInfo) > 0 then
		for _, v in pairs(monsterInfo) do
			if v.creepId == creepCfg.creepsId then
				local extproperties = FightingPowerFormula.instance:parseAttrValues(creepCfg.extproperties)

				if extproperties then
					local hp = extproperties[GameEnum.AttrType.Hp]

					return Mathf.Clamp(Mathf.Ceil(v.hp / hp * 100), 0, 100)
				end
			end
		end
	end

	return 100
end

function HolyDarkMMController:isPassGridNum(activityId, stageId)
	local stageCfg = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(activityId, stageId)
	local monsterInfo = HolyDarkMMModel.instance:getMonsterInfo(stageId)

	if table.nums(monsterInfo) <= 0 then
		return 0, false
	end

	local passNum = 0

	for _, info in pairs(monsterInfo) do
		if info.hp <= 0 then
			local creepCfg = HolyDarkMMConfig.instance:getHolyDarkMMCreepCfg(stageCfg.creepsMasterId, info.creepId)
			local posXNum, posYNum = self:petOccupiedGridNum(creepCfg.posIds)

			if posXNum == 1 and posYNum == 1 then
				passNum = passNum + 1
			elseif posXNum == 1 then
				posXNum = 0
				passNum = passNum + 0 + posYNum
			elseif posYNum == 1 then
				posYNum = 0
				passNum = passNum + posXNum + 0
			end
		end
	end

	return passNum
end

function HolyDarkMMController:openHolyDarkMMChallengeForm(activityId, stageId, formPlanId, angleId, formationPosList, levelId)
	CustomFmtController.instance:showMissionView(HolyDarkMMModel.instance:getChallengeFmtMo(activityId, stageId, formPlanId, angleId, formationPosList, levelId))
end

function HolyDarkMMController:filterCreepsCfg(creepsMasterId, formationPosList, levelId)
	local creepCfg = HolyDarkMMConfig.instance:getHolyDarkMMCreepGroupCfg(creepsMasterId)
	local cfg = {}

	for k, v in pairs(creepCfg) do
		local posIds = v.posIds

		for _, pos in pairs(posIds) do
			if formationPosList[pos] == 1 then
				local hpPercent = self:calculPetHpRate(levelId, v)

				if hpPercent > 0 and not TableUtil.isHad(cfg, v) then
					table.insert(cfg, v)
				end
			end
		end
	end

	return cfg
end

HolyDarkMMController.instance = HolyDarkMMController.New()

return HolyDarkMMController

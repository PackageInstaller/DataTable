-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/controller/TeShaMuChallengeController.lua

module("logic.extensions.teshamu.controller.TeShaMuChallengeController", package.seeall)

local TeShaMuChallengeController = class("TeShaMuChallengeController", BaseController)

function TeShaMuChallengeController:ctor()
	return
end

function TeShaMuChallengeController:onInit()
	self:onReset()
end

function TeShaMuChallengeController:onReset()
	self.levelInfo = {}
end

function TeShaMuChallengeController:sendPM_TeshamuGetInfoReq(activityId)
	TeshamuChallengeAgent.instance:sendPM_TeshamuGetInfoReq(activityId)
end

function TeShaMuChallengeController:handlePM_TeshamuGetInfoRes(status, msg)
	TeShaMuChallengeModel.instance:setStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TeshamuGetInfoRes, msg)
end

function TeShaMuChallengeController:sendPM_TeshamuChallengeReq(activityId, stageId, blockId, form)
	TeshamuChallengeAgent.instance:sendPM_TeshamuChallengeReq(activityId, stageId, blockId, form)
end

function TeShaMuChallengeController:handlePM_TeshamuChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.TeshamuChallengeRes, msg)
end

function TeShaMuChallengeController:sendPM_TeshamuResetReq(activityId, stageId)
	TeshamuChallengeAgent.instance:sendPM_TeshamuResetReq(activityId, stageId)
end

function TeShaMuChallengeController:handlePM_TeshamuResetRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.TeshamuResetRes, msg)
end

function TeShaMuChallengeController:sendPM_TeshamuUpgradeSignInBuffReq(activityId)
	TeshamuChallengeAgent.instance:sendPM_TeshamuUpgradeSignInBuffReq(activityId)
end

function TeShaMuChallengeController:handlePM_TeshamuUpgradeSignInBuffRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.TeshamuUpgradeSignInBuff, msg)
end

function TeShaMuChallengeController:setStageInfo(stageId)
	local stageInfo = TeShaMuChallengeModel.instance:getStageInfo()

	self.levelInfo = {}

	if not TableUtil.isTableEmpty(stageInfo) then
		for i, v in pairs(stageInfo) do
			if v.stageId == stageId then
				self.levelInfo = v
			end
		end
	end
end

function TeShaMuChallengeController:getStageId()
	local stageId = TeShaMuChallengeModel.instance:getStageId()

	if stageId < 1 then
		local lastStageId = 1
		local activityId = TeShaMuChallengeModel.instance:getActId()
		local stageCfg = TeShaMuChallengeConfig.instance:getStageCfg(activityId)

		for _, v in ipairs(stageCfg) do
			local isPass = self:isStagePass(v.stageId)

			if not isPass then
				if self:stageIsUnLock(v.stageId) then
					return v.stageId
				else
					return lastStageId
				end
			end

			lastStageId = v.stageId
		end

		return #stageCfg
	else
		return stageId
	end
end

function TeShaMuChallengeController:stageIsUnLock(stageId)
	local activityId = TeShaMuChallengeModel.instance:getActId()
	local stageCfg = TeShaMuChallengeConfig.instance:getStageCfgById(activityId, stageId)
	local openDays = stageCfg.openDays + 1
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TeshamuChallenge, activityId)
	local openTime = GameUtil.getTimestampOnStartAndEnd(startTime, openDays, 0)

	return openTime <= ServerTime.now()
end

function TeShaMuChallengeController:isStagePass(stageId)
	local stageInfo = TeShaMuChallengeModel.instance:getStageInfo()

	if TableUtil.isTableEmpty(stageInfo) then
		return false
	end

	if stageInfo then
		for _, v in pairs(stageInfo) do
			if v.stageId == stageId then
				if TableUtil.isTableEmpty(v.passBlockIds) then
					return false
				else
					local mapPlanId = TeShaMuChallengeModel.instance:getMapPlanId()
					local mapCfg = TeShaMuChallengeConfig.instance:getMapPlanCfg(mapPlanId)

					if table.nums(v.passBlockIds) == #mapCfg then
						return true
					end
				end
			end
		end
	end

	return false
end

function TeShaMuChallengeController:isCanReset(stageId)
	local stageInfo = TeShaMuChallengeModel.instance:getStageInfo()

	if TableUtil.isTableEmpty(stageInfo) then
		FloatWordMgr.instance:show("没有可重置的关卡哦~")

		return false
	end

	local isFrist = TableUtil.isTableEmpty(self:stageBanPetIds(stageId))

	if isFrist then
		FloatWordMgr.instance:show("没有可重置的关卡哦~")

		return false
	end

	local isPass = self:isStagePass(stageId)

	if isPass then
		FloatWordMgr.instance:show("该关卡已全部通关,无需重置~")

		return false
	end

	return true
end

function TeShaMuChallengeController:blockIsNeighbours(blockId)
	local mapPlanId = TeShaMuChallengeModel.instance:getMapPlanId()
	local enterNeighbours = TeShaMuChallengeConfig.instance:getMapPlanCfgById(mapPlanId, 0).neighbours

	if not TableUtil.isTableEmpty(self.levelInfo) then
		local neighbours = TeShaMuChallengeConfig.instance:getMapPlanCfgById(mapPlanId, blockId).neighbours
		local passBlockIds = self.levelInfo.passBlockIds

		for _, v in pairs(neighbours) do
			if TableUtil.isHad(passBlockIds, v) or TableUtil.isHad(enterNeighbours, blockId) then
				return true
			end
		end
	end

	return TableUtil.isHad(enterNeighbours, blockId)
end

function TeShaMuChallengeController:banPetInfo(blockId)
	local banPetInfos = {}
	local activityId = TeShaMuChallengeModel.instance:getActId()
	local stageId = TeShaMuChallengeModel.instance:getStageId()
	local stageCfg = TeShaMuChallengeConfig.instance:getStageCfgById(activityId, stageId)
	local planCfg = TeShaMuChallengeConfig.instance:getMapPlanCfgById(stageCfg.mapPlanId, blockId)
	local blockCfg = TeShaMuChallengeConfig.instance:getLevelPlanCfgById(stageCfg.levelPlanId, planCfg.level)

	banPetInfos.banPetCount = blockCfg.banPetCount
	banPetInfos.banPetIds = self:banPetIds(blockId)

	return banPetInfos
end

function TeShaMuChallengeController:banPetIds(blockId)
	if not self.levelInfo.blockInfo then
		if not TableUtil.isTableEmpty(self.levelInfo.blockInfo) then
			for _, v in pairs(self.levelInfo.blockInfo) do
				if v.blockId == blockId then
					return v.banPetIds
				end
			end
		end

		return {}
	end
end

function TeShaMuChallengeController:stageBanPetIds(stageId)
	local banPetIds = {}

	if not self.levelInfo.blockInfo then
		if not TableUtil.isTableEmpty(self.levelInfo.blockInfo) then
			for _, info in pairs(self.levelInfo.blockInfo) do
				for _, banPetId in pairs(info.banPetIds) do
					table.insert(banPetIds, banPetId)
				end
			end
		end

		return banPetIds
	end
end

function TeShaMuChallengeController:openChallengeForm(activityId, stageId, blockId)
	CustomFmtController.instance:showMissionView(TeShaMuChallengeModel.instance:getChallengeFmtMo(activityId, stageId, blockId))
end

function TeShaMuChallengeController:fightResult(activityId)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local function comFunc()
			if activityId == 288001 then
				UIJumper.instance:pushOneStack(ViewName.TeShaMuChallengeView, true, activityId)
			elseif activityId == 288002 then
				UIJumper.instance:pushOneStack(ViewName.LightDarkAngelChallengeView, true, activityId)
			end
		end

		local function succHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			comFunc()
		end

		local function failHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
			comFunc()
		end

		if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
			failHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
			failHandler()
		end

		return true
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

TeShaMuChallengeController.instance = TeShaMuChallengeController.New()

return TeShaMuChallengeController

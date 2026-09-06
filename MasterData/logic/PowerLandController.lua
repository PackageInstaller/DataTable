-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/controller/PowerLandController.lua

module("logic.extensions.powerland.controller.PowerLandController", package.seeall)

local PowerLandController = class("PowerLandController", BaseController)

function PowerLandController:ctor()
	return
end

function PowerLandController:onInit()
	self:onReset()
end

function PowerLandController:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
end

function PowerLandController:onSendPowerLandGetInfoReq(activityId)
	PowerLandAgent.instance:sendPM_PowerLandGetInfoReq(activityId)
end

function PowerLandController:onHandlePowerLandGetInfoRes(msg)
	PowerLandModel.instance:onHandlePowerLandGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PowerLandGetInfoRes)
end

function PowerLandController:onSendPowerLandRefreshReq(activityId)
	PowerLandAgent.instance:sendPM_PowerLandRefreshReq(activityId)
end

function PowerLandController:onHandlePowerLandRefreshRes(msg)
	PowerLandModel.instance:onHandlePowerLandRefreshRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PowerLandRefreshPetRes)
end

function PowerLandController:onSendPowerLandStartChallengeReq(activityId)
	PowerLandAgent.instance:sendPM_PowerLandStartChallengeReq(activityId)
end

function PowerLandController:onHandlePowerLandStartChallengeRes(msg)
	PowerLandModel.instance:onHandlePowerLandStartChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PowerLandStartChallengeRes)
end

function PowerLandController:onSendPowerLandChallengeReq(activityId, selectPetId, simpleForm)
	PowerLandAgent.instance:sendPM_PowerLandChallengeReq(activityId, selectPetId, simpleForm)
end

function PowerLandController:onHandlePowerLandChallengeRes(status, msg)
	if status ~= 0 then
		UIStateManager.instance:clear()
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	else
		PowerLandModel.instance:onHandlePowerLandChallengeRes(msg)
		BattleFacade.instance:registerResultHandler(self._handlerBattleEnd, self)
	end
end

function PowerLandController:onSendPowerLandRefreshShopReq(activityId)
	PowerLandAgent.instance:sendPM_PowerLandRefreshShopReq(activityId)
end

function PowerLandController:onHandlePowerLandRefreshShopRes(msg)
	PowerLandModel.instance:onHandlePowerLandRefreshShopRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PowerLandRefreshShopRes)
end

function PowerLandController:onHandlePowerLandStageOverRes(msg)
	PowerLandModel.instance:onHandlePowerLandStageOverRes(msg)

	local changeSetId = PowerLandModel.instance:getChangeSetId()

	if changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PowerLandStageOverRes)
end

function PowerLandController:onSendPowerLandSetFormReq(activityId, simpleForm)
	PowerLandAgent.instance:sendPM_PowerLandSetFormReq(activityId, simpleForm)
end

function PowerLandController:onHandlePowerLandSetFormRes(msg)
	PowerLandModel.instance:onHandlePowerLandSetFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PowerLandSetFormRes)
end

function PowerLandController:dailyRefresh()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PowerLand)

	if not actCfg then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.PowerLandMainView) or ViewMgr.instance:isOpen(ViewName.PowerLandScenceView) or ViewMgr.instance:isOpen(ViewName.InitialPetSelectionView) or ViewMgr.instance:isOpen(ViewName.StagePetSelectionView) or PowerLandModel.instance:isInFmt() then
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.PowerLandMainView)
		FloatWordMgr.instance:show("因跨天，进度已被重置")
	end
end

function PowerLandController:isGameTimesEnough()
	local leaveTimes = PowerLandModel.instance:getLeaveGameTimes()

	return leaveTimes > 0
end

function PowerLandController:getCurTotalStageNum()
	local curActivityId = PowerLandModel.instance:getCurActivityId()

	PowerLandConfig.instance:getTotalStageNum(curActivityId)
end

function PowerLandController:getCurStageType()
	local curActivityId = PowerLandModel.instance:getCurActivityId()
	local curStageId = PowerLandModel.instance:getCurStageId()

	return PowerLandConfig.instance:getStageType(curActivityId, curStageId)
end

function PowerLandController:enterStageBattle()
	PowerLandModel.instance:clearViewInfos()

	local function mainViewCallBack(viewName)
		UIJumper.instance:pushOneStack(viewName)
	end

	PowerLandModel.instance:addViewInfo(mainViewCallBack, ViewName.PowerLandMainView)

	local function scenceViewCallBack(viewName)
		if PowerLandModel.instance:isStartChallenge() then
			UIJumper.instance:pushOneStack(viewName)
		else
			FloatWordMgr.instance:show("挑战已完成")
		end
	end

	PowerLandModel.instance:addViewInfo(scenceViewCallBack, ViewName.PowerLandScenceView)
	CustomFmtController.instance:showMissionView(PowerLandModel.instance:getCustomFmtMo())
end

function PowerLandController:startSotrySummaryStageBattle(activityId, stageId, creepsMasterId, simpleForm)
	local selectPetId
	local simpleForm = PowerLandModel.instance:getCustomFmtMo():getCurSimpleForm()

	BattleFacade.instance:startPowerLandFight(activityId, stageId, creepsMasterId)
	PowerLandController.instance:onSendPowerLandChallengeReq(activityId, selectPetId, simpleForm)
end

function PowerLandController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function saveClientPrize()
		local activityId = PowerLandModel.instance:getCurActivityId()
		local stageId = PowerLandModel.instance:getOldStageId()
		local totalStageNum = PowerLandConfig.instance:getTotalStageNum(activityId)

		if stageId == totalStageNum then
			return
		end

		local stageData = PowerLandConfig.instance:getPlStageData(activityId, stageId)
		local score
		local isWin = PowerLandModel.instance:isChallengeWin()

		score = isWin and stageData.winScore or stageData.failScore

		if score == 0 then
			return
		end

		local itemStr = PowerLandConfig.instance:getPlShowItem()
		local matType, matId = MaterialMgr.getMatParams(itemStr)

		PowerLandModel.instance:_addMatDataToList(matType, matId, score)
	end

	local function popServerPrize()
		local changeSetId = PowerLandModel.instance:getChangeSetId()

		if changeSetId == nil then
			return
		end

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		PowerLandModel.instance:clearChangeSetId()
	end

	local function popBattleResult()
		if PowerLandModel.instance:isChallengeWin() then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		else
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		end
	end

	local function doPreSaveCallBack()
		local viewInfos = PowerLandModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			if info.callBack == nil then
				printError("预存方法不能为nil")
			else
				info.callBack(unpack(info.params))
			end
		end
	end

	local function resultHandler()
		popBattleResult()
		popServerPrize()
		saveClientPrize()
		doPreSaveCallBack()
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		resultHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		resultHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		resultHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		resultHandler()
	end

	return true
end

PowerLandController.instance = PowerLandController.New()

return PowerLandController

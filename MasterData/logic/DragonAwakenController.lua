-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/controller/DragonAwakenController.lua

module("logic.extensions.dragonawaken.controller.DragonAwakenController", package.seeall)

local DragonAwakenController = class("DragonAwakenController", BaseController)

function DragonAwakenController:ctor()
	return
end

DragonAwakenController.UpgradeType = {
	StarGod = 4,
	Equip = 3,
	Pet = 1,
	Awaken = 2,
	HolyStripe = 5
}

function DragonAwakenController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.DragonAwakenGetInfoRes, self._updateRedPointInfo, self)
end

function DragonAwakenController:onReset()
	self._clgFmtMo = DragonAwakenClgFmtMo.New()
	self._trainClgFmtMo = DragonAwakenTrainFmtMo.New()
	self._needPupTrainResult = false
	self._needPupFmt = nil
end

function DragonAwakenController:getInfo(activityId)
	DragonAwakenAgent.instance:sendPM_DragonAwakenGetInfoReq(activityId)
end

function DragonAwakenController:handleGetInfo(msg)
	DragonAwakenModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenGetInfoRes, msg)
end

function DragonAwakenController:getRankInfo(activityId)
	DragonAwakenAgent.instance:sendPM_DragonAwakenRankViewReq(activityId)
end

function DragonAwakenController:handleGetRankInfo(msg)
	DragonAwakenModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenGetRankInfoRes)
end

function DragonAwakenController:startTrainingFight(activityId, hard, form_pb)
	DragonAwakenAgent.instance:sendPM_DragonAwakenTrainingFightReq(activityId, hard, form_pb)
end

function DragonAwakenController:handleNotifyTrainingRes(msg)
	DragonAwakenModel.instance:onNotifyTraining(msg)

	self._needPupTrainResult = true
end

function DragonAwakenController:confirmTrainingResult(activityId)
	DragonAwakenAgent.instance:sendPM_DragonAwakenConfirmResultReq(activityId)
end

function DragonAwakenController:handleConfirmTrainingResult(msg)
	DragonAwakenModel.instance:onConfirmTrainingResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateTrainInfo)
end

function DragonAwakenController:randomTrainingForm(activityId, hard)
	DragonAwakenAgent.instance:sendPM_DragonAwakenRandomFormReq(activityId, hard)
end

function DragonAwakenController:handleRandomTrainingForm(msg)
	DragonAwakenModel.instance:onRandomTrainingForm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateTrainInfo)
end

function DragonAwakenController:upgradeReq(activityId, strengthType)
	DragonAwakenAgent.instance:sendPM_DragonAwakenUpgradeReq(activityId, strengthType)
end

function DragonAwakenController:handleUpgradeReq(msg)
	DragonAwakenModel.instance:onUpgrade(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateUpgradeInfo)
end

function DragonAwakenController:buyPetReq(activityId, creepsId)
	DragonAwakenAgent.instance:sendPM_DragonAwakenBuyPetReq(activityId, creepsId)
end

function DragonAwakenController:handleBuyPetReq(msg)
	DragonAwakenModel.instance:onBuyPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdatePetInfo)
end

function DragonAwakenController:openClgMissionView(activityId)
	self._clgFmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(self._clgFmtMo)

	self._needPupFmt = false
end

function DragonAwakenController:openTrainMissionView(activityId, hard)
	self._trainClgFmtMo:initParams(activityId, hard)
	CustomFmtController.instance:showMissionView(self._trainClgFmtMo)
end

function DragonAwakenController:getIsNeedPupResultView()
	return self._needPupTrainResult
end

function DragonAwakenController:resetNeedPupResultView()
	self._needPupTrainResult = false
end

function DragonAwakenController:startFightRequest(activityId, form_pb)
	DragonAwakenAgent.instance:sendPM_DragonAwakenPhaseFightReq(activityId, form_pb)
end

function DragonAwakenController:handleNotifyFightRes(msg)
	DragonAwakenModel.instance:onNotifyFightRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DragonAwaken, msg)
	BattleFacade.instance:registerResultHandler(function()
		if msg.isWin then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		else
			ViewMgr.instance:open(ViewName.BattleSettlementFail)
		end

		return true
	end)
end

function DragonAwakenController:startNextFight()
	self._needPupFmt = true
end

function DragonAwakenController:getIsNeedPupFmt()
	return self._needPupFmt
end

function DragonAwakenController:loadRedPointInfo()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRAGON_AWAKEN_DAILY, false, true)

	local curActId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DragonAwaken)

	if curActId > 0 then
		self:getInfo(curActId)
	end
end

function DragonAwakenController:_updateRedPointInfo(msg)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRAGON_AWAKEN_DAILY, false, true)

	local activityId = msg.activityId
	local curPhaseId = msg.curPhaseId
	local phaseCfgs = DragonAwakenConfig.instance:getPhaseCfgs(activityId)

	if curPhaseId <= #phaseCfgs then
		local userDataKey = "DRAGON_AWAKEN_REDPOINT_DAILY_" .. activityId

		if checknumber(GameUtil.getUserDayData(userDataKey)) <= 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRAGON_AWAKEN_DAILY, true, true)
		end
	end
end

function DragonAwakenController:resetRedPoint(activityId)
	local userDataKey = "DRAGON_AWAKEN_REDPOINT_DAILY_" .. activityId

	GameUtil.saveUserDayData(userDataKey, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRAGON_AWAKEN_DAILY, false, true)
end

DragonAwakenController.instance = DragonAwakenController.New()

return DragonAwakenController

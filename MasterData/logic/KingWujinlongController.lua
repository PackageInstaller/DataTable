-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/controller/KingWujinlongController.lua

module("logic.extensions.kingwujinlong.controller.KingWujinlongController", package.seeall)

local KingWujinlongController = class("KingWujinlongController", BaseController)

function KingWujinlongController:onInit()
	self:onReset()
end

function KingWujinlongController:onReset()
	self._tempChangeSetId = nil
	self._fmtPool = {}
end

function KingWujinlongController:getActivityId()
	return 440001
end

function KingWujinlongController:sendGetInfo(activityId)
	KingAshlessDragonClgAgent.instance:sendPM_KingAshlessDragonClgGetInfoReq(activityId)
end

function KingWujinlongController:onGetInfo(msg)
	KingWujinlongModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KING_WUJINLONG_CLG_INFO_UPDATE)
end

function KingWujinlongController:sendReset(activityId)
	KingAshlessDragonClgAgent.instance:sendPM_KingAshlessDragonClgResetReq(activityId)
end

function KingWujinlongController:onGetReset(msg)
	KingWujinlongModel.instance:onGetReset(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KING_WUJINLONG_CLG_INFO_UPDATE)
end

function KingWujinlongController:sendConfirm(activityId, confirmNum, save)
	KingAshlessDragonClgAgent:sendPM_KingAshlessDragonClgConfirmReq(activityId, confirmNum, save)
end

function KingWujinlongController:onGetConfirm(msg)
	KingWujinlongModel.instance:onGetConfirm(msg)

	self._tempChangeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.KING_WUJINLONG_CLG_INFO_UPDATE)

	local activityId = msg.activityId
	local info = KingWujinlongModel.instance:getInfo(activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}
		local passPhaseId = checknumber(clgInfo.curPassStageId)
		local cfgList = KingWujinlongConfig.instance:getStageCfgListById(activityId) or {}

		if passPhaseId >= #cfgList then
			local top = UIJumper.instance:getTopState()

			if top then
				UIJumper.instance:removeTopState(top.state)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.KING_WUJINLONG_CLG_RES_GET)
	end
end

function KingWujinlongController:tryShowChangeSet()
	if self._tempChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._tempChangeSetId)

		self._tempChangeSetId = nil
	end
end

function KingWujinlongController:openFmtView(activityId, phaseId, stageId)
	self._fmtPool[activityId] = self._fmtPool[activityId] or KingWujinlongFmtMo.New()

	local fmtMo = self._fmtPool[activityId]

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function KingWujinlongController:sendStartFight(activityId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	KingAshlessDragonClgAgent.instance:sendPM_KingAshlessDragonClgChallengeReq(activityId, form_pb)
end

function KingWujinlongController:handleFightRes(msg)
	KingWujinlongModel.instance:handleFightRes(msg)
end

function KingWujinlongController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = KingWujinlongModel.instance:getFightPb(activityId)

	if pb and pb.win then
		UIStateManager.instance:push(ViewName.KingwujinlongresultView, activityId)

		return true
	end

	return false
end

KingWujinlongController.instance = KingWujinlongController.New()

return KingWujinlongController

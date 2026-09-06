-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/controller/EmperorSubdueController.lua

module("logic.extensions.emperorsubdue.controller.EmperorSubdueController", package.seeall)

local EmperorSubdueController = class("EmperorSubdueController", BaseController)

function EmperorSubdueController:onInit()
	self:onReset()
end

function EmperorSubdueController:onReset()
	self.ciList = nil
	self._fmtMo = nil
	self._bossFmtMo = nil
end

function EmperorSubdueController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function EmperorSubdueController:showMissionView(activityId, stageId)
	self._fmtMo = self._fmtMo or EmperorSubdueFmtMo.New()

	self._fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function EmperorSubdueController:showBossMissionView(activityId, isTrial, time)
	self._bossFmtMo = self._bossFmtMo or EmperorSubdueBossFmtMo.New()

	self._bossFmtMo:initParams(activityId, isTrial, time)
	CustomFmtController.instance:showMissionView(self._bossFmtMo)
end

function EmperorSubdueController:getInfo(activityId)
	EmperorSubdueAgent.instance:sendPM_EmperorSubdueInfoReq(activityId)
end

function EmperorSubdueController:handleGetInfo(msg)
	EmperorSubdueModel.instance:handlePM_EmperorSubdueInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_EmperorSubdueInfoRes)
end

function EmperorSubdueController:startChallenge(activityId, form_pb, stageId)
	EmperorSubdueAgent.instance:sendPM_EmperorSubdueStageClgReq(activityId, form_pb, stageId)
end

function EmperorSubdueController:handleNotifyStageChallenge(msg)
	EmperorSubdueModel.instance:handleNotifyStageChallenge(msg)

	if msg.isWin then
		self.ciList = msg.changeSetId

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(self.ciList)
		end
	end
end

function EmperorSubdueController:startBossChallenge(activityId, selectBuffId, isTrial, form_pb)
	EmperorSubdueAgent.instance:sendPM_EmperorSubdueBossClgReq(activityId, selectBuffId, isTrial, form_pb)
end

function EmperorSubdueController:handleNotifyBossChallenge(msg)
	EmperorSubdueModel.instance:handleNotifyBossChallenge(msg)

	self.ciList = msg.changeSetId

	if msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(self.ciList)
	end
end

function EmperorSubdueController:resetStage(activityId)
	EmperorSubdueAgent.instance:sendPM_EmperorSubdueResetReq(activityId)
end

function EmperorSubdueController:handleResetStage(msg)
	EmperorSubdueModel.instance:handleResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_EmperorSubdueResetRes)
end

function EmperorSubdueController:getRankList(activityId)
	EmperorSubdueAgent.instance:sendPM_EmperorSubdueRankViewReq(activityId)
end

function EmperorSubdueController:handleGetRankList(msg)
	EmperorSubdueModel.instance:handlePM_EmperorSubdueRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_EmperorSubdueRankRes)
end

function EmperorSubdueController:numberToString(num)
	return num >= 100000000 and string.format("%.2f亿", num / 100000000) or num >= 10000 and string.format("%.2f万", num / 10000) or tostring(num)
end

EmperorSubdueController.instance = EmperorSubdueController.New()

return EmperorSubdueController

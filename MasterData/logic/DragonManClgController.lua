-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/controller/DragonManClgController.lua

module("logic.extensions.dragonmanclg.controller.DragonManClgController", package.seeall)

local DragonManClgController = class("DragonManClgController", BaseController)

function DragonManClgController:onInit()
	self:onReset()
end

function DragonManClgController:onReset()
	self.ciList = nil
	self._fmtMo = nil
end

function DragonManClgController:showMissionView(activityId, stageId)
	self._fmtMo = self._fmtMo or DragonManClgFmtMo.New()

	self._fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function DragonManClgController:getInfo(activityId)
	DragonManClgAgent.instance:sendPM_DragonManClgInfoReq(activityId)
end

function DragonManClgController:handleGetInfo(msg)
	DragonManClgModel.instance:handlePM_DragonManClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonManClgInfoRes)
end

function DragonManClgController:startChallenge(activityId, stageId, form_pb)
	DragonManClgAgent.instance:sendPM_DragonManClgChallengeReq(activityId, stageId, form_pb)
end

function DragonManClgController:handleNotifyChallenge(msg)
	DragonManClgModel.instance:handleNotifyChallenge(msg)

	if msg.isWin then
		self.ciList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self.ciList)
	end
end

function DragonManClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

DragonManClgController.instance = DragonManClgController.New()

return DragonManClgController

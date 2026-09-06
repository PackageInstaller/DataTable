-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/controller/RoseclgController.lua

module("logic.extensions.roseclg.controller.RoseclgController", package.seeall)

local RoseclgController = class("RoseclgController", BaseController)

function RoseclgController:ctor()
	return
end

function RoseclgController:onInit()
	self:onReset()
end

function RoseclgController:onReset()
	return
end

function RoseclgController:enterMission(activityId, stageId, teamIndex, creepsMasterId)
	local mo = RoseclgModel.instance:getFmtMo()

	mo:initParams(activityId, stageId, teamIndex, creepsMasterId)
	CustomFmtController.instance:showMissionView(mo)
end

RoseclgController.instance = RoseclgController.New()

return RoseclgController

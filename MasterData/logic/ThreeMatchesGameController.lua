-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threematchesgame/controller/ThreeMatchesGameController.lua

module("logic.extensions.threematchesgame.controller.ThreeMatchesGameController", package.seeall)

local ThreeMatchesGameController = class("ThreeMatchesGameController", BaseController)

function ThreeMatchesGameController:ctor()
	return
end

function ThreeMatchesGameController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(ThreeMatchesGameAgent.InfoRes, self.handlePM_ThreeMatchesGameInfoRes, self)
end

function ThreeMatchesGameController:onReset()
	return
end

function ThreeMatchesGameController:sendPM_ThreeMatchesGameInfoReq(activityId, stageId)
	SxGameModel.instance:getMapInfo(activityId, stageId)
	ThreeMatchesGameAgent.instance:sendPM_ThreeMatchesGameInfoReq(activityId)
end

function ThreeMatchesGameController:handlePM_ThreeMatchesGameInfoRes(status, msg)
	local data = GameUtil.pbToTable(msg)

	SxGameModel.instance:initGameMapArrFromMsg(data.activityId, data.stageInfo)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesGetInfo)
end

ThreeMatchesGameController.instance = ThreeMatchesGameController.New()

return ThreeMatchesGameController

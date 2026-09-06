-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/controller/MultiplegiftpacksController.lua

module("logic.extensions.hdsummerlotteryrecommend.controller.MultiplegiftpacksController", package.seeall)

local MultiplegiftpacksController = class("MultiplegiftpacksController", BaseController)

function MultiplegiftpacksController:onInit()
	self:onReset()
end

function MultiplegiftpacksController:onReset()
	self._info = {}
end

function MultiplegiftpacksController:setGiftInfo(msg)
	self._info.activityId = msg.activityId
	self._info.bought = msg.bought
end

function MultiplegiftpacksController:getGiftInfo()
	return self._info
end

MultiplegiftpacksController.instance = MultiplegiftpacksController.New()

return MultiplegiftpacksController

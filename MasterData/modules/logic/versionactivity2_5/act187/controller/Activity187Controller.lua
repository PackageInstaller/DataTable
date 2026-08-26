-- chunkname: @modules/logic/versionactivity2_5/act187/controller/Activity187Controller.lua

module("modules.logic.versionactivity2_5.act187.controller.Activity187Controller", package.seeall)

local Activity187Controller = class("Activity187Controller", BaseController)

function Activity187Controller:onInit()
	return
end

function Activity187Controller:onInitFinish()
	return
end

function Activity187Controller:addConstEvents()
	return
end

function Activity187Controller:reInit()
	return
end

function Activity187Controller:openAct187View()
	self.getAct187Info(self, self._realOpenAct187View, self, true)
end

function Activity187Controller:getAct187Info(cb, cbObj, isToast)
	local isOpen = Activity187Model.instance:isAct187Open(isToast)

	if not isOpen then
		return
	end

	local actId = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendGet187InfoRequest(actId, cb, cbObj)
end

function Activity187Controller:_realOpenAct187View()
	ViewMgr.instance:openView(ViewName.Activity187View)
end

function Activity187Controller:finishPainting(cb, cbObj)
	local actId = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendAct187FinishGameRequest(actId, cb, cbObj)
end

function Activity187Controller:getAccrueReward(cb, cbObj)
	local actId = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendAct187AcceptRewardRequest(actId, cb, cbObj)
end

Activity187Controller.instance = Activity187Controller.New()

return Activity187Controller

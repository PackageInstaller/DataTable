-- chunkname: @modules/logic/act201/controller/Activity201Controller.lua

module("modules.logic.act201.controller.Activity201Controller", package.seeall)

local Activity201Controller = class("Activity201Controller", BaseController)

function Activity201Controller:onInit()
	self:reInit()
end

function Activity201Controller:reInit()
	return
end

function Activity201Controller:getInvitationInfo(activityId, callBack, callBackObj)
	Activity201Rpc.instance:sendGet201InfoRequest(activityId, callBack, callBackObj)
end

function Activity201Controller:openMainView(activityId)
	self.getInvitationInfo(self, activityId, self._openMainView, self)
end

function Activity201Controller:_openMainView(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackFullView, msg.activityId, true)
	end
end

Activity201Controller.instance = Activity201Controller.New()

return Activity201Controller

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/controller/GoddessVoteController.lua

module("logic.extensions.goddessvote.controller.GoddessVoteController", package.seeall)

local GoddessVoteController = class("GoddessVoteController", BaseController)

function GoddessVoteController:ctor()
	return
end

function GoddessVoteController:onInit()
	GoddessVoteController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
end

function GoddessVoteController:onReset()
	return
end

function GoddessVoteController:_TickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.GoddessVote) then
		self:csRequestGVGetInfoReq()
	end
end

function GoddessVoteController:csRequestGVGetInfoReq(actId)
	GoddessVoteAgent.instance:sendPM_GVGetInfoReq(actId)
end

function GoddessVoteController:scPushGVGetInfo(msg)
	GoddessVoteModel.instance:scPushGVGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataGoddessVoteInfo)
end

function GoddessVoteController:csRequestGVBuyVoteItemReq(actId, count)
	GoddessVoteAgent.instance:sendPM_GVBuyVoteItemReq(actId, count)
end

function GoddessVoteController:scPushGVBuyVoteItem(msg)
	GoddessVoteModel.instance:scPushGVBuyVoteItem(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataGoddessVoteInfo, "buy")
end

function GoddessVoteController:csRequestGVVoteReq(actId, raceId)
	GoddessVoteAgent.instance:sendPM_GVVoteReq(actId, raceId)
end

function GoddessVoteController:scPushGVVote(msg)
	GoddessVoteModel.instance._randomTimer = ServerTime.now()

	self:csRequestGVGetInfoReq(msg.activityId)
end

GoddessVoteController.instance = GoddessVoteController.New()

return GoddessVoteController

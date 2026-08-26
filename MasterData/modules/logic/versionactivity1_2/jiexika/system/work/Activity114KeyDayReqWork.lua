-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114KeyDayReqWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayReqWork", package.seeall)

local Activity114KeyDayReqWork = class("Activity114KeyDayReqWork", Activity114BaseWork)

function Activity114KeyDayReqWork:onStart(context)
	Activity114Rpc.instance:keyDayRequest(Activity114Model.instance.id, self.onReply, self)
end

function Activity114KeyDayReqWork:onReply(cmd, resultCode, msg)
	self:onDone(resultCode == 0)
end

return Activity114KeyDayReqWork

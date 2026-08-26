-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114ReqBaseWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ReqBaseWork", package.seeall)

local Activity114ReqBaseWork = class("Activity114ReqBaseWork", Activity114BaseWork)

function Activity114ReqBaseWork:onReply(cmd, resultCode, msg)
	self:onDone(resultCode == 0)
end

return Activity114ReqBaseWork

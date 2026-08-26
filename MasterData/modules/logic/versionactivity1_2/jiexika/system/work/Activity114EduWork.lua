-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114EduWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114EduWork", package.seeall)

local Activity114EduWork = class("Activity114EduWork", Activity114ReqBaseWork)

function Activity114EduWork:onStart(context)
	Activity114Rpc.instance:eduRequest(Activity114Model.instance.id, tonumber(self.context.eventCo.config.param), self.onReply, self)
end

return Activity114EduWork

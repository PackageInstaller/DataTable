-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114MeetingFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114MeetingFlow", package.seeall)

local Activity114MeetingFlow = class("Activity114MeetingFlow", Activity114BaseFlow)

function Activity114MeetingFlow:addEventWork()
	self:addWork(Activity114CheckWork.New())
	self:addWork(Activity114CheckOrAnswerWork.New())
end

return Activity114MeetingFlow

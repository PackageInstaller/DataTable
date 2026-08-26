-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114StopStoryWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StopStoryWork", package.seeall)

local Activity114StopStoryWork = class("Activity114StopStoryWork", Activity114BaseWork)

function Activity114StopStoryWork:onStart()
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		Activity114Controller.instance:markStoryWillFinish()
	end

	StoryController.instance:dispatchEvent(StoryEvent.AllStepFinished, true)
	self:onDone(true)
end

return Activity114StopStoryWork

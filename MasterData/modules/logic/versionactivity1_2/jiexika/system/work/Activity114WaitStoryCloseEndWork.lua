-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114WaitStoryCloseEndWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WaitStoryCloseEndWork", package.seeall)

local Activity114WaitStoryCloseEndWork = class("Activity114WaitStoryCloseEndWork", Activity114BaseWork)

function Activity114WaitStoryCloseEndWork:onStart(context)
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, self._onCloseViewFinish, self)
	else
		self:onDone(true)
	end
end

function Activity114WaitStoryCloseEndWork:_onCloseViewFinish()
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		return
	end

	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, self._onCloseViewFinish, self)
	self:onDone(true)
end

function Activity114WaitStoryCloseEndWork:clearWork()
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, self._onCloseViewFinish, self)
end

return Activity114WaitStoryCloseEndWork

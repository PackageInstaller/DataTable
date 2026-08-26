-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9TaskItem.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9TaskItem", package.seeall)

local VersionActivity2_9TaskItem = class("VersionActivity2_9TaskItem", VersionActivityFixedTaskItem)

function VersionActivity2_9TaskItem:_btnFinishOnClick()
	VersionActivity2_9TaskItem.super._btnFinishOnClick(self)
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_finishTask)
end

function VersionActivity2_9TaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onJumpDone, self)
		end
	end
end

function VersionActivity2_9TaskItem:_onJumpDone()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_9TaskView)
end

return VersionActivity2_9TaskItem

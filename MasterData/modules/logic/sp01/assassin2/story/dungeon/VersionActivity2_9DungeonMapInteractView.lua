-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapInteractView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapInteractView", package.seeall)

local VersionActivity2_9DungeonMapInteractView = class("VersionActivity2_9DungeonMapInteractView", VersionActivityFixedDungeonMapInteractView)

function VersionActivity2_9DungeonMapInteractView:show()
	if self._show then
		return
	end

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickElement)
end

function VersionActivity2_9DungeonMapInteractView:hide()
	if not self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	self._show = false
	self.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickElement)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

return VersionActivity2_9DungeonMapInteractView

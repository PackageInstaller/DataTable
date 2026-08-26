-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapInteractView.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapInteractView", package.seeall)

local VersionActivity3_10DungeonMapInteractView = class("VersionActivity3_10DungeonMapInteractView", VersionActivityFixedDungeonMapInteractView)

function VersionActivity3_10DungeonMapInteractView:show()
	if self._show then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_task_page)

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractroot, true)
	self:playAnim("open")
end

function VersionActivity3_10DungeonMapInteractView:hide()
	if not self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	self._show = false
	self.dispatchMo = nil

	self.playAnim(self, "close", self.onCloseAnim, self)
end

function VersionActivity3_10DungeonMapInteractView:onCloseAnim()
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

function VersionActivity3_10DungeonMapInteractView:isInteractShow()
	return self._show
end

function VersionActivity3_10DungeonMapInteractView:playAnim(animName, callback, callbackObj)
	self._anim = self._anim or SLFramework.AnimatorPlayer.Get(self._gointeractitem)

	if not self._anim then
		return
	end

	self._anim:Play(animName, callback, callbackObj)
end

return VersionActivity3_10DungeonMapInteractView

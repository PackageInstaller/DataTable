-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10TaskItem.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10TaskItem", package.seeall)

local VersionActivity3_10TaskItem = class("VersionActivity3_10TaskItem", VersionActivityFixedTaskItem)

function VersionActivity3_10TaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onJumpDone, self)
		end
	end
end

function VersionActivity3_10TaskItem:_onJumpDone()
	ViewMgr.instance:closeView(ViewName.VersionActivity3_10TaskView)
end

return VersionActivity3_10TaskItem

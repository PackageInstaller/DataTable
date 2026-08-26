-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/category/Act183DungeonHardMainGroupItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.category.Act183DungeonHardMainGroupItem", package.seeall)

local Act183DungeonHardMainGroupItem = class("Act183DungeonHardMainGroupItem", Act183DungeonBaseGroupItem)

function Act183DungeonHardMainGroupItem:init(go)
	Act183DungeonHardMainGroupItem.super.init(self, go)

	self._animUnlock = gohelper.onceAddComponent(self._golock, gohelper.Type_Animator)

	self.addEventCb(self, Act183Controller.instance, Act183Event.OnInitDungeonDone, self._onInitDungeonDone, self)
end

function Act183DungeonHardMainGroupItem:_onInitDungeonDone()
	self:_checkPlayNewUnlockAnim()
end

function Act183DungeonHardMainGroupItem:_checkPlayNewUnlockAnim()
	if self._status ~= Act183Enum.GroupStatus.Unlocked then
		return
	end

	local actId = Act183Model.instance:getActivityId()
	local hasPlayUnlockAnim = Act183Helper.isGroupHasPlayUnlockAnim(actId, self._groupId)

	if not hasPlayUnlockAnim then
		gohelper.setActive(self._golock, true)
		self._animUnlock:Play("unlock", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act183_HardMainUnlock)
		Act183Helper.savePlayUnlockAnimGroupIdInLocal(actId, self._groupId)
	end
end

return Act183DungeonHardMainGroupItem

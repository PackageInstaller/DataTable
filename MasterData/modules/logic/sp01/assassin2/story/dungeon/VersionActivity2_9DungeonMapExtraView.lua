-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapExtraView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapExtraView", package.seeall)

local VersionActivity2_9DungeonMapExtraView = class("VersionActivity2_9DungeonMapExtraView", BaseView)

function VersionActivity2_9DungeonMapExtraView:onInitView()
	self._btnstealth = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_stealth")
	self._gostealthlocked = gohelper.findChild(self.viewGO, "#btn_stealth/#go_stealthlocked")
	self._gostealthunlocked = gohelper.findChild(self.viewGO, "#btn_stealth/#go_stealthunlocked")
	self._gostealthreddot = gohelper.findChild(self.viewGO, "#btn_stealth/#go_stealthreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9DungeonMapExtraView:addEvents()
	self._btnstealth:AddClickListener(self._btnstealthOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshActivityState, self)
end

function VersionActivity2_9DungeonMapExtraView:removeEvents()
	self._btnstealth:RemoveClickListener()
end

function VersionActivity2_9DungeonMapExtraView:_btnstealthOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.Outside)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParam)

		return
	end

	AssassinController.instance:openAssassinMapView(nil, true)
end

function VersionActivity2_9DungeonMapExtraView:_editableInitView()
	return
end

function VersionActivity2_9DungeonMapExtraView:onOpen()
	self:refreshStealthBtnStatus()
end

function VersionActivity2_9DungeonMapExtraView:refreshStealthBtnStatus()
	local isOpen = ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Outside)

	gohelper.setActive(self._gostealthunlocked, isOpen)
	gohelper.setActive(self._gostealthlocked, not isOpen)
end

function VersionActivity2_9DungeonMapExtraView:_refreshActivityState(actId)
	if not actId or actId == VersionActivity2_9Enum.ActivityId.Outside then
		self:refreshStealthBtnStatus()
	end
end

function VersionActivity2_9DungeonMapExtraView:onClose()
	return
end

function VersionActivity2_9DungeonMapExtraView:onDestroyView()
	return
end

return VersionActivity2_9DungeonMapExtraView

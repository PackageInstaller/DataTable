-- chunkname: @modules/logic/pcInput/activityAdapter/MainActivityAdapter.lua

module("modules.logic.pcInput.activityAdapter.MainActivityAdapter", package.seeall)

local MainActivityAdapter = class("MainActivityAdapter", BaseActivityAdapter)

MainActivityAdapter.keytoFunction = {
	function()
		BpController.instance:openBattlePassView()
	end,
	function()
		ActivityController.instance:openActivityBeginnerView()
	end,
	function()
		PlayerController.instance:openSelfPlayerView()
	end,
	function()
		MailController.instance:open()
	end,
	function()
		TaskController.instance:enterTaskViewCheckUnlock()
	end,
	function()
		BackpackController.instance:enterItemBackpack()
	end,
	function()
		StoreController.instance:openStoreView()
	end,
	function()
		ViewMgr.instance:openView(ViewName.MainThumbnailView)
		SettingsController.instance:openView()
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifySetMainViewVisible)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterCurActivity)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterActivityCenter)
	end,
	function()
		DungeonController.instance:enterDungeonView(true, true)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRoom)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRole)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSummon)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterBook)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterAchievement)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterFriend)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterTravelCollection)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterNotice)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSign)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSetting)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterFeedback)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterStore)
	end
}

function MainActivityAdapter:ctor()
	BaseActivityAdapter.ctor(self)

	self.keytoFunction = MainActivityAdapter.keytoFunction
	self.activitid = PCInputModel.Activity.MainActivity

	self:registerFunction()
end

function MainActivityAdapter:OnkeyUp(keyName)
	if ViewMgr.instance:IsPopUpViewOpen() or ViewMgr.instance:isOpen(ViewName.MainThumbnailView) or ViewMgr.instance:isOpen(ViewName.SettingsView) or ViewMgr.instance:isOpen(ViewName.SummonView) then
		return
	end

	BaseActivityAdapter.OnkeyUp(self, keyName)
end

function MainActivityAdapter:OnkeyDown(keyName)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyDown(self, keyName)
end

return MainActivityAdapter

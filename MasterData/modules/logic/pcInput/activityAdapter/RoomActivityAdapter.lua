-- chunkname: @modules/logic/pcInput/activityAdapter/RoomActivityAdapter.lua

module("modules.logic.pcInput.activityAdapter.RoomActivityAdapter", package.seeall)

local RoomActivityAdapter = class("RoomActivityAdapter", BaseActivityAdapter)

RoomActivityAdapter.keytoFunction = {
	function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() and not ViewMgr.instance:isOpen(ViewName.RoomCharacterPlaceView) or not isInOb then
			return
		end

		HelpController.instance:showHelp(HelpEnum.HelpId.RoomOb, true)
	end,
	function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomMarket)
	end,
	function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomBellTower)
	end,
	function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaith)
	end,
	function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaithFull)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyHide)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.Notifylocate)
	end,
	[9] = function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBuy)
	end,
	[10] = function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyLayout)
	end,
	[11] = function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyPlace)
	end,
	[12] = function()
		local isInOb = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not isInOb then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEdit)
	end
}

function RoomActivityAdapter:checkCanOpen()
	if ViewMgr.instance:IsPopUpViewOpen() then
		return false
	end

	return true
end

function RoomActivityAdapter:ctor()
	BaseActivityAdapter.ctor(self)

	self.keytoFunction = RoomActivityAdapter.keytoFunction
	self.activitid = PCInputModel.Activity.room

	self:registerFunction()
end

function RoomActivityAdapter:OnkeyUp(keyName)
	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(406) then
		return
	end

	BaseActivityAdapter.OnkeyUp(self, keyName)
end

function RoomActivityAdapter:OnkeyDown(keyName)
	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(406) then
		return
	end

	BaseActivityAdapter.OnkeyUp(self, keyName)
end

return RoomActivityAdapter

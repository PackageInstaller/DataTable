-- chunkname: @modules/logic/pcInput/activityAdapter/ThirdDoorActivtiyAdapter.lua

module("modules.logic.pcInput.activityAdapter.ThirdDoorActivtiyAdapter", package.seeall)

local ThirdDoorActivtiyAdapter = class("ThirdDoorActivtiyAdapter", BaseActivityAdapter)

ThirdDoorActivtiyAdapter.keytoFunction = {
	[5] = function()
		if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
			ViewMgr.instance:closeView(ViewName.ExploreMapView)
		else
			if ViewMgr.instance:IsPopUpViewOpen() or not ThirdDoorActivtiyAdapter.instance:getHeroCanMove() then
				return
			end

			ViewMgr.instance:openView(ViewName.ExploreMapView)
		end
	end,
	[6] = function()
		if not ExploreSimpleModel.instance.isShowBag then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.ExploreBackpackView) then
			ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		else
			if ViewMgr.instance:IsPopUpViewOpen() or not ThirdDoorActivtiyAdapter.instance:getHeroCanMove() then
				return
			end

			ViewMgr.instance:openView(ViewName.ExploreBackpackView)
		end
	end,
	[7] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 1)
	end,
	[8] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 2)
	end,
	[9] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 3)
	end,
	[10] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 4)
	end,
	[11] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 5)
	end,
	[12] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 6)
	end,
	[13] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 7)
	end,
	[14] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 8)
	end,
	[15] = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 9)
	end,
	[16] = function()
		if ViewMgr.instance:isOpen(ViewName.HelpView) then
			ViewMgr.instance:closeView(ViewName.HelpView)

			return
		end

		if ViewMgr.instance:IsPopUpViewOpen() or not ThirdDoorActivtiyAdapter.instance:getHeroCanMove() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorHelp)
	end,
	[17] = function()
		if ViewMgr.instance:isOpen(ViewName.ExploreArchivesView) then
			ViewMgr.instance:closeView(ViewName.ExploreArchivesView)

			return
		end

		if ViewMgr.instance:IsPopUpViewOpen() or not ThirdDoorActivtiyAdapter.instance:getHeroCanMove() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorOpenBook)
	end
}

function ThirdDoorActivtiyAdapter:getHeroCanMove()
	local map = ExploreController.instance:getMap()

	if map and map:getNowStatus() == ExploreEnum.MapStatus.Normal then
		return true
	end

	return false
end

function ThirdDoorActivtiyAdapter:ctor()
	BaseActivityAdapter.ctor(self)

	self.keytoFunction = ThirdDoorActivtiyAdapter.keytoFunction
	self.activitid = PCInputModel.Activity.thrityDoor

	self:registerFunction()
end

ThirdDoorActivtiyAdapter.instance = ThirdDoorActivtiyAdapter.New()

return ThirdDoorActivtiyAdapter

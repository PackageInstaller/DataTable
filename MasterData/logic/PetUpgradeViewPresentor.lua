-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petupgrade/view/PetUpgradeViewPresentor.lua

module("logic.extensions.petupgrade.view.PetUpgradeViewPresentor", package.seeall)

local PetUpgradeViewPresentor = class("PetUpgradeViewPresentor", ViewWithGuidePresentor)

function PetUpgradeViewPresentor:ctor()
	PetUpgradeViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PetUpgradeViewPriority
end

function PetUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/petupgrade/petupgradeview.prefab"
	}
end

function PetUpgradeViewPresentor:buildViews()
	return {
		PetUpgradeView.New()
	}
end

function PetUpgradeViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return PetUpgradeViewPresentor

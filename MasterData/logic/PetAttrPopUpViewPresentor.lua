-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAttrPopUpViewPresentor.lua

module("logic.extensions.bag.view.stack.PetAttrPopUpViewPresentor", package.seeall)

local PetAttrPopUpViewPresentor = class("PetAttrPopUpViewPresentor", ViewPresentor)

function PetAttrPopUpViewPresentor:ctor()
	PetAttrPopUpViewPresentor.super.ctor(self)
end

function PetAttrPopUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetAttrPopUpViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petattrpopupview.prefab",
		"ui/views/common/item_attr2.prefab",
		"ui/views/common/item_attr3.prefab"
	}
end

function PetAttrPopUpViewPresentor:buildViews()
	return {
		PetAttrPopUpView.New()
	}
end

return PetAttrPopUpViewPresentor

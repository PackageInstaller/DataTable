-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/OptionalBuyViewPresentor.lua

module("logic.extensions.equipment.view.OptionalBuyViewPresentor", package.seeall)

local OptionalBuyViewPresentor = class("OptionalBuyViewPresentor", ViewWithGuidePresentor)

function OptionalBuyViewPresentor:ctor()
	OptionalBuyViewPresentor.super.ctor(self)
end

function OptionalBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OptionalBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/optionalbuyview.prefab"
	}
end

function OptionalBuyViewPresentor:buildViews()
	return {
		OptionalBuyView.New()
	}
end

return OptionalBuyViewPresentor

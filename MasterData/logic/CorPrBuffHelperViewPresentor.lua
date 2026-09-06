-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrBuffHelperViewPresentor.lua

module("logic.extensions.corpr.view.CorPrBuffHelperViewPresentor", package.seeall)

local CorPrBuffHelperViewPresentor = class("CorPrBuffHelperViewPresentor", ViewPresentor)

function CorPrBuffHelperViewPresentor:ctor()
	CorPrBuffHelperViewPresentor.super.ctor(self)
end

function CorPrBuffHelperViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CorPrBuffHelperViewPresentor:dependWhatResources()
	return {
		"ui/views/corpr/corprbuffhelperview.prefab"
	}
end

function CorPrBuffHelperViewPresentor:buildViews()
	return {
		CorPrBuffHelperView.New()
	}
end

return CorPrBuffHelperViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/SharePopupViewPresentor.lua

module("logic.extensions.sharetask.view.SharePopupViewPresentor", package.seeall)

local SharePopupViewPresentor = class("SharePopupViewPresentor", ViewPresentor)

function SharePopupViewPresentor:ctor()
	SharePopupViewPresentor.super.ctor(self)
end

function SharePopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SharePopupViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/sharepopupview.prefab"
	}
end

function SharePopupViewPresentor:buildViews()
	return {
		SharePopupView.New()
	}
end

return SharePopupViewPresentor

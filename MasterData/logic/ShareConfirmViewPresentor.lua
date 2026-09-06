-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareConfirmViewPresentor.lua

module("logic.extensions.sharetask.view.ShareConfirmViewPresentor", package.seeall)

local ShareConfirmViewPresentor = class("ShareConfirmViewPresentor", ViewPresentor)

function ShareConfirmViewPresentor:ctor()
	ShareConfirmViewPresentor.super.ctor(self)
end

function ShareConfirmViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShareConfirmViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/shareconfirmview.prefab"
	}
end

function ShareConfirmViewPresentor:buildViews()
	return {
		ShareConfirmView.New()
	}
end

return ShareConfirmViewPresentor

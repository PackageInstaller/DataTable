-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareViewPresentor.lua

module("logic.extensions.share.view.ShareViewPresentor", package.seeall)

local ShareViewPresentor = class("ShareViewPresentor", ViewPresentor)

function ShareViewPresentor:ctor()
	ShareViewPresentor.super.ctor(self)
end

function ShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShareViewPresentor:dependWhatResources()
	return {
		"ui/views/share/shareview.prefab"
	}
end

function ShareViewPresentor:buildViews()
	return {
		ShareView.New()
	}
end

return ShareViewPresentor

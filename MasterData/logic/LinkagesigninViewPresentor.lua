-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuobirthday/view/LinkagesigninViewPresentor.lua

module("logic.extensions.xiaonuobirthday.view.LinkagesigninViewPresentor", package.seeall)

local LinkagesigninViewPresentor = class("LinkagesigninViewPresentor", ViewPresentor)

function LinkagesigninViewPresentor:ctor()
	LinkagesigninViewPresentor.super.ctor(self)
end

function LinkagesigninViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkagesigninViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/linkagesigninview.prefab"
	}
end

function LinkagesigninViewPresentor:buildViews()
	return {
		LinkageSignInView.New()
	}
end

return LinkagesigninViewPresentor

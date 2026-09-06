-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialtipViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialtipViewPresentor", package.seeall)

local HerotrialtipViewPresentor = class("HerotrialtipViewPresentor", ViewPresentor)

function HerotrialtipViewPresentor:ctor()
	HerotrialtipViewPresentor.super.ctor(self)
end

function HerotrialtipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialtipViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialtip.prefab"
	}
end

function HerotrialtipViewPresentor:buildViews()
	return {
		HerotrialtipView.New()
	}
end

return HerotrialtipViewPresentor

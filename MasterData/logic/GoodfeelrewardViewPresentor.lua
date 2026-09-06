-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelrewardViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelrewardViewPresentor", package.seeall)

local GoodfeelrewardViewPresentor = class("GoodfeelrewardViewPresentor", ViewPresentor)

function GoodfeelrewardViewPresentor:ctor()
	GoodfeelrewardViewPresentor.super.ctor(self)
end

function GoodfeelrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelrewardview.prefab"
	}
end

function GoodfeelrewardViewPresentor:buildViews()
	return {
		GoodfeelrewardView.New()
	}
end

return GoodfeelrewardViewPresentor

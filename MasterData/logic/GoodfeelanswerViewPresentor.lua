-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelanswerViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelanswerViewPresentor", package.seeall)

local GoodfeelanswerViewPresentor = class("GoodfeelanswerViewPresentor", ViewPresentor)

function GoodfeelanswerViewPresentor:ctor()
	GoodfeelanswerViewPresentor.super.ctor(self)
end

function GoodfeelanswerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelanswerViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelanswerview.prefab"
	}
end

function GoodfeelanswerViewPresentor:buildViews()
	return {
		GoodfeelanswerView.New()
	}
end

return GoodfeelanswerViewPresentor

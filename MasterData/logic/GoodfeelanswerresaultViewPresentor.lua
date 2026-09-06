-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelanswerresaultViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelanswerresaultViewPresentor", package.seeall)

local GoodfeelanswerresaultViewPresentor = class("GoodfeelanswerresaultViewPresentor", ViewPresentor)

function GoodfeelanswerresaultViewPresentor:ctor()
	GoodfeelanswerresaultViewPresentor.super.ctor(self)
end

function GoodfeelanswerresaultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelanswerresaultViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelanswerresaultview.prefab"
	}
end

function GoodfeelanswerresaultViewPresentor:buildViews()
	return {
		GoodfeelanswerresaultView.New()
	}
end

return GoodfeelanswerresaultViewPresentor

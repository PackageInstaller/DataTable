-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelspeanswerViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelspeanswerViewPresentor", package.seeall)

local GoodfeelspeanswerViewPresentor = class("GoodfeelspeanswerViewPresentor", ViewPresentor)

function GoodfeelspeanswerViewPresentor:ctor()
	GoodfeelspeanswerViewPresentor.super.ctor(self)
end

function GoodfeelspeanswerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelspeanswerViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelspeanswerview.prefab"
	}
end

function GoodfeelspeanswerViewPresentor:buildViews()
	return {
		GoodfeelspeanswerView.New()
	}
end

return GoodfeelspeanswerViewPresentor

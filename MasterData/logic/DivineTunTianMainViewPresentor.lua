-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianMainViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianMainViewPresentor", package.seeall)

local DivineTunTianMainViewPresentor = class("DivineTunTianMainViewPresentor", ViewPresentor)

function DivineTunTianMainViewPresentor:ctor()
	DivineTunTianMainViewPresentor.super.ctor(self)
end

function DivineTunTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntianmainview.prefab"
	}
end

function DivineTunTianMainViewPresentor:buildViews()
	return {
		DivineTunTianMainView.New()
	}
end

return DivineTunTianMainViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianNorViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianNorViewPresentor", package.seeall)

local DivineTunTianNorViewPresentor = class("DivineTunTianNorViewPresentor", ViewPresentor)

function DivineTunTianNorViewPresentor:ctor()
	DivineTunTianNorViewPresentor.super.ctor(self)
end

function DivineTunTianNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianNorViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntiannorview.prefab"
	}
end

function DivineTunTianNorViewPresentor:buildViews()
	return {
		DivineTunTianNorView.New()
	}
end

return DivineTunTianNorViewPresentor

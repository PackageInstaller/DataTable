-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianBuffViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianBuffViewPresentor", package.seeall)

local DivineTunTianBuffViewPresentor = class("DivineTunTianBuffViewPresentor", ViewPresentor)

function DivineTunTianBuffViewPresentor:ctor()
	DivineTunTianBuffViewPresentor.super.ctor(self)
end

function DivineTunTianBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntianbuffview.prefab"
	}
end

function DivineTunTianBuffViewPresentor:buildViews()
	return {
		DivineTunTianBuffView.New()
	}
end

return DivineTunTianBuffViewPresentor

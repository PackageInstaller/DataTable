-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianExtViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianExtViewPresentor", package.seeall)

local DivineTunTianExtViewPresentor = class("DivineTunTianExtViewPresentor", ViewPresentor)

function DivineTunTianExtViewPresentor:ctor()
	DivineTunTianExtViewPresentor.super.ctor(self)
end

function DivineTunTianExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianExtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntianextview.prefab"
	}
end

function DivineTunTianExtViewPresentor:buildViews()
	return {
		DivineTunTianExtView.New()
	}
end

return DivineTunTianExtViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianFmtViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianFmtViewPresentor", package.seeall)

local DivineTunTianFmtViewPresentor = class("DivineTunTianFmtViewPresentor", ViewPresentor)

function DivineTunTianFmtViewPresentor:ctor()
	DivineTunTianFmtViewPresentor.super.ctor(self)
end

function DivineTunTianFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntianfmtview.prefab"
	}
end

function DivineTunTianFmtViewPresentor:buildViews()
	return {
		DivineTunTianFmtView.New()
	}
end

return DivineTunTianFmtViewPresentor

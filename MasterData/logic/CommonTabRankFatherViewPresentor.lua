-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/father/CommonTabRankFatherViewPresentor.lua

module("logic.extensions.commontabrank.view.father.CommonTabRankFatherViewPresentor", package.seeall)

local CommonTabRankFatherViewPresentor = class("CommonTabRankFatherViewPresentor", ViewPresentor)

function CommonTabRankFatherViewPresentor:ctor()
	CommonTabRankFatherViewPresentor.super.ctor(self)
end

function CommonTabRankFatherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CommonTabRankFatherViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/commontabrankfatherview.prefab"
	}
end

function CommonTabRankFatherViewPresentor:buildViews()
	return {
		CommonTabRankFatherView.New()
	}
end

return CommonTabRankFatherViewPresentor

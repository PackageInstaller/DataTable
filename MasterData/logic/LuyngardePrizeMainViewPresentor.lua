-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardePrizeMainViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardePrizeMainViewPresentor", package.seeall)

local LuyngardePrizeMainViewPresentor = class("LuyngardePrizeMainViewPresentor", ViewPresentor)

function LuyngardePrizeMainViewPresentor:ctor()
	LuyngardePrizeMainViewPresentor.super.ctor(self)
end

function LuyngardePrizeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardePrizeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardeprizemainview.prefab"
	}
end

function LuyngardePrizeMainViewPresentor:buildViews()
	return {
		LuyngardePrizeMainView.New()
	}
end

return LuyngardePrizeMainViewPresentor

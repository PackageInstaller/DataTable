-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/view/DivinesaintknightfiregodmainViewPresentor.lua

module("logic.extensions.DivineSaintKnightFireGod.view.DivinesaintknightfiregodmainViewPresentor", package.seeall)

local DivinesaintknightfiregodmainViewPresentor = class("DivinesaintknightfiregodmainViewPresentor", ViewPresentor)

function DivinesaintknightfiregodmainViewPresentor:ctor()
	DivinesaintknightfiregodmainViewPresentor.super.ctor(self)
end

function DivinesaintknightfiregodmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesaintknightfiregodmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesaintknightfiregod/divinesaintknightfiregodmainview.prefab"
	}
end

function DivinesaintknightfiregodmainViewPresentor:buildViews()
	return {
		DivinesaintknightfiregodmainView.New()
	}
end

return DivinesaintknightfiregodmainViewPresentor

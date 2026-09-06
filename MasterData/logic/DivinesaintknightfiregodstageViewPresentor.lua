-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/view/DivinesaintknightfiregodstageViewPresentor.lua

module("logic.extensions.DivineSaintKnightFireGod.view.DivinesaintknightfiregodstageViewPresentor", package.seeall)

local DivinesaintknightfiregodstageViewPresentor = class("DivinesaintknightfiregodstageViewPresentor", ViewPresentor)

function DivinesaintknightfiregodstageViewPresentor:ctor()
	DivinesaintknightfiregodstageViewPresentor.super.ctor(self)
end

function DivinesaintknightfiregodstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesaintknightfiregodstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesaintknightfiregod/divinesaintknightfiregodstageview.prefab"
	}
end

function DivinesaintknightfiregodstageViewPresentor:buildViews()
	return {
		DivinesaintknightfiregodstageView.New()
	}
end

return DivinesaintknightfiregodstageViewPresentor

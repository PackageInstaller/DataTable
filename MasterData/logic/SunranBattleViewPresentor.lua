-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranBattleViewPresentor.lua

module("logic.extensions.sunranbattle.view.SunranBattleViewPresentor", package.seeall)

local SunranBattleViewPresentor = class("SunranBattleViewPresentor", ViewWithGuidePresentor)

function SunranBattleViewPresentor:ctor()
	SunranBattleViewPresentor.super.ctor(self)
end

function SunranBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunranBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/sunranbattle/sunranbattleview.prefab"
	}
end

function SunranBattleViewPresentor:buildViews()
	return {
		SunranBattleView.New()
	}
end

return SunranBattleViewPresentor

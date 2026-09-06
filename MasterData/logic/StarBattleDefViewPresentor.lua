-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleDefViewPresentor", package.seeall)

local StarBattleDefViewPresentor = class("StarBattleDefViewPresentor", ViewPresentor)

function StarBattleDefViewPresentor:ctor()
	StarBattleDefViewPresentor.super.ctor(self)
end

function StarBattleDefViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleDefViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattledefview.prefab"
	}
end

function StarBattleDefViewPresentor:buildViews()
	return {
		StarBattleDefView.New()
	}
end

function StarBattleDefViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarBattleDefViewPresentor

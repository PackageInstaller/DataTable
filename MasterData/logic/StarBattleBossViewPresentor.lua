-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleBossViewPresentor", package.seeall)

local StarBattleBossViewPresentor = class("StarBattleBossViewPresentor", ViewPresentor)

function StarBattleBossViewPresentor:ctor()
	StarBattleBossViewPresentor.super.ctor(self)
end

function StarBattleBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleBossViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlebossview.prefab"
	}
end

function StarBattleBossViewPresentor:buildViews()
	return {
		StarBattleBossView.New()
	}
end

function StarBattleBossViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarBattleBossViewPresentor

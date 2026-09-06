-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBossViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpBossViewPresentor", package.seeall)

local StKnExpBossViewPresentor = class("StKnExpBossViewPresentor", ViewPresentor)

function StKnExpBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpBossViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpbossview.prefab"
	}
end

function StKnExpBossViewPresentor:buildViews()
	return {
		StKnExpBossView.New()
	}
end

function StKnExpBossViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StKnExpBossViewPresentor

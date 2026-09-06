-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxldifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxldifficultyViewPresentor", package.seeall)

local ZxldifficultyViewPresentor = class("ZxldifficultyViewPresentor", ViewPresentor)

function ZxldifficultyViewPresentor:ctor()
	ZxldifficultyViewPresentor.super.ctor(self)
end

function ZxldifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZxldifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/zxldifficultyview.prefab"
	}
end

function ZxldifficultyViewPresentor:buildViews()
	return {
		ZxldifficultyView.New()
	}
end

function ZxldifficultyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ZxldifficultyViewPresentor

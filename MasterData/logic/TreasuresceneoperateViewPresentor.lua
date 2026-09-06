-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasuresceneoperateViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasuresceneoperateViewPresentor", package.seeall)

local TreasuresceneoperateViewPresentor = class("TreasuresceneoperateViewPresentor", ViewPresentor)

function TreasuresceneoperateViewPresentor:ctor()
	TreasuresceneoperateViewPresentor.super.ctor(self)
end

function TreasuresceneoperateViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function TreasuresceneoperateViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function TreasuresceneoperateViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasuresceneoperateview.prefab"
	}
end

function TreasuresceneoperateViewPresentor:buildViews()
	return {
		TreasuresceneoperateView.New()
	}
end

return TreasuresceneoperateViewPresentor

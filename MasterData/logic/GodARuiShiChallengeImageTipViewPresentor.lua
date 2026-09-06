-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeImageTipViewPresentor.lua

module("logic.extensions.holystripe.view.GodARuiShiChallengeImageTipViewPresentor", package.seeall)

local GodARuiShiChallengeImageTipViewPresentor = class("GodARuiShiChallengeImageTipViewPresentor", ViewPresentor)

function GodARuiShiChallengeImageTipViewPresentor:ctor()
	GodARuiShiChallengeImageTipViewPresentor.super.ctor(self)
end

function GodARuiShiChallengeImageTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodARuiShiChallengeImageTipViewPresentor:dependWhatResources()
	return {
		"ui/views/godaruishichallenge/godaruishichallengeimagetipview.prefab"
	}
end

function GodARuiShiChallengeImageTipViewPresentor:buildViews()
	return {
		GodARuiShiChallengeImageTipView.New()
	}
end

function GodARuiShiChallengeImageTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function GodARuiShiChallengeImageTipViewPresentor:onClickOutside()
	self:close()
end

return GodARuiShiChallengeImageTipViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallBoxRankViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallBoxRankViewPresentor", package.seeall)

local CompanionMallBoxRankViewPresentor = class("CompanionMallBoxRankViewPresentor", ViewPresentor)

function CompanionMallBoxRankViewPresentor:ctor()
	CompanionMallBoxRankViewPresentor.super.ctor(self)
end

function CompanionMallBoxRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallBoxRankViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallboxrankview.prefab"
	}
end

function CompanionMallBoxRankViewPresentor:buildViews()
	return {
		CompanionMallBoxRankView.New()
	}
end

function CompanionMallBoxRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CompanionMallBoxRankViewPresentor

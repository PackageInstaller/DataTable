-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPetRankJumpViewPresentor.lua

module("logic.extensions.saintknighttask.view.SKTPetRankJumpViewPresentor", package.seeall)

local SKTPetRankJumpViewPresentor = class("SKTPetRankJumpViewPresentor", ViewPresentor)

function SKTPetRankJumpViewPresentor:ctor()
	SKTPetRankJumpViewPresentor.super.ctor(self)
end

function SKTPetRankJumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTPetRankJumpViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktpetrankjumpview.prefab"
	}
end

function SKTPetRankJumpViewPresentor:buildViews()
	return {
		SKTPetRankJumpView.New()
	}
end

function SKTPetRankJumpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTPetRankJumpViewPresentor

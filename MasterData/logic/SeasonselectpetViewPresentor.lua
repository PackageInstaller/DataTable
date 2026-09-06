-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonselectpetViewPresentor.lua

module("logic.extensions.season.view.SeasonselectpetViewPresentor", package.seeall)

local SeasonselectpetViewPresentor = class("SeasonselectpetViewPresentor", ViewWithGuidePresentor)

function SeasonselectpetViewPresentor:ctor()
	SeasonselectpetViewPresentor.super.ctor(self)
end

function SeasonselectpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonselectpetViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonselectpetview.prefab"
	}
end

function SeasonselectpetViewPresentor:buildViews()
	return {
		SeasonselectpetView.New()
	}
end

function SeasonselectpetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonselectpetViewPresentor

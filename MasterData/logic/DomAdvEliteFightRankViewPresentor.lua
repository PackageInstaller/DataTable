-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/rank/DomAdvEliteFightRankViewPresentor.lua

module("logic.extensions.tourarena.view.DomAdvEliteFightRankViewPresentor", package.seeall)

local DomAdvEliteFightRankViewPresentor = class("DomAdvEliteFightRankViewPresentor", ViewPresentor)

function DomAdvEliteFightRankViewPresentor:ctor()
	DomAdvEliteFightRankViewPresentor.super.ctor(self)
end

function DomAdvEliteFightRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEliteFightRankViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvelitefightrankview.prefab"
	}
end

function DomAdvEliteFightRankViewPresentor:buildViews()
	return {
		DomAdvEliteFightRankView.New()
	}
end

function DomAdvEliteFightRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DomAdvEliteFightRankViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/rank/DomAdvBossRankViewPresentor.lua

module("logic.extensions.tourarena.view.DomAdvBossRankViewPresentor", package.seeall)

local DomAdvBossRankViewPresentor = class("DomAdvBossRankViewPresentor", ViewPresentor)

function DomAdvBossRankViewPresentor:ctor()
	DomAdvBossRankViewPresentor.super.ctor(self)
end

function DomAdvBossRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvBossRankViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvbossrankview.prefab"
	}
end

function DomAdvBossRankViewPresentor:buildViews()
	return {
		DomAdvBossRankView.New()
	}
end

function DomAdvBossRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DomAdvBossRankViewPresentor

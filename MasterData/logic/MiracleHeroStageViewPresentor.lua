-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroStageViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroStageViewPresentor", package.seeall)

local MiracleHeroStageViewPresentor = class("MiracleHeroStageViewPresentor", ViewPresentor)

function MiracleHeroStageViewPresentor:ctor()
	MiracleHeroStageViewPresentor.super.ctor(self)
end

function MiracleHeroStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroStageViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleherostageview.prefab"
	}
end

function MiracleHeroStageViewPresentor:buildViews()
	return {
		MiracleHeroStageView.New()
	}
end

function MiracleHeroStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiracleHeroStageViewPresentor

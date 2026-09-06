-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroFormationViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroFormationViewPresentor", package.seeall)

local MiracleHeroFormationViewPresentor = class("MiracleHeroFormationViewPresentor", ViewPresentor)

function MiracleHeroFormationViewPresentor:ctor()
	MiracleHeroFormationViewPresentor.super.ctor(self)
end

function MiracleHeroFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheroformationview.prefab"
	}
end

function MiracleHeroFormationViewPresentor:buildViews()
	return {
		MiracleHeroFormationView.New()
	}
end

return MiracleHeroFormationViewPresentor

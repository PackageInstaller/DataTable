-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroRankViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroRankViewPresentor", package.seeall)

local MiracleHeroRankViewPresentor = class("MiracleHeroRankViewPresentor", ViewPresentor)

function MiracleHeroRankViewPresentor:ctor()
	MiracleHeroRankViewPresentor.super.ctor(self)
end

function MiracleHeroRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroRankViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleherorankview.prefab"
	}
end

function MiracleHeroRankViewPresentor:buildViews()
	return {
		MiracleHeroRankView.New()
	}
end

return MiracleHeroRankViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroResultWinViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroResultWinViewPresentor", package.seeall)

local MiracleHeroResultWinViewPresentor = class("MiracleHeroResultWinViewPresentor", ViewPresentor)

function MiracleHeroResultWinViewPresentor:ctor()
	MiracleHeroResultWinViewPresentor.super.ctor(self)
end

function MiracleHeroResultWinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroResultWinViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheroresultwinview.prefab"
	}
end

function MiracleHeroResultWinViewPresentor:buildViews()
	return {
		MiracleHeroResultWinView.New()
	}
end

return MiracleHeroResultWinViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroMainViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroMainViewPresentor", package.seeall)

local MiracleHeroMainViewPresentor = class("MiracleHeroMainViewPresentor", ViewPresentor)

function MiracleHeroMainViewPresentor:ctor()
	MiracleHeroMainViewPresentor.super.ctor(self)
end

function MiracleHeroMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroMainViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheromainview.prefab"
	}
end

function MiracleHeroMainViewPresentor:buildViews()
	return {
		MiracleHeroMainView.New()
	}
end

return MiracleHeroMainViewPresentor

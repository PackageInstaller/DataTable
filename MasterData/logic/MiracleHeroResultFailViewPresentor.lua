-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroResultFailViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroResultFailViewPresentor", package.seeall)

local MiracleHeroResultFailViewPresentor = class("MiracleHeroResultFailViewPresentor", ViewPresentor)

function MiracleHeroResultFailViewPresentor:ctor()
	MiracleHeroResultFailViewPresentor.super.ctor(self)
end

function MiracleHeroResultFailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiracleHeroResultFailViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheroresultfailview.prefab"
	}
end

function MiracleHeroResultFailViewPresentor:buildViews()
	return {
		MiracleHeroResultFailView.New()
	}
end

return MiracleHeroResultFailViewPresentor

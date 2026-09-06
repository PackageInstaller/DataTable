-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroBattleViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroBattleViewPresentor", package.seeall)

local MiracleHeroBattleViewPresentor = class("MiracleHeroBattleViewPresentor", ViewPresentor)

function MiracleHeroBattleViewPresentor:ctor()
	MiracleHeroBattleViewPresentor.super.ctor(self)
end

function MiracleHeroBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleherobattleview.prefab"
	}
end

function MiracleHeroBattleViewPresentor:buildViews()
	return {
		MiracleHeroBattleView.New()
	}
end

return MiracleHeroBattleViewPresentor

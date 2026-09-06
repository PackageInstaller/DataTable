-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideBattleGasPresentor.lua

module("logic.extensions.guide.view.GuideBattleGasPresentor", package.seeall)

local GuideBattleGasPresentor = class("GuideBattleGasPresentor", GuideViewPresentor)

function GuideBattleGasPresentor:ctor()
	GuideBattleGasPresentor.super.ctor(self)
end

function GuideBattleGasPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideBattleGasPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_battlegas.prefab"
	}
end

function GuideBattleGasPresentor:buildViews()
	return {
		GuideBattleGas.New()
	}
end

return GuideBattleGasPresentor

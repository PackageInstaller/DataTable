-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyBattleViewPresentor.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyBattleViewPresentor", package.seeall)

local MiracleHeroCopyBattleViewPresentor = class("MiracleHeroCopyBattleViewPresentor", ViewPresentor)

function MiracleHeroCopyBattleViewPresentor:ctor()
	MiracleHeroCopyBattleViewPresentor.super.ctor(self)
end

function MiracleHeroCopyBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroCopyBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/miracleherocopy/miracleherocopybattleview.prefab"
	}
end

function MiracleHeroCopyBattleViewPresentor:buildViews()
	return {
		MiracleHeroCopyBattleView.New()
	}
end

return MiracleHeroCopyBattleViewPresentor

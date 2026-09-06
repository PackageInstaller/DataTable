-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroLevelUpViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroLevelUpViewPresentor", package.seeall)

local MiracleHeroLevelUpViewPresentor = class("MiracleHeroLevelUpViewPresentor", ViewPresentor)

function MiracleHeroLevelUpViewPresentor:ctor()
	MiracleHeroLevelUpViewPresentor.super.ctor(self)
end

function MiracleHeroLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleherolevelupview.prefab"
	}
end

function MiracleHeroLevelUpViewPresentor:buildViews()
	return {
		MiracleHeroLevelUpView.New()
	}
end

return MiracleHeroLevelUpViewPresentor

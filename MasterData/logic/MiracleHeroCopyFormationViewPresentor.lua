-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyFormationViewPresentor.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyFormationViewPresentor", package.seeall)

local MiracleHeroCopyFormationViewPresentor = class("MiracleHeroCopyFormationViewPresentor", ViewPresentor)

function MiracleHeroCopyFormationViewPresentor:ctor()
	MiracleHeroCopyFormationViewPresentor.super.ctor(self)
end

function MiracleHeroCopyFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroCopyFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/miracleherocopy/miracleherocopyformationview.prefab"
	}
end

function MiracleHeroCopyFormationViewPresentor:buildViews()
	return {
		MiracleHeroCopyFormationView.New()
	}
end

return MiracleHeroCopyFormationViewPresentor

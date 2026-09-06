-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyStageViewPresentor.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyStageViewPresentor", package.seeall)

local MiracleHeroCopyStageViewPresentor = class("MiracleHeroCopyStageViewPresentor", ViewPresentor)

function MiracleHeroCopyStageViewPresentor:ctor()
	MiracleHeroCopyStageViewPresentor.super.ctor(self)
end

function MiracleHeroCopyStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroCopyStageViewPresentor:dependWhatResources()
	return {
		"ui/views/miracleherocopy/miracleherocopystageview.prefab"
	}
end

function MiracleHeroCopyStageViewPresentor:buildViews()
	return {
		MiracleHeroCopyStageView.New()
	}
end

return MiracleHeroCopyStageViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyMainViewPresentor.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyMainViewPresentor", package.seeall)

local MiracleHeroCopyMainViewPresentor = class("MiracleHeroCopyMainViewPresentor", ViewPresentor)

function MiracleHeroCopyMainViewPresentor:ctor()
	MiracleHeroCopyMainViewPresentor.super.ctor(self)
end

function MiracleHeroCopyMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroCopyMainViewPresentor:dependWhatResources()
	return {
		"ui/views/miracleherocopy/miracleherocopymainview.prefab"
	}
end

function MiracleHeroCopyMainViewPresentor:buildViews()
	return {
		MiracleHeroCopyMainView.New()
	}
end

return MiracleHeroCopyMainViewPresentor

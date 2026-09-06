-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroPettipsViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroPettipsViewPresentor", package.seeall)

local MiracleHeroPettipsViewPresentor = class("MiracleHeroPettipsViewPresentor", ViewPresentor)

function MiracleHeroPettipsViewPresentor:ctor()
	MiracleHeroPettipsViewPresentor.super.ctor(self)
end

function MiracleHeroPettipsViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function MiracleHeroPettipsViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheropettipsview.prefab"
	}
end

function MiracleHeroPettipsViewPresentor:buildViews()
	return {
		MiracleHeroPettipsView.New()
	}
end

return MiracleHeroPettipsViewPresentor

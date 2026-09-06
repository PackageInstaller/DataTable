-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangtowerrankViewPresentor.lua

module("logic.extensions.mangtower.view.MangtowerrankViewPresentor", package.seeall)

local MangtowerrankViewPresentor = class("MangtowerrankViewPresentor", ViewPresentor)

function MangtowerrankViewPresentor:ctor()
	MangtowerrankViewPresentor.super.ctor(self)
end

function MangtowerrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MangtowerrankViewPresentor:dependWhatResources()
	return {
		"ui/views/mangtower/mangtowerrankview.prefab"
	}
end

function MangtowerrankViewPresentor:buildViews()
	return {
		MangTowerRankView.New()
	}
end

return MangtowerrankViewPresentor

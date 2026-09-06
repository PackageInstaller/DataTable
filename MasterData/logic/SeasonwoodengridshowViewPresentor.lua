-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonwoodengridshowViewPresentor.lua

module("logic.extensions.season.view.SeasonwoodengridshowViewPresentor", package.seeall)

local SeasonwoodengridshowViewPresentor = class("SeasonwoodengridshowViewPresentor", ViewPresentor)

function SeasonwoodengridshowViewPresentor:ctor()
	SeasonwoodengridshowViewPresentor.super.ctor(self)
end

function SeasonwoodengridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonwoodengridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonwoodengridshowview.prefab"
	}
end

function SeasonwoodengridshowViewPresentor:buildViews()
	return {
		SeasonWoodenGridShowView.New()
	}
end

return SeasonwoodengridshowViewPresentor

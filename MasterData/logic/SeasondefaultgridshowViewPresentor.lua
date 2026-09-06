-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasondefaultgridshowViewPresentor.lua

module("logic.extensions.season.view.SeasondefaultgridshowViewPresentor", package.seeall)

local SeasondefaultgridshowViewPresentor = class("SeasondefaultgridshowViewPresentor", ViewPresentor)

function SeasondefaultgridshowViewPresentor:ctor()
	SeasondefaultgridshowViewPresentor.super.ctor(self)
end

function SeasondefaultgridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasondefaultgridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasondefaultgridshowview.prefab"
	}
end

function SeasondefaultgridshowViewPresentor:buildViews()
	return {
		SeasonDefaultGridShowView.New()
	}
end

return SeasondefaultgridshowViewPresentor

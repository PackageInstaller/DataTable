-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/noah/NoahstageViewPresentor.lua

module("logic.extensions.scenariocopy.view.noah.NoahstageViewPresentor", package.seeall)

local NoahstageViewPresentor = class("NoahstageViewPresentor", ViewPresentor)

function NoahstageViewPresentor:ctor()
	NoahstageViewPresentor.super.ctor(self)
end

function NoahstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahstageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/noah/noahstageview.prefab"
	}
end

function NoahstageViewPresentor:buildViews()
	return {
		NoahStageView.New()
	}
end

return NoahstageViewPresentor

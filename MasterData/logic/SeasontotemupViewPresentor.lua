-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasontotemupViewPresentor.lua

module("logic.extensions.season.view.SeasontotemupViewPresentor", package.seeall)

local SeasontotemupViewPresentor = class("SeasontotemupViewPresentor", ViewPresentor)

function SeasontotemupViewPresentor:ctor()
	SeasontotemupViewPresentor.super.ctor(self)
end

function SeasontotemupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasontotemupViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontotemupview.prefab"
	}
end

function SeasontotemupViewPresentor:buildViews()
	return {
		SeasonTotemUpView.New()
	}
end

return SeasontotemupViewPresentor

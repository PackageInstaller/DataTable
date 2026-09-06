-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonmaincamplvupViewPresentor.lua

module("logic.extensions.season.view.SeasonmaincamplvupViewPresentor", package.seeall)

local SeasonmaincamplvupViewPresentor = class("SeasonmaincamplvupViewPresentor", ViewPresentor)

function SeasonmaincamplvupViewPresentor:ctor()
	SeasonmaincamplvupViewPresentor.super.ctor(self)
end

function SeasonmaincamplvupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonmaincamplvupViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmaincamplvupview.prefab"
	}
end

function SeasonmaincamplvupViewPresentor:buildViews()
	return {
		SeasonMainCampLvUpView.New()
	}
end

return SeasonmaincamplvupViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonillustrategridshowViewPresentor.lua

module("logic.extensions.season.view.SeasonillustrategridshowViewPresentor", package.seeall)

local SeasonillustrategridshowViewPresentor = class("SeasonillustrategridshowViewPresentor", ViewPresentor)

function SeasonillustrategridshowViewPresentor:ctor()
	SeasonillustrategridshowViewPresentor.super.ctor(self)
end

function SeasonillustrategridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonillustrategridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonillustrategridshowview.prefab"
	}
end

function SeasonillustrategridshowViewPresentor:buildViews()
	return {
		SeasonIlluStrateGridShowView.New()
	}
end

return SeasonillustrategridshowViewPresentor

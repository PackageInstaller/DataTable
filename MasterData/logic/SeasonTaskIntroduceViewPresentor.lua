-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTaskIntroduceViewPresentor.lua

module("logic.extensions.season.view.SeasonTaskIntroduceViewPresentor", package.seeall)

local SeasonTaskIntroduceViewPresentor = class("SeasonTaskIntroduceViewPresentor", ViewPresentor)

function SeasonTaskIntroduceViewPresentor:ctor()
	SeasonTaskIntroduceViewPresentor.super.ctor(self)
end

function SeasonTaskIntroduceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonTaskIntroduceViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontaskintroduceview.prefab"
	}
end

function SeasonTaskIntroduceViewPresentor:buildViews()
	return {
		SeasonTaskIntroduceView.New()
	}
end

return SeasonTaskIntroduceViewPresentor

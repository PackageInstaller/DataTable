-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasoncampenterViewPresentor.lua

module("logic.extensions.season.view.SeasoncampenterViewPresentor", package.seeall)

local SeasoncampenterViewPresentor = class("SeasoncampenterViewPresentor", ViewWithGuidePresentor)

function SeasoncampenterViewPresentor:ctor()
	SeasoncampenterViewPresentor.super.ctor(self)
end

function SeasoncampenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasoncampenterViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasoncampenterview.prefab"
	}
end

function SeasoncampenterViewPresentor:buildViews()
	return {
		SeasonCampEnterView.New()
	}
end

return SeasoncampenterViewPresentor

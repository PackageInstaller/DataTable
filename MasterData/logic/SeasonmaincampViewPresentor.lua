-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonmaincampViewPresentor.lua

module("logic.extensions.season.view.SeasonmaincampViewPresentor", package.seeall)

local SeasonmaincampViewPresentor = class("SeasonmaincampViewPresentor", ViewWithGuidePresentor)

function SeasonmaincampViewPresentor:ctor()
	SeasonmaincampViewPresentor.super.ctor(self)
end

function SeasonmaincampViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonmaincampViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmaincampview.prefab"
	}
end

function SeasonmaincampViewPresentor:buildViews()
	return {
		SeasonMainCampView.New()
	}
end

return SeasonmaincampViewPresentor

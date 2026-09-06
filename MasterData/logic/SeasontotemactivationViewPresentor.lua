-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasontotemactivationViewPresentor.lua

module("logic.extensions.season.view.SeasontotemactivationViewPresentor", package.seeall)

local SeasontotemactivationViewPresentor = class("SeasontotemactivationViewPresentor", ViewPresentor)

function SeasontotemactivationViewPresentor:ctor()
	SeasontotemactivationViewPresentor.super.ctor(self)
end

function SeasontotemactivationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasontotemactivationViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontotemactivationview.prefab"
	}
end

function SeasontotemactivationViewPresentor:buildViews()
	return {
		SeasonTotemActivationView.New()
	}
end

return SeasontotemactivationViewPresentor

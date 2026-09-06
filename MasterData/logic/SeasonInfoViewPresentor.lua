-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonInfoViewPresentor.lua

module("logic.extensions.season.view.SeasonInfoViewPresentor", package.seeall)

local SeasonInfoViewPresentor = class("SeasonInfoViewPresentor", ViewPresentor)

function SeasonInfoViewPresentor:ctor()
	SeasonInfoViewPresentor.super.ctor(self)
end

function SeasonInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasoninfoview.prefab"
	}
end

function SeasonInfoViewPresentor:buildViews()
	return {
		SeasonInfoView.New()
	}
end

return SeasonInfoViewPresentor

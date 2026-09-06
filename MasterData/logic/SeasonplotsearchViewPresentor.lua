-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonplotsearchViewPresentor.lua

module("logic.extensions.season.view.SeasonplotsearchViewPresentor", package.seeall)

local SeasonplotsearchViewPresentor = class("SeasonplotsearchViewPresentor", ViewPresentor)

function SeasonplotsearchViewPresentor:ctor()
	SeasonplotsearchViewPresentor.super.ctor(self)
end

function SeasonplotsearchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonplotsearchViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonplotsearchview.prefab"
	}
end

function SeasonplotsearchViewPresentor:buildViews()
	return {
		SeasonPlotSearchView.New()
	}
end

return SeasonplotsearchViewPresentor

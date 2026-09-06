-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonTotalRankTabChildViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonTotalRankTabChildViewPresentor", package.seeall)

local GodStatuesWarSeasonTotalRankTabChildViewPresentor = class("GodStatuesWarSeasonTotalRankTabChildViewPresentor", ViewPresentor)

function GodStatuesWarSeasonTotalRankTabChildViewPresentor:ctor()
	GodStatuesWarSeasonTotalRankTabChildViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonTotalRankTabChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarSeasonTotalRankTabChildViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasontotalranktabchildview.prefab"
	}
end

function GodStatuesWarSeasonTotalRankTabChildViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonTotalRankTabChildView.New()
	}
end

function GodStatuesWarSeasonTotalRankTabChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarSeasonTotalRankTabChildViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonRankTabFrameViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonRankTabFrameViewPresentor", package.seeall)

local GodStatuesWarSeasonRankTabFrameViewPresentor = class("GodStatuesWarSeasonRankTabFrameViewPresentor", ViewPresentor)

function GodStatuesWarSeasonRankTabFrameViewPresentor:ctor()
	GodStatuesWarSeasonRankTabFrameViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarSeasonRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasonranktabframeview.prefab"
	}
end

function GodStatuesWarSeasonRankTabFrameViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonRankTabFrameView.New()
	}
end

return GodStatuesWarSeasonRankTabFrameViewPresentor

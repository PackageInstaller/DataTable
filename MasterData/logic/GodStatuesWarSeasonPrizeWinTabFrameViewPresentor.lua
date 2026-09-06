-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFrameViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFrameViewPresentor", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFrameViewPresentor = class("GodStatuesWarSeasonPrizeWinTabFrameViewPresentor", ViewPresentor)

function GodStatuesWarSeasonPrizeWinTabFrameViewPresentor:ctor()
	GodStatuesWarSeasonPrizeWinTabFrameViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonPrizeWinTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarSeasonPrizeWinTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasonprizewintabframeview.prefab"
	}
end

function GodStatuesWarSeasonPrizeWinTabFrameViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonPrizeWinTabFrameView.New()
	}
end

return GodStatuesWarSeasonPrizeWinTabFrameViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabFrameRankViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabFrameRankViewPresentor", package.seeall)

local GodStatuesWarTabFrameRankViewPresentor = class("GodStatuesWarTabFrameRankViewPresentor", ViewPresentor)

function GodStatuesWarTabFrameRankViewPresentor:ctor()
	GodStatuesWarTabFrameRankViewPresentor.super.ctor(self)
end

function GodStatuesWarTabFrameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarTabFrameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartabframerankview.prefab"
	}
end

function GodStatuesWarTabFrameRankViewPresentor:buildViews()
	return {
		GodStatuesWarTabFrameRankView.New()
	}
end

return GodStatuesWarTabFrameRankViewPresentor

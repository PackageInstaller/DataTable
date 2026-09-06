-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankPrizeViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankPrizeViewPresentor", package.seeall)

local GodStatuesWarTabChildRankPrizeViewPresentor = class("GodStatuesWarTabChildRankPrizeViewPresentor", ViewPresentor)

function GodStatuesWarTabChildRankPrizeViewPresentor:ctor()
	GodStatuesWarTabChildRankPrizeViewPresentor.super.ctor(self)
end

function GodStatuesWarTabChildRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarTabChildRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartabchildrankprizeview.prefab"
	}
end

function GodStatuesWarTabChildRankPrizeViewPresentor:buildViews()
	return {
		GodStatuesWarTabChildRankPrizeView.New()
	}
end

function GodStatuesWarTabChildRankPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarTabChildRankPrizeViewPresentor

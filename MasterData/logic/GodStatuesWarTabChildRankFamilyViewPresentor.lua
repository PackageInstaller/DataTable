-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankFamilyViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankFamilyViewPresentor", package.seeall)

local GodStatuesWarTabChildRankFamilyViewPresentor = class("GodStatuesWarTabChildRankFamilyViewPresentor", ViewPresentor)

function GodStatuesWarTabChildRankFamilyViewPresentor:ctor()
	GodStatuesWarTabChildRankFamilyViewPresentor.super.ctor(self)
end

function GodStatuesWarTabChildRankFamilyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarTabChildRankFamilyViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartabchildrankfamilyview.prefab"
	}
end

function GodStatuesWarTabChildRankFamilyViewPresentor:buildViews()
	return {
		GodStatuesWarTabChildRankFamilyView.New()
	}
end

function GodStatuesWarTabChildRankFamilyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarTabChildRankFamilyViewPresentor

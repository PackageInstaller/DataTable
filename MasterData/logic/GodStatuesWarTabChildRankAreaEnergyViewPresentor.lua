-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankAreaEnergyViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankAreaEnergyViewPresentor", package.seeall)

local GodStatuesWarTabChildRankAreaEnergyViewPresentor = class("GodStatuesWarTabChildRankAreaEnergyViewPresentor", ViewPresentor)

function GodStatuesWarTabChildRankAreaEnergyViewPresentor:ctor()
	GodStatuesWarTabChildRankAreaEnergyViewPresentor.super.ctor(self)
end

function GodStatuesWarTabChildRankAreaEnergyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarTabChildRankAreaEnergyViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartabchildrankareaenergyview.prefab"
	}
end

function GodStatuesWarTabChildRankAreaEnergyViewPresentor:buildViews()
	return {
		GodStatuesWarTabChildRankAreaEnergyView.New()
	}
end

function GodStatuesWarTabChildRankAreaEnergyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarTabChildRankAreaEnergyViewPresentor

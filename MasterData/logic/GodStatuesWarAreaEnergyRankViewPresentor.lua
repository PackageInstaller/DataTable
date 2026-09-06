-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarAreaEnergyRankViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarAreaEnergyRankViewPresentor", package.seeall)

local GodStatuesWarAreaEnergyRankViewPresentor = class("GodStatuesWarAreaEnergyRankViewPresentor", ViewPresentor)

function GodStatuesWarAreaEnergyRankViewPresentor:ctor()
	GodStatuesWarAreaEnergyRankViewPresentor.super.ctor(self)
end

function GodStatuesWarAreaEnergyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarAreaEnergyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarareaenergyrankview.prefab"
	}
end

function GodStatuesWarAreaEnergyRankViewPresentor:buildViews()
	return {
		GodStatuesWarAreaEnergyRankView.New()
	}
end

return GodStatuesWarAreaEnergyRankViewPresentor

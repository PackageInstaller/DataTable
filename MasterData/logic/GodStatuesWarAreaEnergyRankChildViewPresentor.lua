-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarAreaEnergyRankChildViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarAreaEnergyRankChildViewPresentor", package.seeall)

local GodStatuesWarAreaEnergyRankChildViewPresentor = class("GodStatuesWarAreaEnergyRankChildViewPresentor", ViewPresentor)

function GodStatuesWarAreaEnergyRankChildViewPresentor:ctor()
	GodStatuesWarAreaEnergyRankChildViewPresentor.super.ctor(self)
end

function GodStatuesWarAreaEnergyRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarAreaEnergyRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/godstatueswarareaenergyrankchildview.prefab"
	}
end

function GodStatuesWarAreaEnergyRankChildViewPresentor:buildViews()
	return {
		GodStatuesWarAreaEnergyRankChildView.New()
	}
end

function GodStatuesWarAreaEnergyRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarAreaEnergyRankChildViewPresentor

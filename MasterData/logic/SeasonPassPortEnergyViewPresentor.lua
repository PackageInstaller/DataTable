-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortEnergyViewPresentor.lua

module("logic.extensions.season.view.SeasonPassPortEnergyViewPresentor", package.seeall)

local SeasonPassPortEnergyViewPresentor = class("SeasonPassPortEnergyViewPresentor", ViewPresentor)

function SeasonPassPortEnergyViewPresentor:ctor()
	SeasonPassPortEnergyViewPresentor.super.ctor(self)
end

function SeasonPassPortEnergyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonPassPortEnergyViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpassportenergyview.prefab"
	}
end

function SeasonPassPortEnergyViewPresentor:buildViews()
	return {
		SeasonPassPortEnergyView.New()
	}
end

function SeasonPassPortEnergyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonPassPortEnergyViewPresentor

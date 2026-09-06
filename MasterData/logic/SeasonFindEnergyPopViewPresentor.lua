-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindEnergyPopViewPresentor.lua

module("logic.extensions.season.view.SeasonFindEnergyPopViewPresentor", package.seeall)

local SeasonFindEnergyPopViewPresentor = class("SeasonFindEnergyPopViewPresentor", ViewPresentor)

function SeasonFindEnergyPopViewPresentor:ctor()
	SeasonFindEnergyPopViewPresentor.super.ctor(self)
end

function SeasonFindEnergyPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonFindEnergyPopViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonfindenergypopview.prefab"
	}
end

function SeasonFindEnergyPopViewPresentor:buildViews()
	return {
		SeasonFindEnergyPopView.New()
	}
end

return SeasonFindEnergyPopViewPresentor

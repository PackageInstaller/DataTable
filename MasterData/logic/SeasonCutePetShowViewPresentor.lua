-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonCutePetShowViewPresentor.lua

module("logic.extensions.season.view.SeasonCutePetShowViewPresentor", package.seeall)

local SeasonCutePetShowViewPresentor = class("SeasonCutePetShowViewPresentor", ViewPresentor)

function SeasonCutePetShowViewPresentor:ctor()
	SeasonCutePetShowViewPresentor.super.ctor(self)
end

function SeasonCutePetShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonCutePetShowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasoncutepetshowview.prefab"
	}
end

function SeasonCutePetShowViewPresentor:buildViews()
	return {
		SeasonCutePetShowView.New()
	}
end

return SeasonCutePetShowViewPresentor

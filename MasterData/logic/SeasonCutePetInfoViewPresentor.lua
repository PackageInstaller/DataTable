-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonCutePetInfoViewPresentor.lua

module("logic.extensions.season.view.SeasonCutePetInfoViewPresentor", package.seeall)

local SeasonCutePetInfoViewPresentor = class("SeasonCutePetInfoViewPresentor", ViewPresentor)

function SeasonCutePetInfoViewPresentor:ctor()
	SeasonCutePetInfoViewPresentor.super.ctor(self)
end

function SeasonCutePetInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonCutePetInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasoncutepetinfoview.prefab"
	}
end

function SeasonCutePetInfoViewPresentor:buildViews()
	return {
		SeasonCutePetInfoView.New()
	}
end

return SeasonCutePetInfoViewPresentor

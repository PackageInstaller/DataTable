-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalStageViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalStageViewPresentor", package.seeall)

local OriginPowersClgNormalStageViewPresentor = class("OriginPowersClgNormalStageViewPresentor", ViewPresentor)

function OriginPowersClgNormalStageViewPresentor:ctor()
	OriginPowersClgNormalStageViewPresentor.super.ctor(self)
end

function OriginPowersClgNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginPowersClgNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgnormalstageview.prefab"
	}
end

function OriginPowersClgNormalStageViewPresentor:buildViews()
	return {
		OriginPowersClgNormalStageView.New()
	}
end

return OriginPowersClgNormalStageViewPresentor

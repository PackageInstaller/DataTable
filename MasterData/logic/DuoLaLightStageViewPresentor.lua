-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/DuoLaLightStageViewPresentor.lua

module("logic.extensions.duolalight.view.DuoLaLightStageViewPresentor", package.seeall)

local DuoLaLightStageViewPresentor = class("DuoLaLightStageViewPresentor", ViewPresentor)

function DuoLaLightStageViewPresentor:ctor()
	DuoLaLightStageViewPresentor.super.ctor(self)
end

function DuoLaLightStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuoLaLightStageViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/duolalightstageview.prefab"
	}
end

function DuoLaLightStageViewPresentor:buildViews()
	return {
		DuoLaLightStageView.New()
	}
end

return DuoLaLightStageViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameStageViewPresentor.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameStageViewPresentor", package.seeall)

local OriginDuoLaGameStageViewPresentor = class("OriginDuoLaGameStageViewPresentor", ViewPresentor)

function OriginDuoLaGameStageViewPresentor:ctor()
	OriginDuoLaGameStageViewPresentor.super.ctor(self)
end

function OriginDuoLaGameStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDuoLaGameStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originduolagame/originduolagamestageview.prefab"
	}
end

function OriginDuoLaGameStageViewPresentor:buildViews()
	return {
		OriginDuoLaGameStageView.New()
	}
end

return OriginDuoLaGameStageViewPresentor

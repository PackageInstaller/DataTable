-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgStageViewPresentor.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgStageViewPresentor", package.seeall)

local OriginGoldenDragonClgStageViewPresentor = class("OriginGoldenDragonClgStageViewPresentor", ViewPresentor)

function OriginGoldenDragonClgStageViewPresentor:ctor()
	OriginGoldenDragonClgStageViewPresentor.super.ctor(self)
end

function OriginGoldenDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGoldenDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoldendragonclg/origingoldendragonclgstageview.prefab"
	}
end

function OriginGoldenDragonClgStageViewPresentor:buildViews()
	return {
		OriginGoldenDragonClgStageView.New()
	}
end

return OriginGoldenDragonClgStageViewPresentor

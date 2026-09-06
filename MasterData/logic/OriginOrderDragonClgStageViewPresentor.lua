-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgStageViewPresentor.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgStageViewPresentor", package.seeall)

local OriginOrderDragonClgStageViewPresentor = class("OriginOrderDragonClgStageViewPresentor", ViewPresentor)

function OriginOrderDragonClgStageViewPresentor:ctor()
	OriginOrderDragonClgStageViewPresentor.super.ctor(self)
end

function OriginOrderDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginOrderDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originorderdragonclg/originorderdragonclgstageview.prefab"
	}
end

function OriginOrderDragonClgStageViewPresentor:buildViews()
	return {
		OriginOrderDragonClgStageView.New()
	}
end

return OriginOrderDragonClgStageViewPresentor

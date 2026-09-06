-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageViewPresentor", package.seeall)

local OriginKingOrderClgStageViewPresentor = class("OriginKingOrderClgStageViewPresentor", ViewPresentor)

function OriginKingOrderClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingOrderClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgstageview.prefab"
	}
end

function OriginKingOrderClgStageViewPresentor:buildViews()
	return {
		OriginKingOrderClgStageView.New()
	}
end

return OriginKingOrderClgStageViewPresentor

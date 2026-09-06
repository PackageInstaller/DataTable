-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageWaterInfoViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageWaterInfoViewPresentor", package.seeall)

local OriginKingOrderClgStageWaterInfoViewPresentor = class("OriginKingOrderClgStageWaterInfoViewPresentor", ViewPresentor)

function OriginKingOrderClgStageWaterInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingOrderClgStageWaterInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgstagewaterinfoview.prefab"
	}
end

function OriginKingOrderClgStageWaterInfoViewPresentor:buildViews()
	return {
		OriginKingOrderClgStageWaterInfoView.New()
	}
end

return OriginKingOrderClgStageWaterInfoViewPresentor

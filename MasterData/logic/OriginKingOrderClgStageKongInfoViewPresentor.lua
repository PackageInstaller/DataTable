-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageKongInfoViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageKongInfoViewPresentor", package.seeall)

local OriginKingOrderClgStageKongInfoViewPresentor = class("OriginKingOrderClgStageKongInfoViewPresentor", ViewPresentor)

function OriginKingOrderClgStageKongInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingOrderClgStageKongInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgstagekonginfoview.prefab"
	}
end

function OriginKingOrderClgStageKongInfoViewPresentor:buildViews()
	return {
		OriginKingOrderClgStageKongInfoView.New()
	}
end

return OriginKingOrderClgStageKongInfoViewPresentor

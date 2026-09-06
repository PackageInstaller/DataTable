-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgResultSureViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgResultSureViewPresentor", package.seeall)

local OriginKingOrderClgResultSureViewPresentor = class("OriginKingOrderClgResultSureViewPresentor", ViewPresentor)

function OriginKingOrderClgResultSureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingOrderClgResultSureViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgresultsureview.prefab"
	}
end

function OriginKingOrderClgResultSureViewPresentor:buildViews()
	return {
		OriginKingOrderClgResultSureView.New()
	}
end

return OriginKingOrderClgResultSureViewPresentor

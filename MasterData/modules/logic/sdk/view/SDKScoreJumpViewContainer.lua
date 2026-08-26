-- chunkname: @modules/logic/sdk/view/SDKScoreJumpViewContainer.lua

module("modules.logic.sdk.view.SDKScoreJumpViewContainer", package.seeall)

local SDKScoreJumpViewContainer = class("SDKScoreJumpViewContainer", BaseViewContainer)

function SDKScoreJumpViewContainer:buildViews()
	local views = {}

	table.insert(views, SDKScoreJumpView.New())

	return views
end

return SDKScoreJumpViewContainer

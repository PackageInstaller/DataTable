-- chunkname: @modules/logic/sdk/view/SDKExitGameViewContainer.lua

module("modules.logic.sdk.view.SDKExitGameViewContainer", package.seeall)

local SDKExitGameViewContainer = class("SDKExitGameViewContainer", BaseViewContainer)

function SDKExitGameViewContainer:buildViews()
	local views = {}

	table.insert(views, SDKExitGameView.New())

	return views
end

return SDKExitGameViewContainer

-- chunkname: @modules/logic/sdk/view/SDKSandboxPayViewContainer.lua

module("modules.logic.sdk.view.SDKSandboxPayViewContainer", package.seeall)

local SDKSandboxPayViewContainer = class("SDKSandboxPayViewContainer", BaseViewContainer)

function SDKSandboxPayViewContainer:buildViews()
	local views = {}

	table.insert(views, SDKSandboxPayView.New())

	return views
end

return SDKSandboxPayViewContainer

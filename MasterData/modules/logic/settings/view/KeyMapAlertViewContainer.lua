-- chunkname: @modules/logic/settings/view/KeyMapAlertViewContainer.lua

module("modules.logic.settings.view.KeyMapAlertViewContainer", package.seeall)

local KeyMapAlertViewContainer = class("KeyMapAlertViewContainer", BaseViewContainer)

function KeyMapAlertViewContainer:buildViews()
	local views = {}

	table.insert(views, KeyMapAlertView.New())

	return views
end

return KeyMapAlertViewContainer

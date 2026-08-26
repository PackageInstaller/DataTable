-- chunkname: @modules/logic/messagebox/view/MessageOptionBoxViewContainer.lua

module("modules.logic.messagebox.view.MessageOptionBoxViewContainer", package.seeall)

local MessageOptionBoxViewContainer = class("MessageOptionBoxViewContainer", BaseViewContainer)

function MessageOptionBoxViewContainer:buildViews()
	local views = {}

	table.insert(views, MessageOptionBoxView.New())

	return views
end

return MessageOptionBoxViewContainer

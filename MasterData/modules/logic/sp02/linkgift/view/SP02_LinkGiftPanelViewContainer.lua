-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftPanelViewContainer.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftPanelViewContainer", package.seeall)

local SP02_LinkGiftPanelViewContainer = class("SP02_LinkGiftPanelViewContainer", SP02_LinkGiftBaseViewContainer)

function SP02_LinkGiftPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, SP02_LinkGiftPanelView.New())

	return views
end

return SP02_LinkGiftPanelViewContainer

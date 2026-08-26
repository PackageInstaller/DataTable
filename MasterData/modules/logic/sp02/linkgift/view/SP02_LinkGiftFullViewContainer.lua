-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftFullViewContainer.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftFullViewContainer", package.seeall)

local SP02_LinkGiftFullViewContainer = class("SP02_LinkGiftFullViewContainer", SP02_LinkGiftBaseViewContainer)

function SP02_LinkGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, SP02_LinkGiftFullView.New())

	return views
end

return SP02_LinkGiftFullViewContainer

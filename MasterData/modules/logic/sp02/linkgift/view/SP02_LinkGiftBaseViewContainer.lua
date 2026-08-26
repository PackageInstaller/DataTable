-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftBaseViewContainer.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftBaseViewContainer", package.seeall)

local SP02_LinkGiftBaseViewContainer = class("SP02_LinkGiftBaseViewContainer", BaseViewContainer)

function SP02_LinkGiftBaseViewContainer:buildViews()
	local views = {}

	table.insert(views, SP02_LinkGiftBaseView.New())

	return views
end

return SP02_LinkGiftBaseViewContainer

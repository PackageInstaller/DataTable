-- chunkname: @modules/logic/sp01/linkgift/view/V2a9_LinkGiftViewContainer.lua

module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftViewContainer", package.seeall)

local V2a9_LinkGiftViewContainer = class("V2a9_LinkGiftViewContainer", BaseViewContainer)

function V2a9_LinkGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a9_LinkGiftView.New())

	return views
end

function V2a9_LinkGiftViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return V2a9_LinkGiftViewContainer

-- chunkname: @modules/logic/item/view/ItemTalentChooseViewContainer.lua

module("modules.logic.item.view.ItemTalentChooseViewContainer", package.seeall)

local ItemTalentChooseViewContainer = class("ItemTalentChooseViewContainer", BaseViewContainer)

function ItemTalentChooseViewContainer:buildViews()
	local views = {}

	table.insert(views, ItemTalentChooseView.New())

	return views
end

return ItemTalentChooseViewContainer

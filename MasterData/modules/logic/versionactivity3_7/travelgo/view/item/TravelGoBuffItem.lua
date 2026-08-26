-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoBuffItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoBuffItem", package.seeall)

local TravelGoBuffItem = class("TravelGoBuffItem", SimpleListItem)

function TravelGoBuffItem:onInit()
	self.imgIcon = self.viewGO:GetComponent(gohelper.Type_Image)
end

function TravelGoBuffItem:onAddListeners()
	return
end

function TravelGoBuffItem:onItemShow(data)
	self.cfgId = data.cfgId
	self.stacks = data.stacks
end

return TravelGoBuffItem

-- chunkname: @modules/logic/season/view1_3/Season1_3FightCardView.lua

module("modules.logic.season.view1_3.Season1_3FightCardView", package.seeall)

local Season1_3FightCardView = class("Season1_3FightCardView", BaseView)

function Season1_3FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3FightCardView:addEvents()
	return
end

function Season1_3FightCardView:removeEvents()
	return
end

function Season1_3FightCardView:_editableInitView()
	return
end

function Season1_3FightCardView:onOpen()
	local dataList = Activity104Model.instance:getFightCardDataList()

	self.itemList = self.itemList or {}

	for i = 1, math.max(#self.itemList, #dataList) do
		local data = dataList[i]

		if not self.itemList[i] then
			local item = self:createItem(i)

			self:updateItem(self.itemList[i], data)
		end
	end
end

function Season1_3FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season1_3FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season1_3FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season1_3FightCardView:destroyItem(item)
	item:destroy()
end

function Season1_3FightCardView:onClose()
	return
end

function Season1_3FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season1_3FightCardView

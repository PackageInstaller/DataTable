-- chunkname: @modules/logic/season/view1_2/Season1_2FightCardView.lua

module("modules.logic.season.view1_2.Season1_2FightCardView", package.seeall)

local Season1_2FightCardView = class("Season1_2FightCardView", BaseView)

function Season1_2FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2FightCardView:addEvents()
	return
end

function Season1_2FightCardView:removeEvents()
	return
end

function Season1_2FightCardView:_editableInitView()
	return
end

function Season1_2FightCardView:onOpen()
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

function Season1_2FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season1_2FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season1_2FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season1_2FightCardView:destroyItem(item)
	item:destroy()
end

function Season1_2FightCardView:onClose()
	return
end

function Season1_2FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season1_2FightCardView

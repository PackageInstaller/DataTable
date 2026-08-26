-- chunkname: @modules/logic/season/view1_6/Season1_6FightCardView.lua

module("modules.logic.season.view1_6.Season1_6FightCardView", package.seeall)

local Season1_6FightCardView = class("Season1_6FightCardView", BaseView)

function Season1_6FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6FightCardView:addEvents()
	return
end

function Season1_6FightCardView:removeEvents()
	return
end

function Season1_6FightCardView:_editableInitView()
	return
end

function Season1_6FightCardView:onOpen()
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

function Season1_6FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season1_6FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season1_6FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season1_6FightCardView:destroyItem(item)
	item:destroy()
end

function Season1_6FightCardView:onClose()
	return
end

function Season1_6FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season1_6FightCardView

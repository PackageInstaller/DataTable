-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0FightCardView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightCardView", package.seeall)

local Season123_2_0FightCardView = class("Season123_2_0FightCardView", BaseView)

function Season123_2_0FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0FightCardView:addEvents()
	return
end

function Season123_2_0FightCardView:removeEvents()
	return
end

function Season123_2_0FightCardView:_editableInitView()
	return
end

function Season123_2_0FightCardView:onOpen()
	local dataList = Season123Model.instance:getFightCardDataList()

	self.itemList = self.itemList or {}

	for i = 1, math.max(#self.itemList, #dataList) do
		local data = dataList[i]

		if not self.itemList[i] then
			local item = self:createItem(i)

			self:updateItem(self.itemList[i], data)
		end
	end
end

function Season123_2_0FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season123_2_0FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season123_2_0FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season123_2_0FightCardView:destroyItem(item)
	item:destroy()
end

function Season123_2_0FightCardView:onClose()
	return
end

function Season123_2_0FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season123_2_0FightCardView

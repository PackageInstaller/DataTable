-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8FightCardView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightCardView", package.seeall)

local Season123_1_8FightCardView = class("Season123_1_8FightCardView", BaseView)

function Season123_1_8FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8FightCardView:addEvents()
	return
end

function Season123_1_8FightCardView:removeEvents()
	return
end

function Season123_1_8FightCardView:_editableInitView()
	return
end

function Season123_1_8FightCardView:onOpen()
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

function Season123_1_8FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season123_1_8FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season123_1_8FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season123_1_8FightCardView:destroyItem(item)
	item:destroy()
end

function Season123_1_8FightCardView:onClose()
	return
end

function Season123_1_8FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season123_1_8FightCardView

-- chunkname: @modules/logic/seasonver/act123/view/Season123FightCardView.lua

module("modules.logic.seasonver.act123.view.Season123FightCardView", package.seeall)

local Season123FightCardView = class("Season123FightCardView", BaseView)

function Season123FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123FightCardView:addEvents()
	return
end

function Season123FightCardView:removeEvents()
	return
end

function Season123FightCardView:_editableInitView()
	return
end

function Season123FightCardView:onOpen()
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

function Season123FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season123FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season123FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season123FightCardView:destroyItem(item)
	item:destroy()
end

function Season123FightCardView:onClose()
	return
end

function Season123FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season123FightCardView

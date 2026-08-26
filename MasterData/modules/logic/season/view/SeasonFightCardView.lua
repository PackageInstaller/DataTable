-- chunkname: @modules/logic/season/view/SeasonFightCardView.lua

module("modules.logic.season.view.SeasonFightCardView", package.seeall)

local SeasonFightCardView = class("SeasonFightCardView", BaseView)

function SeasonFightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonFightCardView:addEvents()
	return
end

function SeasonFightCardView:removeEvents()
	return
end

function SeasonFightCardView:_editableInitView()
	return
end

function SeasonFightCardView:onOpen()
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

function SeasonFightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = SeasonFightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function SeasonFightCardView:updateItem(item, data)
	item:setData(data)
end

function SeasonFightCardView:destroyItem(item)
	item:destroy()
end

function SeasonFightCardView:onClose()
	return
end

function SeasonFightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return SeasonFightCardView

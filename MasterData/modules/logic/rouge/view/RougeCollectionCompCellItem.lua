-- chunkname: @modules/logic/rouge/view/RougeCollectionCompCellItem.lua

module("modules.logic.rouge.view.RougeCollectionCompCellItem", package.seeall)

local RougeCollectionCompCellItem = class("RougeCollectionCompCellItem", RougeCollectionBaseSlotCellItem)

function RougeCollectionCompCellItem:onInit(viewGO, pos_x, pos_y, cellParams)
	RougeCollectionCompCellItem.super.onInit(self, viewGO, pos_x, pos_y, cellParams)

	self._goeffect = gohelper.findChild(self.viewGO, "#effect")
end

RougeCollectionCompCellItem.PlayEffectDuration = 0.8

function RougeCollectionCompCellItem:onPlaceCollection(insideLines)
	self:updateCellState(RougeEnum.LineState.Green)
	self:hideInsideLines(insideLines)
end

function RougeCollectionCompCellItem:_hideEffect()
	gohelper.setActive(self._goeffect, false)
end

function RougeCollectionCompCellItem:revertCellState(collectionId)
	RougeCollectionCompCellItem.super.revertCellState(self, collectionId)
end

function RougeCollectionCompCellItem:hideInsideLines(insideLines)
	if insideLines then
		for _, direction in pairs(insideLines) do
			local lineImage = self._directionTranMap[direction]

			if lineImage then
				gohelper.setActive(lineImage.gameObject, false)
			end
		end
	end
end

function RougeCollectionCompCellItem:playGetCollectionEffect()
	TaskDispatcher.cancelTask(self._hideEffect, self)
	TaskDispatcher.runDelay(self._hideEffect, self, RougeCollectionCompCellItem.PlayEffectDuration)
	gohelper.setActive(self._goeffect, true)
end

function RougeCollectionCompCellItem:__onDispose()
	TaskDispatcher.cancelTask(self._hideEffect, self)
	RougeCollectionCompCellItem.super.__onDispose(self)
end

return RougeCollectionCompCellItem

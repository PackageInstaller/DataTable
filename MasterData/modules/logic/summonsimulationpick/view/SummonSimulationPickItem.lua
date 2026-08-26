-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickItem.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickItem", package.seeall)

local SummonSimulationPickItem = class("SummonSimulationPickItem", LuaCompBase)

function SummonSimulationPickItem:init(go)
	self._go = go
	self._imageicon = gohelper.findChildImage(go, "heroicon/#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationPickItem:_editableInitView()
	self._heroItems = {}
	self._goheroItem = gohelper.findChild(self._go, "#scroll_result/Viewport/content/#go_heroitem")
	self._root = gohelper.findChild(self._go, "#scroll_result/Viewport/content")

	gohelper.setActive(self._goheroItem, false)
end

function SummonSimulationPickItem:refreshData(heroIds, selectType)
	self.selectType = selectType

	local itemList = self._heroItems
	local haveItemCount = #itemList

	if heroIds then
		if not #heroIds then
			local needCount = 0

			for i = 1, needCount do
				local item

				if haveItemCount < i then
					local instance = self:getItem()

					item = SummonSimulationPickListItem.New()

					item:init(instance)
					table.insert(itemList, item)
				else
					item = itemList[i]
				end

				gohelper.setActive(item.go, true)

				local heroId = heroIds[i]

				item:setData(heroId, self.selectType)
			end

			if needCount < haveItemCount then
				for i = needCount + 1, haveItemCount do
					local item = itemList[i]

					gohelper.setActive(item.go, false)
				end
			end
		end
	end
end

function SummonSimulationPickItem:getItem()
	local prefab = self._goheroItem

	return (gohelper.clone(prefab, self._root))
end

function SummonSimulationPickItem:setActive(active)
	gohelper.setActive(self._go, active)
end

function SummonSimulationPickItem:setParent(parentGo)
	self._go.transform.parent = parentGo.transform

	transformhelper.setLocalPosXY(self._go.transform, 0, 0)
end

function SummonSimulationPickItem:getTransform()
	return self._go.transform
end

function SummonSimulationPickItem:onDestroy()
	for _, item in ipairs(self._heroItems) do
		item:onDestroy()
	end
end

function SummonSimulationPickItem:onDestroyView()
	return
end

return SummonSimulationPickItem

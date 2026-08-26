-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueAttributeItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeItem", package.seeall)

local LiangYueAttributeItem = class("LiangYueAttributeItem", LuaCompBase)

function LiangYueAttributeItem:init(go)
	self.go = go
	self._go_Target1 = gohelper.findChild(go, "#go_Target1")
	self._go_Target2 = gohelper.findChild(go, "#go_Target2")
	self._go_Target3 = gohelper.findChild(go, "#go_Target3")

	self:initComp()
end

function LiangYueAttributeItem:initComp()
	self._descItemList = {}
	self._targetObjList = {
		self._go_Target1,
		self._go_Target2,
		self._go_Target3
	}

	for _, obj in ipairs(self._targetObjList) do
		local item = LiangYueAttributeDescItem.New()

		item:init(obj)
		table.insert(self._descItemList, item)
	end
end

function LiangYueAttributeItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function LiangYueAttributeItem:setInfo(data)
	for index, item in ipairs(self._descItemList) do
		if not data[index] then
			item:setActive(false)
		else
			local attribute = data[index]

			item:setActive(true)
			item:setInfo(attribute[2], attribute[3])
		end
	end
end

function LiangYueAttributeItem:setItemPos(yPos, columnCount)
	self.yPos = yPos
	self.columnCount = columnCount
end

function LiangYueAttributeItem:onDestroy()
	return
end

return LiangYueAttributeItem

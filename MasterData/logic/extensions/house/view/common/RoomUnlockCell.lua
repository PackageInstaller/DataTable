-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomUnlockCell.lua

module("logic.extensions.house.view.common.RoomUnlockCell", package.seeall)

local M = class("RoomUnlockCell")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._arrayOrderItem = {}

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._goOrderItemGroup = goutil.findChild(self._mainGO, "itemGroup")
	self._goOrderItem = goutil.findChild(self._goOrderItemGroup, "item")
	self._txtTitle = goutil.findChildTextComponent(self._mainGO, "title/txtTitle")
	self._txtDescription = goutil.findChildTextComponent(self._mainGO, "txtEffect")

	self:bindEvents()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:getMainGO()
	return self._mainGO
end

function M:setTitle(titleStr)
	self._txtTitle.text = titleStr
end

function M:setDescription(visible, descStr, descColorStr)
	goutil.setActive(self._txtDescription.gameObject, visible)

	if visible then
		self._txtDescription.text = descStr

		if not string.nilorempty(descColorStr) then
			self._txtDescription.color = parsecolor(descColorStr)
		end
	end
end

function M:setOrders(visible, datas)
	goutil.setActive(self._goOrderItemGroup, visible)

	if visible then
		for idx, data in ipairs(datas) do
			local itemGO = goutil.clone(self._goOrderItem, string.format("order_item_%s", idx))

			goutil.addChildToParent(itemGO, self._goOrderItemGroup)

			local orderItem = Astral.LuaComponentContainer.Add(itemGO, RoomOrderIconItem)

			table.insert(self._arrayOrderItem, orderItem)
			orderItem:setVisible(true)
			orderItem:setIcon(data.iconType, data.iconName)
			orderItem:setName(data.nameStr)
			orderItem:setNameColor(data.nameColorStr)
		end
	end
end

return M

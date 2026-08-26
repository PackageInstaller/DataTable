-- chunkname: @modules/logic/rouge/view/RougeItemNodeBase.lua

module("modules.logic.rouge.view.RougeItemNodeBase", package.seeall)

local RougeItemNodeBase = class("RougeItemNodeBase", UserDataDispose)
local table_insert = table.insert

function RougeItemNodeBase:ctor(parent)
	assert(isTypeOf(parent, RougeSimpleItemBase), "[RougeItemNodeBase] ctor failed: parent must inherited from RougeSimpleItemBase type(parent)=" .. (parent.__cname or "nil"))
	self:__onInit()

	self._parent = parent
end

function RougeItemNodeBase:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEventListeners()
end

function RougeItemNodeBase:onDestroy()
	self:onDestroyView()
end

function RougeItemNodeBase:staticData()
	if not self._parent then
		return
	end

	return self._parent._staticData
end

function RougeItemNodeBase:parent()
	return self._parent
end

function RougeItemNodeBase:baseViewContainer()
	local data = self:staticData()

	if not data then
		return
	end

	return data.baseViewContainer
end

function RougeItemNodeBase:dispatchEvent(evtName, ...)
	if not self._parent then
		logWarn("dispatchEvent")

		return
	end

	local c = self:baseViewContainer()

	if not c then
		return
	end

	c:dispatchEvent(evtName, ...)
end

function RougeItemNodeBase:index()
	if not self._parent then
		return
	end

	return self._parent:index()
end

function RougeItemNodeBase:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function RougeItemNodeBase:posX()
	if not self._parent then
		return
	end

	return self._parent:posX()
end

function RougeItemNodeBase:posY()
	if not self._parent then
		return
	end

	return self._parent:posY()
end

function RougeItemNodeBase:_fillUserDataTb(prefixStr, outGoList, outCmpList)
	local i = 1
	local cmp = self[prefixStr .. i]

	while not gohelper.isNil(cmp) do
		if outGoList then
			table_insert(outGoList, cmp.gameObject)
		end

		if outCmpList then
			table_insert(outCmpList, cmp)
		end

		i = i + 1
		cmp = self[prefixStr .. i]
	end
end

function RougeItemNodeBase:_onSetScrollParentGameObject(limitScrollRectCmp)
	if gohelper.isNil(limitScrollRectCmp) then
		return
	end

	local c = self:baseViewContainer()

	if not c then
		return
	end

	local go = c:getScrollViewGo()

	if gohelper.isNil(go) then
		return
	end

	limitScrollRectCmp.parentGameObject = go
end

function RougeItemNodeBase:onUpdateMO(mo)
	self:setData(mo)
end

function RougeItemNodeBase:addEventListeners()
	self:addEvents()
end

function RougeItemNodeBase:removeEventListeners()
	self:removeEvents()
end

function RougeItemNodeBase:onDestroyView()
	self:removeEventListeners()
	self:__onDispose()
end

function RougeItemNodeBase:setData(mo)
	self._mo = mo
end

return RougeItemNodeBase

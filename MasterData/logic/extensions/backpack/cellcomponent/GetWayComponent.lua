-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/GetWayComponent.lua

module("logic.extensions.backpack.cellcomponent.GetWayComponent", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("GetWayComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._btnGetJump = nil
	self._getWayDesc = nil
	self._jumpId = nil
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._getWayDesc = registry:findUIElement("get_way_item_-171799723", UIComponentType.Text)
	self._btnGetJump = ButtonAdapter.Get(registry:findUIElement("get_way_item_-555815783"))

	self._btnGetJump:AddClickListener(self._dealJump, self)
end

function M:_dealJump()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId)
end

function M:updateData(data)
	local jumpInfo = data.jumpInfo

	if jumpInfo then
		self._jumpId = jumpInfo.jumpId
		self._getWayDesc.text = jumpInfo.jumpDesc ~= "" and jumpInfo.jumpDesc or lang("tip_not_get_way")

		goutil.setActive(self._btnGetJump.gameObject, jumpInfo.jumpDesc ~= "")
	else
		self._getWayDesc.text = lang("tip_not_get_way")

		goutil.setActive(self._btnGetJump.gameObject, false)
	end
end

function M:onDestroy()
	return
end

return M

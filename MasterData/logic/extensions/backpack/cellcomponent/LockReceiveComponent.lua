-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LockReceiveComponent.lua

module("logic.extensions.backpack.cellcomponent.LockReceiveComponent", package.seeall)

local M = class("LockReceiveComponent", CellBaseComponent)
local kUnlock = "backpack_item_lock"

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._goLock = registry:findUIElement("backpack_item_428834081")
	self._animation = self._goLock:GetComponent(ComponentType.Animation)
end

function M:setVisible(visible)
	goutil.setActive(self._goLock, visible)
end

function M:updateData(itemData)
	local islock = itemData:getIsReceiveLock()

	goutil.setActive(self._goLock, islock)
end

function M:playUnlockAnim()
	self._animation:Play(kUnlock)
end

function M:onDestroy()
	self._goLock = nil
	self._animation = nil
end

return M

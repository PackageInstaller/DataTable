-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipRecycleDetailInfoComponent.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipRecycleDetailInfoComponent", package.seeall)

local M = class("EquipRecycleDetailInfoComponent", BackpackEquipDetailTips)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._isHideLock = true
end

function M:setHideLock(isHideLock)
	self._isHideLock = true
end

return M

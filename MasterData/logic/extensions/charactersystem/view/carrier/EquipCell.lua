-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EquipCell.lua

module("logic.extensions.charactersystem.view.carrier.EquipCell", package.seeall)

local M = class("EquipCell", ItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterRecomendEquipCell.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterRecomendEquipCell", package.seeall)

local M = class("CharacterRecomendEquipCell", RewardCell)

function M:_initComponents()
	self:_addComponent("cellComp", CharacterRecomendEquipCellComp)
	self:_addComponent("signComp", ItemSignComponent)
end

return M

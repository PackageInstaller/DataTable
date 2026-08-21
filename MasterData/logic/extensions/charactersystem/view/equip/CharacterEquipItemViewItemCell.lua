-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipItemViewItemCell.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipItemViewItemCell", package.seeall)

local M = class("CharacterEquipItemViewItemCell", ItemCell)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("level", LevelComponent)
	self:_addComponent("holeCount", HoleCountComponent)
end

return M

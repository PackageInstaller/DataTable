-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeEquipInfoTeamItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeEquipInfoTeamItem", package.seeall)

local TowerComposeEquipInfoTeamItem = class("TowerComposeEquipInfoTeamItem", EquipInfoTeamItem)

function TowerComposeEquipInfoTeamItem:onClickEquip()
	TowerComposeEquipInfoTeamItem.super.onClickEquip(self)
end

return TowerComposeEquipInfoTeamItem

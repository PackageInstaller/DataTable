-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipTowerMoreAwardDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResEquipTower = require("ClientData/ResEquipTower")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "EquipTowerMoreAwardDlg"
local EquipTowerMoreAwardDlg = Class(strClassName, UIControls.Window)

function EquipTowerMoreAwardDlg:ctor()
	self.awardGrids = {}
end

function EquipTowerMoreAwardDlg:setData(randId)
	ClientUtils.CreateBonusGrid(self, self.awardGrids, "Bg/AwardList/Content", randId)
end

function EquipTowerMoreAwardDlg:checkCustomEquip(suitId, effectId, heroId)
	for i, grid in ipairs(self.awardGrids) do
		if grid:getVisible() and grid.object.itemType == Const.ITEM_TYPE_EQUIP_TEMPLETE and grid.object.isHeroDefine == 1 then
			grid.object:setDefineEffectId(effectId)
			grid.object:setSuitIds({
				suitId
			})
			grid:setObj(grid.object)
		end

		if grid.object.resData.subtype == Const.ITEM_STYPE_BUILD_STONE then
			grid.grid:showBgHero(heroId)
		end
	end
end

return EquipTowerMoreAwardDlg

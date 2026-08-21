-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleHeroCheckDlg.lua

local SneakBattleHeroCheckDlg = Class("SneakBattleHeroCheckDlg", UIControls.Window)
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local HeroGridSneakBattleCard = require("UI/SneakBattle/HeroGridSneakBattleCard")

function SneakBattleHeroCheckDlg:ctor(...)
	self:initUI()
end

function SneakBattleHeroCheckDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/ListSelectPanel")
	self.listHeros = CommonHeroListPanel(self, "MainInfoPanel")
	self.listHeros._slot4CellSelect = Slot(self.onHeroCellClick, self)

	local actData = CurAvatar:getSneakBattleActivityData()

	if actData then
		self.allHeros = actData:getCircleBattleHeroList()
		self.actData = actData
	end

	self.listHeros.isDragTip = false

	self.listHeros:initHeroList(HeroGridSneakBattleCard, "System/Hero/GridHeroCardSneakBattle", UIConst.HERO_SNEAK_BATTLE_SORT_MAP, UIConst.HERO_MAZE_FILTER_PANEL_MAP, self.allHeros)
end

function SneakBattleHeroCheckDlg:setData(actData)
	return
end

function SneakBattleHeroCheckDlg:refreshUISneakBattle(...)
	if self.actData then
		self.allHeros = self.actData:getCircleBattleHeroList()

		self.listHeros:updateHeroBag(self.allHeros, {}, UIConst.HERO_SNEAK_BATTLE_SORT_MAP)
		self.listHeros:refreshSort()

		local ui = UIManager.tryGetUI("sneakBattleHeroInfoDlg")

		if ui then
			ui:refreshUISneakBattle(self.listHeros.showHeros)
		end
	end
end

function SneakBattleHeroCheckDlg:onHeroCellClick(sender)
	if self.actData then
		UIManager.getUI("sneakBattleHeroInfoDlg", true):setData(self.actData, self.listHeros.showHeros, sender.mIndex)
	end
end

function SneakBattleHeroCheckDlg:onBtnCloseClick()
	self:setVisible(false)
end

return SneakBattleHeroCheckDlg

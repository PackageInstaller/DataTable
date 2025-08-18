-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\HeroEquipEvolutionDlg.lua

local EquipEvolutionPanel = require("UI/Equip/EquipEvolutionPanel")
local strClassName = "HeroEquipEvolutionDlg"
local HeroEquipEvolutionDlg = Class(strClassName, UIControls.Window)

function HeroEquipEvolutionDlg:ctor()
	self:initUI()
end

function HeroEquipEvolutionDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
end

function HeroEquipEvolutionDlg:onOpen()
	HeroEquipEvolutionDlg.super.onOpen(self)

	if self.equip then
		self.panelEvo:refreshMaterialInfo()
	end
end

function HeroEquipEvolutionDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_EQUIP_EVOLUTION)
end

function HeroEquipEvolutionDlg:setEquip(equip, isFromBattle)
	if isFromBattle then
		self.mWindow.panelFund:setVisible(false)
	end

	self.equip = equip
	self.isFromBattle = isFromBattle

	if not self.panelEvo then
		self.panelEvo = EquipEvolutionPanel(self, "MainInfoPanel", "System/Hero/EquipEvolutionPanel", 0, 0, true)
	end

	self.panelEvo:setEquip(self.equip)
end

function HeroEquipEvolutionDlg:playSuccessEfxAndAni(newEquip)
	self.panelEvo:playSuccessEfxAndAni(newEquip)
end

function HeroEquipEvolutionDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroEquipEvolutionDlg

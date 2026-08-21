-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipBuildInfoPanel.lua

local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local EquipBuildMaterialPanel = require("UI/Equip/EquipBuildMaterialPanel")
local strClassName = "EquipBuildInfoPanel"
local EquipBuildInfoPanel = Class(strClassName, SingleEquipTipsChild)

function EquipBuildInfoPanel:ctor()
	self:initUI()
end

function EquipBuildInfoPanel:initUI()
	self.buildMaterialPanel = EquipBuildMaterialPanel(self, "EquipPowerUp")
	self.panelName = UIControls.Panel(self, "TextName")
	self.panelBg = UIControls.Panel(self, "BgUpgrade")
	self.txtUpgrade = UIControls.Label(self, "BgUpgrade/Text")
	self.panelInfo = UIControls.Panel(self, "InfoList")
end

function EquipBuildInfoPanel:setItem(equip, stone)
	self:updateEquip(equip)
	self.buildMaterialPanel:setData(equip, stone)
end

function EquipBuildInfoPanel:updateEquip(equip)
	if equip then
		if self.gridEquip then
			self.gridEquip:destroy()

			self.gridEquip = nil
		end

		EquipBuildInfoPanel.super.setItem(self, equip)
		self.gridEquip.btnSensor:setObjEnabled(false)
		self.panelName:setVisible(true)

		if equip.enhanceLevel and equip.enhanceLevel > 0 then
			self.txtUpgrade:setText("+" .. equip.enhanceLevel)
			self.panelBg:setVisible(true)
		else
			self.panelBg:setVisible(false)
		end

		self.panelInfo:setVisible(true)
	else
		self.panelName:setVisible(false)
		self.panelBg:setVisible(false)
		self.panelInfo:setVisible(false)

		if self.gridEquip then
			self.gridEquip:destroy()

			self.gridEquip = nil
		end
	end
end

function EquipBuildInfoPanel:onEquipBuild(newEquip)
	self.newEquip = newEquip
	self.refreshSliderTimer = Timer.New(Slot(self.realEquipInfoBuild, self), 2.3, 1)

	self.refreshSliderTimer:Start()
end

function EquipBuildInfoPanel:realEquipInfoBuild()
	if self.refreshSliderTimer then
		self.refreshSliderTimer:Stop()

		self.refreshSliderTimer = nil
	end

	EquipBuildInfoPanel.super.onEquipBuild(self, self.newEquip)
end

return EquipBuildInfoPanel

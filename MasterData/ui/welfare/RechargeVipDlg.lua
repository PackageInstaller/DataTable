-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\RechargeVipDlg.lua

local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local MallDlgBase = require("UI/MainState/Trade/MallDlgBase")
local strClassName = "RechargeVipDlg"
local RechargeVipDlg = Class(strClassName, MallDlgBase)

function RechargeVipDlg:ctor()
	return
end

function RechargeVipDlg:onOpen(...)
	RechargeVipDlg.super.onOpen(self)

	local vioceId = UIMiscConfig.VOCAL_ID_VIP_RECHARGE

	CueManager.playGroupVocal(vioceId)
end

function RechargeVipDlg:initConfig()
	self.startTabId = 31
	self.tabTypeConfig = {
		[4] = true
	}
end

function RechargeVipDlg:refreshPanel(panelType)
	if not panelType then
		for idx, panel in pairs(self.panels) do
			panel:refreshData()
		end

		return
	end

	if self.panels[panelType] then
		self.panels[panelType]:refreshData()
	end
end

function RechargeVipDlg:onClose()
	CueManager.stopVocal()
	RechargeVipDlg.super.onClose(self)
end

return RechargeVipDlg

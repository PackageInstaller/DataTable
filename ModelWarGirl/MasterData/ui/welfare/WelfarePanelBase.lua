-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfarePanelBase.lua

local strClassName = "WelfarePanelBase"
local WelfarePanelBase = Class(strClassName, UIControls.Child)

function WelfarePanelBase:initPanelData(mallTabData, panelConfigData)
	self.mallTabData = mallTabData
	self.panelConfigData = panelConfigData
	self.panelFund = self.mParent.panelFund

	self:initPanel()
end

function WelfarePanelBase:initPanel()
	return
end

function WelfarePanelBase:openPanelData(mallTabData, panelConfigData)
	self.mallTabData = mallTabData
	self.panelConfigData = panelConfigData

	self.panelFund:settingFund(panelConfigData.funds or Const.FUND_DEFAULT_CONFIG)
	self:onOpenPanel()
	self:panelTop()

	if self.panelConfigData.voiceGroupId then
		CueManager.playGroupVocal(self.panelConfigData.voiceGroupId)
	end
end

function WelfarePanelBase:onOpenPanel()
	return
end

function WelfarePanelBase:onClosePanel()
	return
end

function WelfarePanelBase:panelTop()
	return
end

function WelfarePanelBase:onNewDay()
	return
end

return WelfarePanelBase

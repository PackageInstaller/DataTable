-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MallSimplePanel.lua

local UIControls = UIControls
local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local strClassName = "MallSimplePanel"
local MallSimplePanel = Class(strClassName, WelfarePanelBase)

function MallSimplePanel:ctor()
	self:initUI()
end

function MallSimplePanel:initUI(panelFund, shopTabs)
	self.btnGo = UIControls.Button(self, "BtnGo")

	self.btnGo:addEventClick(self.onGoClick)
end

function MallSimplePanel:onGoClick()
	if self.panelConfigData.arg1 then
		JumpGuideManager.jump(self.panelConfigData.arg1)
	end
end

return MallSimplePanel

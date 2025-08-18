-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\BeginnerTempAnimPanel.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "BeginnerTempAnimPanel"
local BeginnerTempAnimPanel = Class(strClassName, UIControls.Window)

function BeginnerTempAnimPanel:ctor()
	self.btnSkip = UIControls.Button(self, "FuncPanel/BtnSkip")

	self.btnSkip:addEventClick(self.onBtnSkip)
end

function BeginnerTempAnimPanel:onOpenOver()
	BeginnerTempAnimPanel.super.onOpenOver(self)
	self:setVisible(false)
end

function BeginnerTempAnimPanel:onBtnSkip()
	self:setVisible(false)
end

return BeginnerTempAnimPanel

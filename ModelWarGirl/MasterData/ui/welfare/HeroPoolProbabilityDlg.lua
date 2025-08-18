-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\HeroPoolProbabilityDlg.lua

local DrawProbabilityPanel = require("UI/DrawCard/DrawProbabilityPanel")
local strClassName = "HeroPoolProbabilityDlg"
local HeroPoolProbabilityDlg = Class(strClassName, UIControls.Window)

function HeroPoolProbabilityDlg:ctor()
	self:initUI()
end

function HeroPoolProbabilityDlg:initUI()
	self.probabilityPanel = DrawProbabilityPanel(self, "ProbabilityPanel")
end

function HeroPoolProbabilityDlg:setData(poolId)
	self.probabilityPanel:setPoolInfo("", poolId)
end

return HeroPoolProbabilityDlg

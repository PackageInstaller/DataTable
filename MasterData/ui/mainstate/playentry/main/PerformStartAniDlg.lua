-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\PerformStartAniDlg.lua

local strClassName = "PerformStartAniDlg"
local PerformStartAniDlg = Class(strClassName, UIControls.Window)

function PerformStartAniDlg:ctor()
	return
end

function PerformStartAniDlg:onModelReady(performManager)
	self.modelReady = true
	self.performManager = performManager

	self:checkNext()
end

function PerformStartAniDlg:checkNext()
	if not self.mOpening and self.modelReady then
		self.performManager.realStartAction()
		self:setVisible(false)
	end
end

function PerformStartAniDlg:onOpenOver()
	PerformStartAniDlg.super.onOpenOver(self)
	self:checkNext()
end

return PerformStartAniDlg

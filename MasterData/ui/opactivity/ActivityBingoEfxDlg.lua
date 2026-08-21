-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBingoEfxDlg.lua

local strClassName = "ActivityBingoEfxDlg"
local ActivityBingoEfxDlg = Class(strClassName, UIControls.Window)

function ActivityBingoEfxDlg:ctor()
	self.efxTimer = Timer.New(Slot(self.onTimerFinish, self), 3)
end

function ActivityBingoEfxDlg:setData(finalId, awardId, gridId)
	self.finalId = finalId
	self.awardId = awardId
	self.gridId = gridId

	if self.efxTimer then
		self.efxTimer:Restart()
	end
end

function ActivityBingoEfxDlg:onTimerFinish()
	local ui = UIManager.getUI("activityBingoAwardShowPanel", true)

	ui:setData(self.finalId, self.awardId, self.gridId)

	if self.efxTimer then
		self.efxTimer:Stop()
	end

	self:setVisible(false)
end

function ActivityBingoEfxDlg:onClose()
	if self.efxTimer then
		self.efxTimer:Stop()
	end

	ActivityBingoEfxDlg.super.onClose(self)
end

return ActivityBingoEfxDlg

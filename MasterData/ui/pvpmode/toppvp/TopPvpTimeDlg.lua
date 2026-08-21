-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpTimeDlg.lua

local strClassName = "TopPvpTimeDlg"
local TopPvpTimeDlg = Class(strClassName, UIControls.Window)

function TopPvpTimeDlg:ctor(...)
	self:initUI()
end

function TopPvpTimeDlg:initUI(...)
	self.txtTime = UIControls.Label(self, "TopPVPTimePanel/TextTime")
end

function TopPvpTimeDlg:onShow(time)
	if time and time > 0 then
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, time, false)
	end
end

function TopPvpTimeDlg:onClose(...)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	TopPvpTimeDlg.super.onClose(self)
end

return TopPvpTimeDlg

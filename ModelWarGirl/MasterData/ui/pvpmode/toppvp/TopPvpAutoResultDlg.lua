-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpAutoResultDlg.lua

local strClassName = "TopPvpAutoResultDlg"
local TopPvpAutoResultDlg = Class(strClassName, UIControls.Window)
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")

function TopPvpAutoResultDlg:ctor()
	self:initUI()
end

function TopPvpAutoResultDlg:initUI()
	self.winPanel = UIControls.Panel(self, "WinPanel")
	self.failPanel = UIControls.Panel(self, "FailPanel")
	self.txtWinTips = UIControls.Label(self, "WinPanel/TextTips")
	self.txtFailTips = UIControls.Label(self, "FailPanel/TextTips")
end

function TopPvpAutoResultDlg:show(isWin)
	if isWin == true then
		self.winPanel:setVisible(true)
		self.failPanel:setVisible(false)
	else
		self.winPanel:setVisible(false)
		self.failPanel:setVisible(true)
	end

	local resData = ResBPPvpShow[13070019]

	if resData then
		local hint = resData.desc

		if hint then
			self.txtFailTips:setText(hint)
		end
	end

	local resData = ResBPPvpShow[13070020]

	if resData then
		local hint = resData.desc

		if hint then
			self.txtWinTips:setText(hint)
		end
	end

	self:playAni("InTopPVPAutoResult", nil, true)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	local function fun()
		local ui = UIManager.tryGetUI("topPvpAutoResultDlg")

		if ui and ui:getVisible() then
			ui:setVisible(false)
		end
	end

	local cd = ResBPPvpMisc[1].bet_show_last_time or 5

	self.timer = Timer.New(fun, cd, 1)

	self.timer:Start()
end

function TopPvpAutoResultDlg:destroy(...)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		TopPvpAutoResultDlg.super.destroy(self)

		return
	end

	GameFsm.getCurState():exitBattle()
	TopPvpAutoResultDlg.super.destroy(self)
end

return TopPvpAutoResultDlg

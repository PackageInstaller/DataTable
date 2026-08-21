-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpCoinDlg.lua

local strClassName = "TopPvpCoinDlg"
local TopPvpCoinDlg = Class(strClassName, UIControls.Window)

function TopPvpCoinDlg:ctor(...)
	self:initUI()
end

function TopPvpCoinDlg:initUI(...)
	self.panelAttr = UIControls.Panel(self, "CoinPanel/EfxCoin")
	self.aninfo = UIControls.UIAni(self, "")
	self.firstHandPanel = UIControls.Panel(self, "CoinPanel/FirstHandPanel")
	self.backHandPanel = UIControls.Panel(self, "CoinPanel/BackHandPanel")

	self.firstHandPanel:setVisible(false)
	self.backHandPanel:setVisible(false)
end

function TopPvpCoinDlg:onOpen()
	TopPvpCoinDlg.super.onOpen(self)
end

function TopPvpCoinDlg:show(isFirst)
	self.aninfo:setVisible(true)
	self:playAni("InTopPVPFirstHand", nil, true)

	if isFirst == true then
		self.firstHandPanel:setVisible(true)
		self.backHandPanel:setVisible(false)
	else
		self.firstHandPanel:setVisible(false)
		self.backHandPanel:setVisible(true)
	end

	local function fun()
		self.panelAttr:setVisible(true)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(fun, 2, 1)

	self.timer:Start()
end

function TopPvpCoinDlg:lastShow(isFirst)
	if isFirst == true then
		self.firstHandPanel:setVisible(true)
		self.backHandPanel:setVisible(false)
	else
		self.firstHandPanel:setVisible(false)
		self.backHandPanel:setVisible(true)
	end
end

function TopPvpCoinDlg:destroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	TopPvpCoinDlg.super.destroy(self)
end

return TopPvpCoinDlg

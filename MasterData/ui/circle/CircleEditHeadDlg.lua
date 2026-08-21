-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleEditHeadDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "CircleEditHeadDlg"
local CircleEditHeadDlg = Class(strClassName, UIControls.Window)

function CircleEditHeadDlg:ctor()
	self:initUI()
end

function CircleEditHeadDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	self.txtTips:setText(string.format(Lang.get(30178), ResClanMisc[1].rehead_cd))

	self.badageInfoList = {}

	for i = 1, 3 do
		local btnBadage = UIControls.Button(self, "Bg/BadgePanel/BtnBadge" .. i)

		btnBadage:addEventClick(self.onBtnBadageClick)

		self.badageInfoList[i] = btnBadage
	end

	self:onBtnBadageClick(self.badageInfoList[CurAvatar.myCircle.headId])
end

function CircleEditHeadDlg:onBtnConfirmClick()
	if self.selectBadageIdx == CurAvatar.myCircle.headId then
		MsgManager.clientNotice(234)

		return
	end

	if ClientUtils.getServerTime() < CurAvatar.myCircle.reheadTick + ResClanMisc[1].rehead_cd * 60 * 60 + 3 then
		MsgManager.clientNotice(222)

		return
	end

	RPC.clanRehead(self.selectBadageIdx)
end

function CircleEditHeadDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CircleEditHeadDlg:onBtnBadageClick(sender)
	for idx, badageInfo in ipairs(self.badageInfoList) do
		badageInfo:setEnable(sender ~= badageInfo)

		if sender == badageInfo then
			self.selectBadageIdx = idx
		end
	end
end

return CircleEditHeadDlg

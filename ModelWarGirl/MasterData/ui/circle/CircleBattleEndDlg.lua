-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleEndDlg.lua

local ResClientConfirm = require("ClientData/ResClientConfirm")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleEndDlg"
local CircleBattleEndDlg = Class(strClassName, UIControls.Window)

function CircleBattleEndDlg:ctor(...)
	self:initUI()
end

function CircleBattleEndDlg:initUI(...)
	self.btnCancel = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtDes = UIControls.Label(self, "BgPanel/TextDes")
end

function CircleBattleEndDlg:onOpen(...)
	CircleBattleEndDlg.super.onOpen(self)

	local info = ResClientConfirm[1050]

	if info then
		self.txtDes:setText(info.content or "")
	end
end

function CircleBattleEndDlg:onBtnConfirmClick(...)
	local index = CircleControlCenter.getEndGridServerCheckIndex()

	CurAvatar:tryCallCircleBattleRpc("clanBattleNextLayer", index)
	self:setVisible(false)
end

function CircleBattleEndDlg:onBtnCancelClick(...)
	self:setVisible(false)
end

return CircleBattleEndDlg

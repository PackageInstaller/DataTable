-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChooseRedPacketDlg.lua

local ResRedPacketThankContent = require("ClientData/ResRedPacketThankContent")
local ResItemClientConfig = require("ClientData/ResItemClientConfig")
local ResItem = require("ClientData/ResItem")
local strClassName = "ChooseRedPacketDlg"
local ChooseRedPacketDlg = Class(strClassName, UIControls.Window)
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local SUPER_ID = 510229
local NORMAL_ID = 510228
local SHOW_TYPE = {
	FIREWORK = 2,
	RED_PACKET = 1
}

function ChooseRedPacketDlg:ctor(...)
	self:initUI()
end

function ChooseRedPacketDlg:initUI(...)
	self.btnTips = UIControls.Button(self, "Bg/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnSuperRedPacket = UIControls.Button(self, "Bg/RedMoneyPanel/BtnRedMoney2", "Text")

	self.btnSuperRedPacket:addEventClick(self.onBtnSuperRedPacketClick)

	self.btnNormalRedPacket = UIControls.Button(self, "Bg/RedMoneyPanel/BtnRedMoney1", "Text")

	self.btnNormalRedPacket:addEventClick(self.onBtnNormalRedPacketClick)

	self.txtSuperNum = UIControls.Label(self, "Bg/RedMoneyPanel/BtnRedMoney2/TextNum")
	self.txtNormalNum = UIControls.Label(self, "Bg/RedMoneyPanel/BtnRedMoney1/TextNum")
end

function ChooseRedPacketDlg:onOpen(...)
	ChooseRedPacketDlg.super.onOpen(self)
end

function ChooseRedPacketDlg:show(type)
	self.type = type or SHOW_TYPE.RED_PACKET
	self.superId = ResRedPacketShow[self.type].super_item_id or SUPER_ID
	self.normalId = ResRedPacketShow[self.type].normal_item_id or NORMAL_ID
	self.superNum = CurAvatar:getItemNumById(self.superId)
	self.normalNum = CurAvatar:getItemNumById(self.normalId)

	local normalRedItem = ResItem[self.normalId]

	if normalRedItem then
		self.btnNormalRedPacket:setText(normalRedItem.name)
	end

	local superRedItem = ResItem[self.superId]

	if superRedItem then
		self.btnSuperRedPacket:setText(superRedItem.name)
	end

	self.txtSuperNum:setText(self.superNum)
	self.txtNormalNum:setText(self.normalNum)
end

function ChooseRedPacketDlg.randBlessing(item, default)
	local itConfig = ResItemClientConfig[item.id]
	local id = itConfig.red_pack_appr

	if default then
		return 1, ResRedPacketThankContent[id][1].content
	else
		local index = math.random(#ResRedPacketThankContent[id])

		return index, ResRedPacketThankContent[id][index].content
	end
end

function ChooseRedPacketDlg:onBtnNormalRedPacketClick(...)
	if self.normalNum <= 0 then
		MsgManager.notice(Lang.get(30169))

		return
	end

	local item = BaseObject.GetObject(self.normalId, self.normalNum)
	local ui = UIManager.getUI("openItemConfirmDlg", true)

	ui:onShow(item, Slot(self.close, self))
	ui:showBlessingPanel(self.randBlessing)
	ui:setNumLimit(Const.MAX_RED_PACKET_USE_NUM, 1)
end

function ChooseRedPacketDlg:onBtnSuperRedPacketClick(...)
	if self.superNum <= 0 then
		MsgManager.notice(Lang.get(30169))

		return
	end

	local item = BaseObject.GetObject(self.superId, self.superNum)
	local ui = UIManager.getUI("openItemConfirmDlg", true)

	ui:onShow(item, Slot(self.close, self))
	ui:showBlessingPanel(self.randBlessing)
	ui:setNumLimit(Const.MAX_RED_PACKET_USE_NUM, 1)
end

function ChooseRedPacketDlg:close(...)
	self:setVisible(false)

	CurAvatar.showHighBonusDlg = true
end

function ChooseRedPacketDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function ChooseRedPacketDlg:onBtnTipsClick(...)
	local type = ResClientHardCode[13].value[1]
	local noticeId = ResRedPacketShow[type] and ResRedPacketShow[type].notice_id or Const.INFO_NOTICE_RED_PACKET

	UIManager.getUI("infoNotice", true):showSystemInfo(noticeId)
end

return ChooseRedPacketDlg

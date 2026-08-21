-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BuyGiftDrawConfirmDlg.lua

local strClassName = "BuyGiftDrawConfirmDlg"
local BuyGiftDrawConfirmDlg = Class(strClassName, UIControls.Window)

function BuyGiftDrawConfirmDlg:ctor()
	self:initUI()
end

function BuyGiftDrawConfirmDlg:initUI()
	self.textContent = UIControls.Label(self, "Bg/ContentPanel/TextContent")
	self.attentionSwitch = UIControls.Toggle(self, "Bg/AttentionSwitch", "Label")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function BuyGiftDrawConfirmDlg:showUI(content)
	self.textContent:setText(content)
	self:showToggle(CurAvatar.giftDrawNoConfirm or false)
end

function BuyGiftDrawConfirmDlg:showToggle(chooseState)
	chooseState = chooseState or false

	self.attentionSwitch:setVisible(true)
	self.attentionSwitch:setOn(chooseState)
end

function BuyGiftDrawConfirmDlg:getToggleState(...)
	return self.attentionSwitch:isOn()
end

function BuyGiftDrawConfirmDlg:onBtnConfirmClick()
	CurAvatar.giftDrawNoConfirm = self:getToggleState()

	self:setVisible(false)
end

return BuyGiftDrawConfirmDlg

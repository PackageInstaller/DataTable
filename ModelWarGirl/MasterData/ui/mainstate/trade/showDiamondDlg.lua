-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\showDiamondDlg.lua

local UIControls = require("UI/UIControls")
local strClassName = "showDiamondDlg"
local showDiamondDlg = Class(strClassName, UIControls.Window)

function showDiamondDlg:ctor()
	self.diamond_buy = UIControls.Label(self, "Bg/DiamondPanel/Diamond1/TextNum")
	self.diamond_free = UIControls.Label(self, "Bg/DiamondPanel/Diamond2/TextNum")
	self.diamond_total = UIControls.Label(self, "Bg/DiamondPanel/Diamond3/TextNum")
	self.btnComfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnComfirm:addEventClick(self.onClose)
end

function showDiamondDlg:onOpen()
	local get_diamond_free = self._getDiamondFree()
	local get_diamond_buy = self._getDiamondBuy()

	self.diamond_free:setText(get_diamond_free)
	self.diamond_buy:setText(get_diamond_buy)
	self.diamond_total:setText(ClientUtils.getMoney(Const.MONEY_ID_DIAMOND))
	showDiamondDlg.super.onOpen(self)
end

function showDiamondDlg:_getDiamondFree()
	return CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND)
end

function showDiamondDlg:_getDiamondBuy()
	return CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)
end

function showDiamondDlg:onClose()
	self:setVisible(false, true)
end

return showDiamondDlg

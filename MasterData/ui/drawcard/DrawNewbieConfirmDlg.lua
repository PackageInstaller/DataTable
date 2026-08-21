-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawNewbieConfirmDlg.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "DrawNewbieConfirmDlg"
local DrawNewbieConfirmDlg = Class(strClassName, UIControls.Window)

function DrawNewbieConfirmDlg:ctor(...)
	self:initUI()
end

function DrawNewbieConfirmDlg:initUI(...)
	self.leftTxt = UIControls.Label(self, "BgPanel/TextNum")
	self.confirmBtn = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.retrieveBtn = UIControls.Button(self, "BgPanel/BtnFind")

	self.retrieveBtn:addEventClick(self._onClickRetrieve)

	self.cancelBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.cancelBtn:addEventClick(self._onClickCancel)
end

function DrawNewbieConfirmDlg:setDrawInfo(leftCount, confirmFunc)
	if leftCount > 0 then
		self.leftTxt:setVisible(true)
		self.leftTxt:setText(leftCount)
	else
		self.leftTxt:setVisible(false)
	end

	self.confirmFunc = confirmFunc
end

function DrawNewbieConfirmDlg:_onClickConfirm(...)
	if DrawCardUtils.checkBag(10) then
		RPC.drawNewbie(1)
		self:setVisible(false)

		if self.confirmFunc then
			self.confirmFunc()
		end
	end
end

function DrawNewbieConfirmDlg:_onClickRetrieve(...)
	if DrawCardUtils.checkBag(10) then
		RPC.drawNewbie(0)
		DrawCardUtils.setNewbieRetrieve()
		self:setVisible(false)

		if self.confirmFunc then
			self.confirmFunc()
		end
	end
end

function DrawNewbieConfirmDlg:_onClickCancel(...)
	self:setVisible(false)
end

return DrawNewbieConfirmDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChoosePanel.lua

local strClassName = "ChoosePanel"
local ChoosePanel = Class(strClassName, UIControls.Panel)
local ResRandClient = require("ClientData/ResRandClient")

function ChoosePanel:ctor()
	self:initUI()
end

function ChoosePanel:initUI()
	self.btnList = {}
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtTimes = UIControls.Label(self, self.mPath .. "/TextTime/Text")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
end

function ChoosePanel:onBtnConfirmClick()
	RPC.itemUse({
		{
			num = 1,
			id = self.itemGift.id
		}
	}, self.curSelectIdx)
end

function ChoosePanel:resetChoose()
	self.txtTimes:setText(self.itemGift.num)
	self:onBtnSelectClick(self.btnList[1])
end

function ChoosePanel:onBtnSelectClick(sender)
	for i, btn in ipairs(self.btnList) do
		self.btnList[i]:setEnable(sender ~= btn)

		if sender == btn then
			self.curSelectIdx = btn.idx
		end
	end
end

return ChoosePanel

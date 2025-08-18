-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\AvgConfirmBox.lua

local strClassName = "AvgConfirmBox"
local AvgConfirmBox = Class(strClassName, UIControls.Window)

function AvgConfirmBox:ctor()
	self:initUI()
end

function AvgConfirmBox:initUI()
	self.titleTxt = UIControls.Label(self, "Bg/ContentPanel/TextTitle")
	self.contentTxt = UIControls.Label(self, "Bg/ContentPanel/TextContent")
	self.yesBtn = UIControls.Button(self, "Bg/BtnConfirm")

	self.yesBtn:addEventClick(self.onBtnYes)

	self.noBtn = UIControls.Button(self, "Bg/BtnDeny")

	self.noBtn:addEventClick(self.onBtnNo)
end

function AvgConfirmBox:setData(data)
	self.titleTxt:setText(data.title or "")
	self.contentTxt:setText(data.content or "")

	self.yesCallback = data.yesCallback
	self.noCallback = data.noCallback
end

function AvgConfirmBox:onBtnYes()
	if self.yesCallback then
		self.yesCallback()
	end

	self:setVisible(false)
end

function AvgConfirmBox:onBtnNo()
	if self.noCallback then
		self:noCallback()
	end

	self:setVisible(false)
end

return AvgConfirmBox

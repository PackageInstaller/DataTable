-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\NumControlPanel.lua

local ResClientNotice = require("ClientData/ResClientNotice")
local UIControls = UIControls
local math = math
local strClassName = "NumControlPanel"
local NumControlPanel = Class(strClassName, UIControls.Panel)

function NumControlPanel:ctor()
	self:initUI()
end

function NumControlPanel:initUI()
	if UIControls.checkControlFunc(self, self.mPath .. "/TextTitleNum") then
		self.textTitle = UIControls.Label(self, self.mPath .. "/TextTitleNum")
	end

	self.btnSub = UIControls.Button(self, self.mPath .. "/BtnNumMin")

	self.btnSub:addEventClick(self.onClickSub)

	self.btnAdd = UIControls.Button(self, self.mPath .. "/BtnNumAdd")

	self.btnAdd:addEventClick(self.onClickAdd)

	self.btnMax = UIControls.Button(self, self.mPath .. "/BtnNumMax")

	self.btnMax:addEventClick(self.onClickMax)

	self.btnInput = UIControls.Button(self, self.mPath .. "/InputNum", "Text")

	self.btnInput:addEventClick(self.onClickInput)

	self.keyboard = UIControls.NumKeyboard(self, self.mPath .. "/KeyboardPanel")

	self.keyboard:setVisible(false)
end

function NumControlPanel:onShow(maxNum, initNum, controlDesc, maxDesc, minNum)
	if self.textTitle then
		self.textTitle:setText(controlDesc or Lang.get(528))
	end

	self.maxNum = maxNum
	self.minNum = minNum or 1

	self:onNumChanged(initNum)

	self.maxDesc = maxDesc

	self.keyboard:setMaxNotice(self.maxDesc or ResClientNotice[147].notice)
end

function NumControlPanel:onNumChanged(num)
	self.nowNum = num

	self.btnInput:setText(num)

	if self.mEventNumChanged then
		self.mEventNumChanged(self.nowNum)
	end
end

function NumControlPanel:onClickSub(sender)
	if self.nowNum - 1 < self.minNum then
		if self.minNum == 1 then
			MsgManager.notice(Lang.get(30496))
		else
			MsgManager.clientNotice(685)
		end

		return
	end

	self.nowNum = self.nowNum - 1

	self:onNumChanged(self.nowNum)
end

function NumControlPanel:onClickAdd(sender)
	if self.nowNum + 1 > self.maxNum then
		local notice = self.maxDesc or ResClientNotice[147].notice

		MsgManager.notice(notice)

		return
	end

	self.nowNum = math.min(self.nowNum + 1, self.maxNum)

	self:onNumChanged(self.nowNum)
end

function NumControlPanel:onClickMax(sender)
	if self.nowNum == self.maxNum then
		local notice = self.maxDesc or ResClientNotice[147].notice

		MsgManager.notice(notice)

		return
	end

	self.nowNum = self.maxNum

	self:onNumChanged(self.nowNum)
end

function NumControlPanel:onClickInput(sender)
	self.keyboard:show(Slot(self.onNumChanged, self), self.nowNum, self.maxNum, 0)
end

function NumControlPanel:setNumLimit(maxNum, initNum)
	if maxNum then
		self.maxNum = math.min(self.maxNum, maxNum)
	end

	if initNum then
		initNum = math.min(initNum, self.maxNum)

		self:onNumChanged(initNum)
	end
end

return NumControlPanel

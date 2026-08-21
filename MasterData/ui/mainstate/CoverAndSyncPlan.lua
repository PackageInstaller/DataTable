-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\CoverAndSyncPlan.lua

local UserData = require("Helper/UserData")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "CoverAndSyncPlan"
local CoverAndSyncPlan = Class(strClassName, UIControls.Window)

function CoverAndSyncPlan:ctor()
	self:initUI()
end

function CoverAndSyncPlan:initUI()
	self.txtContent = UIControls.Label(self, "Bg/ContentPanel/TextContent")
	self.txtSyncText = UIControls.Label(self, "Bg/ContentPanel/OptionSync/Text")

	self.txtSyncText:setText(ResClientNotice[612].notice)

	self.toggleSync = UIControls.Toggle(self, "Bg/ContentPanel/OptionSync")

	self.toggleSync:addEventValueChanged(self.onToggleValueChanged)

	self.checkMark = UIControls.Panel(self, "Bg/ContentPanel/OptionSync/Background/Checkmark")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny", "Text")

	self.btnDeny:addEventClick(self.onBtnDeny)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirm)

	self.btnOtherFunc = UIControls.Button(self, "Bg/BtnOtherFunc", "Text")

	self.btnOtherFunc:addEventClick(self.onBtnOtherFunc)
end

function CoverAndSyncPlan:onToggleValueChanged(sender, isOn)
	local isSync = isOn == true and "1" or "0"

	self.toggleIsOn = isOn

	UserData.saveCommonData("DefaultSync", isSync)
	self.checkMark:setVisible(isOn)
end

function CoverAndSyncPlan:show(planId, confirmId, yesFunc, noFunc, otherFunc, isShowOther, isShowSyncToggle)
	self.planData = CurAvatar.equipPlanDic[planId]
	self.yesFunc = yesFunc
	self.noFunc = noFunc
	self.otherFunc = otherFunc

	self.txtContent:setText(utils.format(ResClientConfirm[confirmId].content, self.planData.name))
	self.btnDeny:setText(ResClientConfirm[confirmId].cancel_text)
	self.btnConfirm:setText(ResClientConfirm[confirmId].confirm_text)

	if isShowOther then
		self.btnOtherFunc:setText(ResClientConfirm[confirmId].other_text or "")
	end

	local isSync = UserData.loadCommonData("DefaultSync")

	if isSync and isSync == "1" then
		self.toggleSync:setOn(true)
		self.checkMark:setVisible(true)

		self.toggleIsOn = true
	else
		self.toggleSync:setOn(false)
		self.checkMark:setVisible(false)

		self.toggleIsOn = false
		isSync = "0"
	end

	self.btnOtherFunc:setVisible(isShowOther)
	self.toggleSync:setVisible(isShowSyncToggle == true)
	UserData.saveCommonData("DefaultSync", isSync)
end

function CoverAndSyncPlan:onBtnDeny()
	if self.noFunc then
		self.noFunc()
	end

	self:setVisible(false)
end

function CoverAndSyncPlan:onBtnConfirm()
	if self.yesFunc then
		self.yesFunc()
	end

	self:setVisible(false)
end

function CoverAndSyncPlan:onBtnOtherFunc()
	if self.otherFunc then
		self.otherFunc()
	end

	self:setVisible(false)
end

return CoverAndSyncPlan

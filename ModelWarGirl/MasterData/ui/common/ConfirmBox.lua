-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\ConfirmBox.lua

local ResClientConfirm = require("ClientData/ResClientConfirm")
local ConfirmPrivilegePanel = require("UI/Common/ConfirmPrivilegePanel")
local ResItem = require("ClientData/ResItem")
local ConfirmCostPanel = Class("ConfirmCostPanel", UIControls.Panel)

function ConfirmCostPanel:ctor()
	self:initUI()
end

function ConfirmCostPanel:initUI()
	self.imgCostItem = UIControls.Image(self, self.mPath .. "/Icon")
	self.textCost = UIControls.Label(self, self.mPath .. "/TextNum")
end

function ConfirmCostPanel:setItem(itemID, needNum)
	local nowNum = ClientUtils.getMoney(itemID)

	self.textCost:setText(ClientUtils.getNumShortStr(needNum) .. "/" .. ClientUtils.getNumShortStr(nowNum))

	local itemIcon = BaseObject.getItemIconPath(itemID)

	if itemIcon then
		self.imgCostItem:setImage(itemIcon[1], itemIcon[2])
	end

	self:setVisible(true)
end

function ConfirmCostPanel:setByfunc(func)
	local iconPath, icon, allNum, needNum = func()

	self.textCost:setText(ClientUtils.getNumShortStr(needNum) .. "/" .. ClientUtils.getNumShortStr(allNum))
	self.imgCostItem:setImage(iconPath, icon)
	self:setVisible(true)
end

local strClassName = "ConfirmBox"
local ConfirmBox = Class(strClassName, UIControls.Window)

ConfirmBox.mShowID = 0

local CONFIRM_MODE_ONE_BTN = 1
local CONFIRM_MODE_TWO_BTN = 2
local CONFIRM_MODE_THREE_BTN = 3

function ConfirmBox:ctor()
	self:initUI()

	self.updateTimer = Timer.New(Slot(self.onTimeHide, self), 1, -1)
	self.updataContentTimer = Timer.New(Slot(self.onContentTimeUpdate, self), 1, -1)
end

function ConfirmBox:initUI()
	self.textContent = UIControls.Label(self, "Bg/ContentPanel/TextContent", true)
	self.textTimeContent = UIControls.Label(self, "Bg/ContentPanel/TextTime")

	self.textTimeContent:setVisible(false)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)

	self.btnOtherFunc = UIControls.Button(self, "Bg/BtnOtherFunc", "Text")

	self.btnOtherFunc:addEventClick(self.onBtnOtherFuncClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny", "Text")

	self.btnDeny:addEventClick(self.onClickBtnDeny)

	self.btnDenyText = self.btnDeny:getText()
	self.btnConfirmText = self.btnConfirm:getText()
	self.attentionSwitch = UIControls.Toggle(self, "Bg/AttentionSwitch", "Label")
	self.panelPrivilege = ConfirmPrivilegePanel(self, "Bg/PrivilegePanel")
	self.costPanels = {}
	self.costPanels[1] = ConfirmCostPanel(self, "Bg/BtnConfirm/CostPanel")
	self.costPanels[2] = ConfirmCostPanel(self, "Bg/BtnDeny/CostPanel")
	self.costPanels[3] = ConfirmCostPanel(self, "Bg/BtnOtherFunc/CostPanel")
end

function ConfirmBox:onTimeHide()
	if self.dur == 0 then
		if self.timeOutFunc then
			self.timeOutFunc()
		end

		self:hide()
	end

	self.btnConfirm:setText(string.format(Lang.get(30208), self.dur))

	self.dur = self.dur - 1
end

function ConfirmBox:checkCostInfo(checkIndex)
	if self.costInfo and self.costInfo[checkIndex] then
		local func = self.costInfo[checkIndex].func

		if func then
			local iconPath, icon, allNum, needNum = func()

			if allNum < needNum then
				return Lang.get(30210)
			end
		else
			local itemID = self.costInfo[checkIndex][1]
			local needNum = self.costInfo[checkIndex][2] or 1
			local itemData = ResItem[itemID] or {}
			local nowNum = ClientUtils.getMoney(itemID)

			if nowNum < needNum then
				return string.format(Lang.get(30209), itemData.name or "")
			end
		end
	end
end

function ConfirmBox:onClickBtnDeny(sender)
	local costFadeback = self:checkCostInfo(2)

	if costFadeback then
		MsgManager.notice(costFadeback .. sender:getText())

		return
	end

	self:hide()

	if self.noFunc ~= nil then
		self.noFunc()
	end
end

Const.CACHED_ATTENTION_RECORD_TABLE = {}

function ConfirmBox:onClickBtnConfirm(sender)
	local costFadeback = self:checkCostInfo(1)

	if costFadeback then
		MsgManager.notice(costFadeback .. sender:getText())

		return
	end

	if self.confirmId and self:getToggleState() then
		Const.CACHED_ATTENTION_RECORD_TABLE[self.confirmId] = true
	end

	self:hide()

	if self.yesFunc ~= nil then
		self.yesFunc()
	end
end

function ConfirmBox:onBtnOtherFuncClick(sender)
	local costFadeback = self:checkCostInfo(3)

	if costFadeback then
		MsgManager.notice(costFadeback .. sender:getText())

		return
	end

	self:hide()

	if self.otherFunc ~= nil then
		self.otherFunc()
	end
end

function ConfirmBox:show(confirmType, ...)
	self.costInfo = nil

	self.textTimeContent:setVisible(false)

	return self:_show(confirmType, ...)
end

function ConfirmBox:showWithCost(costInfo, confirmType, ...)
	self.costInfo = costInfo

	return self:_show(confirmType, ...)
end

function ConfirmBox:showFromId(confirmId, cbYes, cbNo, cbOther, costInfo)
	local confirmData = ResClientConfirm[confirmId]

	if confirmData then
		if confirmData.other_text then
			self:showWithCost(costInfo, UIConst.CONFIRM_THREEBTN, confirmData.title, confirmData.content, {
				cbNo,
				cbYes,
				cbOther
			}, -1, {
				confirmData.confirm_text,
				confirmData.cancel_text,
				confirmData.other_text
			})
		elseif confirmData.cancel_text then
			self:showWithCost(costInfo, UIConst.CONFIRM_TWOBTN, confirmData.title, confirmData.content, cbYes, cbNo, -1, confirmData.confirm_text, confirmData.cancel_text)
		else
			self:showWithCost(costInfo, UIConst.CONFIRM_ONEBTN, confirmData.title, confirmData.content, cbYes, confirmData.confirm_text)
		end

		if confirmData.open_attention == 1 then
			self.confirmId = confirmId

			self:showToggle(nil, confirmData.default_attention == 1)
		end

		if confirmData.default_back_mode then
			self.defaultBackMode = confirmData.default_back_mode
		end
	end
end

function ConfirmBox:setConfirmDefault(default_back_mode)
	self.defaultBackMode = default_back_mode
end

function ConfirmBox:_show(confirmType, ...)
	self.confirmId = nil

	self.attentionSwitch:setVisible(false)
	self.panelPrivilege:setVisible(false)
	self.btnConfirm:setText(self.btnConfirmText)
	self.updateTimer:Stop()

	if confirmType == UIConst.CONFIRM_ONEBTN then
		self.mode = CONFIRM_MODE_ONE_BTN

		self:showOneBtn(...)
	elseif confirmType == UIConst.CONFIRM_TWOBTN then
		self.mode = CONFIRM_MODE_TWO_BTN

		self:showTwoBtn(...)
	elseif confirmType == UIConst.CONFIRM_THREEBTN then
		self.mode = CONFIRM_MODE_THREE_BTN

		self:showThreeBtn(...)
	else
		return
	end

	self:_showCostInfo()

	if not self:getVisible() then
		self:setVisible(true)
	end

	if self.mode == CONFIRM_MODE_ONE_BTN then
		self.defaultBackMode = 1
	elseif self.mode == CONFIRM_MODE_TWO_BTN and not self.noFunc then
		self.defaultBackMode = 2
	else
		self.defaultBackMode = nil
	end

	ConfirmBox.mShowID = ConfirmBox.mShowID + 1

	return ConfirmBox.mShowID
end

function ConfirmBox:hide(confirmID)
	if confirmID ~= nil and confirmID ~= ConfirmBox.mShowID then
		return
	end

	self.updateTimer:Stop()

	if self.updataContentTimer then
		self.yesFuncOnTimerFinish = nil

		self.updataContentTimer:Stop()
	end

	self:setVisible(false)
end

function ConfirmBox:hideAll()
	self:hide()
end

function ConfirmBox:showOneBtn(title, content, confirmFunc, btnName, txtAlign)
	self.textContent:setText(content)

	if txtAlign == nil then
		txtAlign = UIConst.TXTALIGN_UC
	end

	if txtAlign then
		self.textContent:setAlign(txtAlign)
	end

	self.yesFunc = confirmFunc

	self.btnConfirm:setEnable(true)
	self.btnConfirm:setVisible(true)
	self.btnConfirm:setText(btnName or self.btnConfirmText)
	self.btnDeny:setVisible(false)
	self.btnOtherFunc:setVisible(false)
end

function ConfirmBox:showOneBtnDeny(title, content, confirmFunc, txtAlign)
	self.textContent:setText(content)

	if txtAlign == nil then
		txtAlign = UIConst.TXTALIGN_UC
	end

	if txtAlign then
		self.textContent:setAlign(txtAlign)
	end

	self.noFunc = confirmFunc

	self.btnDeny:setEnable(true)
	self.btnDeny:setVisible(true)
	self.btnConfirm:setVisible(false)
	self.btnOtherFunc:setVisible(false)
end

function ConfirmBox:showTwoBtn(title, content, yesFunc, noFunc, dur, yesText, noText, timeOutFunc, txtAlign)
	self.textContent:setText(content)

	if txtAlign == nil then
		txtAlign = UIConst.TXTALIGN_UC
	end

	if txtAlign then
		self.textContent:setAlign(txtAlign)
	end

	self.yesFunc = yesFunc
	self.noFunc = noFunc

	self.btnDeny:setEnable(true)
	self.btnDeny:setVisible(true)
	self.btnOtherFunc:setVisible(false)
	self.btnDeny:setText(noText or Lang.get(7))
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setVisible(true)
	self.btnConfirm:setText(yesText or Lang.get(8))

	self.timeOutFunc = timeOutFunc

	if dur ~= nil and dur > 0 then
		self.dur = dur

		self.updateTimer:Restart()
	end
end

function ConfirmBox:showThreeBtn(title, content, funcs, dur, texts, timeOutFunc, txtAlign)
	self.textContent:setText(content)

	if txtAlign == nil then
		txtAlign = UIConst.TXTALIGN_UC
	end

	if txtAlign then
		self.textContent:setAlign(txtAlign)
	end

	self.yesFunc = funcs[1]
	self.noFunc = funcs[2]
	self.otherFunc = funcs[3]

	local yesText = texts[1]
	local noText = texts[2]
	local otherText = texts[3]

	self.btnDeny:setEnable(true)
	self.btnDeny:setVisible(true)
	self.btnOtherFunc:setVisible(true)
	self.btnOtherFunc:setEnable(true)
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setVisible(true)
	self.btnDeny:setText(noText or Lang.get(7))
	self.btnConfirm:setText(yesText or Lang.get(8))
	self.btnOtherFunc:setText(otherText or Lang.get(30211))

	self.timeOutFunc = timeOutFunc

	if dur ~= nil and dur > 0 then
		self.dur = dur

		self.updateTimer:Restart()
	end
end

function ConfirmBox:showTwoBtnItem(title, content, yesFunc, noFunc, itemID, itemCount, txtAlign)
	self.textContent:setText(content)

	if txtAlign == nil then
		txtAlign = UIConst.TXTALIGN_UC
	end

	if txtAlign then
		self.textContent:setAlign(txtAlign)
	end

	self.yesFunc = yesFunc
	self.noFunc = noFunc

	self.btnDeny:setEnable(true)
	self.btnDeny:setVisible(true)
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setVisible(true)
	self.btnOtherFunc:setVisible(false)

	if itemID then
		if self._gridItem == nil then
			self._gridItem = ItemGrid(self, "Bg/ItemPanel", "System/Common/Grid/GridItem", 0, 0, true)
			self._gridItem.mEnableTips = false
		end

		local item = BaseObject.GetObject(itemID)

		if itemCount then
			item.mCount = itemCount
		end

		self._gridItem:setItem(item)
		self.contentGrid:setVisible(true)
	end
end

function ConfirmBox:_showCostInfo()
	self:_setCostPanel(self.costPanels[1], self.costInfo, 1)

	if self.mode == CONFIRM_MODE_ONE_BTN then
		self.costPanels[2]:setVisible(false)
		self.costPanels[3]:setVisible(false)
	else
		self:_setCostPanel(self.costPanels[2], self.costInfo, 2)

		if self.mode == CONFIRM_MODE_TWO_BTN then
			self.costPanels[3]:setVisible(false)
		else
			self:_setCostPanel(self.costPanels[3], self.costInfo, 3)
		end
	end
end

function ConfirmBox:_setCostPanel(costPanel, costInfo, order)
	if costInfo and costInfo[order] then
		local costData = costInfo[order]

		if costData.func then
			costPanel:setByfunc(costData.func)
		else
			costPanel:setItem(costData[1], costData[2] or 1)
		end
	else
		costPanel:setVisible(false)
	end
end

function ConfirmBox:showToggle(content, chooseState)
	chooseState = chooseState or false

	self.attentionSwitch:setVisible(true)

	if content ~= nil then
		self.attentionSwitch:setText(content)
	end

	self.attentionSwitch:setOn(chooseState)
end

function ConfirmBox:getToggleState(...)
	return self.attentionSwitch:isOn()
end

function ConfirmBox:startContentTimer(preText, nextText, timeLast, cbOnClickSure)
	self.contentTimePre = preText or ""
	self.contentTimeNext = nextText or ""
	self.updateTime = timeLast

	if cbOnClickSure then
		self.yesFuncOnTimerFinish = cbOnClickSure
	end

	if self.updataContentTimer then
		self.textTimeContent:setVisible(true)
		self.updataContentTimer:Restart()
	end

	self:onContentTimeUpdate()
end

function ConfirmBox:setSpcShowForPrivilege(priId, callBack)
	if RegionUtils.isCN() then
		self.panelPrivilege:setVisible(true)
		self.panelPrivilege:setPrivilegeInfo(priId, callBack)
	end
end

function ConfirmBox:onContentTimeUpdate()
	if not self.updateTime then
		self.updataContentTimer:Stop()

		return
	end

	local timeLast = self.updateTime - ClientUtils.getServerTime()

	if timeLast < 0 then
		self.yesFunc = self.yesFuncOnTimerFinish and self.yesFuncOnTimerFinish or self.yesFunc

		self.updataContentTimer:Stop()

		return
	end

	local timeText

	timeText = utils.calcTimeTxt(timeLast)

	local str = string.format(Lang.get(30590), timeText)

	self.textTimeContent:setText(str)
end

function ConfirmBox:tryCloseCanvas()
	if self.defaultBackMode == 1 then
		self:onClickBtnConfirm(self.btnConfirm)

		return true
	elseif self.defaultBackMode == 2 then
		if self.btnDeny:getVisible() then
			self:onClickBtnDeny(self.btnDeny)

			return true
		end
	elseif self.defaultBackMode == 3 and self.btnOtherFunc:getVisible() then
		self:onBtnOtherFuncClick(self.btnOtherFunc)

		return true
	end

	return false
end

function ConfirmBox:onClose()
	if self.updataContentTimer then
		self.yesFuncOnTimerFinish = nil

		self.updataContentTimer:Stop()
	end

	if self.updateTimer then
		self.updateTimer:Stop()
	end

	self.textTimeContent:setVisible(false)
end

return ConfirmBox

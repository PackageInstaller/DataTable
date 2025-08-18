-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\CommonFuncEntryPanel.lua

local ResClientNotice = require("ClientData/ResClientNotice")
local ResPowerMisc = require("ClientData/ResPowerMisc")
local VersionUtils = require("System/VersionUtils")
local UIControls = UIControls
local EventConst = require("EventConst")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local SDKConst = require("SDK/SDKConst")
local ResponseCode = SDKConst.ResponseCode
local HttpUtils = Framework.Network.HttpUtils
local Button = UIControls.Button
local Image = UIControls.Image
local FundPart = Class("FundPart", UIControls.Button)

function FundPart:ctor()
	self.mEventClick = nil
	self.moneyValue = 0
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextNum")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
	self.imgAdd = UIControls.Image(self, self.mPath .. "/BgAdd")
	self.aniAdd = UIControls.UIAni(self, self.mPath .. "/Icon")
	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")
end

function FundPart:setMoneyValue(moneyValue, hasAni)
	local oldValue = self.moneyValue

	if moneyValue == nil then
		self.moneyValue = ClientUtils.getMoney(self.mMoneyID)
	else
		self.moneyValue = moneyValue
	end

	if RegionUtils.isKR() and self.mMoneyID == Const.MONEY_ID_DIAMOND then
		local value = CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)

		if value < 0 then
			self.moneyValue = CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND)
		end
	end

	if self.mMoneyID == Const.MONEY_ID_POWER then
		self.txtNum:setText(self.moneyValue .. "/" .. CurAvatar:getPowerResumeMax())
	else
		self.txtNum:setText(ClientUtils.getNumShortStr(self.moneyValue))
	end

	if hasAni and self.mWindow and self.mWindow:isInShow() and oldValue < moneyValue then
		self.aniAdd:startAni("CurrencyGet")
	end
end

function FundPart:setMoney(moneyID)
	local avatar = CurAvatar

	if moneyID == nil or avatar == nil then
		self.mMoneyID = nil

		self:setVisible(false)

		return
	end

	self.mMoneyID = moneyID

	self:setMoneyValue()

	local moneyInfo = ClientUtils.getMoneyIcon(moneyID)

	if moneyInfo then
		self.imgIcon:setImage(moneyInfo[1], moneyInfo[2])

		if moneyInfo[5] then
			self.redDot:addHint({
				moneyInfo[5]
			})
		else
			self.redDot:clearHint()
		end
	end

	if Const.CAN_JUMP_BUY_MONEY_ID[self.mMoneyID] then
		if Const.MONEY_BUY_JUMP_CONDITION[self.mMoneyID] then
			local isLocked = ConditionLimitManager.inLimitState(Const.MONEY_BUY_JUMP_CONDITION[self.mMoneyID])

			self.imgAdd:setVisible(not isLocked)
		else
			self.imgAdd:setVisible(true)
		end
	else
		self.imgAdd:setVisible(false)
	end

	self:setVisible(true)
end

local strClassName = "CommonFuncEntryPanel"
local CommonFuncEntryPanel = Class(strClassName, UIControls.Child)

function CommonFuncEntryPanel:ctor()
	self:initUI()
	self:settingFund(Const.FUND_DEFAULT_CONFIG)

	self.slot4ItemUpdate = Slot(self.onItemUpdate, self)
	self.slotOfConditionChanged = Slot(self.onRefresh, self)
	self.slotOfMoneyFly = Slot(self._moneyFlyIn, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4ItemUpdate)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
	EventCenter.addEventListener(EventConst.MONEY_FLY, self.slotOfMoneyFly)
end

function CommonFuncEntryPanel:initUI()
	self.btns = {}

	for i = 1, 3 do
		local btn = FundPart(self, "CurrencyPanel/BtnCurrency" .. i)

		btn:addEventClick(self.onFundClick)

		self.btns[i] = btn
	end

	self.btnBag = Button(self, "BtnBag")

	self.btnBag:addEventClick(self.onBtnBagClick)

	self.btnMail = Button(self, "BtnMail")

	self.btnMail:addEventClick(self.onBtnMailClick)
	self:_checkBtnEnable()

	self.btnChat = Button(self, "BtnChat")
	self.redChat = UIControls.RedDot(self, "BtnChat/IconNew")

	self.redChat:addHint({
		UIConst.RD_HINT_CHAT
	})
	self.btnChat:addEventClick(self.onBtnChatClick)

	self.btnFunc = Button(self, "BtnHome")
	self.redHome = UIControls.RedDot(self, "BtnHome/IconNew")

	self.redHome:addHint({
		UIConst.RD_HINT_MAINSETTING
	})

	self.imgFunc = Image(self, "BtnHome/Img")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	if GameFsm.isInState(Const.STATE_BATTLE) then
		self:settingFunc(true)
	end
end

function CommonFuncEntryPanel:onRefresh()
	self:settingFund(self.moneyIDs)
	self:_checkBtnEnable()
end

function CommonFuncEntryPanel:settingFund(moneyIDs)
	if not CurAvatar then
		return
	end

	self.moneyIDs = moneyIDs

	for i, btn in ipairs(self.btns) do
		local moneyID = moneyIDs[i]

		if moneyID then
			btn:setMoney(moneyID)
		else
			btn:setVisible(false)
		end
	end
end

function CommonFuncEntryPanel:settingFunc(isSetup)
	if isSetup then
		self.imgFunc:setImage("Atlas/MainMenuAtlas/MainMenuAtlas", "BtnSetup")
	else
		self.imgFunc:setImage("Atlas/MainMenuAtlas/MainMenuAtlas", "BtnHome")
	end

	self.btnFunc.isSetup = isSetup
end

function CommonFuncEntryPanel:onFundClick(sender)
	if Const.MONEY_BUY_JUMP_CONDITION[sender.mMoneyID] then
		local isLocked = ConditionLimitManager.inLimitState(Const.MONEY_BUY_JUMP_CONDITION[sender.mMoneyID])

		if isLocked then
			local fakeItem = BaseObject.GetObject(sender.mMoneyID)

			UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem)

			return
		end
	end

	if sender.mMoneyID == Const.MONEY_ID_DIAMOND then
		CurAvatar:jumpToRecharge()
	elseif sender.mMoneyID == Const.MONEY_ID_POWER then
		UIManager.getUI("buyCapacityDlg", true):initBuyType()
	else
		local fakeItem = BaseObject.GetObject(sender.mMoneyID)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem)
	end
end

function CommonFuncEntryPanel:onBtnBagClick(sender)
	JumpGuideManager.jump(Const.JUMP_BAG_COMMON)
end

function CommonFuncEntryPanel:onBtnMailClick(sender)
	if self.mailUnlocked then
		CurAvatar:tryOpenMailBox()
	else
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_MAIL))
	end
end

function CommonFuncEntryPanel:onBtnChatClick(sender)
	UIManager.getUI("chatDlg", true)
end

function CommonFuncEntryPanel:onBtnFuncClick(sender)
	if sender.isSetup then
		local mainSettingDlg = UIManager.getUI("mainSettingDlg", true)
	elseif GameFsm.isInState(Const.STATE_MAIN) then
		UIManager.backToMainMenu()
	else
		GameFsm.translateState(Const.STATE_MAIN)
	end
end

function CommonFuncEntryPanel:onItemUpdate(itemId)
	for i, btn in ipairs(self.btns) do
		if btn.mMoneyID == itemId then
			btn:setMoneyValue(CurAvatar:getItemNumById(itemId), true)
		end
	end
end

function CommonFuncEntryPanel:_checkBtnEnable(limitId)
	self.mailUnlocked = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MAIL)

	if self.mailUnlocked and not self.hintMail then
		self.hintMail = UIControls.RedDot(self, "BtnMail/IconNew")

		self.hintMail:addHint({
			UIConst.RD_HINT_MAIL
		})
	elseif not self.mailUnlocked and self.hintMail then
		self.hintMail:delHint(UIConst.RD_HINT_MAIL)

		self.hintMail = nil
	end

	self.bagUnlocked = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BAG)

	if self.bagUnlocked and not self.hintBag then
		self.hintBag = UIControls.RedDot(self, "BtnBag/IconNew")

		self.hintBag:addHint({
			UIConst.RD_HINT_BAG
		})
	elseif not self.bagUnlocked and self.hintBag then
		self.hintBag:delHint(UIConst.RD_HINT_BAG)

		self.hintBag = nil
	end
end

function CommonFuncEntryPanel:onDestroy()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4ItemUpdate)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
	EventCenter.removeEventListener(EventConst.MONEY_FLY, self.slotOfMoneyFly)
	CommonFuncEntryPanel.super.onDestroy(self)
end

function CommonFuncEntryPanel:_moneyFlyIn(dataMode, itemList)
	if not self.mWindow:isInShow() then
		return
	end

	for _, itemInfo in ipairs(itemList) do
		local itemId = itemInfo[1]
		local endObj = self.btnBag

		for i, btn in ipairs(self.btns) do
			if btn.mMoneyID == itemId then
				endObj = btn.imgIcon

				break
			end
		end

		if dataMode == UIConst.FLY_MODE_UI_OBJ then
			local startObj = itemInfo[2]
			local itemNum = itemInfo[3]

			FlyIconUtils.setFlyUItoUI(startObj, endObj, itemId, itemNum)
		elseif dataMode == UIConst.FLY_MODE_3D then
			local worldPos = itemInfo[2]
			local itemNum = itemInfo[3]

			FlyIconUtils.setFly3DtoUI(worldPos, endObj, itemId, itemNum)
		end
	end
end

return CommonFuncEntryPanel

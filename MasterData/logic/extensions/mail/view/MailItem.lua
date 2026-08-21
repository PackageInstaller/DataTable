-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/MailItem.lua

module("logic.extensions.mail.view.MailItem", package.seeall)

local M = class("MailItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._hasReadGo = registry:findUIElement("mail_item_789222831")
	self._unReadGo = registry:findUIElement("mail_item_1631421063")
	self._labTitle = registry:findUIElement("mail_item_-653755870", UIComponentType.TextMeshProUGUI)
	self._labLimitTime = registry:findUIElement("mail_item_1709483899", UIComponentType.Text)
	self._imgLimitTimeBg = registry:findUIElement("mail_item_-1598534435", UIComponentType.Image)
	self._itemGo = registry:findUIElement("rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, MailRewardItem)

	goutil.setActive(self._itemGo, false)

	self._btnClick = ButtonAdapter.Get(registry:findUIElement("mail_item_813289882"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._imgSelectGo = registry:findUIElement("mail_item_1280781728")
	self._secretTypeGo = registry:findUIElement("mail_item_1919351321")
	self._normalBg = registry:findUIElement("mail_item_2120792646")
	self._imgSecretDi = registry:findUIElement("mail_item_-375243207")
	self._moveRoot = goutil.findChild(self._go, "root")
	self._canvasGroup = goutil.findChildComponent(self._go, "root", ComponentType.CanvasGroup)
end

function M:setDefaultState()
	return
end

function M:setTargetState()
	return
end

function M:setCanvasGroupAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

local duration = 0.2

function M:playEnterAnim()
	return
end

function M:StopAni()
	return
end

function M:setCellData(mailData, index)
	if not mailData then
		return
	end

	self._curIndex = index
	self._mailData = mailData

	if mailData:hasAttachment() then
		self._canvasGroup.alpha = mailData:getIsRead() and mailData:hasGetReward() and 0.5 or 1
	else
		self._canvasGroup.alpha = self._mailData:getIsRead() and 0.5 or 1
	end

	self._remainingTime = mailData:getExpiredTime()

	goutil.setActive(self._imgSelectGo, mailData:isSelect())
	goutil.setActive(self._secretTypeGo, mailData:getIsSecret())
	goutil.setActive(self._hasReadGo, mailData:getIsRead())
	goutil.setActive(self._unReadGo, not mailData:getIsRead())

	if mailData:getIsSecret() then
		local isRead = mailData:getIsRead() and mailData:getUnlockState()

		goutil.setActive(self._hasReadGo, isRead)
		goutil.setActive(self._unReadGo, not isRead)

		self._canvasGroup.alpha = isRead and mailData:hasGetReward() and 0.5 or 1
	end

	local content = mailData:getTitle()

	self._labTitle.text = StringUtil.replaceTMPBlackBlock(StringUtil.getShortName(content, 20)) or ""

	if self.view:getIsHistoryType() then
		goutil.setActive(self._labLimitTime.gameObject, false)

		self._canvasGroup.alpha = 1
	else
		goutil.setActive(self._labLimitTime.gameObject, true)

		self._labLimitTime.text = mailData:getExpiredTimeStr()
	end

	local itemMo = mailData:getFirstReward()

	goutil.setActive(self._itemGo, itemMo and true or false)

	if itemMo then
		self._itemCell:setCellData(itemMo, 1)

		local isGetReward = mailData:hasAttachment() and mailData:hasGetReward()

		self._itemCell:setIsGetReward(isGetReward)
	end

	if self._remainingTime then
		settimer(1, self._updateTimer, self, true)
	end
end

function M:_updateTimer()
	if self._remainingTime then
		local orgRemainTime = self._remainingTime

		if self._remainingTime > 0 then
			self._remainingTime = self._remainingTime - 1
		end

		if self._remainingTime <= 0 then
			if not self.view:getIsHistoryType() then
				self._labLimitTime.text = lang("tip_overdue")
			end

			removetimer(self._updateTimer, self)

			if orgRemainTime ~= self._remainingTime then
				self.view:refreshDetailInfo(self._mailData:getId())
			end
		end
	else
		removetimer(self._updateTimer, self)
	end
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:getIndex()
	return self._curIndex
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex, true)
	end
end

function M:OnDisable()
	removetimer(self._updateTimer, self)
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._hasReadGo = nil
	self._unReadGo = nil
	self._labTitle = nil
	self._labLimitTime = nil
	self._itemGo = nil
	self._itemCell = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
	self._imgSelectGo = nil
	self._clickCallBackFunc = nil
	self._clickCallBackHandler = nil
	self._secretTypeGo = nil
end

return M

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubWaringTipMediator.lua

ClubWaringTipMediator = class("ClubWaringTipMediator", DmPopupViewMediator, _M)

ClubWaringTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickBtnOk"
	},
	["main.btn_cancel.button"] = {
		clickAudio = "Se_Click_Cancle",
		func = "onClickBtnCancel"
	}
}

function ClubWaringTipMediator:initialize()
	super.initialize(self)
end

function ClubWaringTipMediator:dispose()
	super.dispose(self)
end

function ClubWaringTipMediator:userInject()
	return
end

function ClubWaringTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "tishi_bg_584.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("UPDATE_UI7"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		bgSize = {
			width = 837.8,
			height = 425
		}
	})

	self:bindWidget("main.btn_ok", OneLevelViceButton, {})
	self:bindWidget("main.btn_cancel", OneLevelMainButton, {})

	self._main = self:getView():getChildByName("main")
	self._btnOk = self._main:getChildByFullName("btn_ok")

	self._btnOk:setVisible(false)

	self._btnCancel = self._main:getChildByFullName("btn_cancel")

	self._btnCancel:setVisible(false)
end

function ClubWaringTipMediator:enterWithData(data)
	self._data = data
	self._sound = data.playSound

	local richTextStr = data.richTextStr
	local descLabel = ccui.RichText:createWithXML(richTextStr, {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0.5, 1))
	descLabel:renderContent()

	local size = descLabel:getContentSize()

	if not data.resizeWidth then
		if size.width > 400 then
			descLabel:ignoreContentAdaptWithSize(false)
			descLabel:setContentSize(cc.size(data.resizeWidth, 0))
		end

		descLabel:setPosition(567, 394)
		descLabel:setLocalZOrder(99)
		self._main:addChild(descLabel, 1)
		self._main:setTouchEnabled(not data.enabled)

		local btnCount = 0
		local btnOkDate = data.btnOkDate

		if btnOkDate then
			btnCount = btnCount + 1

			self._btnOk:setVisible(true)

			if btnOkDate.titleStr then
				self._btnOk:getChildByName("name"):setString(btnOkDate.titleStr)
			end
		end

		local btnCancelDate = data.btnCancelDate

		if btnCancelDate then
			btnCount = btnCount + 1

			self._btnCancel:setVisible(true)

			if btnCancelDate.titleStr then
				self._btnCancel:getChildByName("name"):setString(btnCancelDate.titleStr)
			end
		end

		if btnCount == 1 then
			local posX = 600

			self._btnOk:setPositionX(posX)
			self._btnCancel:setPositionX(posX)
		end
	end
end

function ClubWaringTipMediator:onCloseClicked(sender, eventType)
	local closeCallBack = self._data.closeCallBack

	if closeCallBack then
		closeCallBack()
	end

	self:close()
end

function ClubWaringTipMediator:onClickBtnOk(sender, eventType)
	if self._data.btnOkDate and self._data.btnOkDate.callBack then
		self._data.btnOkDate.callBack()
		self:close()
	elseif self._data.btnOkDate then
		self:close()
	end
end

function ClubWaringTipMediator:onClickBtnCancel(sender, eventType)
	if self._data.btnCancelDate and self._data.btnCancelDate.callBack then
		self._data.btnCancelDate.callBack()
		self:close()
	elseif self._data.btnCancelDate then
		self:close()
	end
end

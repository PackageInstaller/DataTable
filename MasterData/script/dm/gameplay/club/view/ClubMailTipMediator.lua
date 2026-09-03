-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubMailTipMediator.lua

ClubMailTipMediator = class("ClubMailTipMediator", DmPopupViewMediator, _M)

ClubMailTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubMailTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Mail_Number", "content")
local kBtnHandlers = {
	["main.mapbtn"] = {
		clickAudio = "Se_Alert_Error",
		func = "onClickMapBtn"
	},
	["main.linkbtn"] = {
		clickAudio = "Se_Alert_Error",
		func = "onClickLinkBtn"
	},
	["main.chatmmemberbtn"] = {
		clickAudio = "Se_Alert_Error",
		func = "onClickChatMemberBtn"
	},
	["main.expressionbtn"] = {
		clickAudio = "Se_Alert_Error",
		func = "onClickExpressionBtn"
	},
	["main.sendbtn.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickSendBtn"
	}
}

function ClubMailTipMediator:initialize()
	super.initialize(self)
end

function ClubMailTipMediator:dispose()
	super.dispose(self)
end

function ClubMailTipMediator:userInject()
	return
end

function ClubMailTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.sendbtn", OneLevelViceButton, {})
	self:createBgWidget()
end

function ClubMailTipMediator:createBgWidget()
	local injector = self:getInjector()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text46"),
		bgSize = {
			width = 700,
			height = 480
		}
	})
end

function ClubMailTipMediator:enterWithData()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._mainPanel = self:getView():getChildByName("main")
	self._mainPanel.originPos = cc.p(self._mainPanel:getPosition())

	local pos = self._mainPanel:convertToWorldSpace(cc.p(0, 0))

	self._mainPanel.worldPositionY = pos.y
	self._linkPanel = self._mainPanel:getChildByName("linkpanel")

	self._linkPanel:setVisible(false)

	local lastNum = self._clubSystem:getMailLimitCount() - self._clubInfoOj:getSendMailCount()
	local mailLabel = self._mainPanel:getChildByFullName("maillabel")
	local descLabel = ccui.RichText:createWithXML(Strings:get("Club_Text199", {
		fontName = TTF_FONT_FZYH_R,
		num = lastNum
	}), {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0, 0))
	descLabel:renderContent()
	descLabel:addTo(self._mainPanel):posite(274, 198)
	self:createTextFiled()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHPOSITIONCHANGE_SUCC, self, self.closeView)
end

function ClubMailTipMediator:createTextFiled()
	self._inPutStr = ""
	self._editBox = self._mainPanel:getChildByFullName("textfiled")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setPlaceHolder(Strings:get("Club_Text53"))
		self._editBox:setPlaceHolderColor(cc.c4b(80, 50, 20, 153))
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setString("")
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			local state, finalString = StringChecker.checkString(self._editBox:getText(), MaskWordType.CHAT)

			if state == StringCheckResult.AllOfCharForbidden then
				self._inPutStr = ""

				self._editBox:setText("")
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Input_Tip4")
				}))
			end
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._inPutStr = self._editBox:getText()
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)
end

function ClubMailTipMediator:closeView(event)
	self:close()
end

function ClubMailTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ClubMailTipMediator:onClickMapBtn(sender, eventType)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

function ClubMailTipMediator:onClickLinkBtn(sender, eventType)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

function ClubMailTipMediator:onClickChatMemberBtn(sender, eventType)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

function ClubMailTipMediator:onClickExpressionBtn(sender, eventType)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

function ClubMailTipMediator:onClickSendBtn(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if self._inPutStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubMailNotInput_Text")
		}))

		return
	end

	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

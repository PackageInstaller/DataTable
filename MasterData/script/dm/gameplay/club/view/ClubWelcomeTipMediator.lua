-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubWelcomeTipMediator.lua

ClubWelcomeTipMediator = class("ClubWelcomeTipMediator", DmPopupViewMediator, _M)

ClubWelcomeTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubWelcomeTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.okbtn.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickOk"
	},
	["main.cancelbtn.button"] = {
		clickAudio = "Se_Click_Cancle",
		func = "onCloseClicked"
	}
}
local welcomeStrList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_WelcomeMessage", "content")
local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_WelcomeWords", "content")

function ClubWelcomeTipMediator:initialize()
	super.initialize(self)
end

function ClubWelcomeTipMediator:dispose()
	super.dispose(self)
	self._clubSystem:setCurMediatorTag(nil)
end

function ClubWelcomeTipMediator:userInject()
	return
end

function ClubWelcomeTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.cancelbtn", OneLevelMainButton, {})
	self:bindWidget("main.okbtn", OneLevelViceButton, {})

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text45"),
		title1 = Strings:get("UITitle_EN_Huanyingxinren"),
		bgSize = {
			width = 837,
			height = 512
		}
	})
end

function ClubWelcomeTipMediator:enterWithData()
	self._clubSystem:setCurMediatorTag("ClubWelcomeTipMediator")

	self._inPutStr = self._clubSystem:getClubInfoOj():getWelcomeMsg()
	self._selectIndex = self._clubSystem:getClubInfoOj():getWelcomeIndex()
	self._selfEditMsg = self._clubSystem:getClubInfoOj():getSelfEditWelMsg()
	self._boxCheckCache = {}
	self._selfEdit = false

	local mainPanel = self:getView():getChildByFullName("main")

	self._mainPanel = mainPanel
	self._mainPanel.originPos = cc.p(self._mainPanel:getPosition())

	local pos = self._mainPanel:convertToWorldSpace(cc.p(0, 0))

	self._mainPanel.worldPositionY = pos.y

	for i = 1, 3 do
		local checkBox = mainPanel:getChildByFullName("checkbox" .. tostring(i))

		self._boxCheckCache[#self._boxCheckCache + 1] = checkBox

		checkBox:addEventListener(function(sender, eventType)
			self:onCheckBoxClick(sender, eventType, i)
		end)

		local textLabel = mainPanel:getChildByFullName("text_bg_" .. tostring(i) .. ".titlelabel")

		textLabel:setString(Strings:get(welcomeStrList[i]))
		checkBox:setSelected(i == self._selectIndex)

		local touchPanel = mainPanel:getChildByFullName("text_bg_" .. tostring(i))

		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onCheckBoxClick(checkBox, ccui.CheckBoxEventType.selected, i)
		end)
	end

	self._writePanel = mainPanel:getChildByFullName("writepanel")

	local checkBox = self._mainPanel:getChildByFullName("checkbox")

	checkBox:addEventListener(function(sender, eventType)
		self:onCheckBoxClick(sender, eventType, 4)
	end)
	checkBox:setSelected(self._selectIndex == 4)

	self._boxCheckCache[#self._boxCheckCache + 1] = checkBox

	self:createTextFiled()

	if self._selectIndex == 4 then
		self._editBox:setPlaceHolder(self._inPutStr)
	elseif self._selfEditMsg ~= "" then
		self._editBox:setPlaceHolder(self._selfEditMsg)
	end
end

function ClubWelcomeTipMediator:createTextFiled()
	self._editBox = self._mainPanel:getChildByFullName("text_bg_4.textfiled")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setPlaceHolder(Strings:get("Club_Text134"))
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
				self._selfEditMsg = self._clubSystem:getClubInfoOj():getWelcomeMsg()

				self._editBox:setText(self._selfEditMsg)
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Input_Tip3")
				}))
			end
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._selfEditMsg = self._editBox:getText()
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

function ClubWelcomeTipMediator:setAllCheckBoxIsVisible()
	for i = 1, #self._boxCheckCache do
		self._boxCheckCache[i]:setSelected(false)
	end
end

function ClubWelcomeTipMediator:onCloseClicked(sender, eventType)
	if self._selectIndex ~= 4 then
		self._clubSystem:getClubInfoOj():setSelfEditWelMsg(self._selfEditMsg)
	end

	self:close()
end

function ClubWelcomeTipMediator:onClickOk(sender, eventType)
	if self._selectIndex == 4 then
		self._welcomeStr = self._selfEditMsg
		self._selfEdit = true
	else
		self._welcomeStr = Strings:get(welcomeStrList[self._selectIndex])
	end

	if self._welcomeStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text135")
		}))

		return
	end

	self._clubSystem:setWelcomeMsg(self._welcomeStr, self._selectIndex, self._selfEdit, function()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text136")
		}))

		if not self._selfEdit then
			self._clubSystem:getClubInfoOj():setSelfEditWelMsg(self._selfEditMsg)
		end

		self:close()
	end)
end

function ClubWelcomeTipMediator:onCheckBoxClick(sender, eventType, index)
	if self._selectIndex == index then
		sender:setSelected(self._selectIndex == index)

		return
	end

	if eventType == ccui.CheckBoxEventType.selected then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		self:setAllCheckBoxIsVisible()
		sender:setSelected(true)

		self._selectIndex = index
	elseif eventType == ccui.CheckBoxEventType.unselected then
		-- block empty
	end
end

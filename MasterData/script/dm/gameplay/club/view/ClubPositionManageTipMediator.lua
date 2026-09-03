-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubPositionManageTipMediator.lua

ClubPositionManageTipMediator = class("ClubPositionManageTipMediator", DmPopupViewMediator, _M)

ClubPositionManageTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubPositionManageTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.okbtn.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onOKClicked"
	},
	["main.closebtn.button"] = {
		clickAudio = "Se_Click_Cancle",
		func = "onCloseClicked"
	}
}

function ClubPositionManageTipMediator:initialize()
	super.initialize(self)
end

function ClubPositionManageTipMediator:dispose()
	super.dispose(self)
end

function ClubPositionManageTipMediator:userInject()
	return
end

function ClubPositionManageTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.closebtn", OneLevelMainButton, {})
	self:bindWidget("main.okbtn", OneLevelViceButton, {})
	self:createBgWidget()
end

function ClubPositionManageTipMediator:createBgWidget()
	local injector = self:getInjector()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("Club_Text147"),
		title1 = Strings:get("UITitle_EN_Zhiweiguanli"),
		bgSize = {
			width = 837,
			height = 510
		}
	})
end

function ClubPositionManageTipMediator:enterWithData(data)
	self._data = data
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._mainPanel = self:getView():getChildByFullName("main")

	local iconPanel = self._mainPanel:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createPlayerIcon({
		clipType = 1,
		frameStyle = 2,
		id = data:getHeadId(),
		headFrameId = data:getHeadFrame()
	})

	icon:setScale(1.1)
	icon:addTo(iconPanel):center(iconPanel:getContentSize())

	local Text_Lv = self._mainPanel:getChildByFullName("Text_Lv")

	Text_Lv:setString("Lv." .. data:getLevel())

	local nameLabel = self._mainPanel:getChildByFullName("namelabel")

	nameLabel:setString(data:getName())

	local lineGradiantVec2 = {
		{
			ratio = 0.7,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}
	local combatLabel = self._mainPanel:getChildByFullName("combatimg.numlabel")

	combatLabel:setString(data:getCombat())
	combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	local dayContributeLabel = self._mainPanel:getChildByFullName("daycontributelabel2")

	dayContributeLabel:setString(data:getLastWeekCon())

	local contributelabel1 = self._mainPanel:getChildByFullName("contributelabel1")

	contributelabel1:getVirtualRenderer():setLineSpacing(4)

	local daycontributelabel1 = self._mainPanel:getChildByFullName("daycontributelabel1")

	daycontributelabel1:getVirtualRenderer():setLineSpacing(4)

	local contributeLabel = self._mainPanel:getChildByFullName("contributelabel2")

	contributeLabel:setString(data:getContribution())

	local joinDayLabel = self._mainPanel:getChildByFullName("joindaylabel2")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local joinTime = gameServerAgent:remoteTimestamp() - data:getJoinTime()
	local dayNum = math.max(1, TimeUtil:localDate("%d", joinTime))

	joinDayLabel:setString(Strings:get("Club_Text148", {
		day = dayNum
	}))

	local positionLabel = self._mainPanel:getChildByFullName("positionlabel2")

	positionLabel:setString(self._clubSystem:getPositionNameStr(data:getPosition()))
	self:refreshPositionPanel()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHPOSITIONCHANGE_SUCC, self, self.closeView)
end

function ClubPositionManageTipMediator:closeView(event)
	self:close()
end

function ClubPositionManageTipMediator:refreshPositionPanel()
	self._boxCheckCache = {}

	local data = {
		{
			isEnough = true,
			str = Strings:get("Club_Text124")
		},
		{
			str = Strings:get("Club_Text125") .. Strings:get("Club_Text149", {
				num1 = self._clubInfoOj:getDProprieterCount(),
				num2 = self._clubInfoOj:getDProprieterLimitCount()
			}),
			isEnough = self._clubInfoOj:getDProprieterCount() >= self._clubInfoOj:getDProprieterLimitCount()
		},
		{
			str = Strings:get("Club_Text126") .. Strings:get("Club_Text149", {
				num1 = self._clubInfoOj:getEliteCount(),
				num2 = self._clubInfoOj:getEliteLimitCount()
			}),
			isEnough = self._clubInfoOj:getEliteCount() >= self._clubInfoOj:getEliteLimitCount()
		},
		{
			str = Strings:get("Club_Text127") .. Strings:get("Club_Text149", {
				num1 = self._clubInfoOj:getMemberCount(),
				num2 = self._clubInfoOj:getMemberLimitCount()
			}),
			isEnough = self._clubInfoOj:getMemberCount() >= self._clubInfoOj:getMemberLimitCount()
		}
	}
	local curPosition = self._clubInfoOj:getPosition()

	self._selectIndex = self._data:getPosition()

	for i = 1, 4 do
		local checkBox = self._mainPanel:getChildByFullName("ckeckbox" .. tostring(i))

		checkBox:addEventListener(function(sender, eventType)
			self:onCheckBoxClick(sender, eventType, i)
		end)

		self._boxCheckCache[i] = checkBox

		local checkBoxText = self._mainPanel:getChildByFullName("text" .. tostring(i))

		checkBoxText:addTouchEventListener(function(sender, eventType)
			self:onCheckBoxClick(checkBox, ccui.CheckBoxEventType.selected, i)
		end)

		local label = checkBoxText:getChildByName("namelabel")

		label:setString(data[i].str)
		checkBox:setSelected(self._selectIndex == i)
		checkBox:setVisible(true)

		if curPosition == ClubPosition.kDeputyProprieter and i < 3 then
			checkBox:setVisible(false)
		end
	end
end

function ClubPositionManageTipMediator:setAllCheckBoxIsVisible()
	for i = 1, #self._boxCheckCache do
		self._boxCheckCache[i]:setSelected(false)
	end
end

function ClubPositionManageTipMediator:onBackClicked(sender, eventType)
	self:close()
end

function ClubPositionManageTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ClubPositionManageTipMediator:onOKClicked(sender, eventType)
	local curPosition = self._data:getPosition()

	if self._selectIndex ~= curPosition then
		if self._selectIndex == ClubPosition.kProprieter then
			local data = {
				richTextStr = Strings:get("Club_Text191", {
					playerName = self._data:getName(),
					fontName = TTF_FONT_FZYH_R
				}),
				btnOkDate = {
					callBack = function()
						self._clubSystem:changePlayerPos(self._data:getRid(), self._selectIndex, function()
							self:dispatch(ShowTipEvent({
								tip = Strings:get("Club_Text150")
							}))
							self:close()
						end)
					end
				},
				btnCancelDate = {}
			}
			local view = self:getInjector():getInstance("ClubWaringTipView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data))
		else
			local data = {
				richTextStr = Strings:get("Club_Text91", {
					playername = self._data:getName(),
					fontName = TTF_FONT_FZYH_R,
					position1 = self._clubSystem:getPositionNameStr(self._data:getPosition()),
					position2 = self._clubSystem:getPositionNameStr(self._selectIndex)
				}),
				btnOkDate = {
					callBack = function()
						self._clubSystem:changePlayerPos(self._data:getRid(), self._selectIndex, function()
							self:dispatch(ShowTipEvent({
								tip = Strings:get("Club_Text204")
							}))
							self:close()
						end)
					end
				},
				btnCancelDate = {}
			}
			local view = self:getInjector():getInstance("ClubWaringTipView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data))
		end
	else
		self:close()
	end
end

function ClubPositionManageTipMediator:onCheckBoxClick(sender, eventType, index)
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

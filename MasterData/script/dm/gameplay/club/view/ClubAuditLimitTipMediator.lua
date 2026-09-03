-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubAuditLimitTipMediator.lua

ClubAuditLimitTipMediator = class("ClubAuditLimitTipMediator", DmPopupViewMediator, _M)

ClubAuditLimitTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubAuditLimitTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.levelnode.addbtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_2",
		func = "onClickLevelAdd"
	},
	["main.levelnode.minusbtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_2",
		func = "onClickLevelMinus"
	},
	["main.combatnode.addbtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_2",
		func = "onClickCombatAdd"
	},
	["main.combatnode.minusbtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_2",
		func = "onClickCombatMinus"
	},
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickOK"
	}
}
local limitType = {
	ClubAuditType.kFreeOpen,
	ClubAuditType.kLimitCondition,
	ClubAuditType.kClose
}

function ClubAuditLimitTipMediator:initialize()
	super.initialize(self)
end

function ClubAuditLimitTipMediator:dispose()
	super.dispose(self)
end

function ClubAuditLimitTipMediator:userInject()
	return
end

function ClubAuditLimitTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.btn_ok", OneLevelViceButton, {})
end

function ClubAuditLimitTipMediator:createPopBgWidget()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text40"),
		title1 = Strings:get("UITitle_EN_Jiarushezhi"),
		bgSize = {
			width = 837.8,
			height = 510.13
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
end

function ClubAuditLimitTipMediator:enterWithData(data)
	self:createPopBgWidget()

	self._maxLevel = data.level
	self._maxCombat = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Set_MaxBattleValue", "content")

	local auditCondition = self._clubSystem:getClubInfoOj():getAuditCondition()
	local auditType = auditCondition:getType()

	self._selectIndex = auditType + 1
	self._boxCheckCache = {}
	self._levelLimit = auditCondition:getLevel()
	self._combatLimit = auditCondition:getCombat()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._levelTextFiled = self._mainPanel:getChildByFullName("levelnode.textfiled")
	self._combatTextFiled = self._mainPanel:getChildByFullName("combatnode.textfiled")

	self:initTextFiled()

	for i = 1, 3 do
		local checkBox = self._mainPanel:getChildByFullName("checkbox" .. tostring(i))

		checkBox:addEventListener(function(sender, eventType)
			self:onCheckBoxClick(sender, eventType, i)
		end)

		self._boxCheckCache[i] = checkBox

		checkBox:setSelected(self._selectIndex == i)
		checkBox:setVisible(true)

		local textBg = self._mainPanel:getChildByFullName("textBg_" .. tostring(i))

		textBg:setTouchEnabled(true)

		local function callFunc(sender, eventType)
			local selected = self._boxCheckCache[i]:isSelected()

			if selected then
				if not ccui.CheckBoxEventType.unselected then
					local eventType = ccui.CheckBoxEventType.selected

					self:onCheckBoxClick(checkBox, eventType, i)
				end
			end
		end

		mapButtonHandlerClick(nil, textBg, {
			func = callFunc
		})
	end

	self:refreshLimitLabel()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHPOSITIONCHANGE_SUCC, self, self.closeView)
end

function ClubAuditLimitTipMediator:checkString(str)
	local checkList = {
		"+",
		"-",
		"."
	}

	for i = 1, #checkList do
		local charStr = checkList[i]
		local em = string.find(str, charStr)

		if #em > 0 then
			return true
		end
	end

	return false
end

function ClubAuditLimitTipMediator:initTextFiled()
	local levelMaxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Set_MaxLevelNum", "content")
	local combatMaxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Set_MaxBattleNum", "content")
	local levelLabel = self._mainPanel:getChildByFullName("levelnode.levellabel")
	local combatLabel = self._mainPanel:getChildByFullName("combatnode.combatlabel")

	self._levelChange = self._levelLimit

	if self._levelTextFiled:getDescription() == "TextField" then
		self._levelTextFiled:setString("")
		self._levelTextFiled:setMaxLength(levelMaxLength)
		self._levelTextFiled:setMaxLengthEnabled(true)
	end

	self._levelTextFiled:setLocalZOrder(99)
	self._levelTextFiled:setVisible(true)

	self._levelTextFiled = convertTextFieldToEditBox(self._levelTextFiled, nil, MaskWordType.CHAT)

	self._levelTextFiled:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	self._levelTextFiled:onEvent(function(eventName, sender)
		if eventName == "began" then
			levelLabel:setString("")
		elseif eventName == "ended" then
			if type(tonumber(self._levelChange)) ~= "number" or self._levelChange == "" then
				levelLabel:setString(self._levelLimit)
				self._levelTextFiled:setText("")
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Club_Limit_Tips_3")
				}))

				return
			end

			self._levelLimit = math.modf(tonumber(self._levelChange))
			self._levelLimit = math.max(0, self._levelLimit)

			if self._levelLimit > self._maxLevel then
				self._levelLimit = self._maxLevel

				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Club_Limit_Tips_1")
				}))
			end

			self:refreshLimitLabel()
			self._levelTextFiled:setText("")
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._levelChange = self._levelTextFiled:getText()
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

	self._combatChange = self._combatLimit

	if self._combatTextFiled:getDescription() == "TextField" then
		self._combatTextFiled:setString("")
		self._combatTextFiled:setMaxLength(combatMaxLength)
		self._combatTextFiled:setMaxLengthEnabled(true)
	end

	self._combatTextFiled:setLocalZOrder(99)
	self._combatTextFiled:setVisible(true)

	self._combatTextFiled = convertTextFieldToEditBox(self._combatTextFiled, nil, MaskWordType.CHAT)

	self._combatTextFiled:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	self._combatTextFiled:onEvent(function(eventName, sender)
		if eventName == "began" then
			combatLabel:setString("")
		elseif eventName == "ended" then
			if type(tonumber(self._combatChange)) ~= "number" or self._combatChange == "" then
				combatLabel:setString(self._combatLimit)
				self._combatTextFiled:setText("")
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Club_Limit_Tips_3")
				}))

				return
			end

			self._combatLimit = math.modf(tonumber(self._combatChange))
			self._combatLimit = math.max(0, self._combatLimit)

			if self._combatLimit > self._maxCombat then
				self._combatLimit = self._maxCombat

				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Club_Limit_Tips_2")
				}))
			end

			self:refreshLimitLabel()
			self._combatTextFiled:setText("")
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._combatChange = self._combatTextFiled:getText()
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

function ClubAuditLimitTipMediator:closeView(event)
	self:close()
end

function ClubAuditLimitTipMediator:checkLimitEngouh()
	return self._levelLimit > self._maxLevel or self._combatLimit > self._maxCombat
end

function ClubAuditLimitTipMediator:refreshLimitLabel()
	local levelLabel = self._mainPanel:getChildByFullName("levelnode.levellabel")

	levelLabel:setString(self._levelLimit)
	levelLabel:enableOutline(cc.c4b(35, 15, 5, 127.5), 2)

	local combatLabel = self._mainPanel:getChildByFullName("combatnode.combatlabel")

	combatLabel:setString(self._combatLimit)
	combatLabel:enableOutline(cc.c4b(35, 15, 5, 127.5), 2)

	local tipLabel = self._mainPanel:getChildByFullName("titlelabel")

	tipLabel:setVisible(true)
	tipLabel:setString(Strings:get("Club_Text84"))
end

function ClubAuditLimitTipMediator:setAllCheckBoxIsVisible()
	for i = 1, #self._boxCheckCache do
		self._boxCheckCache[i]:setSelected(false)
	end
end

function ClubAuditLimitTipMediator:onCheckBoxClick(sender, eventType, index)
	if self._selectIndex == index then
		sender:setSelected(self._selectIndex == index)

		return
	end

	if eventType == ccui.CheckBoxEventType.selected then
		self:setAllCheckBoxIsVisible()
		sender:setSelected(true)

		self._selectIndex = index
	elseif eventType == ccui.CheckBoxEventType.unselected then
		-- block empty
	end
end

function ClubAuditLimitTipMediator:checkLevelLimit()
	local change = self._levelChange

	if self._levelLimit + change < 0 or self._levelLimit + change > self._maxLevel then
		return false
	else
		self._levelLimit = self._levelLimit + change

		return true
	end
end

function ClubAuditLimitTipMediator:checkCombatLimit()
	local change = self._combatChange

	if self._combatLimit + change < 0 then
		self._combatLimit = 0

		return false
	elseif self._combatLimit + change > self._maxCombat then
		self._combatLimit = self._maxCombat

		return false
	else
		self._combatLimit = self._combatLimit + change

		return true
	end
end

local longSleepTime = 0.02
local waitSleepTime = 0.5

function ClubAuditLimitTipMediator:onClickOK(sender, eventType)
	if self._levelLimit > self._maxLevel then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text163")
		}))

		return
	end

	if self._combatLimit > self._maxCombat then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text164")
		}))

		return
	end

	self._clubSystem:setClubThreshold(limitType[self._selectIndex], self._levelLimit, self._combatLimit, function(resCode)
		if DisposableObject:isDisposed(self) then
			return
		end

		self:close()
	end)
end

function ClubAuditLimitTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ClubAuditLimitTipMediator:onClickLevelAdd(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._levelLimit = self._maxLevel

		self:refreshLimitLabel()
	end
end

function ClubAuditLimitTipMediator:onClickLevelMinus(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._levelLimit = 0

		self:refreshLimitLabel()
	end
end

function ClubAuditLimitTipMediator:onClickCombatAdd(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._combatLimit = self._maxCombat

		self:refreshLimitLabel()
	end
end

function ClubAuditLimitTipMediator:onClickCombatMinus(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._combatLimit = 0

		self:refreshLimitLabel()
	end
end

function ClubAuditLimitTipMediator:touchBegin(sender)
	self:closeSleepScheduler()
	self:createSleepScheduler(waitSleepTime)
end

function ClubAuditLimitTipMediator:touchSleepEnd()
	self:closeSleepScheduler()
	self:createLongAddScheduler(longSleepTime)
end

function ClubAuditLimitTipMediator:longAdd()
	local canAdd = self:_changeFunc()

	self:refreshLimitLabel()

	if not canAdd then
		return
	else
		self:createLongAddScheduler(longSleepTime)
	end
end

function ClubAuditLimitTipMediator:createSleepScheduler(time)
	self:closeLongAddScheduler()

	if self._longSleepScheduler == nil then
		self._longSleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd()
		end, time, false)
	end
end

function ClubAuditLimitTipMediator:closeSleepScheduler()
	if self._longSleepScheduler then
		LuaScheduler:getInstance():unschedule(self._longSleepScheduler)

		self._longSleepScheduler = nil
	end
end

function ClubAuditLimitTipMediator:createLongAddScheduler(time)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd()
		end, time, false)
	end
end

function ClubAuditLimitTipMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

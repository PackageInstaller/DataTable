-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityExchangeTipMediator.lua

ActivityExchangeTipMediator = class("ActivityExchangeTipMediator", DmPopupViewMediator, _M)

ActivityExchangeTipMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["mainpanel.minusbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainpanel.addbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainpanel.minbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onMinClicked"
	},
	["mainpanel.maxbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onMaxClicked"
	}
}

function ActivityExchangeTipMediator:initialize()
	super.initialize(self)
end

function ActivityExchangeTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ActivityExchangeTipMediator:onRemove()
	super.onRemove(self)
end

function ActivityExchangeTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._btnWidget = self:bindWidget("mainpanel.changeone", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickExchange, self)
		}
	})

	bindWidget(self, "mainpanel.tipnode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("VT_Exchange_Title_ChoiceNum"),
		title1 = Strings:get("UITitle_EN_Xuanzeshuliang"),
		bgSize = {
			width = 837,
			height = 470
		}
	})
end

function ActivityExchangeTipMediator:enterWithData(data)
	self._activityId = data.activityId or nil
	self._id = data.id or nil
	self._maxCount = data.count or 0
	self._curCount = self._maxCount > 0 and 1 or 0
	self._callback = data.callback or nil

	self:createView()
	self:refreshView()
end

function ActivityExchangeTipMediator:createView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._minusBtn = self._mainPanel:getChildByFullName("minusbtn")
	self._addBtn = self._mainPanel:getChildByFullName("addbtn")
	self._progPanel = self._mainPanel:getChildByFullName("progpanel")
	self._progLabel = self._progPanel:getChildByFullName("prolabel")
	self._showNum = self._progPanel:getChildByFullName("showNum")

	self._showNum:setString("0")

	self._editBox = self._progPanel:getChildByFullName("TextField")
	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			self:closeChangeScheduler()
			self._showNum:setString("")

			self._editNum = self._curCount

			self._editBox:setText("")
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			if type(tonumber(self._editNum)) ~= "number" or self._editNum == "" then
				self._showNum:setString(self._curCount)
				self._editBox:setText("")

				return
			end

			local num = tonumber(self._editNum)

			if num > self._maxCount then
				num = self._maxCount
			elseif num < 0 then
				num = 0
			end

			self._curCount = num

			self._progLabel:setString(self._curCount .. "/" .. self._maxCount)
			self._showNum:setString(self._curCount)
			self._editBox:setText("")

			self._editNum = ""
		elseif eventName == "changed" then
			self._editNum = self._editBox:getText()
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

function ActivityExchangeTipMediator:refreshView()
	self._progLabel:setString(self._curCount .. "/" .. self._maxCount)
	self._showNum:setString(self._curCount)
	self._editBox:setText("")
	self._minusBtn:setGray(self._curCount <= 1)
	self._addBtn:setGray(self._curCount >= self._maxCount)
	self._mainPanel:getChildByFullName("changeone.button"):setGray(self._curCount <= 0)
	self._mainPanel:getChildByFullName("changeone.button"):setTouchEnabled(self._curCount > 0)
end

function ActivityExchangeTipMediator:onBackClicked(sender, eventType)
	self:close()
end

function ActivityExchangeTipMediator:onChangeClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isAdd = sender == self._addBtn

		local canAdd = self:checkEngouh(true)

		if not canAdd then
			self:refreshView()
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		self:createChangeScheduler()
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self:refreshView()
		self:closeChangeScheduler()
	end
end

function ActivityExchangeTipMediator:onMaxClicked(sender, eventType)
	if self._curCount == self._maxCount and self._curCount == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("VT_Exchange_Lack_Tips")
		}))

		return
	end

	self._curCount = self._maxCount

	self:refreshView()
end

function ActivityExchangeTipMediator:onMinClicked(sender, eventType)
	if self._maxCount == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("VT_Exchange_Lack_Tips")
		}))

		return
	end

	self._curCount = 1

	self:refreshView()
end

function ActivityExchangeTipMediator:update()
	local addNum = self._isAdd and 1 or -1

	self._curCount = self._curCount + addNum
	self._curCount = math.ceil(self._curCount)

	if self._curCount <= 1 then
		self._curCount = 1
	end

	if self._curCount >= self._maxCount then
		self._curCount = self._maxCount

		self:closeChangeScheduler()
	end

	self:refreshView()
end

function ActivityExchangeTipMediator:createChangeScheduler()
	self:closeChangeScheduler()

	if self._changeScheduler == nil then
		self._changeScheduler = LuaScheduler:getInstance():schedule(function()
			self:update()
		end, 0.1, true)
	end
end

function ActivityExchangeTipMediator:closeChangeScheduler()
	if self._changeScheduler then
		LuaScheduler:getInstance():unschedule(self._changeScheduler)

		self._changeScheduler = nil
	end
end

function ActivityExchangeTipMediator:checkEngouh(hasTip)
	if self._isAdd and self._curCount >= self._maxCount then
		self._curCount = self._maxCount

		self:closeChangeScheduler()

		return false
	elseif not self._isAdd and self._curCount <= 0 then
		self._curCount = 0

		self:closeChangeScheduler()

		return false
	end

	return true
end

function ActivityExchangeTipMediator:onClickExchange()
	if not self._id then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = "id nil"
		}))

		return
	end

	if self._curCount == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("VT_Exchange_Lack_Tips")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		exchangeId = self._id,
		exchangeAmount = self._curCount
	}

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._activitySystem:requestDoActivity(self._activityId, data, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				needClick = true,
				rewards = rewards
			}))
		end

		if self._callback then
			self._callback()
		end

		self:close()
	end)
end

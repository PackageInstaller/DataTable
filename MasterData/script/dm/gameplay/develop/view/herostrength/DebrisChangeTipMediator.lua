-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/DebrisChangeTipMediator.lua

DebrisChangeTipMediator = class("DebrisChangeTipMediator", DmPopupViewMediator, _M)

DebrisChangeTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local DebrisItemId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragment", "content")
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

function DebrisChangeTipMediator:initialize()
	super.initialize(self)
end

function DebrisChangeTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function DebrisChangeTipMediator:onRemove()
	super.onRemove(self)
end

function DebrisChangeTipMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_HERODEBRISCHANGE_SUCC, self, self.refreshViewByDebrisChange)

	self._btnWidget = self:bindWidget("mainpanel.changeone", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onExchangeClicked, self)
		}
	})

	bindWidget(self, "mainpanel.tipnode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("debris_UI1"),
		title1 = Strings:get("UITitle_EN_Suipianzhuanhuan"),
		bgSize = {
			width = 837,
			height = 573
		}
	})
end

function DebrisChangeTipMediator:enterWithData(heroId)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroPrototype = self._heroSystem:getHeroProById(self._heroId)
	self._heroDebrisItemId = self._heroData:getFragId()
	self._isAdd = true
	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)
	self._heroDebrisNum = self._bagSystem:getItemCount(self._heroDebrisItemId)
	self._curCount = self._debrisItemNum > 0 and 1 or 0

	self:createView()
	self:refreshView()
end

function DebrisChangeTipMediator:refreshViewByDebrisChange()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("HEROS_UI23")
	}))

	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)
	self._curCount = self._debrisItemNum > 0 and 1 or 0

	self:refreshView()
end

function DebrisChangeTipMediator:createView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._text = self._infoPanel:getChildByFullName("text")
	self._nameLabel = self._infoPanel:getChildByFullName("numLabel")
	self._numLabel = self._infoPanel:getChildByFullName("numLabel_1")
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

			if num > self._debrisItemNum then
				num = self._debrisItemNum
			elseif num < 0 then
				num = 0
			end

			self._curCount = num

			self._progLabel:setString(self._curCount .. "/" .. self._debrisItemNum)
			self._showNum:setString(self._curCount)
			self._editBox:setText("")

			self._editNum = ""
		elseif eventName == "changed" then
			self._editNum = self._editBox:getText()

			print(" type=" .. type(self._editNum))
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

function DebrisChangeTipMediator:refreshView()
	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)
	self._masterDebrisPanel = self._mainPanel:getChildByFullName("debris1panel")

	self._masterDebrisPanel:removeAllChildren()

	self._masterItemIcon = self._bagSystem:createItemIcon(DebrisItemId)

	self._masterItemIcon:addTo(self._masterDebrisPanel):center(self._masterDebrisPanel:getContentSize())

	self._heroDebrisNum = self._bagSystem:getItemCount(self._heroDebrisItemId)

	local icon = IconFactory:createRewardIcon({
		id = self._heroDebrisItemId,
		type = RewardType.kHero,
		code = self._heroDebrisItemId,
		amount = self._heroDebrisNum
	}, {
		isWidget = true
	})

	self._heroDebrisPanel = self._mainPanel:getChildByFullName("debris2panel")

	self._heroDebrisPanel:removeAllChildren()
	icon:addTo(self._heroDebrisPanel):center(self._heroDebrisPanel:getContentSize())
	icon:setNotEngouhState(false)

	local endNum = self._heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId())

	self._endNum = self._heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId())
	endNum = endNum - self._heroDebrisNum < 0 and 0 or endNum - self._heroDebrisNum

	self._nameLabel:setString(RewardSystem:getName({
		id = self._heroDebrisItemId
	}))

	local quality = RewardSystem:getQuality({
		id = self._heroDebrisItemId
	})

	GameStyle:setQualityText(self._nameLabel, quality)
	self._numLabel:setString("X" .. endNum)

	local width1 = self._text:getContentSize().width
	local width2 = self._nameLabel:getContentSize().width
	local width3 = self._numLabel:getContentSize().width

	self._text:setPositionX(0)
	self._nameLabel:setPositionX(width1)
	self._numLabel:setPositionX(width1 + width2)
	self._infoPanel:setContentSize(cc.size(width1 + width2 + width3, 46))

	if self._heroData:getStar() >= HeroStarCountMax then
		self._progLabel:setString(self._curCount .. "/" .. self._debrisItemNum)
		self._showNum:setString(self._curCount)
		self._editBox:setTouchAreaEnabled(false)

		return
	end

	self._progLabel:setString(self._curCount .. "/" .. self._debrisItemNum)
	self._showNum:setString(self._curCount)
	self._editBox:setText("")
	self._minusBtn:setGray(self._curCount <= 1)
	self._addBtn:setGray(self._curCount >= self._debrisItemNum)
	self._mainPanel:getChildByFullName("changeone.button"):setGray(self._curCount <= 0)
	self._mainPanel:getChildByFullName("changeone.button"):setTouchEnabled(self._curCount > 0)
end

function DebrisChangeTipMediator:onBackClicked(sender, eventType)
	self:close()
end

function DebrisChangeTipMediator:onExchangeClicked(sender, eventType)
	local debrisNum = self._bagSystem:getItemCount(DebrisItemId)
	local star = self._heroData:getStar()

	if star < HeroStarCountMax and self._heroDebrisNum == self._endNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010012")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if debrisNum == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010013")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
	self._bagSystem:requestHeroDebrisChange(self._heroId, self._curCount)
end

function DebrisChangeTipMediator:onChangeClicked(sender, eventType)
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

function DebrisChangeTipMediator:onMaxClicked(sender, eventType)
	if self._curCount == self._debrisItemNum and self._curCount == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010013")
		}))

		return
	end

	self._curCount = self._debrisItemNum

	self:refreshView()
end

function DebrisChangeTipMediator:onMinClicked(sender, eventType)
	if self._debrisItemNum == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010013")
		}))

		return
	end

	self._curCount = 1

	self:refreshView()
end

function DebrisChangeTipMediator:update()
	local addNum = self._isAdd and 1 or -1

	self._curCount = self._curCount + addNum
	self._curCount = math.ceil(self._curCount)

	if self._curCount <= 1 then
		self._curCount = 1
	end

	if self._curCount >= self._debrisItemNum then
		self._curCount = self._debrisItemNum

		self:closeChangeScheduler()
	end

	self:refreshView()
end

function DebrisChangeTipMediator:createChangeScheduler()
	self:closeChangeScheduler()

	if self._changeScheduler == nil then
		self._changeScheduler = LuaScheduler:getInstance():schedule(function()
			self:update()
		end, 0.1, true)
	end
end

function DebrisChangeTipMediator:closeChangeScheduler()
	if self._changeScheduler then
		LuaScheduler:getInstance():unschedule(self._changeScheduler)

		self._changeScheduler = nil
	end
end

function DebrisChangeTipMediator:checkEngouh(hasTip)
	if self._isAdd and self._curCount >= self._debrisItemNum then
		self._curCount = self._debrisItemNum

		self:closeChangeScheduler()

		return false
	elseif not self._isAdd and self._curCount <= 0 then
		self._curCount = 0

		self:closeChangeScheduler()

		return false
	end

	return true
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroGeneralFragmentMeditor.lua

HeroGeneralFragmentMeditor = class("HeroGeneralFragmentMeditor", DmPopupViewMediator, _M)

HeroGeneralFragmentMeditor:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local DebrisItemId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragment", "content")
local kBtnHandlers = {
	["main.minusbtn"] = {
		ignoreClickAudio = true,
		func = "onSubClicked"
	},
	["main.addbtn"] = {
		ignoreClickAudio = true,
		func = "onAddClicked"
	},
	["main.maxbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onMaxClicked"
	}
}

function HeroGeneralFragmentMeditor:initialize()
	super.initialize(self)
end

function HeroGeneralFragmentMeditor:dispose()
	self._viewClose = true

	super.dispose(self)
end

function HeroGeneralFragmentMeditor:onRemove()
	super.onRemove(self)
end

function HeroGeneralFragmentMeditor:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_HERODEBRISCHANGE_SUCC, self, self.refreshViewByDebrisChange)

	self._btnWidget = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onExchangeClicked, self)
		}
	})

	bindWidget(self, "main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("OmnipotentFrag_PopupText"),
		title1 = Strings:get("UITitle_EN_Suipianzhuanhuan"),
		bgSize = {
			width = 837,
			height = 573
		}
	})
end

function HeroGeneralFragmentMeditor:enterWithData(data)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroId = data.heroId
	self._kind = data.kind
	self._fromIdentityAwake = data.fromIdentityAwake
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroPrototype = self._heroSystem:getHeroProById(self._heroId)
	self._heroDebrisItemId = self._heroData:getFragId()

	self:refreshData()
	self:createView()
	self:refreshView()
	self:refreshSlider()
end

function HeroGeneralFragmentMeditor:refreshData()
	self._debrisItemInfo = self:getDebrisItemIdByQuality()
	self._debrisItemNum = self._bagSystem:getItemCount(self._debrisItemInfo.id)
	self._heroDebrisNum = self._bagSystem:getItemCount(self._heroDebrisItemId)

	local data = self:getDebrisItemIdByQuality()

	assert(data, "no qualiy Hero_StarFragment ")

	local nextIsMiniStar = self._heroData:getNextIsMiniStar()
	local isLittleStar = self._heroData:getLittleStar()

	self._state = self._kind == 1 and (isLittleStar and not nextIsMiniStar and 1 or 2) or 2
end

function HeroGeneralFragmentMeditor:refreshViewByDebrisChange()
	local rewards = {
		self._getReward
	}
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
	self:close()
end

function HeroGeneralFragmentMeditor:getDebrisItemIdByQuality()
	local data
	local quality = self._heroData:getRarity()
	local info = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_StarFragment", "content")

	for k, v in pairs(info) do
		if quality == tonumber(k) then
			data = {
				id = next(v),
				num = v[next(v)]
			}

			break
		end
	end

	return data
end

function HeroGeneralFragmentMeditor:createView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._countlabel = self._mainPanel:getChildByFullName("countlabel")
	self._masterDebrisPanel = self._mainPanel:getChildByFullName("debris1panel")
	self._heroDebrisPanel = self._mainPanel:getChildByFullName("debris2panel")
	self._richText = ccui.RichText:createWithXML("", {})

	self._richText:setAnchorPoint(self._countlabel:getAnchorPoint())
	self._richText:setPosition(cc.p(self._countlabel:getPosition()))
	self._richText:addTo(self._countlabel:getParent())
	self._richText:setOpacity(86)
	self._countlabel:setOpacity(86)

	self._slider = self._mainPanel:getChildByFullName("slider")

	self._slider:setScale9Enabled(true)
	self._slider:setCapInsets(cc.rect(43, 2, 32, 2))
	self._slider:setCapInsetsBarRenderer(cc.rect(1, 1, 1, 1))
	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			if self._curCount == 0 then
				self._slider:setPercent(0)
			else
				local percent = self._slider:getPercent()

				if percent == 0 then
					self._curCount = 1
				else
					local count = math.ceil(percent / 100 * self._max)

					self._curCount = math.min(count, self._max)
				end

				self:refreshView()
			end
		end
	end)

	self._curCount = 1
end

function HeroGeneralFragmentMeditor:refreshSlider()
	self._slider:setPercent(self._curCount / self._max * 100)
end

function HeroGeneralFragmentMeditor:refreshView()
	if self._state == 1 then
		self._max = self._debrisItemNum

		self._countlabel:setVisible(false)
		self._richText:setVisible(true)

		local itemConfig = self._bagSystem:getItemConfig(self._heroDebrisItemId)

		if itemConfig then
			::label_12_0::

			local name = Strings:get(itemConfig.Name)

			self._richText:setString(Strings:get("OmnipotentFrag_ShowTip04", {
				color = "#00FF00",
				fontName = TTF_FONT_FZYH_M,
				heroFrag = name,
				cur = self._curCount,
				total = self._max
			}))
		end
	elseif self._kind == 1 then
		if not self._heroData:getNextStarId() then
			var_12_0 = self._heroData:getNextStarId(true)

			local endNum = self._heroPrototype:getStarCostFragByStar((self._fromIdentityAwake or nil) and self._heroData:getNextIdentityStarId())
			local canHave = self._heroDebrisNum + self._debrisItemInfo.num * self._debrisItemNum
			local nowNum = self._curCount * self._debrisItemInfo.num + self._heroDebrisNum

			self._max = endNum <= self._heroDebrisNum and self._debrisItemNum or endNum <= canHave and math.ceil((endNum - self._heroDebrisNum) / self._debrisItemInfo.num) or self._debrisItemNum

			if endNum <= nowNum then
				self._countlabel:setVisible(true)
				self._richText:setVisible(false)
				self._countlabel:setString(Strings:get((self._fromIdentityAwake or nil) and "Hero_IA_UI_3"))
			else
				self._countlabel:setVisible(false)
				self._richText:setVisible(true)

				local itemConfig = self._bagSystem:getItemConfig(self._heroDebrisItemId)

				if itemConfig then
					::label_12_1::

					local name = Strings:get(itemConfig.Name)

					self._richText:setString(Strings:get((self._fromIdentityAwake or nil) and "Hero_IA_UI_4", {
						color = "#FF0000",
						fontName = TTF_FONT_FZYH_M,
						heroFrag = name,
						cur = nowNum,
						total = endNum
					}))
				end
			end
		end
	end

	self._masterDebrisPanel:removeAllChildren()

	self._masterItemIcon = IconFactory:createItemIcon({
		id = self._debrisItemInfo.id
	}, {
		showAmount = true,
		isWidget = true
	})

	self._masterItemIcon:addTo(self._masterDebrisPanel):center(self._masterDebrisPanel:getContentSize())
	self._masterItemIcon:setAmount(self._curCount .. "/" .. self._debrisItemNum)

	self._heroDebrisNum = self._bagSystem:getItemCount(self._heroDebrisItemId)

	local icon = IconFactory:createRewardIcon({
		id = self._heroDebrisItemId,
		type = RewardType.kHero,
		code = self._heroDebrisItemId,
		amount = self._heroDebrisNum
	}, {
		showAmount = true,
		isWidget = true
	})

	self._heroDebrisPanel:removeAllChildren()
	icon:addTo(self._heroDebrisPanel):center(self._heroDebrisPanel:getContentSize())
	icon:setNotEngouhState(false)
	icon:setAmount(self._curCount * self._debrisItemInfo.num + self._heroDebrisNum)
end

function HeroGeneralFragmentMeditor:onBackClicked(sender, eventType)
	self:close()
end

function HeroGeneralFragmentMeditor:onExchangeClicked(sender, eventType)
	if self._curCount <= 0 and self._debrisItemNum > 0 then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)

	self._getReward = {
		code = self._heroDebrisItemId,
		amount = self._curCount,
		type = RewardType.kItem
	}

	self._bagSystem:requestHeroDebrisChange(self._heroId, self._curCount)
end

function HeroGeneralFragmentMeditor:onAddClicked(sender, eventType)
	self._curCount = self._curCount + 1

	if self._curCount > self._max then
		self._curCount = self._max
	end

	self:refreshView()
	self:refreshSlider()
end

function HeroGeneralFragmentMeditor:onSubClicked(sender, eventType)
	self._curCount = self._curCount - 1

	if self._curCount < 1 then
		self._curCount = 1
	end

	self:refreshView()
	self:refreshSlider()
end

function HeroGeneralFragmentMeditor:onMaxClicked(sender, eventType)
	self._curCount = self._max

	self:refreshView()
	self:refreshSlider()
end

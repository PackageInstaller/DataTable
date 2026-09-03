-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthLevelMediator.lua

HeroStrengthLevelMediator = class("HeroStrengthLevelMediator", DmPopupViewMediator, _M)

HeroStrengthLevelMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroStrengthLevelMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
HeroStrengthLevelMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["mainpanel.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onOkClicked"
	},
	["mainpanel.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickRule"
	}
}

function HeroStrengthLevelMediator:initialize()
	super.initialize(self)
end

function HeroStrengthLevelMediator:dispose()
	self._viewClose = true

	if self._eatItemView then
		self._eatItemView:dispose()
	end

	if self._evolutionView then
		self._evolutionView:dispose()
	end

	if self._rebornView then
		self._rebornView:dispose()
	end

	super.dispose(self)
end

function HeroStrengthLevelMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROLEVELUP_SUCC, self, self.refreshViewByLvlUp)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_SYNCHRONIZED, self, self.refreshLevelView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BAG_SYNCHRONIZED, self, self.refreshLevelView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshEvoView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROLEVELUP_FINISH, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROEVOLUTION_FINISH, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROREBORN_SUCC, self, self.closeView)
end

function HeroStrengthLevelMediator:closeView()
	self:close()
end

function HeroStrengthLevelMediator:enterWithData(data)
	self._heroSystem = self._developSystem:getHeroSystem()

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_IGNORESOUND, {
		ignoreSound = true
	}))
	self:createData(data)
	self:initNodes()
end

function HeroStrengthLevelMediator:createData(data)
	self._reborn = false

	if data and data.reborn then
		self._reborn = data.reborn
	end

	if data and data.id then
		self._heroId = data.id
	else
		local heroData = self._heroSystem:getHeroById(self._heroSystem:getOwnHeroIds()[1].id)

		self._heroId = heroData:getId()
	end
end

function HeroStrengthLevelMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._viewNode = self._mainPanel:getChildByFullName("eatNode")

	local bg = self._mainPanel:getChildByFullName("bg")

	self._text1 = bg:getChildByFullName("text1")
	self._button = self._mainPanel:getChildByFullName("button")

	self._button:setVisible(false)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		self._text1:setContentSize(cc.size(180, 50))
	end

	self._text2 = bg:getChildByFullName("text2")

	self:refreshView()
	self:setupClickEnvs()
end

function HeroStrengthLevelMediator:checkEnabledQuality()
	local result, tip = self._heroSystem:checkEnabledQuality()

	return result
end

function HeroStrengthLevelMediator:refreshView()
	if self._reborn then
		self._button:setVisible(true)

		if self._rebornView then
			self._rebornView:dispose()

			self._rebornView = nil
		end

		self._viewNode:removeAllChildren()
		self._text1:setString(Strings:get("Hero_Reborn_UI1"))
		self._text2:setString(Strings:get("Hero_Reborn_UI1_En"))

		local eatPanel = cc.CSLoader:createNode("asset/ui/StrengthenEvolutionNew.csb")

		eatPanel:addTo(self._viewNode):posite(0, 0)

		local eatViewData = {
			mediator = self,
			heroId = self._heroId,
			mainNode = eatPanel
		}

		self._rebornView = self._heroSystem:enterRebornView(eatViewData)
	elseif self:checkEnabledQuality() and self._heroSystem:isHeroLevelMax(self._heroId) and not self._evolutionView then
		if self._eatItemView then
			self._eatItemView:dispose()

			self._eatItemView = nil
		end

		self._viewNode:removeAllChildren()
		self._text1:setString(Strings:get("HEROS_UI70"))
		self._text2:setString(Strings:get("UITitle_EN_Huobanlianjie"))

		local eatPanel = cc.CSLoader:createNode("asset/ui/StrengthenEvolutionNew.csb")

		eatPanel:addTo(self._viewNode):posite(0, 0)

		local eatViewData = {
			mediator = self,
			heroId = self._heroId,
			mainNode = eatPanel
		}

		self._evolutionView = self._heroSystem:enterEvolutionView(eatViewData)
	elseif not self._eatItemView then
		if self._evolutionView then
			self._evolutionView:dispose()

			self._evolutionView = nil
		end

		self._viewNode:removeAllChildren()
		self._text1:setString(Strings:get("HEROS_UI48"))
		self._text2:setString(Strings:get("UITitle_EN_Dengjiqianghua"))

		local eatPanel = cc.CSLoader:createNode("asset/ui/StrengthenEatItem.csb")

		eatPanel:addTo(self._viewNode):posite(0, 0)

		local eatViewData = {
			mediator = self,
			heroId = self._heroId,
			mainNode = eatPanel
		}

		self._eatItemView = self._heroSystem:enterEatItemView(eatViewData)
	end

	self:runStartAnim()
end

function HeroStrengthLevelMediator:refreshEvoView()
	if self._evolutionView then
		self._evolutionView:refreshView(self._heroId)
	end
end

function HeroStrengthLevelMediator:refreshViewByLvlUp()
	if self._eatItemView then
		self._eatItemView:refreshView(self._heroId)
		self._eatItemView:showLevelUpCombatAnim()
	end
end

function HeroStrengthLevelMediator:refreshLevelView()
	if self._eatItemView then
		self._eatItemView:refreshView(self._heroId, true)
	end
end

function HeroStrengthLevelMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:onOkClicked()
end

function HeroStrengthLevelMediator:onOkClicked()
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_IGNORESOUND, {
		ignoreSound = false
	}))
	self._heroSystem:setEatItemCache({})
	self:close()
end

function HeroStrengthLevelMediator:onClickedGoto()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:tryEnter({})
end

function HeroStrengthLevelMediator:runStartAnim()
	if self._eatItemView then
		self._eatItemView:runStartAnim()
	end

	if self._evolutionView then
		self._evolutionView:runStartAnim()
	end

	if self._rebornView then
		self._rebornView:runStartAnim()
	end
end

function HeroStrengthLevelMediator:onClickRule()
	local rules = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Hero_Reborn_shuoming", "content")

	self._activitySystem:showActivityRules(rules)
end

function HeroStrengthLevelMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if self._eatItemView then
		local itemNode = self._eatItemView._itemNodes[1]

		if guideAgent:isGuiding() and itemNode then
			storyDirector:setClickEnv("HeroStrengthLevelMediator.itemNode", itemNode, function(sender, eventType)
				self._eatItemView:onEatItemClicked(itemNode, ccui.TouchEventType.began, true)
				self._eatItemView:onEatItemClicked(itemNode, ccui.TouchEventType.ended, true)
				storyDirector:notifyWaiting("click_HeroUpLevel_itemNode")
			end)

			local upBtn = self._eatItemView._upBtn

			if upBtn then
				storyDirector:setClickEnv("HeroStrengthLevelMediator.upBtn", upBtn, function(sender, eventType)
					self._eatItemView:onClickLevelUp()
					storyDirector:notifyWaiting("click_HeroUpLevel_upBtn")
				end)
			end

			local backBtn = self:getView():getChildByFullName("mainpanel.backBtn")

			if backBtn then
				storyDirector:setClickEnv("HeroStrengthLevelMediator.backBtn", backBtn, function(sender, eventType)
					storyDirector:notifyWaiting("click_HeroUpLevel_backBtn")
					self:onOkClicked()
				end)
			end

			local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
				storyDirector:notifyWaiting("enter_HeroStrengthLevelMediator")
			end))

			self:getView():runAction(sequence)
		end
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_HeroStrengthMediator")
	end))

	self:getView():runAction(sequence)
end

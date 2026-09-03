-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagGiftChooseOneMediator.lua

BagGiftChooseOneMediator = class("BagGiftChooseOneMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["window.minusbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["window.addbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["window.maxbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMax"
	}
}

function BagGiftChooseOneMediator:initialize()
	super.initialize(self)

	self._curRewardId = nil
	self._curItemId = nil
	self._curCount = nil
	self._curName = ""
end

function BagGiftChooseOneMediator:dispose()
	self:closeChangeScheduler()
	super.dispose(self)
end

function BagGiftChooseOneMediator:userInject()
	self._developSystem = self:getInjector():getInstance(DevelopSystem)
	self._bagSystem = self._developSystem:getBagSystem()
end

function BagGiftChooseOneMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._useBtn = self:bindWidget("window.usebtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickUse, self)
		}
	})
end

function BagGiftChooseOneMediator:enterWithData(data)
	assert(data ~= nil, "error:data=nil")
	assert(data.entryId ~= nil, "error:data.entryId=nil")

	self._entryId = data.entryId
	self._entry = self._bagSystem:getEntryById(self._entryId)
	self._isAdd = true

	self:setupUseBaseNum()
	self:setupView(data)
	self:updateView()
end

function BagGiftChooseOneMediator:setupUseBaseNum()
	self._maxCount = self._bagSystem:getItemCount(self._entryId)
	self._minCount = 1
	self._curCount = 1
end

function BagGiftChooseOneMediator:setupView(data)
	self._indicator = self:getView():getChildByFullName("indicator")

	local mainPanel = self:getView():getChildByFullName("window")
	local var_7_1 = mainPanel:getChildByFullName("tipnode")
	local var_7_2 = {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		}
	}

	var_7_2.title = data.title or ""
	var_7_2.title1 = data.title1 or ""

	bindWidget(self, bgNode, PopupNormalWidget, var_7_2)

	local item = self._entry.item
	local desc2 = mainPanel:getChildByFullName("itemDesc2")

	desc2:setString(Strings:get("bag_ChoiceReward_Text1") .. item:getDesc())

	local configValueKey = ConfigReader:getDataByNameIdAndKey("ConfigValue", "UREquip_ExtraPanelName", "content")

	if self and self[item:getId()] then
		local richText = ccui.RichText:createWithXML("", {})

		bgNode:setAnchorPoint(desc2:getAnchorPoint())
		bgNode:setPosition(cc.p(desc2:getPosition()))
		bgNode:addTo(desc2:getParent())
		bgNode:setString(Strings:get("bag_UR_Learn_Tips"))
		bgNode:ignoreContentAdaptWithSize(true)
		bgNode:rebuildElements()
		bgNode:formatText()
		bgNode:renderContent(desc2:getContentSize().width, desc2:getContentSize().height)
		desc2:setVisible(false)
	end

	local rewardList = mainPanel:getChildByFullName("itemPanel.listView")

	bgNode:removeAllItems()
	bgNode:setScrollBarEnabled(false)

	local rewards = item:getPrototype()._itemBase.Reward

	for i = 1, #rewards do
		local rewardData = ConfigReader:getRecordById("Reward", rewards[i]).Content
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(90, 90))

		local icon = IconFactory:createRewardIcon(rewardData[1], {
			showAmount = true,
			isWidget = true
		})

		icon.rewardId = rewards[i]

		self:bindTouchHander(icon, IconTouchHandler:new(self), rewardData[1], {
			needDelay = true
		})
		icon:setScaleNotCascade(0.7)
		icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
		bgNode:pushBackCustomItem(layout)
	end

	if #rewards <= 6 then
		bgNode:setContentSize(cc.size(105 * #rewards - 15, 95))
		bgNode:setTouchEnabled(false)
	end

	self._minusBtn = mainPanel:getChildByFullName("minusbtn")
	self._addBtn = mainPanel:getChildByFullName("addbtn")
	self._maxBtn = mainPanel:getChildByFullName("maxbtn")
	self._curCountText = mainPanel:getChildByFullName("count.countlabel")
	self._info1 = mainPanel:getChildByFullName("itemPanel.info")
	self._info2 = mainPanel:getChildByFullName("itemPanel.info2")
	self._info3 = mainPanel:getChildByFullName("itemPanel.info3")
end

function BagGiftChooseOneMediator:bindTouchHander(icon, handler, info, style)
	local rewardData = RewardSystem:parseInfo(info)

	icon.info = rewardData
	icon.style = style or {}

	icon:setTouchEnabled(true)
	icon:setSwallowTouches((style or nil) and (style.swallowTouches or false))
	icon:addTouchEventListener(function(sender, eventType)
		if icon.callFunc then
			icon.callFunc(sender, eventType)
		end

		if eventType == ccui.TouchEventType.began then
			local delayAct = cc.DelayTime:create(style.delayTime or 0.3)
			local judgeShowAct = cc.CallFunc:create(function()
				if handler.onBegan ~= nil then
					handler:onBegan(icon)
				end
			end)
			local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

			sender:runAction(seqAct)
		elseif eventType == ccui.TouchEventType.canceled then
			sender:stopAllActions()

			if handler.onCanceled ~= nil then
				handler:onCanceled(icon)
			end
		elseif eventType == ccui.TouchEventType.moved then
			if style and style.stopActionWhenMove then
				sender:stopAllActions()
			end

			if handler.onMoved ~= nil then
				handler:onMoved(icon)
			end
		elseif eventType == ccui.TouchEventType.ended then
			sender:stopAllActions()

			if handler.onEnded ~= nil then
				handler:onEnded(icon)
			end

			self._curRewardId = icon.rewardId
			self._curItemId = icon.info.id
			self._curName = self:getName(rewardData)

			self:updateView()

			local indicator = self._indicator
			local size = sender:getContentSize()

			indicator:setVisible(true)
			indicator:setPosition(size.width / 2, size.height / 2)
			indicator:setLocalZOrder(10)
			indicator:changeParent(sender)
			self:stopIndicatorAni()

			self._actIndicator = performWithDelay(self:getView(), function()
				self:stopIndicatorAni()

				if not indicator:isVisible() then
					return
				end

				indicator:runAction(cc.FadeIn:create(0.1))
				indicator:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.95), cc.ScaleTo:create(0.5, 1))))
			end, 0.1)
		end
	end)
end

function BagGiftChooseOneMediator:updateView()
	self._maxBtn:setEnabled(self._curCount < self._maxCount)
	self._minusBtn:setEnabled(self._curCount > 1)
	self._minusBtn:setGray(self._curCount <= 1)
	self._addBtn:setGray(self._curCount == self._maxCount)
	self._curCountText:setString(tostring(self._curCount) .. "/" .. tostring(self._maxCount))

	if self._curRewardId and self._curRewardId ~= "" then
		self._info1:setVisible(false)
		self._info2:setVisible(true)
		self._info3:setVisible(true)
		self._info3:setString(self._curName)
	else
		self._info1:setVisible(true)
		self._info2:setVisible(false)
		self._info3:setVisible(false)
	end
end

function BagGiftChooseOneMediator:onClickMax(sender, eventType)
	self._curCount = self._maxCount

	self:updateView()
end

function BagGiftChooseOneMediator:onClickUse(sender, eventType)
	if self._curRewardId == nil or self._curRewardId == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("bag_ChoiceReward_Tips")
		}))

		return
	end

	if self._curCount >= self._minCount and self._curCount <= self._maxCount then
		local canUse = self._bagSystem:requestBoxChooseItem(self._entryId, self._curCount, self._curRewardId, function(data)
			if not checkDependInstance(self) then
				return
			end

			local rewards = data.reward

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end
		end)

		if canUse then
			self:closeChangeScheduler()
			self:close()
		end
	end
end

function BagGiftChooseOneMediator:onBackClicked(sender, eventType)
	self:closeChangeScheduler()
	self:close()
end

function BagGiftChooseOneMediator:onChangeClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isAdd = sender == self._addBtn

		self:createChangeScheduler()
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self:updateView()
		self:closeChangeScheduler()
	end
end

function BagGiftChooseOneMediator:update()
	local addNum = self._isAdd and 1 or -1

	self._curCount = self._curCount + addNum
	self._curCount = math.ceil(self._curCount)

	if self._curCount <= 1 then
		self._curCount = 1
	end

	if self._curCount >= self._maxCount then
		self._curCount = self._maxCount
	end

	self:updateView()
end

function BagGiftChooseOneMediator:createChangeScheduler()
	self:closeChangeScheduler()

	if self._changeScheduler == nil then
		self._changeScheduler = LuaScheduler:getInstance():schedule(function()
			self:update()
		end, 0.2, true)
	end
end

function BagGiftChooseOneMediator:closeChangeScheduler()
	if self._changeScheduler then
		LuaScheduler:getInstance():unschedule(self._changeScheduler)

		self._changeScheduler = nil
	end
end

local kRewardConfig = {
	[RewardType.kRewardLink] = {
		name = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "MysteryItemName", "content")),
		desc = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "MysteryItemDesc", "content"))
	},
	[RewardType.kStory] = {
		name = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryItemName", "content")),
		desc = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryItemDesc", "content"))
	}
}

function BagGiftChooseOneMediator:getName(rewardData)
	local info = rewardData
	local rewardConfig = kRewardConfig[rewardData.type]

	if rewardConfig then
		return rewardConfig.name
	end

	if rewardData.type ~= nil and rewardData.code ~= nil then
		info = self:parseInfo(rewardData)
	end

	assert(info ~= nil, "error:rewardData=nil")
	assert(info.id ~= nil, "error:id error")

	local id = tostring(info.id)

	if info.rewardType then
		if info.rewardType == RewardType.kSurface then
			local config = ConfigReader:getRecordById("Surface", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		end
	end

	local config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("Skill", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("MasterCoreBase", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("PlayerHeadFrame", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	return ""
end

function BagGiftChooseOneMediator:stopIndicatorAni()
	self._indicator:stopAllActions()
	self._indicator:setScale(1)
end

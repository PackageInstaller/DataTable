-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreSweepMediator.lua

ExploreSweepMediator = class("ExploreSweepMediator", DmPopupViewMediator, _M)

ExploreSweepMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreSweepMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

EVT_SWEEPPOWERCHANGE_SERVER = "EVT_SWEEPPOWERCHANGE_SERVER"

local kBtnHandlers = {
	["mMainPanel.mSweepBtn.button"] = {
		func = "onSweepBtn"
	},
	["mMainPanel.mConfirmBtn.button"] = {
		func = "onConfirmBtn"
	},
	["mMainPanel.touchPanel"] = {
		ignoreClickAudio = true,
		func = "onSpeedUpSweep"
	}
}
local kTextColor = {
	Green = cc.c3b(205, 250, 100),
	Red = cc.c3b(255, 135, 135)
}

function ExploreSweepMediator:initialize()
	super.initialize(self)
end

function ExploreSweepMediator:dispose()
	self._developSystem:popPlayerLvlUpView()
	super.dispose(self)
end

function ExploreSweepMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mMainPanel.mSweepBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("mMainPanel.mConfirmBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SWEEPPOWERCHANGE_SERVER, self, self.setPowerView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ENERGRY_SUCC, self, self.setPowerView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_RESETTIMES, self, self.setPowerView)
end

function ExploreSweepMediator:onRemove()
	super.onRemove(self)
end

function ExploreSweepMediator:enterWithData(data)
	self._sweepData = data
	self._itemId = DataReader:getDataByNameIdAndKey("ConfigValue", "TansuoOneClickReward_Show", "content")
	self._needNum = data.needNum or 0

	self:initWidget()
	self:refreshView()
end

function ExploreSweepMediator:initWidget()
	local bgNode = self:getView():getChildByFullName("mMainPanel.tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackBtn, self)
		},
		title = Strings:get("Stage_Wipe_Title"),
		bgSize = {
			width = 835,
			height = 580
		}
	})

	self._sweepBtn = self:getView():getChildByFullName("mMainPanel.mSweepBtn")

	self._sweepBtn:setVisible(false)

	self._sweepLabel = self:getView():getChildByFullName("mMainPanel.mSweepBtn.name")
	self._comfirmBtn = self:getView():getChildByFullName("mMainPanel.mConfirmBtn")

	self._comfirmBtn:setVisible(false)

	self._comfirmLabel = self:getView():getChildByFullName("mMainPanel.mConfirmBtn.name")
	self._listView = self:getView():getChildByFullName("mMainPanel.mListView")

	self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
		times = math.min(self._sweepData.param.wipeTimes, self._exploreSystem:getEnterTimes())
	}))
	self._comfirmLabel:setString(Strings:find("CUSTOM_CONFIRM"))
	self._listView:setScrollBarEnabled(false)

	local itemPanel = self:getView():getChildByFullName("mMainPanel.mainItem")

	self._sweepItemNum = itemPanel:getChildByFullName("labelGetNum")

	self._sweepItemNum:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._sweepItemIconNode = itemPanel:getChildByFullName("icon")
	self._sweepItemName = itemPanel:getChildByFullName("itemName")
	self._sweepItemText = itemPanel:getChildByFullName("labelGetText")

	self._sweepItemText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._sweepItemGet = itemPanel:getChildByFullName("labelGet")
	self._process = itemPanel:getChildByFullName("progress")

	self._process:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._touchPanel = self:getView():getChildByFullName("mMainPanel.touchPanel")

	if self._itemId then
		local itemIcon = IconFactory:createIcon({
			id = self._itemId
		})

		itemIcon:setScale(0.8)
		self._sweepItemIconNode:addChild(itemIcon)

		local goodsInfo = ConfigReader:requireRecordById("ItemConfig", tostring(self._itemId))

		self._sweepItemName:setString(Strings:get(goodsInfo.Name))
		GameStyle:setQualityText(self._sweepItemName, goodsInfo.Quality)
	else
		itemPanel:setVisible(false)
	end

	self:setPowerView()
end

function ExploreSweepMediator:setPowerView()
	local powerNode = self:getView():getChildByFullName("mMainPanel.powerNode")
	local textNode = self:getView():getChildByFullName("mMainPanel.powerNode.text_bg.text")
	local iconNode = self:getView():getChildByFullName("mMainPanel.powerNode.icon_node")

	iconNode:removeAllChildren()

	local level = self:getDevelopSystem():getPlayer():getLevel()

	self._bagSystem = self:getDevelopSystem():getBagSystem()

	local curPower, lastRecoverTime = self._bagSystem:getPower()
	local powerLimit = self._bagSystem:getRecoveryPowerLimit(level)
	local maxPowerLimit = self._bagSystem:getMaxPowerLimit()
	local text = math.min(curPower, maxPowerLimit) .. "/" .. powerLimit

	self:getView():getChildByFullName("mMainPanel.powerNode")
	textNode:setString(text)

	local goldIcon = IconFactory:createPic({
		id = CurrencyIdKind.kGold
	})
	local goldSize = goldIcon:getContentSize()
	local iconPic = IconFactory:createPic({
		id = "IR_Power"
	}, {
		showWidth = goldSize.height
	})

	if iconPic then
		iconPic:addTo(iconNode)
	end

	powerNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:powerBuyCall()
		end
	end)
end

function ExploreSweepMediator:powerBuyCall()
	local view = self:getInjector():getInstance("CurrencyBuyPopView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		_currencyType = CurrencyType.kActionPoint
	}, self))
end

function ExploreSweepMediator:refreshView()
	self._listView:removeAllChildren()

	local count = 0

	for _, _ in pairs(self._sweepData.reward) do
		local rewards = self._sweepData.reward[tostring(count)]

		count = count + 1

		local sweepLayout = ccui.Layout:create()
		local itemView = cc.CSLoader:createNode("asset/ui/BlockSweepItemNode.csb")
		local contentLayout = itemView:getChildByFullName("content")

		sweepLayout:addChild(itemView)
		itemView:offset(0, 7)
		itemView:setName("itemView")
		sweepLayout:setContentSize(contentLayout:getContentSize())

		local isRecomand = false
		local allReward = {}

		if rewards and rewards.recommend and #rewards.recommend > 0 then
			isRecomand = true

			for _, v in ipairs(rewards.recommend) do
				allReward[#allReward + 1] = v
			end
		end

		if rewards and rewards.normal and #rewards.normal > 0 then
			for _, v in ipairs(rewards.normal) do
				allReward[#allReward + 1] = v
			end
		end

		if rewards and rewards.actExtraRewards and #rewards.actExtraRewards > 0 then
			for _, v in ipairs(rewards.actExtraRewards) do
				allReward[#allReward + 1] = v
			end
		end

		table.sort(allReward, function(a, b)
			local aq = RewardSystem:getQuality(a)
			local bq = RewardSystem:getQuality(b)

			return bq < aq
		end)
		self:refreshSweepItemView(count, allReward, rewards.playerExp, itemView, isRecomand)
		sweepLayout:setOpacity(0)
		self._listView:pushBackCustomItem(sweepLayout)
	end

	self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
		times = math.min(self._sweepData.param.wipeTimes, self._exploreSystem:getEnterTimes())
	}))

	self._sweepCount = count

	local endLayout = ccui.Layout:create()
	local endView = cc.CSLoader:createNode("asset/ui/BlockSweepEndNode.csb")
	local endContentLayout = endView:getChildByFullName("content")

	endLayout:addChild(endView)

	local text = endView:getChildByFullName("content.content.Text")

	endLayout:setContentSize(endContentLayout:getContentSize())
	endLayout:setOpacity(0)

	if self._sweepData.param.wipeTimes == 1 then
		endContentLayout:offset(0, -120)
	end

	self._listView:pushBackCustomItem(endLayout)
	self._listView:jumpToPercentVertical(0)

	local container = self._listView:getInnerContainer()
	local moveToBottom = cc.MoveTo:create(count * 0.45, cc.p(0, 0))

	local function cellAction(cell)
		local itemPanel = cell:getChildByFullName("itemView.content.mDownLayout")
		local i = 1

		while true do
			local reward = itemPanel:getChildByName("reward" .. i)

			if reward then
				reward:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * (i - 1)), cc.FadeIn:create(0.15)))

				i = i + 1
			else
				break
			end
		end
	end

	self._touchPanel:setVisible(true)
	container:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), moveToBottom, cc.CallFunc:create(function()
		local items = self._listView:getItems()
		local endLayout = items[#items]

		endLayout:runAction(cc.FadeIn:create(0.6))
		self._sweepBtn:setVisible(true)
		self._comfirmBtn:setVisible(true)

		if self:checkTimesUp() then
			local mConfirmBtn = self:getView():getChildByFullName("mMainPanel.mConfirmBtn")

			mConfirmBtn:setPositionX(490)
			self._sweepBtn:setVisible(false)
		end

		self._touchPanel:setVisible(false)
	end)))
	self._listView:runAction(cc.CallFunc:create(function()
		local items = self._listView:getItems()

		for k, v in pairs(items) do
			if k <= count then
				local delayTime = 0.2
				local fadeInTime = 0.1

				if k == 1 then
					delayTime = 0
					fadeInTime = 0.01
				end

				v:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime + 0.2 * (k - 1)), cc.FadeIn:create(fadeInTime)))
				performWithDelay(self._listView, function()
					cellAction(v)
				end, 0.1 + 0.45 * (k - 1))
			end
		end
	end))

	if self._itemId then
		local hasItemNum = self:getDevelopSystem():getBagSystem():getItemCount(self._itemId)
		local curAmout = self._process:getChildByFullName("curAmout")

		curAmout:setString(hasItemNum)

		local targetAmout = self._process:getChildByFullName("targetAmout")

		targetAmout:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
		targetAmout:setString("/" .. self._needNum)

		if self._needNum <= 0 then
			self._process:setVisible(false)
		else
			self._process:setVisible(true)
		end

		local showNum = 0
		local textColor
		local textOutline = cc.c4b(0, 0, 0, 219.29999999999998)
		local showText

		if hasItemNum >= self._needNum then
			showNum = self:getSweepItemNum()
			textColor = kTextColor.Green
			showText = Strings:get("BLOCK_GET")
		else
			showNum = self:getSweepItemNum()
			textColor = kTextColor.Red
			showText = Strings:get("BLOCK_GET")
		end

		self._sweepItemGet:setString(showText)
		self._sweepItemNum:setString(showNum)
		curAmout:setTextColor(textColor)
		curAmout:enableOutline(textOutline, 1)
		targetAmout:setPositionX(curAmout:getPositionX() + curAmout:getContentSize().width + 3)
		self._sweepItemText:setPositionX(self._sweepItemNum:getPositionX() + self._sweepItemNum:getContentSize().width)
	end
end

function ExploreSweepMediator:refreshSweepItemView(index, rewards, exp, itemView, isRecomand)
	local fightTimesLabel = itemView:getChildByFullName("content.mTopLayout.mFightTimesLabel")
	local experienceLabel = itemView:getChildByFullName("content.mMidLayout.mExperienceLabel")
	local experienceNum = itemView:getChildByFullName("content.mMidLayout.mExperienceNum")
	local goldLabel = itemView:getChildByFullName("content.mMidLayout.mGoldLabel")
	local rewardLayout = itemView:getChildByFullName("content.mDownLayout")
	local icoIcon = itemView:getChildByFullName("content.mMidLayout.ico1")

	icoIcon:setVisible(false)

	if isRecomand then
		fightTimesLabel:setString(Strings:get("BigMap_RewardFast_Text01", {
			num = index
		}))
	else
		fightTimesLabel:setString(Strings:get("CUSTOM_FIGHT_TIMES", {
			times = index
		}))
	end

	experienceNum:setString(tostring(exp))
	goldLabel:setVisible(false)

	local space = 5
	local px = 0
	local scale = 0.55

	for i, v in ipairs(rewards) do
		local rewardInfo = {
			amount = v.amount,
			code = v.code,
			type = v.type
		}
		local child = IconFactory:createRewardIcon(rewardInfo, {
			isWidget = true
		})

		if child then
			IconFactory:bindTouchHander(child, IconTouchHandler:new(self), rewardInfo, {
				needDelay = true
			})
			child:setScaleNotCascade(scale)

			local size = cc.size(child:getContentSize().width * scale, child:getContentSize().height * scale)

			px = px + size.width / 2 + 3.5

			child:setPosition(cc.p(px, size.height / 2))
			rewardLayout:addChild(child)
			child:setOpacity(0)
			child:setName("reward" .. i)

			px = px + size.width / 2 + space
		end
	end

	rewardLayout:setInnerContainerSize(cc.size(px, 70))
	rewardLayout:setScrollBarEnabled(false)
end

function ExploreSweepMediator:getSweepItemNum()
	local num = 0
	local count = 0

	for _, _ in pairs(self._sweepData.reward) do
		local rewards = self._sweepData.reward[tostring(count)]

		count = count + 1

		if rewards and rewards.recommend and #rewards.recommend > 0 then
			for _, v in ipairs(rewards.recommend) do
				if v.code == self._itemId then
					num = num + v.amount
				end
			end
		end

		if rewards and rewards.normal and #rewards.normal > 0 then
			for _, v in ipairs(rewards.normal) do
				if v.code == self._itemId then
					num = num + v.amount
				end
			end
		end

		if rewards and rewards.actExtraRewards and #rewards.actExtraRewards > 0 then
			for _, v in ipairs(rewards.actExtraRewards) do
				if v.code == self._itemId then
					num = num + v.amount
				end
			end
		end
	end

	return num
end

function ExploreSweepMediator:checkTimesUp()
	local times = self._exploreSystem:getEnterTimes()

	if times <= 0 then
		return true
	end

	return false
end

function ExploreSweepMediator:onSweepBtn(sender, type)
	local pointData = self._exploreSystem:getMapPointObjById(self._sweepData.param.pointId)
	local costPower = pointData:getNeedPower()

	if self:getDevelopSystem():getEnergy() < costPower * self._sweepData.param.wipeTimes then
		self:powerBuyCall()

		return
	end

	self._sweepBtn:setVisible(false)
	self._comfirmBtn:setVisible(false)
	self._exploreSystem:requestSweepPoint(self._sweepData.param.pointId, math.min(self._exploreSystem:getEnterTimes(), self._sweepData.param.wipeTimes), function(response)
		if checkDependInstance(self) then
			local data = {}

			data.reward = response.data
			data.param = {
				pointId = self._sweepData.param.pointId,
				wipeTimes = math.min(self._exploreSystem:getEnterTimes(), self._sweepData.param.wipeTimes)
			}
			self._sweepData = data

			self:refreshView()
		end
	end, true)
end

function ExploreSweepMediator:onBackBtn(sender, type)
	self:close()
end

function ExploreSweepMediator:onConfirmBtn(sender, type)
	self:close()
end

function ExploreSweepMediator:onScrollListView(event)
	self:refreshCellVisible()
end

function ExploreSweepMediator:refreshCellVisible()
	local inner = self._listView:getChildren()

	for i = 1, #inner do
		local layout = inner[i]
		local worldPt = layout:getParent():convertToWorldSpace(cc.p(layout:getPosition()))
		local listPtY = self._listView:convertToNodeSpace(cc.p(worldPt)).y
		local isHide = listPtY < -3 - layout:getContentSize().height or listPtY > self._listView:getContentSize().height - 3

		layout:setVisible(not isHide)
	end
end

function ExploreSweepMediator:onSpeedUpSweep()
	self._touchPanel:setVisible(false)
	self._listView:stopAllActions()

	local items = self._listView:getItems()
	local remainTime = 0

	for k, v in pairs(items) do
		if k <= self._sweepCount then
			v:setOpacity(255)

			local itemPanel = v:getChildByFullName("itemView.content.mDownLayout")
			local i = 1

			while true do
				local reward = itemPanel:getChildByName("reward" .. i)

				if reward then
					if reward:getOpacity() > 0 then
						remainTime = k * 0.05
					end

					reward:setOpacity(255)

					i = i + 1
				else
					break
				end
			end
		end
	end

	local container = self._listView:getInnerContainer()

	container:stopAllActions()
	container:runAction(cc.Sequence:create(cc.MoveTo:create(0.5 - remainTime, cc.p(0, 0)), cc.CallFunc:create(function()
		local items = self._listView:getItems()
		local endLayout = items[#items]

		endLayout:runAction(cc.FadeIn:create(0.6))
		self._sweepBtn:setVisible(true)
		self._comfirmBtn:setVisible(true)

		if self:checkTimesUp() then
			local mConfirmBtn = self:getView():getChildByFullName("mMainPanel.mConfirmBtn")

			mConfirmBtn:setPositionX(490)
			self._sweepBtn:setVisible(false)
		end
	end)))
end

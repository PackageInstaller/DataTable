-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/CommonStageSweepMediator.lua

CommonStageSweepMediator = class("CommonStageSweepMediator", DmPopupViewMediator, _M)

CommonStageSweepMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
CommonStageSweepMediator:has("_developSystem", {
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

function CommonStageSweepMediator:initialize()
	super.initialize(self)
end

function CommonStageSweepMediator:dispose()
	self._developSystem:popPlayerLvlUpView()
	super.dispose(self)
end

function CommonStageSweepMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mMainPanel.mSweepBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("mMainPanel.mConfirmBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ENERGRY_SUCC, self, self.buyEnergyCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SWEEPPOWERCHANGE_SERVER, self, self.setPowerView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ENERGRY_SUCC, self, self.setPowerView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_RESETTIMES, self, self.setPowerView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_CLOSE_SWEEP, self, self.closeViewByCooperateBoss)
end

function CommonStageSweepMediator:onRemove()
	super.onRemove(self)
end

function CommonStageSweepMediator:enterWithData(data)
	self._sweepData = data
	self._sweepData.rewardGold = self._sweepData.rewardGold or 0
	self._sweepData.extraReward = self._sweepData.extraReward or {}
	self._needNum = data.needNum or 0
	self._itemId = data.itemId
	self._showCooperateBoss = false

	self:initWidget()
	self:refreshView()
end

function CommonStageSweepMediator:initWidget()
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

	local pointId = self._sweepData.param.pointId
	local point = self._stageSystem:getPointById(pointId)

	if self._sweepData.param.wipeTimes == 1 then
		self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
			times = 1
		}))
	elseif point:getType() == StageType.kNormal then
		self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
			times = 10
		}))
	else
		self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
			times = 5
		}))
	end

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

function CommonStageSweepMediator:setPowerView()
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

function CommonStageSweepMediator:powerBuyCall()
	local view = self:getInjector():getInstance("CurrencyBuyPopView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		_currencyType = CurrencyType.kActionPoint
	}, self))
end

function CommonStageSweepMediator:refreshView()
	self._listView:removeAllChildren()

	local count = 0
	local hasItemNum = self:getDevelopSystem():getBagSystem():getItemCount(self._itemId)

	for index, rewards in ipairs(self._sweepData.rewardItems) do
		local allReward = table.deepcopy(rewards)
		local sweepLayout = ccui.Layout:create()
		local itemView = cc.CSLoader:createNode("asset/ui/BlockSweepItemNode.csb")
		local contentLayout = itemView:getChildByFullName("content")

		sweepLayout:addChild(itemView)
		itemView:offset(0, 7)
		itemView:setName("itemView")
		sweepLayout:setContentSize(contentLayout:getContentSize())

		if self._sweepData.activityExtraReward then
			local actExtraReward = self._sweepData.activityExtraReward[index]

			for _, v in ipairs(actExtraReward) do
				allReward[#allReward + 1] = v
			end
		end

		self:refreshSweepItemView(index, allReward, itemView)
		sweepLayout:setOpacity(0)
		self._listView:pushBackCustomItem(sweepLayout)

		count = count + 1
	end

	self._sweepCount = count

	local endLayout = ccui.Layout:create()
	local endView = cc.CSLoader:createNode("asset/ui/BlockSweepEndNode.csb")
	local endContentLayout = endView:getChildByFullName("content")

	endLayout:addChild(endView)

	local text = endView:getChildByFullName("content.content.Text")

	if count < self._sweepData.param.wipeTimes and hasItemNum >= self._needNum and self._needNum ~= 0 then
		text:setString(Strings:get("Sweep_Target_AllDone"))
	end

	endLayout:setContentSize(endContentLayout:getContentSize())
	endLayout:setOpacity(0)

	if #self._sweepData.extraReward ~= 0 then
		local extraLayout = ccui.Layout:create()
		local extraView = cc.CSLoader:createNode("asset/ui/BlockSweepExtraNode.csb")
		local extraContentLayout = extraView:getChildByFullName("content")

		extraLayout:addChild(extraView)
		extraView:setName("extraView")
		extraView:setPosition(cc.p(0, -120))
		extraLayout:setContentSize(extraContentLayout:getContentSize())
		self:refreshExtraItemView(extraView)
		self._listView:pushBackCustomItem(extraLayout)
	else
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

		if #self._sweepData.extraReward ~= 0 then
			local extraLayout = items[#items - 1]
			local extraView = extraLayout:getChildByName("extraView")

			extraLayout:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				extraView:runAction(cc.MoveTo:create(0.2, cc.p(0, 0)))
			end), cc.CallFunc:create(function()
				self._developSystem:popPlayerLvlUpView()

				local i = 1

				while true do
					local itemPanel = extraView:getChildByFullName("content.mDownLayout")
					local reward = itemPanel:getChildByName("reward" .. i)

					if reward then
						reward:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + 0.15 * (i - 1)), cc.FadeIn:create(0.1)))

						i = i + 1
					else
						if self._showCooperateBoss then
							performWithDelay(self:getView(), function()
								self:close()
							end, 0.1)
						end

						break
					end
				end
			end)))
		end

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

function CommonStageSweepMediator:refreshSweepItemView(index, rewards, itemView)
	local curwipeTimes = #self._sweepData.rewardItems
	local fightTimesLabel = itemView:getChildByFullName("content.mTopLayout.mFightTimesLabel")
	local experienceLabel = itemView:getChildByFullName("content.mMidLayout.mExperienceLabel")
	local experienceNum = itemView:getChildByFullName("content.mMidLayout.mExperienceNum")
	local goldLabel = itemView:getChildByFullName("content.mMidLayout.mGoldLabel")
	local rewardLayout = itemView:getChildByFullName("content.mDownLayout")

	rewardLayout:setScrollBarEnabled(false)
	fightTimesLabel:setString(Strings:get("CUSTOM_FIGHT_TIMES", {
		times = index
	}))
	experienceLabel:setString(Strings:get("CUSTOM_FIGHT_EXP"))
	experienceNum:setString(" " .. self._sweepData.rewardPlayerExp / curwipeTimes)
	goldLabel:setString(" " .. self._sweepData.rewardGold / curwipeTimes)

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
end

function CommonStageSweepMediator:refreshExtraItemView(itemView)
	local extraRewardLabel = itemView:getChildByFullName("content.mTopLayout.mExtraRewardLabel")
	local rewardLayout = itemView:getChildByFullName("content.mDownLayout")

	extraRewardLabel:setString(Strings:find("CUSTOM_FIGHT_ADDTIONAL_REWARD"))

	local _tab = self._sweepData.extraReward

	for k, v in ipairs(_tab) do
		v.config = ConfigReader:getRecordById("ItemConfig", v.code)
	end

	table.sort(_tab, function(a, b)
		local aCfg = a.config
		local bCfg = b.config

		if aCfg.Quality == bCfg.Quality then
			return aCfg.Sort > bCfg.Sort
		else
			return aCfg.Quality > bCfg.Quality
		end
	end)

	for i, v in ipairs(self._sweepData.extraReward) do
		local rewardInfo = {
			amount = v.amount,
			code = v.code,
			type = v.type
		}
		local scale = 0.55
		local child = IconFactory:createRewardIcon(rewardInfo, {
			isWidget = true
		})

		if child then
			IconFactory:bindTouchHander(child, IconTouchHandler:new(self), rewardInfo, {
				needDelay = true
			})
			child:setScaleNotCascade(scale)
			child:setPosition(cc.p((i - 1) * 70 + 35, rewardLayout:getContentSize().height / 2))
			rewardLayout:addChild(child)
			child:setName("reward" .. i)
			child:setOpacity(0)
		end
	end
end

function CommonStageSweepMediator:getSweepItemNum()
	local num = 0

	for k, v in pairs(self._sweepData.rewardItems) do
		for _, rewards in pairs(v) do
			if rewards.code == self._itemId then
				num = num + rewards.amount
			end
		end
	end

	return num
end

function CommonStageSweepMediator:checkTimesUp()
	self._point = self:getStageSystem():getPointById(self._sweepData.param.pointId)

	if not self._point then
		return true
	end

	if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
		return true
	end

	return false
end

function CommonStageSweepMediator:onSweepBtn(sender, type)
	local cfg = self._stageSystem:getPointConfigById(self._sweepData.param.pointId)

	if self:getDevelopSystem():getEnergy() < cfg.StaminaCost then
		self:powerBuyCall()

		return
	end

	self._sweepBtn:setVisible(false)
	self._comfirmBtn:setVisible(false)

	local wipeTarget
	local hasItemNum = self:getDevelopSystem():getBagSystem():getItemCount(self._itemId)

	self._stageSystem:requestStageSweep(self._sweepData.param.mapId, self._sweepData.param.pointId, self._sweepData.param.wipeTimes, (hasItemNum < self._needNum or nil) and {
		[self._itemId] = self._needNum
	}, function(data)
		if checkDependInstance(self) then
			data.param = self._sweepData.param
			self._sweepData = data

			self:refreshView()
		end
	end, true)
end

function CommonStageSweepMediator:onBackBtn(sender, type)
	self:close()
end

function CommonStageSweepMediator:onConfirmBtn(sender, type)
	self:close()
end

function CommonStageSweepMediator:buyEnergyCallback()
	return
end

function CommonStageSweepMediator:onScrollListView(event)
	self:refreshCellVisible()
end

function CommonStageSweepMediator:refreshCellVisible()
	local inner = self._listView:getChildren()

	for i = 1, #inner do
		local layout = inner[i]
		local worldPt = layout:getParent():convertToWorldSpace(cc.p(layout:getPosition()))
		local listPtY = self._listView:convertToNodeSpace(cc.p(worldPt)).y
		local isHide = listPtY < -3 - layout:getContentSize().height or listPtY > self._listView:getContentSize().height - 3

		layout:setVisible(not isHide)
	end
end

function CommonStageSweepMediator:onSpeedUpSweep()
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

		if #self._sweepData.extraReward ~= 0 then
			local extraLayout = items[#items - 1]
			local extraView = extraLayout:getChildByName("extraView")

			extraLayout:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				extraView:runAction(cc.MoveTo:create(0.2, cc.p(0, 0)))
			end), cc.CallFunc:create(function()
				self._developSystem:popPlayerLvlUpView()

				local i = 1

				while true do
					local itemPanel = extraView:getChildByFullName("content.mDownLayout")
					local reward = itemPanel:getChildByName("reward" .. i)

					if reward then
						reward:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + 0.15 * (i - 1)), cc.FadeIn:create(0.1)))

						i = i + 1
					else
						break
					end
				end
			end)))
		end

		self._sweepBtn:setVisible(true)
		self._comfirmBtn:setVisible(true)

		if self:checkTimesUp() then
			local mConfirmBtn = self:getView():getChildByFullName("mMainPanel.mConfirmBtn")

			mConfirmBtn:setPositionX(490)
			self._sweepBtn:setVisible(false)
		end

		if self._showCooperateBoss then
			performWithDelay(self:getView(), function()
				self:close()
			end, 0.1)
		end
	end)))
end

function CommonStageSweepMediator:closeViewByCooperateBoss()
	if DisposableObject:isDisposed(self) and DisposableObject:isDisposed(self:getView()) then
		return
	end

	self._showCooperateBoss = true
end

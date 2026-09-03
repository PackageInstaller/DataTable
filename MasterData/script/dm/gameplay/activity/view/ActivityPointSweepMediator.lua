-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityPointSweepMediator.lua

ActivityPointSweepMediator = class("ActivityPointSweepMediator", DmPopupViewMediator, _M)

ActivityPointSweepMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityPointSweepMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityPointSweepMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

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

function ActivityPointSweepMediator:initialize()
	super.initialize(self)
end

function ActivityPointSweepMediator:dispose()
	self._developSystem:popPlayerLvlUpView()
	super.dispose(self)
end

function ActivityPointSweepMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mMainPanel.mSweepBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("mMainPanel.mConfirmBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ENERGRY_SUCC, self, self.buyEnergyCallback)
end

function ActivityPointSweepMediator:onRemove()
	super.onRemove(self)
end

function ActivityPointSweepMediator:enterWithData(data)
	self._activityId = data.param.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._model = self._activity:getBlockMapActivity()
	self._sweepData = data
	self._sweepData.extraReward = self._sweepData.extraReward or {}
	self._needNum = data.needNum or 0
	self._itemId = data.itemId

	self:initWidget()
	self:refreshView()
end

function ActivityPointSweepMediator:initWidget()
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

	if self._sweepData.param.wipeTimes == 1 then
		self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
			times = 1
		}))
	else
		self._sweepLabel:setString(Strings:get("CUSTOM_SWEEP_AGAIN", {
			times = 10
		}))
	end

	self._comfirmLabel:setString(Strings:find("CUSTOM_CONFIRM"))
	self._listView:setScrollBarEnabled(false)

	local itemPanel = self:getView():getChildByFullName("mMainPanel.mainItem")
	local powerNode = self:getView():getChildByFullName("mMainPanel.powerNode")

	if powerNode then
		powerNode:setVisible(false)
	end

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
end

function ActivityPointSweepMediator:refreshView()
	self._listView:removeAllChildren()

	local count = 0
	local hasItemNum = self:getDevelopSystem():getBagSystem():getItemCount(self._itemId)

	for index, rewards in ipairs(self._sweepData.data.rewardList) do
		local extrarewards = rewards.heroExtraReward
		local allReward = table.deepcopy(rewards)

		for k, v in pairs(extrarewards or {}) do
			for _k, _v in pairs(allReward.itemRewards) do
				if _v.code == v.code then
					allReward.itemRewards[_k].amount = _v.amount + v.amount

					break
				end
			end
		end

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

	if self._sweepData.extraReward and #self._sweepData.extraReward ~= 0 then
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
		endContentLayout:offset(0, self._sweepCount == 1 and -120 or 0)
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

		if self._sweepData.extraReward and #self._sweepData.extraReward ~= 0 then
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

function ActivityPointSweepMediator:refreshSweepItemView(index, rewards, itemView)
	local curwipeTimes = #self._sweepData.data.rewardList
	local fightTimesLabel = itemView:getChildByFullName("content.mTopLayout.mFightTimesLabel")
	local experienceLabel = itemView:getChildByFullName("content.mMidLayout.mExperienceLabel")
	local experienceNum = itemView:getChildByFullName("content.mMidLayout.mExperienceNum")
	local goldLabel = itemView:getChildByFullName("content.mMidLayout.mGoldLabel")
	local rewardLayout = itemView:getChildByFullName("content.mDownLayout")

	fightTimesLabel:setString(Strings:get("CUSTOM_FIGHT_TIMES", {
		times = index
	}))
	experienceLabel:setString(Strings:get("CUSTOM_FIGHT_EXP"))
	experienceNum:setVisible(false)
	experienceLabel:setVisible(false)

	if self._sweepData.rewardPlayerExp then
		experienceNum:setString(" " .. self._sweepData.rewardPlayerExp / curwipeTimes)
		experienceNum:setVisible(true)
		experienceLabel:setVisible(true)
	end

	goldLabel:setVisible(false)

	if rewards.goldReward then
		goldLabel:setString(" " .. rewards.goldReward / curwipeTimes)
		goldLabel:setVisible(true)
	end

	local space = 5
	local px = 0
	local scale = 0.55
	local showRewards = rewards.itemRewards

	if rewards.activityExtraReward then
		for i, v in pairs(rewards.activityExtraReward) do
			v.isActivityExtra = true
			showRewards[#showRewards + 1] = v
		end
	end

	for i, v in ipairs(showRewards) do
		local rewardInfo = {
			amount = v.amount,
			code = v.code,
			type = v.type
		}

		if v.amount > 0 then
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

				if v.isActivityExtra then
					local markImg = ccui.ImageView:create("asset/common/shaungdan_img_xianshidiaoluojiaobiao.png")

					markImg:addTo(child, 10000):posite(45, 95):setScale(1.2)

					local text = ccui.Text:create(Strings:get("Newyear_Item_LimitedTimeDrop"), TTF_FONT_FZYH_M, 18)

					text:addTo(markImg):center(markImg:getContentSize()):offset(-3, 3)
				end
			end
		end
	end
end

function ActivityPointSweepMediator:refreshExtraItemView(itemView)
	local extraRewardLabel = itemView:getChildByFullName("content.mTopLayout.mExtraRewardLabel")
	local rewardLayout = itemView:getChildByFullName("content.mDownLayout")

	extraRewardLabel:setString(Strings:find("CUSTOM_FIGHT_ADDTIONAL_REWARD"))

	if not self._sweepData.extraReward then
		for k, v in ipairs(self._sweepData.extraReward) do
			v.config = ConfigReader:getRecordById("ItemConfig", v.code)
		end

		table.sort(self._sweepData.extraReward, function(a, b)
			local aCfg = a.config
			local bCfg = b.config

			if aCfg.Quality == bCfg.Quality then
				return aCfg.Sort > bCfg.Sort
			else
				return aCfg.Quality > bCfg.Quality
			end
		end)

		for i, v in ipairs(self._sweepData.extraReward or {}) do
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
end

function ActivityPointSweepMediator:getSweepItemNum()
	local num = 0

	for k, v in pairs(self._sweepData.data.rewardList) do
		for _, rewards in pairs(v) do
			if type(rewards) == "table" then
				for _, reward in pairs(rewards) do
					if reward.code == self._itemId then
						num = num + reward.amount
					end
				end
			end
		end
	end

	return num
end

function ActivityPointSweepMediator:checkTimesUp()
	if self._model:getType() == ActivityType.KActivityBlockMapNew then
		self._point = self._model:getSubPointById(self._sweepData.param.pointId)
		self._type = self._sweepData.param.type
	else
		self._point = self._model:getPointById(self._sweepData.param.pointId)
		self._type = litTypeMap[self._model:getStageTypeById(self._sweepData.param.pointId)]
	end

	return self:getMaxSwipCount() <= 0
end

function ActivityPointSweepMediator:getMaxSwipCount()
	local itemId, cost
	local costEnergy = self._point:getCostEnergy()

	for k, v in pairs(costEnergy) do
		itemId = k
		cost = tonumber(v)

		break
	end

	local config = PowerConfigMap[itemId]

	if not config and DEBUG ~= 0 then
		config = PowerConfigMap.TEST
	end

	return math.modf(((config or nil) and self._bagSystem[config.func](self._bagSystem, itemId)) / cost)
end

function ActivityPointSweepMediator:onSweepBtn(sender, type)
	local cfg = ConfigReader:getRecordById("ActivityBlockPoint", self._sweepData.param.pointId)

	if self:getMaxSwipCount() <= 0 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
		}))

		return
	end

	self._sweepBtn:setVisible(false)
	self._comfirmBtn:setVisible(false)

	local param = {}

	param.type = self._type
	param.doActivityType = 107
	param.mapId = self._sweepData.param.mapId
	param.pointId = self._sweepData.param.pointId

	local maxNum = self:getMaxSwipCount()

	param.times = math.min(self._sweepData.param.wipeTimes, maxNum)

	self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), param, function(data)
		if checkDependInstance(self) then
			data.param = self._sweepData.param
			self._sweepData = data

			self:refreshView()
		end
	end)
end

function ActivityPointSweepMediator:onBackBtn(sender, type)
	self:close()
end

function ActivityPointSweepMediator:onConfirmBtn(sender, type)
	self:close()
end

function ActivityPointSweepMediator:buyEnergyCallback()
	return
end

function ActivityPointSweepMediator:onScrollListView(event)
	self:refreshCellVisible()
end

function ActivityPointSweepMediator:refreshCellVisible()
	local inner = self._listView:getChildren()

	for i = 1, #inner do
		local layout = inner[i]
		local worldPt = layout:getParent():convertToWorldSpace(cc.p(layout:getPosition()))
		local listPtY = self._listView:convertToNodeSpace(cc.p(worldPt)).y
		local isHide = listPtY < -3 - layout:getContentSize().height or listPtY > self._listView:getContentSize().height - 3

		layout:setVisible(not isHide)
	end
end

function ActivityPointSweepMediator:onSpeedUpSweep()
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

		if self._sweepData.extraReward and #self._sweepData.extraReward ~= 0 then
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
	end)))
end

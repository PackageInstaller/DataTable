-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/FreeStaminaActivityMediator.lua

FreeStaminaActivityMediator = class("FreeStaminaActivityMediator", BaseActivityMediator, _M)

FreeStaminaActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
FreeStaminaActivityMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function FreeStaminaActivityMediator:initialize()
	super.initialize(self)
end

function FreeStaminaActivityMediator:dispose()
	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end

	super.dispose(self)
end

function FreeStaminaActivityMediator:onRemove()
	super.onRemove(self)
end

function FreeStaminaActivityMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
end

function FreeStaminaActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator
	self._dataList = self._activity:getActivityConfig().FreeStamina
	self._bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()

	self:setupView()
end

function FreeStaminaActivityMediator:setupView()
	local roleModelId = {
		"Model_Story_FTLEShi01",
		"Model_Story_CLMan01",
		"Model_Story_ZTXChang01"
	}
	local pos = {
		{
			150,
			73
		},
		{
			140,
			120
		},
		{
			150,
			100
		}
	}

	for i = 1, 3 do
		local data = self._dataList[i]
		local panel = self._main:getChildByName("Panel_" .. i)
		local roleNode = panel:getChildByName("rolepanel")
		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			iconType = 2,
			id = roleModelId[i]
		})

		img:setScale(0.91)
		img:addTo(roleNode):posite(pos[i][1], pos[i][2])

		local rewardNode = panel:getChildByName("reward")
		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", data.Reward, "Content")
		local scale = 0.5
		local count = #rewards
		local cellWidth = 70
		local offset = count * (cellWidth * 0.5) - 8

		for i = 1, 4 do
			local reward = rewards[i]

			if reward then
				local rewardIcon = IconFactory:createRewardIcon(reward, {
					showAmount = true,
					isWidget = true
				})

				rewardIcon:setAnchorPoint(0, 0.5)
				rewardIcon:addTo(rewardNode):posite((i - 1) * cellWidth - offset, 0)
				rewardIcon:setScaleNotCascade(scale)
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
					swallowTouches = true
				})
			end
		end

		local timeText = panel:getChildByName("Text_time")
		local time1 = self:getRealGetTime(data.Time[1])
		local time2 = self:getRealGetTime(data.Time[2])
		local timeStr1 = TimeUtil:localDate("%H:%M", time1)
		local timeStr2 = TimeUtil:localDate("%H:%M", time2)

		timeText:setString(timeStr1 .. "-" .. timeStr2)

		local richText = ccui.RichText:createWithXML("", {})

		richText:addTo(panel):setName("descText")
		richText:setAnchorPoint(cc.p(0.5, 0.5))
		richText:posite(153, 83)

		local getBtn = panel:getChildByName("btn_get")

		getBtn:getChildByName("Text_name"):setAdditionalKerning(4)

		local function getFunc()
			self:onClickGet(data.Order)
		end

		mapButtonHandlerClick(nil, getBtn, {
			func = getFunc
		})

		local buyBtn = panel:getChildByName("btn_buy")

		buyBtn:getChildByName("Text_name"):setAdditionalKerning(4)

		local function buyFunc()
			self:onClickBuy(data.Order)
		end

		mapButtonHandlerClick(nil, buyBtn, {
			func = buyFunc
		})
	end

	self:refreshView()
	self:startTimer()
end

function FreeStaminaActivityMediator:startTimer()
	local function update()
		for i = 1, 3 do
			local panel = self._main:getChildByName("Panel_" .. i)
			local data = self._dataList[i]
			local receiveStatus = self._activity:getRewardStatusByIndex(data.Order)
			local status, canDiamondGet = self._activitySystem:isCanGetStamina(data.Time, data.Order)
			local descText = panel:getChildByName("descText")

			descText:setVisible(false)

			if canDiamondGet then
				descText:setVisible(true)
				descText:setString(Strings:get("FreeStamina_Cost", {
					num = self._activity:getActivityConfig().Replacement,
					fontName = TTF_FONT_FZYH_M
				}))
			elseif not canDiamondGet and status == StaminaRewardTimeStatus.kAfter and receiveStatus == ActivityTaskStatus.kUnfinish then
				descText:setVisible(true)

				local currentTime = self._gameServerAgent:remoteTimestamp()
				local targetTime = self:getRealGetTime(data.Time[1])
				local remainTime = targetTime - currentTime
				local timeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

				descText:setString(Strings:get("FreeStamina_Count", {
					time = timeStr,
					fontName = TTF_FONT_FZYH_M
				}))
			end

			self:refreshView()
		end
	end

	self._timeScheduler = LuaScheduler:getInstance():schedule(update, 1, true)
end

function FreeStaminaActivityMediator:getRealGetTime(dateStr)
	local timeList = string.split(dateStr, ":")
	local currentTime = self._gameServerAgent:remoteTimestamp()
	local currentRemoteDate = TimeUtil:remoteDate("*t", currentTime)

	currentRemoteDate.hour = timeList[1]
	currentRemoteDate.min = timeList[2]
	currentRemoteDate.sec = timeList[3]

	return (TimeUtil:timeByRemoteDate(currentRemoteDate))
end

function FreeStaminaActivityMediator:refreshView()
	for i = 1, 3 do
		local data = self._dataList[i]
		local panel = self._main:getChildByName("Panel_" .. i)
		local receiveStatus = self._activity:getRewardStatusByIndex(data.Order)
		local status, canDiamondGet = self._activitySystem:isCanGetStamina(data.Time, data.Order)
		local getImg = panel:getChildByName("Image_hasget")

		getImg:setVisible(receiveStatus == ActivityTaskStatus.kGet)

		local getBtn = panel:getChildByName("btn_get")
		local buyBtn = panel:getChildByName("btn_buy")

		getBtn:setVisible(status == StaminaRewardTimeStatus.kNow or not canDiamondGet and status == StaminaRewardTimeStatus.kAfter and receiveStatus == ActivityTaskStatus.kUnfinish)
		buyBtn:setVisible(canDiamondGet)
		getBtn:setGray(status == StaminaRewardTimeStatus.kAfter)
	end
end

function FreeStaminaActivityMediator:onClickGet(index)
	local data = self._dataList[index]
	local status = self._activitySystem:isCanGetStamina(data.Time, data.Order)

	if status == StaminaRewardTimeStatus.kNow then
		local param = {
			doActivityType = 101,
			index = index
		}

		self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
			self:refreshView()
			self:showRewardView(response)
		end)
	end
end

function FreeStaminaActivityMediator:onClickBuy(index)
	local costCount = self._activity:getActivityConfig().Replacement
	local data = {
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("FreeStamina_FindConfirm", {
			num = costCount,
			fontName = TTF_FONT_FZYH_M
		}),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" and outSelf._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, costCount, {
			type = "tip"
		}) then
			local param = {
				doActivityType = 102,
				index = index
			}

			outSelf._activitySystem:requestDoActivity(outSelf._activity:getId(), param, function(response)
				outSelf:refreshView()
				outSelf:showRewardView(response)
			end)
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function FreeStaminaActivityMediator:showRewardView(response)
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ShowTipEvent({
		tip = Strings:get("Daily_Gift_Get")
	}))
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		needClick = true,
		rewards = response.data.reward
	}))
end

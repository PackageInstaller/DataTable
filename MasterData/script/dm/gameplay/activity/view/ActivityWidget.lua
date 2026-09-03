-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityWidget.lua

ActivityCountdownWidget = class("ActivityCountdownWidget", BaseWidget, _M)

ActivityCountdownWidget:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityCountdownWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActTime.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityCountdownWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityCountdownWidget:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ActivityCountdownWidget:initSubviews(view)
	self._view = view
	self._timeText = view:getChildByName("Text_1")
	self._titleText = view:getChildByName("Text_title")
end

function ActivityCountdownWidget:setTime(data)
	if self._titleText and data.title then
		self._titleText:setString("【" .. data.title .. "】")
	end

	self:updateTime(data)

	if data.icon then
		local icon = self._view:getChildByName("Image_icon")

		if icon then
			icon:loadTexture(data.icon, ccui.TextureResType.plistType)
		end
	end
end

function ActivityCountdownWidget:updateTime(data)
	if self._timeText and self._timer == nil then
		local function update()
			local remainTime = self._activitySystem:getActivityRemainTime(data.activityId)

			self._timeText:setString(TimeUtil:formatTime(Strings:get("ActivityCommon_UI01"), remainTime * 0.001))
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

		update()
	end
end

ActivityRemainTimeWidget = class("ActivityRemainTimeWidget", BaseWidget, _M)

ActivityRemainTimeWidget:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityRemainTimeWidget.class:createWidgetNode(style)
	local resFile

	return cc.CSLoader:createNode(style == 2 and "asset/ui/ActRemainTime1.csb" or "asset/ui/ActRemainTime.csb")
end

function ActivityRemainTimeWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityRemainTimeWidget:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ActivityRemainTimeWidget:initSubviews(view)
	self._view = view
	self._title = view:getChildByName("title")
	self._bigNum = view:getChildByName("bigNum")
	self._unit1 = view:getChildByName("unit1")
	self._smallNum = view:getChildByName("smallNum")

	self:setTextEffect(self._title)
	self:setTextEffect(self._bigNum)
	self:setTextEffect(self._unit1)
	self:setTextEffect(self._smallNum)
end

function ActivityRemainTimeWidget:setTextEffect(view)
	local lineGradiantVec2 = {
		{
			ratio = 0.7,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.3,
			color = cc.c4b(206, 222, 255, 255)
		}
	}

	view:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	if view == self._title then
		view:enableOutline(cc.c4b(4, 14, 28, 147.89999999999998), 1)
	else
		view:enableOutline(cc.c4b(80, 40, 20, 219.29999999999998), 1)
	end
end

function ActivityRemainTimeWidget:updateTime(data)
	if self._timer == nil then
		local function update()
			local fmtStr = "${d}:${H}:${M}:${S}"
			local remainTime = self._activitySystem:getActivityRemainTime(data.activityId)
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime * 0.001)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			if timeTab.day > 0 then
				self._bigNum:setString(timeTab.day)
				self._unit1:setString(Strings:get("TimeUtil_Day"))
				self._smallNum:setString(timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min"))
			else
				self._bigNum:setString(timeTab.hour)
				self._unit1:setString(Strings:get("TimeUtil_Hour"))
				self._smallNum:setString(timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

		update()
	end
end

ActivityTimeWidget = class("ActivityTimeWidget", BaseWidget, _M)

function ActivityTimeWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActDesc.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityTimeWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityTimeWidget:dispose()
	super.dispose(self)
end

function ActivityTimeWidget:initSubviews(view)
	self._view = view
	self._timeText = view:getChildByName("Text_1")
	self._titleText = view:getChildByName("Text_title")

	self._titleText:enableOutline(cc.c4b(3, 1, 4, 255), 1)
	self._timeText:enableOutline(cc.c4b(3, 1, 4, 255), 1)
end

function ActivityTimeWidget:setTime(data)
	local dateStart = TimeUtil:localDate("*t", data.startTime * 0.001)
	local dateEnd = TimeUtil:localDate("*t", data.endTime * 0.001)

	self._timeText:setString(dateStart.year .. "." .. dateStart.month .. "." .. dateStart.day .. "-" .. dateEnd.year .. "." .. dateEnd.month .. "." .. dateEnd.day)
	self._timeText:setAdditionalKerning(2)

	if self._titleText and data.title then
		self._titleText:setString(data.title .. " :")
	end
end

ActivityDescWidget = class("ActivityDescWidget", BaseWidget, _M)

function ActivityDescWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActDesc.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityDescWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityDescWidget:dispose()
	super.dispose(self)
end

function ActivityDescWidget:initSubviews(view)
	self._view = view
	self._descText = view:getChildByName("Text_1")
	self._titleText = view:getChildByName("Text_title")
end

function ActivityDescWidget:setDesc(data)
	self._descText:setString(data.desc)

	if data.isReset then
		self._descText:setVisible(false)

		local str = Strings:get("ActivityCommon_UI15", {
			desc = data.desc,
			fontName = TTF_FONT_FZYH_M
		}) .. " " .. Strings:get("ActivityCommon_UI16", {
			fontName = TTF_FONT_FZYH_M
		})

		if not self._resetText then
			self._resetText = ccui.RichText:createWithXML(str, {})

			self._resetText:setAnchorPoint(cc.p(0, 1))
			self._resetText:addTo(self._view):posite(67, 38)
			self._resetText:renderContent(self._descText:getContentSize().width, 0)
		end

		self._resetText:setString(str)
	end

	if self._titleText and data.title then
		self._titleText:setString(data.title)
	end
end

ActivityTaskCellWidget = class("ActivityTaskCellWidget", BaseWidget, _M)

ActivityTaskCellWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
ActivityTaskCellWidget:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityTaskCellWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActTaskCell.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityTaskCellWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityTaskCellWidget:getView()
	return self._view
end

function ActivityTaskCellWidget:dispose()
	super.dispose(self)
end

function ActivityTaskCellWidget:initSubviews(view)
	self._view = view
	self._conditionText = self._view:getChildByName("Text_condition")
	self._curText = self._view:getChildByName("Text_curvalue")
	self._targetText = self._view:getChildByName("Text_target")
	self._actBtn = self._view:getChildByName("btn_act")
	self._gotImage = self._view:getChildByName("Image_got")

	self._actBtn:setSwallowTouches(false)
end

function ActivityTaskCellWidget:setupView(data, info)
	self._mediator = info.mediator
	self._parentMediator = info.parentMediator
	self._activityId = info.activityId
	self._data = data

	local rewardPanel = self._view:getChildByName("icon")
	local rewards = data:getReward()

	if rewards and rewards.Content then
		for i, rewardData in pairs(rewards.Content) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setScaleNotCascade(0.56)
			icon:addTo(rewardPanel):posite(40 + (i - 1) * 76.3, 38)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
				needDelay = true
			})
		end
	end

	self:updateView(data)
end

local kTaskStatusTextMap = {
	[ActivityTaskStatus.kUnfinish] = Strings:get("SOURCE_DESC2"),
	[ActivityTaskStatus.kFinishNotGet] = Strings:get("Task_UI11")
}
local kTaskStatusColorMap = {
	[ActivityTaskStatus.kUnfinish] = cc.c3b(223, 255, 46),
	[ActivityTaskStatus.kFinishNotGet] = cc.c3b(255, 255, 255)
}

function ActivityTaskCellWidget:updateView(data)
	self._data = data

	local conditionList = data:getCondition()
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local desc = conditionkeeper:getConditionDesc(conditionList[1])

	self._conditionText:setString(desc .. " :")

	local taskValueList = data:getTaskValueList()

	self._curText:setString(taskValueList[1].currentValue)
	self._targetText:setString("/" .. taskValueList[1].targetValue)
	self._curText:setPositionX(self._targetText:getPositionX() - self._targetText:getContentSize().width)
	self._conditionText:setPositionX(self._curText:getPositionX() - self._curText:getContentSize().width - 4)

	local status = data:getStatus()

	self._curText:setVisible(true)
	self._targetText:setVisible(true)
	self._conditionText:setVisible(true)
	self._actBtn:setVisible(true)
	self._gotImage:setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		local text = self._actBtn:getChildByName("Text_str")

		text:setString(kTaskStatusTextMap[status])

		if data:getDestUrl() ~= nil and data:getDestUrl() ~= "" then
			local function callFuncGo(sender, eventType)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					self:onClickGo()
				end
			end

			mapButtonHandlerClick(nil, self._actBtn, {
				func = callFuncGo
			})
		end

		self._actBtn:loadTextureNormal("common_btn_s02.png", ccui.TextureResType.plistType)
		self._actBtn:loadTexturePressed("common_btn_s02.png", ccui.TextureResType.plistType)
	elseif status == ActivityTaskStatus.kFinishNotGet then
		local text = self._actBtn:getChildByName("Text_str")

		text:setString(kTaskStatusTextMap[status])
		self._actBtn:setGray(false)

		local function callFuncGo(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClickGet()
			end
		end

		self._actBtn:loadTextureNormal("common_btn_s01.png", ccui.TextureResType.plistType)
		self._actBtn:loadTexturePressed("common_btn_s01.png", ccui.TextureResType.plistType)
		mapButtonHandlerClick(nil, self._actBtn, {
			func = callFuncGo
		})
	else
		self._curText:setVisible(false)
		self._targetText:setVisible(false)
		self._conditionText:setVisible(false)
		self._actBtn:setVisible(false)
		self._gotImage:setVisible(true)
	end
end

function ActivityTaskCellWidget:onClickGo()
	local url = self._data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityTaskCellWidget:onClickGet()
	local status = self._data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		taskId = self._data:getId()
	}

	self._activitySystem:requestDoActivity(self._activityId, data, function(response)
		self._mediator:showRewardView(response.data, data)
	end)
end

ActivityExchangeCellWidget = class("ActivityExchangeCellWidget", BaseWidget, _M)

ActivityExchangeCellWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
ActivityExchangeCellWidget:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityExchangeCellWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ActivityExchangeCellWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActExchangeCell.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityExchangeCellWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityExchangeCellWidget:getView()
	return self._view
end

function ActivityExchangeCellWidget:dispose()
	super.dispose(self)
end

function ActivityExchangeCellWidget:initSubviews(view)
	self._view = view
	self._descText = self._view:getChildByName("Text_desc")
	self._curText = self._view:getChildByName("Text_curvalue")
	self._targetText = self._view:getChildByName("Text_target")
	self._exchangeBtn = self._view:getChildByName("btn_exchange")

	self._exchangeBtn:setSwallowTouches(false)

	self._iconClone = self._view:getChildByName("costicon")
	self._imageChooseState = self._view:getChildByName("Image_state")
	self._button_choose = self._view:getChildByName("Image_choose_bg")

	self._iconClone:setVisible(false)
end

function ActivityExchangeCellWidget:setupView(data, info)
	self._mediator = info.mediator
	self._parentMediator = info.parentMediator
	self._activityId = info.activityId
	self._data = data

	local rewardPanel = self._view:getChildByName("icon")
	local config = self._data.config

	self._costPanelArr = {}

	local costList = config.Cost

	self._enough = true

	for i, value in pairs(costList) do
		local iconPanel = self._iconClone:clone()

		iconPanel:setVisible(true)

		local icon = IconFactory:createRewardIcon(value, {
			showAmount = false,
			isWidget = true
		})

		icon:addTo(iconPanel, -1):center(iconPanel:getContentSize())
		icon:setScaleNotCascade(0.56)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), value, {
			needDelay = true
		})
		iconPanel:addTo(rewardPanel):posite((i - 1) * 76.3, 0)

		local curText = iconPanel:getChildByName("Text_curvalue")
		local targetText = iconPanel:getChildByName("Text_target")

		self._costPanelArr[#self._costPanelArr + 1] = iconPanel

		local count = self._developSystem:getBagSystem():getItemCount(value.id)

		curText:setString(count)
		targetText:setString("/" .. value.amount)
		curText:setPositionX(targetText:getPositionX() - targetText:getContentSize().width - 2)

		if count < value.amount then
			self._enough = false
		end
	end

	local arrow = self._view:getChildByName("arrow")

	arrow:setPositionX(#costList * 76.3 + 15)

	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")

	if targetList then
		for i, value in pairs(targetList) do
			local iconPanel = self._iconClone:clone()

			iconPanel:setVisible(true)
			iconPanel:addTo(rewardPanel):posite(30 + (#costList + i - 1) * 76.3, 0)

			local icon = IconFactory:createRewardIcon(value, {
				showAmount = false,
				isWidget = true
			})

			icon:addTo(iconPanel, -1):center(iconPanel:getContentSize()):setScaleNotCascade(0.56)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), value, {
				needDelay = true
			})

			local curText = iconPanel:getChildByName("Text_curvalue")
			local targetText = iconPanel:getChildByName("Text_target")

			if value.type == 2 then
				targetText:setVisible(true)
				targetText:setString(value.amount)
			else
				targetText:setVisible(false)
				iconPanel:getChildByName("levelImage"):setVisible(false)
			end

			curText:setVisible(false)
		end
	end

	self:updateView(data)

	local function callFunc(sender, eventType)
		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()

		if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
			self:onClickExchange()
		end
	end

	mapButtonHandlerClick(nil, self._exchangeBtn, {
		ignoreClickAudio = true,
		func = callFunc
	})

	local function callFunc(sender, eventType)
		self:setRedPointSta()
	end

	mapButtonHandlerClick(nil, self._button_choose, {
		ignoreClickAudio = true,
		func = callFunc
	})
end

function ActivityExchangeCellWidget:updateView(data)
	self._data = data

	local config = self._data.config
	local costList = config.Cost

	self._enough = true

	for i, iconPanel in pairs(self._costPanelArr) do
		local costData = costList[i]
		local curText = iconPanel:getChildByName("Text_curvalue")
		local targetText = iconPanel:getChildByName("Text_target")
		local count = self._developSystem:getBagSystem():getItemCount(costData.id)

		curText:setString(count)
		targetText:setString("/" .. costData.amount)
		curText:setPositionX(targetText:getPositionX() - targetText:getContentSize().width - 2)

		if count < costData.amount then
			self._enough = false
		end
	end

	if config.Times == -1 then
		self._curText:setVisible(false)
		self._targetText:setVisible(false)
		self._descText:setString(Strings:get("EXCHANGE_NO_LIMIT"))
		self._descText:setAnchorPoint(cc.p(0.5, 0.5))
		self._descText:setPositionX(self._exchangeBtn:getPositionX())
	else
		self._descText:setString(Strings:get("ActivityCommon_UI09_Limit"))
		self._curText:setString(data.amount)
		self._targetText:setString("/" .. config.Times)
		self._exchangeBtn:setGray(data.amount == 0 or not self._enough)

		local textPosX = self._curText:getPositionX() - self._curText:getContentSize().width - 2

		self._descText:setPositionX(textPosX)
	end

	self:refreshRedPointSta()
end

function ActivityExchangeCellWidget:onClickExchange()
	if self._data.amount == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("ActivityCommon_Tip01")
		}))

		return
	end

	if not self._enough then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("ActivityCommon_Tip02")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		exchangeId = self._data.id
	}

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._activitySystem:requestDoActivity(self._activityId, data, function(response)
		self._mediator:showRewardView(response.data, data)
	end)
end

function ActivityExchangeCellWidget:refreshRedPointSta()
	local rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
	local key = "ActivityExchange_" .. self._activityId .. "_" .. rid .. "_" .. self._data.index
	local sta = cc.UserDefault:getInstance():getBoolForKey(key, true)

	self._imageChooseState:setVisible(sta)
end

function ActivityExchangeCellWidget:setRedPointSta()
	local rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
	local key = "ActivityExchange_" .. self._activityId .. "_" .. rid .. "_" .. self._data.index
	local sta = cc.UserDefault:getInstance():getBoolForKey(key, true)

	cc.UserDefault:getInstance():setBoolForKey(key, not sta)
	self._parentMediator:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	self:refreshRedPointSta()
end

ActivityBannerCellWidget = class("ActivityBannerCellWidget", BaseWidget, _M)

ActivityBannerCellWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function ActivityBannerCellWidget.class:createWidgetNode()
	local resFile = "asset/ui/ActBanner.csb"

	return cc.CSLoader:createNode(resFile)
end

function ActivityBannerCellWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ActivityBannerCellWidget:dispose()
	super.dispose(self)
end

function ActivityBannerCellWidget:initSubviews(view)
	self._view = view
	self._bgImg = view:getChildByName("Image_bg")
	self._goBtn = view:getChildByName("btn_go")
end

function ActivityBannerCellWidget:setupView(data)
	self._data = data

	local config = self._data.config

	local function callFunc(sender, eventType)
		self:onClickGo()
	end

	mapButtonHandlerClick(nil, self._goBtn, {
		func = callFunc
	})
	self._bgImg:loadTexture("asset/ui/activity/" .. config.Img)
	self._goBtn:setVisible(config.Link ~= nil and config.Link ~= "")
end

function ActivityBannerCellWidget:onClickGo()
	local url = self._data.config.Link
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/view/MonthSignInMediator.lua

MonthSignInMediator = class("MonthSignInMediator", DmPopupViewMediator, _M)

MonthSignInMediator:has("_monthSignInSystem", {
	is = "r"
}):injectWith("MonthSignInSystem")

local kBtnHandlers = {
	main = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onTouchMainView"
	},
	["main.contentNode.backLastViewBtn"] = {
		ignoreClickAudio = true,
		func = "onBackFirstView"
	}
}
local clutchtimeArray = {
	[0] = "Clutchtime_Text_1",
	"Clutchtime_Text_2",
	"Clutchtime_Text_2",
	"Clutchtime_Text_3",
	"Clutchtime_Text_3",
	"Clutchtime_Text_4",
	"Clutchtime_Text_4",
	"Clutchtime_Text_5",
	"Clutchtime_Text_5",
	"Clutchtime_Text_6",
	"Clutchtime_Text_6",
	"Clutchtime_Text_7",
	"Clutchtime_Text_7",
	"Clutchtime_Text_8",
	"Clutchtime_Text_8",
	"Clutchtime_Text_9",
	"Clutchtime_Text_9",
	"Clutchtime_Text_10",
	"Clutchtime_Text_10",
	"Clutchtime_Text_11",
	"Clutchtime_Text_11",
	"Clutchtime_Text_12",
	"Clutchtime_Text_12",
	"Clutchtime_Text_1"
}
local actUiConfig = {
	[ActivityType_UI.kActivityBlockWsj] = {
		qdImg = "wsj_qd_img_1.png",
		qdStr = "wsj_",
		dhbAnim = "dhb_xinriqiandaowansheng",
		dhaAnim = "dha_xinriqiandaowansheng"
	},
	[ActivityType_UI.KActivityBlockHoliday] = {
		qdImg = "qd_img_1.png",
		dhbAnim = "dhb_shengdanqiandao",
		qdStr = "",
		dhaAnim = "dha_shengdanqiandao",
		textColor = cc.c3b(145, 33, 51),
		textOffset = cc.p(0, 20)
	}
}
local dailyLuckImagePart = "qd_img_"
local coordinate
local movieClipName = {
	"zbc_baoxiang",
	"zac_baoxiang",
	"zcc_baoxiang"
}

function MonthSignInMediator:initialize()
	coordinate = cc.p(-126, -173)

	super.initialize(self)
end

function MonthSignInMediator:dispose()
	super.dispose(self)
end

function MonthSignInMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MonthSignInMediator:mapEventListeners()
	return
end

function MonthSignInMediator:enterWithData(data)
	self._closeBtn = self:getView():getChildByFullName("closeBtn")
	self._textNode = self:getView():getChildByFullName("main.textNode")
	self._contentNode = self:getView():getChildByFullName("main.contentNode")
	self._commonNode = self:getView():getChildByFullName("main.commonNode")
	self._actionText = self:getView():getChildByFullName("actionText")

	self._actionText:setLocalZOrder(100)
	self._closeBtn:setLocalZOrder(101)

	for i = 1, 3 do
		local node = self._textNode:getChildByFullName("accReward_state" .. i .. ".anim")
		local mc = cc.MovieClip:create(movieClipName[i])

		mc:addTo(node):center(node:getContentSize())
		mc:setScale(0.6)

		local function callFunc(sender)
			self:onClickNextReward(sender, i)
		end

		mapButtonHandlerClick(nil, self._textNode:getChildByFullName("accReward_state" .. i), {
			ignoreClickAudio = true,
			func = callFunc
		})
		node:setTouchEnabled(false)
	end

	local isTodaySign = self._monthSignInSystem:isTodaySign()

	if isTodaySign then
		local var_5_0 = self._monthSignInSystem:getCheckinSum()

		if not var_5_0 then
			var_5_0 = self._monthSignInSystem:getCheckinSum() + 1

			local allCheckTimes = var_5_0
			local greatestRewardTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CheckInRewardLuck1", "content")
			local unitNumber = allCheckTimes - math.floor(allCheckTimes / 10) * 10
			local greatestReward = greatestRewardTab[tostring(unitNumber)]
			local rewards = ConfigReader:getDataByNameIdAndKey("Reward", greatestReward, "Content")

			if not isTodaySign then
				self:initAnim(rewards)
			else
				self:initView(rewards)
			end

			local textNode = self:getView():getChildByName("textNode")

			textNode:setLocalZOrder(99)
			textNode:runAction(cc.FadeIn:create(1))

			if GameConfigs.HERO_TOUCHVIEW_DEBUG then
				self:debugDrawNode()
			end

			local Text16 = self._textNode:getChildByFullName("Text_16")

			if getCurrentLanguage() == GameLanguageType.DE then
				Text16:setFontSize(14)
			end
		end
	end
end

function MonthSignInMediator:debugDrawNode()
	local myDrawNode = cc.DrawNode:create()
	local array = {
		cc.p(350, 110),
		cc.p(750, 110),
		cc.p(750, 520),
		cc.p(350, 520)
	}

	myDrawNode:drawPolygon(array, 4, cc.c4f(255, 0, 0, 255), 10, cc.c4f(255, 0, 0, 255))
	myDrawNode:drawPoly(array, #array, true, cc.c4f(0, 0, 1, 1))
	myDrawNode:addTo(self:getView())
end

function MonthSignInMediator:setupView()
	local sumupCheckInDay = self._monthSignInSystem:getCheckinSum()

	self._commonNode:getChildByFullName("accSignDay"):setString(Strings:get("MonthCheckIn_Sum_Day", {
		num = sumupCheckInDay
	}))

	local todayLuck = self._monthSignInSystem:getTodayLuck()
	local isAct, actUi = self._monthSignInSystem:checkActivity()

	if isAct then
		if not (actUiConfig[actUi].qdStr .. dailyLuckImagePart .. todayLuck .. ".png") then
			local imageName = dailyLuckImagePart .. todayLuck .. ".png"

			self._commonNode:getChildByFullName("todayLuck"):loadTexture(imageName, 1)

			local todaySignTime = self._monthSignInSystem:getTodaySignTime()
			local timeTab = TimeUtil:getHMSByTimestamp(todaySignTime)
			local timeStr = Strings:get(clutchtimeArray[timeTab.hour])

			self._commonNode:getChildByName("time"):setString(timeStr)

			local desc = self._monthSignInSystem:getTodayLuckDesc()

			self._textNode:getChildByName("rewardName"):setString(Strings:get(desc.Name))
			self._contentNode:getChildByName("rewardName"):setString(Strings:get(desc.Name))

			local detailMessage = self._contentNode:getChildByName("detailText")

			detailMessage:setString(Strings:get(desc.Desc))

			local settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()
			local weathData = settingModel:getWeatherData()
			local climateDay = GameStyle:getClimateById(weathData.conditionIdDay)

			if climateDay then
				local weatherStr = self._commonNode:getChildByFullName("weather")

				weatherStr:setString(Strings:get(climateDay))
			end

			if getCurrentLanguage() ~= GameLanguageType.CN then
				local weatherStr = self._commonNode:getChildByFullName("weather")

				weatherStr:setVisible(false)
			end

			local rewardPanel = self._textNode:getChildByFullName("rewardPanel")
			local rewards = self._monthSignInSystem:getTodayReward()

			if rewards then
				local icon = IconFactory:createRewardIcon(rewards[1], {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[1], {
					needDelay = true
				})
				icon:setScaleNotCascade(0.6)
				icon:addTo(rewardPanel):center(rewardPanel:getContentSize())
			end

			local actionBtn = self._commonNode:getChildByFullName("actionBtn")

			actionBtn:setVisible(false)

			local function callFunc()
				self:onClickAction()
			end

			mapButtonHandlerClick(nil, actionBtn, {
				ignoreClickAudio = true,
				func = callFunc
			})

			local anim = self._mc

			self._mc:addCallbackAtFrame(29, function()
				local childView = anim:getChildByFullName("pickUpSecView")

				self._textNode:changeParent(childView)
				self._commonNode:changeParent(childView)
				self._contentNode:changeParent(childView)
				self._contentNode:setPosition(coordinate)
			end)
			self._mc:addCallbackAtFrame(45, function()
				self._closeBtn:runAction(cc.FadeIn:create(0.25))
				self._actionText:runAction(cc.FadeIn:create(0.25))
				actionBtn:setVisible(true)
				self:getView():setVisible(true)

				self._mc = nil
			end)
			self._mc:addCallbackAtFrame(91, function()
				anim:stop()
			end)
			self._mc:gotoAndPlay(21)

			self._mc = -1
		end
	end
end

function MonthSignInMediator:initView(surfaceReward)
	local isAct, actUi = self._monthSignInSystem:checkActivity()

	if isAct then
		if not actUiConfig[actUi].dhbAnim then
			local n = "dhb_xinriqiandao"
			local anim = cc.MovieClip:create(n)

			anim:addTo(self:getView())
			anim:setPosition(cc.p(568, 320))
			anim:gotoAndStop(1)
			anim:setPlaySpeed(10)

			self._mc = anim

			self:setUpTotalReward()

			local childView = self._mc:getChildByFullName("pickUpFirstView")

			self._textNode:changeParent(childView)
			self._textNode:setPosition(coordinate)
			self._textNode:setVisible(true)
			self._commonNode:changeParent(childView)
			self._commonNode:setPosition(coordinate)
			self._commonNode:setVisible(true)
			self:getView():setVisible(false)

			local textNode = self:getView():getChildByName("textNode")

			textNode:setVisible(false)
			self:setupView()
		end
	end
end

function MonthSignInMediator:initAnim(surfaceReward)
	self:setUpTotalReward()

	self._bindTotalRewardClick = true
	self._mc = -1

	local isAct, actUi = self._monthSignInSystem:checkActivity()

	if isAct then
		if not actUiConfig[actUi].dhaAnim then
			local n = "dha_xinriqiandao"
			local anim = cc.MovieClip:create(n)

			anim:addTo(self:getView())
			anim:setPosition(cc.p(568, 320))

			local animSurface = anim:getChildByName("surface")
			local rewardIcon = IconFactory:createRewardIcon(surfaceReward[1], {
				isWidget = true
			})

			rewardIcon:addTo(animSurface):setPosition(cc.p(0, -105))
			rewardIcon:setScaleNotCascade(0.6)

			local text = ccui.Text:create(Strings:get("CheckIn_Today_Greatest_Reward"), TTF_FONT_FZYH_M, 18)

			text:setTextColor(cc.c3b(255, 225, 186))
			text:addTo(animSurface):setPosition(cc.p(-1, -168))

			local insertNode = anim:getChildByName("insertNode")

			if isAct then
				if not actUiConfig[actUi].qdImg then
					local imageName = "qd_img_1.png"
					local image = ccui.ImageView:create(imageName, 1)

					image:addTo(insertNode)
					image:setPosition(cc.p(89, 136))
					anim:addCallbackAtFrame(10, function()
						anim:stop()

						if isAct then
							if not actUiConfig[actUi].dhbAnim then
								local n = "dhb_xinriqiandao"
								local constMc = cc.MovieClip:create(n)

								constMc:addTo(self:getView())
								constMc:setPosition(cc.p(568, 320))
								constMc:gotoAndStop(1)

								self._mc = constMc

								local childView = self._mc:getChildByFullName("pickUpFirstView")

								self._textNode:changeParent(childView)
								self._textNode:setPosition(coordinate)
								self._textNode:setVisible(true)
								self._commonNode:changeParent(childView)
								self._commonNode:setPosition(coordinate)
								self._commonNode:setVisible(true)

								local surface = self._mc:getChildByName("surface")
								local rewardIcon = IconFactory:createRewardIcon(surfaceReward[1], {
									isWidget = true
								})

								rewardIcon:addTo(surface):setPosition(cc.p(0, -105))
								rewardIcon:setScaleNotCascade(0.6)

								local text = ccui.Text:create("", TTF_FONT_FZYH_M, 18)

								text:ignoreContentAdaptWithSize(false)
								text:setContentSize(cc.size(150, 30))
								text:setString(Strings:get("CheckIn_Today_Greatest_Reward"))
								text:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
								text:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
								text:setTextColor(cc.c3b(255, 225, 186))
								text:addTo(surface):setPosition(cc.p(-1, -168))
								anim:removeFromParent()

								if isAct and actUiConfig[actUi].textColor then
									text:setTextColor(actUiConfig[actUi].textColor)
								end

								if isAct and actUiConfig[actUi].textOffset then
									text:offset(actUiConfig[actUi].textOffset.x, actUiConfig[actUi].textOffset.y)
									rewardIcon:offset(actUiConfig[actUi].textOffset.x, actUiConfig[actUi].textOffset.y)
								end
							end
						end
					end)
				end
			end
		end
	end
end

function MonthSignInMediator:setUpTotalReward()
	self._totalRewardsId = {}

	local rewardInfo = self._monthSignInSystem._totalRewardTab
	local gotReward = self._monthSignInSystem:getGotRewards()
	local hasGotTimes = table.nums(gotReward)

	for i = hasGotTimes + 1, hasGotTimes + 3 do
		local info = rewardInfo[i]
		local j = i - hasGotTimes
		local node = self._textNode:getChildByName("accReward_state" .. j)

		if info then
			node:setVisible(true)
			node:getChildByName("dayNum"):setString(info.day)

			self._totalRewardsId[#self._totalRewardsId + 1] = info.rewardId
		else
			node:setVisible(false)
		end
	end
end

function MonthSignInMediator:onClickNextReward(sender, index)
	if self._bindTotalRewardClick then
		return
	end

	local rewardId = self._totalRewardsId[index]

	if rewardId then
		local day = sender:getChildByName("dayNum"):getString()
		local todaySignDay = self._monthSignInSystem:getCheckinSum()
		local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")
		local difDay = tonumber(day) - tonumber(todaySignDay)
		local view = self:getInjector():getInstance("MonthSignRewardBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			remainLastView = true
		}, {
			rewards = reward,
			difDay = difDay
		}))
	end
end

function MonthSignInMediator:onTouchMainView(sender, eventType)
	if not self._mc then
		local touchBeganPos = sender:getTouchBeganPosition()
		local rect = cc.rect(350, 100, 400, 410)

		if cc.rectContainsPoint(rect, touchBeganPos) then
			return
		else
			self:close()

			return
		end
	end

	if self._mc == -1 then
		return
	end

	local touchBeganPos = cc.p(568, 320)

	if eventType == ccui.TouchEventType.began then
		touchBeganPos = sender:getTouchBeganPosition()
	elseif eventType == ccui.TouchEventType.moved then
		local pos = sender:getTouchMovePosition()

		if pos.x - touchBeganPos.x > 70 and not self._onRequestCheckIn then
			self._onRequestCheckIn = true

			self._monthSignInSystem:requestGetDailyReward(function(response)
				if checkDependInstance(self) then
					self:setupView()

					self._onRequestCheckIn = false

					self:dealReward(response.data)
				end
			end, function(response)
				self:close()
			end)
		end
	elseif eventType == ccui.TouchEventType.ended and not self._onRequestCheckIn then
		self._onRequestCheckIn = true

		self._monthSignInSystem:requestGetDailyReward(function(response)
			if checkDependInstance(self) then
				self:setupView()

				self._onRequestCheckIn = false

				self:dealReward(response.data)
			end
		end, function(response)
			self:close()
		end)
	end
end

function MonthSignInMediator:dealReward(data)
	local rewards = data.reward

	performWithDelay(self:getView(), function()
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			remainLastView = true
		}, {
			rewards = rewards
		}))
	end, 1)

	if data.totalReward then
		performWithDelay(self:getView(), function()
			local firstNode = self._textNode:getChildByFullName("accReward_state1.anim")

			firstNode:removeAllChildren()

			local mc = cc.MovieClip:create("zba_baoxiang")

			mc:addTo(firstNode):center(firstNode:getContentSize())
			mc:setScale(0.6)

			local delegate = __associated_delegate__(self)({
				willClose = function(self, popUpMediator, data)
					local firstNode = self._textNode:getChildByFullName("accReward_state1.anim")

					firstNode:removeAllChildren()

					local mc = cc.MovieClip:create("zbc_baoxiang")

					mc:addTo(firstNode):center(firstNode:getContentSize())
					mc:setScale(0.6)
				end
			})
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				remainLastView = true
			}, {
				rewards = data.totalReward
			}, delegate))
			self:setUpTotalReward()

			self._bindTotalRewardClick = false
		end, 3.2)
	else
		self._bindTotalRewardClick = false
	end
end

function MonthSignInMediator:onClickAction()
	if self._textNode:isVisible() then
		self._textNode:setVisible(false)
		self._contentNode:setVisible(true)
		self._actionText:setString(Strings:get("CheckIn_Share_Luck"))
	end
end

function MonthSignInMediator:onBackFirstView()
	self._textNode:setVisible(true)
	self._contentNode:setVisible(false)
	self._actionText:setString(Strings:get("CheckIn_Reveal_Luck"))
end

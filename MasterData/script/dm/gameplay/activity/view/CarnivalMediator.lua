-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/CarnivalMediator.lua

CarnivalMediator = class("CarnivalMediator", DmAreaViewMediator, _M)

CarnivalMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.storyBtn"] = {
		ignoreClickAudio = true,
		func = "onClickPlayStory"
	}
}
local kCellWidth, kCellHeight = 560, 99

local function adoptChildPos(target, node)
	local basePosX, basePosY = target:getChildByName("allFinish"):getPosition()
	local convertBaseToWorld = target:convertToWorldSpace(cc.p(basePosX, basePosY))
	local nodeConvertToWorld = node:getParent():convertToWorldSpace(cc.p(node:getPositionX(), node:getPositionY()))
	local offset = {}

	offset.x = nodeConvertToWorld.x - convertBaseToWorld.x
	offset.y = nodeConvertToWorld.y - convertBaseToWorld.y

	node:offset(-offset.x, -offset.y)
end

function CarnivalMediator:initialize()
	super.initialize(self)
end

function CarnivalMediator:dispose()
	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end

	if self._boardHeroEffect then
		AudioEngine:getInstance():stopEffect(self._boardHeroEffect)

		self._boardHeroEffect = nil
	end

	if self._scoreWidget then
		for k, widget in pairs(self._scoreWidget) do
			widget:removeFromParent(true)
		end

		self._scoreWidget = nil
	end

	self:removeBoxTipsView()
	super.dispose(self)
end

function CarnivalMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self:mapButtonHandlersClick(kBtnHandlers)
	self:setupTopInfoWidget()
end

function CarnivalMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function CarnivalMediator:activityClose(event)
	local data = event:getData()
end

function CarnivalMediator:enterWithData()
	self._model = self._activitySystem:getActivityById("Carnival")

	self:setupView()
end

function CarnivalMediator:setupView()
	self._groupIndex = self._model:getActivity()

	local view = self:getView()

	self._mainActivity = self._main:getChildByName("mainActivity")
	self._dayList = self._main:getChildByName("dayList")
	self._scoreCell = view:getChildByName("score_cell")
	self._loadingBar = self._main:getChildByFullName("giftListView.loadingBar")
	self._score = self._main:getChildByName("score")
	self._safeTouchPanel = view:getChildByName("safeTouchPanel")

	local countdownNode = self._main:getChildByName("remainTime")

	countdownNode:setVisible(false)

	local rarityAnim = cc.MovieClip:create("ssr_yingxiongxuanze")

	rarityAnim:addTo(self._main:getChildByName("titlePanel"))
	rarityAnim:setPosition(cc.p(480, 37))
	self:initHeroPanel()
	self:createTopTab()
	self:initScorePanel()
	self:refreshScoreInfo()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshState)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
end

function CarnivalMediator:initHeroPanel()
	local heroPanel = self._main:getChildByName("heroPanel")
	local talkPanel = heroPanel:getChildByName("talkPanel")
	local text = talkPanel:getChildByFullName("clipNode.text")

	text:setLineSpacing(4)
	text:getVirtualRenderer():setMaxLineWidth(330)

	local bubbleBg = talkPanel:getChildByName("talkBg")

	bubbleBg:ignoreContentAdaptWithSize(true)

	self._primeTextPosX = text:getPositionX()
	self._primeTextPosY = text:getPositionY()

	talkPanel:setLocalZOrder(2)

	local activityConfig = self._model:getConfig().ActivityConfig
	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = activityConfig.ModelId
	})

	self._sharedSpine = spineani

	spineani:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)
	heroSprite:addTo(heroPanel, 1):posite(240, 180)

	local surfaceId = ConfigReader:getDataByNameIdAndKey("HeroBase", "ZTXChang", "SurfaceList")[1]
	local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
	local num = #surfaceData

	for i = 1, num do
		local _info = surfaceData[i]
		local touchPanel = ccui.Layout:create()

		touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

		local point = _info.point
		local size = heroSprite:getContentSize()

		if point[1] == "all" then
			touchPanel:setContentSize(cc.size(size.width / 2 * picInfo.zoom, size.height * picInfo.zoom))
			touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
		else
			touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
			touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + size.width / 2, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
		end

		touchPanel:setTouchEnabled(true)
		touchPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				if spineani:hasAnimation(_info.action) then
					spineani:playAnimation(0, _info.action, true)
				end

				if self._boardHeroEffect then
					return
				end

				local soundId = "Voice_ZTXChang_10"
				local isExistStr = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "CueName"))

				if isExistStr and isExistStr ~= "Voice_Default" then
					local text = talkPanel:getChildByFullName("clipNode.text")

					talkPanel:setVisible(true)
					text:stopAllActions()
					text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

					local trueSoundId

					self._boardHeroEffect, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
						self._boardHeroEffect = nil

						if checkDependInstance(self) then
							talkPanel:setVisible(false)
						end
					end)

					local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc"))

					text:setString(str)
					self:setTextAnim()
				end
			end
		end)
		touchPanel:addTo(heroSprite, num + 1 - i)
	end
end

function CarnivalMediator:setTextAnim()
	local talkPanel = self._main:getChildByFullName("heroPanel.talkPanel")
	local clipNode = talkPanel:getChildByName("clipNode")
	local text = clipNode:getChildByName("text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function CarnivalMediator:spineAnimEvent(event)
	if event.type == "complete" and event.animation ~= "animation" then
		self._sharedSpine:playAnimation(0, "animation", true)
	end
end

function CarnivalMediator:createTopTab()
	local groupNum = #self._groupIndex
	local idx = self._model:getDefaultActivityIndex()

	self._topTabIndex = 1

	for i = idx, 1, -1 do
		local isOpen = self:getActivitySystem():isCarnivalGruopOpen(i)

		if isOpen then
			self._topTabIndex = i

			break
		end
	end

	local tabBtns = {}

	for i = 1, groupNum do
		local btn = self._dayList:getChildByName("top_tab_cell" .. i)

		btn:setTag(i)

		btn.index = i
		tabBtns[#tabBtns + 1] = btn

		local group = self._model:getGroup(i)
		local selectView = btn:getChildByName("select")
		local unselectView = btn:getChildByName("unselect")
		local lock = btn:getChildByName("lock")
		local dayNum = btn:getChildByName("dayText")

		dayNum:setString(Strings:get("Activity_Day", {
			num = i
		}))

		local day = selectView:getChildByName("day")

		day:setString(Strings:get("Activity_Day", {
			num = i
		}))

		local dayDesc = selectView:getChildByName("name")

		dayDesc:setString(Strings:get(group:getDesc()))
		dayDesc:setAdditionalKerning(6)

		local isOpen = self:getActivitySystem():isCarnivalGruopOpen(i)

		btn.isOpen = isOpen

		selectView:setVisible(self._topTabIndex == i)
		lock:setVisible(not isOpen)
		unselectView:setVisible(isOpen and self._topTabIndex ~= i)
		dayNum:setVisible(self._topTabIndex ~= i)

		local node = RedPoint:createDefaultNode(IconFactory.redPointPath1)
		local redPoint = RedPoint:new(node, btn, function()
			return btn.isOpen and self._model:subActivityHasRedPoint(self._groupIndex[i])
		end)

		redPoint:offset(13, 13)
		redPoint:setScale(0.8)

		btn.redPoint = redPoint
	end

	self._leftTabController = TabController:new(tabBtns, nil, {
		buttonClick = function(sender, eventType, selectTag)
			self:onClickTopTab(sender, eventType, selectTag)
		end
	})

	self._leftTabController:selectTabByTag(self._topTabIndex)
end

function CarnivalMediator:updateTableCell(index)
	local targetNode = self._mainActivity:getChildByName("target" .. index)

	targetNode:setVisible(true)

	local group = self._model:getGroup(self._topTabIndex)
	local taskList = group:getTaskList()
	local task = taskList[index]
	local status = task:getStatus()
	local bg = targetNode:getChildByName("bg")

	bg:ignoreContentAdaptWithSize(true)

	local state

	if status == ActivityTaskStatus.kUnfinish or status == ActivityTaskStatus.kFinishNotGet then
		local finishView = targetNode:getChildByName("finishView")
		local unFinishView = targetNode:getChildByName("unFinishView")

		finishView:setVisible(false)
		unFinishView:setVisible(true)

		local url = task:getDestUrl()
		local subActivityId = task:getActivityId()
		local config = task:getConfig()
		local taskId = config.Id
		local actBtn = unFinishView:getChildByName("goBtn")
		local callFunc

		if status == ActivityTaskStatus.kUnfinish then
			actBtn:loadTextureNormal("tbzl_btn_qw.png", ccui.TextureResType.plistType)
			actBtn:loadTexturePressed("tbzl_btn_qw.png", ccui.TextureResType.plistType)
			bg:loadTexture("tbzl_btn_di1.png", ccui.TextureResType.plistType)
			actBtn:getChildByName("text1"):setVisible(true)
			actBtn:getChildByName("text2"):setVisible(false)

			function callFunc()
				self:onClickGoto(url)
			end

			local taskValue = task:getTaskValueList()
			local targetValue = taskValue[#taskValue].targetValue
			local curValue = taskValue[#taskValue].currentValue

			if targetValue > 1000 then
				targetValue = 1
				curValue = 0
			end

			local valueTips = actBtn:getChildByFullName("text1.count")

			valueTips:setString(Strings:get("Carnival_Target_Rate", {
				num1 = curValue,
				num2 = targetValue
			}))
		else
			actBtn:loadTextureNormal("tbzl_btn_lq.png", ccui.TextureResType.plistType)
			actBtn:loadTexturePressed("tbzl_btn_lq.png", ccui.TextureResType.plistType)
			actBtn:getChildByName("text1"):setVisible(false)
			actBtn:getChildByName("text2"):setVisible(true)
			bg:loadTexture("tbzl_btn_di2.png", ccui.TextureResType.plistType)

			function callFunc()
				if self._boardHeroEffect then
					AudioEngine:getInstance():stopEffect(self._boardHeroEffect)

					self._boardHeroEffect = nil
				end

				self:onClickReceive(subActivityId, taskId)
			end
		end

		mapButtonHandlerClick(nil, actBtn, {
			ignoreClickAudio = true,
			func = callFunc
		})

		state = false
	elseif status == ActivityTaskStatus.kGet then
		bg:loadTexture("tbzl_btn_di1.png", ccui.TextureResType.plistType)
		targetNode:getChildByName("finishView"):setVisible(true)
		targetNode:getChildByName("unFinishView"):setVisible(false)

		state = true
	end

	return state
end

function CarnivalMediator:sortTaskList()
	local group = self._model:getGroup(self._topTabIndex)
	local taskList = group:getTaskList()

	table.sort(taskList, function(a, b)
		local aSortNum = a._config.OrderNum
		local bSortNum = b._config.OrderNum

		return bSortNum < aSortNum
	end)
end

function CarnivalMediator:baseUpdateTableCell(index)
	local targetNode = self._mainActivity:getChildByName("target" .. index)
	local group = self._model:getGroup(self._topTabIndex)
	local groupConfig = group:getActivityConfig()
	local taskList = group:getTaskList()
	local task = taskList[index]
	local status = task:getStatus()
	local finishViewBg = targetNode:getChildByFullName("finishView.entireImage")

	finishViewBg:ignoreContentAdaptWithSize(true)
	finishViewBg:loadTexture("asset/scene/" .. groupConfig.img .. ".jpg", ccui.TextureResType.localType)

	local allFinish = self._mainActivity:getChildByName("allFinish")

	allFinish:loadTexture("asset/scene/" .. groupConfig.img .. ".jpg", ccui.TextureResType.localType)
	adoptChildPos(self._mainActivity, finishViewBg)

	if status ~= ActivityTaskStatus.kGet then
		local unFinishView = targetNode:getChildByName("unFinishView")
		local taskName = unFinishView:getChildByName("title")

		if getCurrentLanguage() ~= GameLanguageType.CN then
			taskName:setFontSize(17)
			taskName:setPositionY(120)
			taskName:setPositionX(15)
		end

		taskName:getVirtualRenderer():setMaxLineWidth(210)

		local config = task:getConfig()
		local str = Strings:get(config.Desc)

		taskName:setString(str)

		local rewardId = config.Reward
		local rewards = ConfigReader:getRecordById("Reward", rewardId)
		local rewardInfo = rewards.Content[1]
		local scale = 0.35
		local icon, amount = self:getRewardIconAndAmount(rewardInfo, scale)
		local iconNode = unFinishView:getChildByName("iconNode")

		iconNode:removeAllChildren()
		icon:addTo(iconNode):center(iconNode:getContentSize())

		local touchLayer = ccui.Layout:create()

		touchLayer:setContentSize(cc.size(65, 65))
		touchLayer:addTo(iconNode):center(iconNode:getContentSize())
		IconFactory:bindTouchHander(touchLayer, IconTouchHandler:new(self), rewardInfo, {
			needDelay = true
		})
		unFinishView:getChildByName("amount"):setString("x" .. amount)
	end
end

function CarnivalMediator:initScorePanel()
	local rewardList = self._model:getRewardList()

	self._scoreWidget = {}

	local giftView = self._main:getChildByName("giftListView")

	giftView:setScrollBarEnabled(false)

	local baseZeroPosX = self._loadingBar:getPositionX()
	local maxSizeWidth = self._loadingBar:getContentSize().width

	self._maxScore = 42

	if rewardList then
		self._maxScore = rewardList[#rewardList].Num

		for k, v in ipairs(rewardList) do
			local widget = self._scoreCell:clone()
			local iconBg = widget:getChildByFullName("Panel_icon")
			local rewards = ConfigReader:getRecordById("Reward", v.Reward).Content

			if rewards then
				local hideAnim = v.Shine and v.Shine == 0 or false
				local rewardIcon = IconFactory:createRewardIcon(rewards[1], {
					isWidget = true,
					hideAnim = hideAnim
				})

				rewardIcon:setScaleNotCascade(0.45)
				rewardIcon:addTo(iconBg):center(iconBg:getContentSize())
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewards[1], {
					needDelay = true
				})
			end

			iconBg.score = v.Num

			local textNum = widget:getChildByFullName("text")

			textNum:setString(v.Num)
			iconBg:setTouchEnabled(true)

			local function callFunc(sender, eventType)
				self:onClickGift(sender, v.Reward)
			end

			mapButtonHandlerClick(nil, iconBg, {
				func = callFunc
			}, nil, true)

			self._scoreWidget[#self._scoreWidget + 1] = widget

			local isRewardReceived = self._model:isScoreRewardReceived(v.Num)
			local receivedImg = widget:getChildByFullName("img_received")

			receivedImg:setVisible(isRewardReceived)

			local node = RedPoint:createDefaultNode()
			local redPoint = RedPoint:new(node, widget, function()
				return self._model:scoreRewardHasRedPoint(v.Num)
			end)

			redPoint:setScale(0.6)
			redPoint:posite(55, 85)

			widget.hasRedPoint = true

			widget:addTo(giftView)

			local coordinate = k / #rewardList * maxSizeWidth

			widget:setPosition(cc.p(baseZeroPosX + coordinate, -22))
		end
	end
end

function CarnivalMediator:refreshScoreInfo()
	local scoreTab = {
		0,
		5,
		10,
		15,
		30,
		40
	}
	local rewardCount = self._model:getRewardCount()

	self._score:setString(rewardCount)

	for i = 1, #scoreTab do
		local prev = scoreTab[i]
		local tail = i == #scoreTab and 100000000 or scoreTab[i + 1]

		if prev <= rewardCount and rewardCount < tail then
			local basePercent = (i - 1) * 20
			local interpolation = 20 * (rewardCount - prev) / (tail - prev)

			self._loadingBar:setPercent(basePercent + interpolation)

			break
		end
	end

	self:refreshGiftState()
end

function CarnivalMediator:refreshGiftState()
	for k, widget in pairs(self._scoreWidget) do
		local iconBg = widget:getChildByFullName("Panel_icon")
		local isRewardReceived = self._model:isScoreRewardReceived(iconBg.score)
		local receivedImg = widget:getChildByFullName("img_received")

		receivedImg:setVisible(isRewardReceived)
	end
end

function CarnivalMediator:removeBoxTipsView()
	if self._boxTipsWidget ~= nil then
		self._boxTipsWidget:getView():removeFromParent()

		self._boxTipsWidget = nil
	end

	if self._touchLayer then
		self._touchLayer:setVisible(false)
	end
end

function CarnivalMediator:showGiftTipsView(info, btn)
	self:removeBoxTipsView()

	if self._boxTipsWidget == nil then
		self._boxTipsWidget = BoxTipsWidget:new(BoxTipsWidget:createWidgetNode(), info)
		self._boxTipsWidget.target = btn

		self:getView():addChild(self._boxTipsWidget:getView(), 9999)

		local view = self:getView():getChildByFullName("main.bg")

		if not self._touchLayer then
			local touchLayer = ccui.Layout:create()

			touchLayer:setAnchorPoint(cc.p(0.5, 0.5))
			touchLayer:addTo(view, 2):center(view:getContentSize())
			touchLayer:setContentSize(self:getView():getContentSize())
			touchLayer:setTouchEnabled(true)
			touchLayer:setSwallowTouches(false)

			local function callFunc(sender, eventType)
				self:removeBoxTipsView()
			end

			mapButtonHandlerClick(nil, touchLayer, {
				func = callFunc
			})

			self._touchLayer = touchLayer
		end

		self._touchLayer:setVisible(true)

		self._boxTipsWidget.target = info.box
	end
end

function CarnivalMediator:refreshState()
	self:sortTaskList()

	local state = true

	for i = 1, 6 do
		local _state = self:updateTableCell(i)

		state = state and _state
	end

	if state then
		self:groupAllFinish()
	end

	self:refreshGiftState()
end

function CarnivalMediator:groupAllFinish()
	self._mainActivity:getChildByName("allFinish"):setVisible(true)

	for i = 1, 6 do
		self._mainActivity:getChildByName("target" .. i):setVisible(false)
	end
end

function CarnivalMediator:onGetTaskRewardCallback(response)
	local rewards = response.data.reward
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
	self:sortTaskList()

	local state = true

	for i = 1, 6 do
		local _state = self:updateTableCell(i)

		state = state and _state
	end

	if state then
		self:groupAllFinish()

		local soundId = "Voice_ZTXChang_14"
		local heroPanel = self._main:getChildByName("heroPanel")
		local talkPanel = heroPanel:getChildByName("talkPanel")
		local text = talkPanel:getChildByFullName("clipNode.text")

		talkPanel:setVisible(true)
		text:stopAllActions()
		text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

		local trueSoundId

		self._boardHeroEffect, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			self._boardHeroEffect = nil

			if checkDependInstance(self) then
				talkPanel:setVisible(false)
			end
		end)

		local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc"))

		text:setString(str)
		self:setTextAnim()
	end

	self:refreshScoreInfo()
end

function CarnivalMediator:onGetScoreRewardCallback(response)
	local rewards = response.data.reward

	if rewards then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = rewards
		}))
	end

	self:refreshScoreInfo()
end

function CarnivalMediator:onClickGift(sender, reward)
	local totalScore = self._model:getRewardCount()
	local isRewardReceived = self._model:isScoreRewardReceived(sender.score)

	if totalScore >= sender.score and isRewardReceived == false then
		local activityId = "Carnival"
		local param = {
			doActivityType = 101,
			targetNum = sender.score
		}

		self._activitySystem:requestDoActivity(activityId, param, function(response)
			self:onGetScoreRewardCallback(response)
		end)

		return
	end

	local rewardCount = self._model:getRewardCount()
	local info = {
		rewardId = reward,
		tips = Strings:get("Carnival_GetRewardNumTips", {
			num = sender.score,
			fontName = TTF_FONT_FZYH_M,
			color = (rewardCount < sender.score or nil) and "#FF0000"
		}),
		hasGet = isRewardReceived
	}
	local view = self:getInjector():getInstance("ActivityBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, info))
end

function CarnivalMediator:onClickTopTab(sender, eventType, selectTag)
	if eventType == ccui.TouchEventType.began then
		-- block empty
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended then
		if not sender.isOpen then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Carnival_OpenDayTips", {
					day = selectTag
				})
			}))

			return
		end

		local oldBtn = self._dayList:getChildByName("top_tab_cell" .. self._topTabIndex)

		oldBtn:getChildByName("select"):setVisible(false)
		oldBtn:getChildByName("unselect"):setVisible(true)
		oldBtn:getChildByName("dayText"):setVisible(true)
		sender:getChildByName("select"):setVisible(true)
		sender:getChildByName("unselect"):setVisible(false)
		sender:getChildByName("dayText"):setVisible(false)

		self._topTabIndex = sender:getTag()
		self._leftTabController._curButton = sender

		self:sortTaskList()
		self._mainActivity:getChildByName("allFinish"):setVisible(false)

		local state = true

		for i = 1, 6 do
			self:baseUpdateTableCell(i)

			local _state = self:updateTableCell(i)

			state = state and _state
		end

		if state then
			self:groupAllFinish()
		end
	end
end

function CarnivalMediator:onClickGoto(url)
	if url then
		self:dispatch(Event:new(EVT_OPENURL, {
			url = url
		}))
	end
end

function CarnivalMediator:onClickReceive(subActivityId, taskId)
	local param = {}

	param.doActivityType = "101"
	param.taskId = taskId

	self._activitySystem:requestDoChildActivity("Carnival", subActivityId, param, function(response)
		if checkDependInstance(self) then
			self:onGetTaskRewardCallback(response)
		end
	end)
end

function CarnivalMediator:doReset()
	local model = self._activitySystem:getActivityById("Carnival")

	if not model then
		self:dismiss()

		return
	end

	local groupNum = #self._groupIndex

	for i = 1, groupNum do
		local btn = self._dayList:getChildByName("top_tab_cell" .. i)
		local selectView = btn:getChildByName("select")
		local unselectView = btn:getChildByName("unselect")
		local lock = btn:getChildByName("lock")
		local dayNum = btn:getChildByName("dayText")
		local isOpen = self:getActivitySystem():isCarnivalGruopOpen(i)

		btn.isOpen = isOpen

		selectView:setVisible(self._topTabIndex == i)
		lock:setVisible(not isOpen)
		unselectView:setVisible(isOpen and self._topTabIndex ~= i)
		dayNum:setVisible(self._topTabIndex ~= i)
		btn.redPoint:refresh()
	end
end

function CarnivalMediator:onClickPlayStory()
	if self._mainActivity:getChildByName("allFinish"):isVisible() then
		local group = self._model:getGroup(self._topTabIndex)
		local groupConfig = group:getActivityConfig()
		local storyId = groupConfig.story
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()
		local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()

		local function endCallback()
			local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
			local customKey = self._model:getId() .. "_story"
			local customData = customDataSystem:getValue(PrefixType.kGlobal, customKey)
			local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
			local statisticsData = storyAgent:getStoryStatisticsData(storyId)

			StatisticSystem:send({
				type = "plot_end",
				op_type = "plot_activity",
				point = "plot_end",
				activityid = self._model:getTitle(),
				plot_id = storyId,
				plot_name = Strings:get(group:getDesc()),
				id_first = (not customData or nil) and 1,
				totaltime = endTs - startTs,
				detail = statisticsData.detail,
				amount = statisticsData.amount,
				misc = statisticsData.misc
			})
		end

		storyAgent:play(storyId, nil, endCallback)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Carnival_Story_Unlock")
		}))
	end
end

function CarnivalMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function CarnivalMediator:getRewardIconAndAmount(rewardInfo, scale)
	local info = RewardSystem:parseInfo(rewardInfo)
	local id = info.id

	if not info.amount then
		if info.rewardType then
			if info.rewardType == RewardType.kSurface then
				local config = ConfigReader:getRecordById("Surface", id)

				if config and config.Id then
					local icon = IconFactory:createRoleIconSpriteNew({
						id = config.Model
					})

					icon:setScale(scale)

					return icon, info.amount
				end
			elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
				local config = ConfigReader:getRecordById("HeroEquipBase", tostring(id))

				if config and config.Id then
					local icon = IconFactory:createRewardEquipIcon(info)

					icon:setScale(scale * 1.3)

					return icon, info.amount
				end
			end
		end

		local config = ConfigReader:getRecordById("ResourcesIcon", tostring(id))

		if config and config.Id then
			local iconName = config.LargeIcons[1]
			local iconNode = ccui.ImageView:create(iconName .. ".png", 1)

			iconNode:setScale(scale)

			return iconNode, info.amount
		end

		config = ConfigReader:getRecordById("ItemConfig", tostring(id))

		if config and config.Id then
			local itemImg = IconFactory:createItemPic(info, {
				ignoreScaleSize = true
			})

			itemImg:setScale(scale)

			return itemImg, info.amount
		end
	end
end

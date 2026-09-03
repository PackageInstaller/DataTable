-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockEggMediator.lua

ActivityBlockEggMediator = class("ActivityBlockEggMediator", DmAreaViewMediator, _M)

ActivityBlockEggMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockEggMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["bottomPanel.refresh_btn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRefresh"
	},
	["main.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["bottomPanel.rewardBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	},
	["bottomPanel.open5Btn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickOpen5Eggs"
	},
	["bottomPanel.taskBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTask"
	}
}
local maxOpenNum = 6
local kEggStatus = {
	kOpened = 3,
	kToOpen = 1,
	kOpening = 2
}

function ActivityBlockEggMediator:initialize()
	super.initialize(self)
end

function ActivityBlockEggMediator:dispose()
	self._eggNode:stopAllActions()
	self:getView():stopAllActions()

	if self._eggTimer then
		self._eggTimer:stop()

		self._eggTimer = nil
	end

	super.dispose(self)
end

function ActivityBlockEggMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateRefreshNum)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._touchPanel = self:getView():getChildByName("touchPanel")

	self._touchPanel:setVisible(false)

	self._main = self:getView():getChildByName("main")
	self._numNode = self._main:getChildByName("numNode")
	self._eggNode = self._main:getChildByName("eggNode")
	self._eggClone = self._main:getChildByName("eggClone")

	self._eggClone:setVisible(false)

	self._bottomPanel = self:getView():getChildByName("bottomPanel")
	self._refreshBtn = self._bottomPanel:getChildByName("refresh_btn")
	self._rewardNode = self._bottomPanel:getChildByName("rewardNode")
	self._imageBg = self._main:getChildByName("Imagebg")

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(167, 186, 255, 255)
		}
	}

	self._bottomPanel:getChildByFullName("rewardBtn.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	self._bottomPanel:getChildByFullName("open5Btn.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	self._bottomPanel:getChildByFullName("taskBtn.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ActivityBlockEggMediator:doReset()
	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	if model:getType() == ActivityType.KActivityBlock then
		local activity = model:getEggActivity()

		if not activity then
			self:dismiss()
		end
	end
end

function ActivityBlockEggMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = self._eggActivity:getResourcesBanner(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get(self._eggActivity:getTitle()),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 35 or nil
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local tipBtn = self:getView():getChildByFullName("main.tipBtn")

	tipBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 22)
end

function ActivityBlockEggMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock

	self:initData(true)
	self:setupTopInfoWidget()
	self:initRewardView()
	self:initView()
	self:updateRound()
	self:updateRefreshNum()
	self:createEggTimer()
end

function ActivityBlockEggMediator:refreshView()
	self:initData()
	self:updateEggNodes()
end

function ActivityBlockEggMediator:initData(isInit)
	if isInit then
		self._eggRewardIdTemp = {}
		self._canShowRefresh = true
	end

	self._activityModel = self._activitySystem:getActivityById(self._activityId)

	if self._activityModel:getType() == ActivityType.KActivityBlock then
		self._eggActivity = self._activityModel:getEggActivity()
		self._isSubAct = true
	else
		self._eggActivity = self._activityModel
		self._isSubAct = false
	end

	self._eggModel = self._eggActivity:getEgg()
	self._costData = self._eggModel:getCost()
	self._bigRewards = self._eggModel:getEggBigRewards()
	self._eggList = self._eggModel:getEggList()
	self._notGotEggs = {}

	for i = 1, #self._eggList do
		local rewardId = self._eggList[i].rewardId

		if rewardId == "" then
			table.insert(self._notGotEggs, i)
		else
			self._eggRewardIdTemp[i] = self._eggRewardIdTemp[i] or {}
			self._eggRewardIdTemp[i].eggStatus = kEggStatus.kOpened
			self._eggRewardIdTemp[i].rewardId = rewardId
			self._eggRewardIdTemp[i].reward = nil
			self._eggRewardIdTemp[i].bigReward = not not self._bigRewards[rewardId]
		end
	end

	if not self._refreshing and #self._notGotEggs == #self._eggList and not isInit then
		self._autoRefreshing = true
	end
end

function ActivityBlockEggMediator:initView()
	self._imageBg:loadTexture(self._eggActivity:getBgPath())
	self._eggNode:removeAllChildren()

	self._eggNodes = {}
	self._eggStatus = {}

	for i = 1, #self._eggList do
		local image = self._eggList[i].image
		local rewardId = self._eggList[i].rewardId
		local node = self._eggClone:clone()

		node:setVisible(true)
		node:addTo(self._eggNode)

		local parent = node:getChildByName("icon")

		if rewardId ~= "" then
			self._eggStatus[i] = kEggStatus.kOpened

			local itemNode

			if self._bigRewards[rewardId] then
				local anim = self:createAnimBigReward(parent)

				itemNode = anim:getChildByName("itemNode")

				anim:gotoAndStop(86)
			else
				local anim = self:createAnimNormalReward(parent)

				itemNode = anim:getChildByName("itemNode")

				anim:gotoAndStop(43)
			end

			local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")[1]
			local icon = IconFactory:createRewardIcon(reward, {
				showAmount = false,
				notShowQulity = true
			})

			icon:addTo(itemNode)
		else
			self._eggStatus[i] = kEggStatus.kToOpen

			local function callFunc()
				self:onClickEgg(i)
			end

			mapButtonHandlerClick(nil, node, {
				ignoreClickAudio = true,
				func = callFunc
			})

			local anim = self:createAnimNormalEgg(parent)
			local eggNode = anim:getChildByName("eggNode")
			local egg = ccui.ImageView:create(image, 1)

			egg:addTo(eggNode)
			anim:gotoAndStop(49)
		end

		if i <= 6 then
			node:setPosition(cc.p(112 + 149 * (i - 1), 328))
		elseif i > 6 and i <= 12 then
			node:setPosition(cc.p(87 + 160 * (i - 7), 201))
		else
			node:setPosition(cc.p(70 + 170 * (i - 13), 57))
		end

		table.insert(self._eggNodes, node)
	end

	self:playBackgroundMusic()

	local taskBtn = self._bottomPanel:getChildByName("taskBtn")

	if taskBtn then
		taskBtn:setVisible(self._eggActivity:getActivityConfig().TaskActivity ~= nil)
	end
end

function ActivityBlockEggMediator:playBackgroundMusic()
	local bgm = self._activityModel:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityBlockEggMediator:initRewardView()
	self._rewardNode:removeAllChildren()

	local rewards = {}

	self._allGot = true

	for rewardId, v in pairs(self._bigRewards) do
		local index = v.sort

		rewards[index] = {
			rewardId = rewardId,
			got = v.got
		}

		if not v.got then
			self._allGot = false
		end
	end

	local length = #rewards

	for i = 1, length do
		local reward = rewards[i]

		self:createReward(reward.rewardId, {
			y = 0,
			x = 82 * (i - 1)
		}, reward.got)
	end

	if length == 0 then
		self._refreshBtn:setVisible(false)
		self._bottomPanel:getChildByName("text"):setVisible(false)
	else
		self._bottomPanel:getChildByName("text"):setVisible(true)
		self._refreshBtn:setVisible(self._allGot)
	end
end

function ActivityBlockEggMediator:createReward(rewardId, pos, got)
	local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")[1]
	local icon = IconFactory:createRewardIcon(reward, {
		isWidget = true
	})

	icon:addTo(self._rewardNode):posite(pos.x, pos.y):setScale(0.6)
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
		needDelay = true
	})

	if got then
		icon:setColor(cc.c3b(127, 127, 127))

		local image = ccui.ImageView:create("hd_14r_btn_go.png", 1)

		image:addTo(self._rewardNode):posite(pos.x, pos.y):setScale(0.6)
	end
end

function ActivityBlockEggMediator:refreshViewByRefresh()
	AudioEngine:getInstance():playEffect("Se_Effect_Refresh_Egg", false)
	self._eggNode:stopAllActions()

	local x = self._eggNode:getPositionX()
	local y = self._eggNode:getPositionY()

	self._eggNode:setPositionX(x + 200)

	local callFunc = cc.CallFunc:create(function()
		for i = 1, #self._eggNodes do
			local image = self._eggList[i].image
			local rewardId = self._eggList[i].rewardId
			local node = self._eggNodes[i]

			node:setTouchEnabled(rewardId == "")

			local parent = node:getChildByName("icon")

			parent:removeAllChildren()

			local anim = self:createAnimNormalEgg(parent)
			local eggNode = anim:getChildByName("eggNode")
			local egg = ccui.ImageView:create(image, 1)

			egg:addTo(eggNode)
			anim:gotoAndPlay(0)

			local function callFunc()
				self:onClickEgg(i)
			end

			mapButtonHandlerClick(nil, node, {
				clickAudio = "Se_Click_Select_1",
				func = callFunc
			})

			self._eggStatus[i] = kEggStatus.kToOpen
		end
	end)
	local moveTo = cc.MoveTo:create(0.1, cc.p(x, y))

	self._eggNode:runAction(cc.Sequence:create(moveTo, callFunc))
end

function ActivityBlockEggMediator:refreshViewByAutoRefresh()
	for i = 1, #self._eggNodes do
		local rewardId = self._eggRewardIdTemp[i].rewardId
		local reward = self._eggRewardIdTemp[i].reward
		local eggStatus = self._eggRewardIdTemp[i].eggStatus
		local isBigReward = self._eggRewardIdTemp[i].bigReward
		local node = self._eggNodes[i]

		node:setTouchEnabled(false)

		local parent = node:getChildByName("icon")

		parent:removeAllChildren()

		local itemNode

		if isBigReward then
			local anim = self:createAnimBigReward(parent)

			itemNode = anim:getChildByName("itemNode")

			if eggStatus == kEggStatus.kOpening then
				anim:gotoAndPlay(46)
			else
				anim:gotoAndStop(86)
			end
		else
			local anim = self:createAnimNormalReward(parent)

			itemNode = anim:getChildByName("itemNode")

			if eggStatus == kEggStatus.kOpening then
				anim:gotoAndPlay(31)
			else
				anim:gotoAndStop(43)
			end
		end

		if not reward or not reward then
			::label_17_0::

			local reward_ = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")[1]
			local icon = IconFactory:createRewardIcon(reward_, {
				showAmount = false,
				notShowQulity = true
			})

			icon:addTo(itemNode)
		end
	end
end

function ActivityBlockEggMediator:refreshViewNormal()
	for i = 1, #self._eggNodes do
		local image = self._eggList[i].image
		local rewardId = self._eggList[i].rewardId
		local node = self._eggNodes[i]

		node:setTouchEnabled(rewardId == "")

		local parent = node:getChildByName("icon")

		parent:removeAllChildren()

		if rewardId ~= "" then
			local itemNode

			if self._bigRewards[rewardId] then
				local anim = self:createAnimBigReward(parent)

				itemNode = anim:getChildByName("itemNode")

				if self._eggStatus[i] == kEggStatus.kOpening then
					anim:gotoAndPlay(46)
				else
					anim:gotoAndStop(86)
				end
			else
				local anim = self:createAnimNormalReward(parent)

				itemNode = anim:getChildByName("itemNode")

				if self._eggStatus[i] == kEggStatus.kOpening then
					anim:gotoAndPlay(31)
				else
					anim:gotoAndStop(43)
				end
			end

			local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")[1]
			local icon = IconFactory:createRewardIcon(reward, {
				showAmount = false,
				notShowQulity = true
			})

			icon:addTo(itemNode)

			self._eggStatus[i] = kEggStatus.kOpened
		else
			local anim = self:createAnimNormalEgg(parent)
			local eggNode = anim:getChildByName("eggNode")
			local egg = ccui.ImageView:create(image, 1)

			egg:addTo(eggNode)
			anim:gotoAndStop(49)

			local function callFunc()
				self:onClickEgg(i)
			end

			mapButtonHandlerClick(nil, node, {
				clickAudio = "Se_Click_Select_1",
				func = callFunc
			})

			self._eggStatus[i] = kEggStatus.kToOpen
		end
	end
end

function ActivityBlockEggMediator:createAnimBigReward(parent)
	local anim1 = cc.MovieClip:create("dana_zacaidan")

	anim1:setName("EggAnim")
	anim1:addTo(parent):center(parent:getContentSize())
	anim1:addCallbackAtFrame(86, function()
		anim1:stop()
	end)

	return anim1
end

function ActivityBlockEggMediator:createAnimNormalReward(parent)
	local anim1 = cc.MovieClip:create("danb_zacaidan")

	anim1:setName("EggAnim")
	anim1:addTo(parent):center(parent:getContentSize())
	anim1:addCallbackAtFrame(43, function()
		anim1:stop()
	end)

	return anim1
end

function ActivityBlockEggMediator:createAnimNormalEgg(parent)
	local anim1 = cc.MovieClip:create("danjinru_zacaidan")

	anim1:setName("EggAnim")
	anim1:addTo(parent):center(parent:getContentSize())
	anim1:addCallbackAtFrame(28, function()
		self._touchPanel:setVisible(false)

		self._refreshing = false

		anim1:stop()
	end)
	anim1:addCallbackAtFrame(83, function()
		anim1:stop()
	end)

	return anim1
end

function ActivityBlockEggMediator:updateEggNodes()
	if self._refreshing then
		self:createEggTimer()
		self:initRewardView()
		self:updateRound()
		self:updateRefreshNum()
		self:refreshViewByRefresh()
	elseif self._autoRefreshing then
		self:refreshViewByAutoRefresh()
	else
		self:createEggTimer()
		self:initRewardView()
		self:updateRefreshNum()
		self:refreshViewNormal()
	end
end

function ActivityBlockEggMediator:createEggTimer()
	if self._eggTimer then
		self._eggTimer:stop()

		self._eggTimer = nil
	end

	local function checkTimeFunc()
		if self._refreshing or self._autoRefreshing then
			return
		end

		local length = #self._notGotEggs

		if length > 0 then
			local index = math.random(1, length)
			local eggIndex = self._notGotEggs[index]
			local status = self._eggStatus[eggIndex]
			local node = self._eggNodes[eggIndex]

			if node and status == kEggStatus.kToOpen then
				local parent = node:getChildByName("icon")
				local anim = parent:getChildByName("EggAnim")

				anim:gotoAndPlay(49)
			end
		end
	end

	self._eggTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 2.5, false)
end

function ActivityBlockEggMediator:updateRound()
	local str = Strings:get("ActivityBlock_UI_4", {
		num = self._eggActivity:getNum()
	})

	self._numNode:getChildByName("text"):setString(str)
end

function ActivityBlockEggMediator:updateRefreshNum()
	local num = math.min(#self._notGotEggs, maxOpenNum)
	local trueNum = 0

	for i = 1, num do
		local enough = true

		for itemId, num in pairs(self._costData) do
			local amount = self._bagSystem:getItemCount(itemId)

			if amount < num * i then
				enough = false
			end
		end

		if not enough then
			break
		end

		trueNum = i
	end

	num = math.max(1, trueNum)
	self._eggNum = num

	self._bottomPanel:getChildByFullName("open5Btn.text"):setString(Strings:get("ActivityBlock_UI_20", {
		num = num
	}))
end

function ActivityBlockEggMediator:onEggSucc(eggId, response)
	self:refreshView()
	self:onGetRewardCallback(eggId, response)
end

function ActivityBlockEggMediator:onGetRewardCallback(eggId, response)
	local bigRewards = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", eggId, "KeyRewardShow") or {}
	local idList = response.data.idList
	local hasBigReward = false

	for i = 1, #bigRewards do
		local rewardId = bigRewards[i]

		if table.indexof(idList, rewardId) then
			hasBigReward = true

			break
		end
	end

	local rewards = {}

	if not response.data.reward then
		for i = 1, #response.data.reward do
			table.insert(rewards, response.data.reward[i][1])
		end

		local function callback()
			if #rewards > 0 then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards,
					callback = function()
						if checkDependInstance(self) then
							if not self._autoRefreshing then
								if self._allGot and self._canShowRefresh and self._refreshBtn:isVisible() then
									self._canShowRefresh = false

									self:onClickRefresh()
								end

								self._touchPanel:setVisible(false)
							else
								self._canShowRefresh = true
								self._refreshing = true
								self._autoRefreshing = false
								self._eggRewardIdTemp = {}

								self:refreshView()
							end
						end
					end
				}))
			end
		end

		local autoRefresh = #self._notGotEggs == #self._eggList

		self:getView():stopAllActions()

		if hasBigReward then
			AudioEngine:getInstance():playEffect("Se_Alert_Better_Egg", false)

			if autoRefresh then
				self._activitySystem:showEggSucc(self._activityId, self._eggActivity, callback)

				return
			end

			performWithDelay(self:getView(), function()
				self._activitySystem:showEggSucc(self._activityId, self._eggActivity, callback)
			end, 0.7)
		else
			AudioEngine:getInstance():playEffect("Se_Alert_Normal_Egg", false)

			if autoRefresh then
				callback()

				return
			end

			performWithDelay(self:getView(), function()
				callback()
			end, 0.3)
		end
	end
end

function ActivityBlockEggMediator:onClickEgg(index)
	for itemId, num in pairs(self._costData) do
		local amount = self._bagSystem:getItemCount(itemId)

		if amount < num then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("ActivityBlock_UI_23")
			}))

			return
		end
	end

	self._touchPanel:setVisible(true)

	self._eggStatus[index] = kEggStatus.kOpening

	local eggId = self._eggModel:getId()
	local param = {}

	param.doActivityType = "101"
	param.index = {
		index - 1
	}

	local function callBack(response)
		if checkDependInstance(self) then
			local bigRewards = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", eggId, "KeyRewardShow") or {}

			self._eggRewardIdTemp[index] = self._eggRewardIdTemp[index] or {}
			self._eggRewardIdTemp[index].eggStatus = kEggStatus.kOpening
			self._eggRewardIdTemp[index].rewardId = nil
			self._eggRewardIdTemp[index].reward = response.data.reward[1][1]
			self._eggRewardIdTemp[index].bigReward = not not bigRewards[response.data.idList[1]]

			self:onEggSucc(eggId, response)
		end
	end

	if self._isSubAct then
		self._activitySystem:requestDoChildActivity(self._activityModel:getId(), self._eggActivity:getId(), param, function(response)
			callBack(response)
		end)
	else
		self._activitySystem:requestDoActivity(self._activityModel:getId(), param, function(response)
			callBack(response)
		end)
	end
end

function ActivityBlockEggMediator:onClickOpen5Eggs()
	if #self._notGotEggs == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local length = self._eggNum

	for itemId, num in pairs(self._costData) do
		local amount = self._bagSystem:getItemCount(itemId)

		if amount < num * length then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("ActivityBlock_UI_23")
			}))

			return
		end
	end

	self._touchPanel:setVisible(true)

	local eggId = self._eggModel:getId()
	local param = {}

	param.doActivityType = "101"
	param.index = {}

	for i = 1, length do
		local eggIndex = self._notGotEggs[i]

		self._eggStatus[eggIndex] = kEggStatus.kOpening

		table.insert(param.index, eggIndex - 1)
	end

	local function callBack(response)
		if checkDependInstance(self) then
			local bigRewards = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", eggId, "KeyRewardShow") or {}

			for i = 1, #param.index do
				if response.data.reward[i] then
					local eggIndex = param.index[i] + 1

					self._eggRewardIdTemp[eggIndex] = self._eggRewardIdTemp[eggIndex] or {}
					self._eggRewardIdTemp[eggIndex].eggStatus = kEggStatus.kOpening
					self._eggRewardIdTemp[eggIndex].rewardId = nil
					self._eggRewardIdTemp[eggIndex].reward = response.data.reward[i][1]
					self._eggRewardIdTemp[eggIndex].bigReward = not not bigRewards[response.data.idList[i]]
				end
			end

			self:onEggSucc(eggId, response)
		end
	end

	if self._isSubAct then
		self._activitySystem:requestDoChildActivity(self._activityModel:getId(), self._eggActivity:getId(), param, function(response)
			callBack(response)
		end)
	else
		self._activitySystem:requestDoActivity(self._activityModel:getId(), param, function(response)
			callBack(response)
		end)
	end
end

function ActivityBlockEggMediator:onClickReward()
	self._activitySystem:showEasterRewards({
		activityId = self._activityId
	})
end

function ActivityBlockEggMediator:onClickRule()
	local rules = self._eggActivity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockEggMediator:onClickRefresh()
	local function func()
		self._refreshing = true

		self._touchPanel:setVisible(true)

		local param = {}

		param.doActivityType = "102"

		local function callBack(response)
			if checkDependInstance(self) then
				self._canShowRefresh = true
				self._autoRefreshing = false
				self._eggRewardIdTemp = {}

				self:dispatch(ShowTipEvent({
					tip = Strings:get("ActivityBlock_UI_22")
				}))
				self:refreshView()
			end
		end

		if self._isSubAct then
			self._activitySystem:requestDoChildActivity(self._activityModel:getId(), self._eggActivity:getId(), param, function(response)
				callBack(response)
			end)
		else
			self._activitySystem:requestDoActivity(self._activityModel:getId(), param, function(response)
				callBack(response)
			end)
		end
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("ActivityBlock_UI_3"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ActivityBlockEggMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockEggMediator:onClickTask()
	local id = self._eggActivity:getActivityConfig().TaskActivity

	if id then
		local view = self:getInjector():getInstance("ActivityEggTaskView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
			activityId = id
		}))
	end
end

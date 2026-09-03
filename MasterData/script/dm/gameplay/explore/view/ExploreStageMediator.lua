-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreStageMediator.lua

ExploreStageMediator = class("ExploreStageMediator", DmAreaViewMediator, _M)

ExploreStageMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreStageMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreStageMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ExploreStageMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
ExploreStageMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	tipBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTip"
	},
	["main.bottomNode.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDpTask"
	}
}
local boxRewardImg = {
	["1"] = {
		"renwu_icon_bx_1.png",
		"renwu_icon_bx_1.png",
		"renwu_icon_bx_1.png"
	},
	["2"] = {
		"renwu_icon_bx_2.png",
		"renwu_icon_bx_2.png",
		"renwu_icon_bx_2.png"
	},
	["3"] = {
		"renwu_icon_bx_3.png",
		"renwu_icon_bx_3.png",
		"renwu_icon_bx_3.png"
	},
	["4"] = {
		"renwu_icon_bx_4.png",
		"renwu_icon_bx_4.png",
		"renwu_icon_bx_4.png"
	},
	["5"] = {
		"renwu_icon_bx_5.png",
		"renwu_icon_bx_5.png",
		"renwu_icon_bx_5.png"
	}
}

function ExploreStageMediator:initialize()
	super.initialize(self)
end

function ExploreStageMediator:dispose()
	super.dispose(self)
end

function ExploreStageMediator:onRemove()
	super.onRemove(self)
end

function ExploreStageMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_RESET_MAPCOUNT, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REWARD_SUCC, self, self.onGetRewardCallback)
end

function ExploreStageMediator:enterWithData(data)
	self._mapTypeId = data.mapTypeId
	self._mapTypeObj = self._exploreSystem:getMapTypesDic(self._mapTypeId)
	self._pointIds = self._mapTypeObj:getMapPointId()
	self._pointId = self._pointIds[1]
	self._data = data
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._mapTask = self._exploreSystem:getMapTask(self._mapTypeObj:getSystemTaskIds())

	self:initView()
	self:initPointView()
	self:updateReward()
	self:setupTopInfoWidget()
	self:initStoryPoint()
	self:runStartAction()
	self:setupClickEnvs()
end

function ExploreStageMediator:resumeWithData()
	self:updateData()
	self:updateView()
	self:updateDailyRewardTimes()
end

function ExploreStageMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._pointPanel = self._main:getChildByName("pointPanel")
	self._storyPoint = self._pointPanel:getChildByName("storyPoint")

	self._storyPoint:setVisible(false)
	self._storyPoint:addClickEventListener(function()
		self:onClickStoryPoint()
	end)

	self._dpPanel = self._main:getChildByFullName("bottomNode.dpPanel")
	self._loadingBg = self._dpPanel:getChildByName("loadingBg")
	self._progress = self._loadingBg:getChildByFullName("progress.progress")
	self._loadingBar = self._loadingBg:getChildByName("loadingBar")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._rewardClone = self._loadingBg:getChildByName("clonePanel")

	self._rewardClone:setVisible(false)

	self._rewardPanel = self._main:getChildByFullName("bottomNode.rewardPanel")
	self._rewardTaskClone = self._rewardPanel:getChildByFullName("rewardClone")

	self._rewardTaskClone:setVisible(false)

	local path = self._mapTypeObj:getBGImg()

	self._main:getChildByName("bg"):loadTexture(path .. ".jpg")

	local bgAnim = self._main:getChildByName("bgAnim")

	bgAnim:removeAllChildren()

	local animName = self._mapTypeObj:getBGStageAnim() or "stage_1_shamoyibian"
	local stageName = string.sub(animName, 1, 7)

	self._mainAnim = cc.MovieClip:create(animName)

	self._mainAnim:addTo(bgAnim):center(bgAnim:getContentSize())
	self._mainAnim:addEndCallback(function()
		self._mainAnim:stop()
	end)

	local title = self._mapTypeObj:getName()
	local nameNode = self._mainAnim:getChildByName("nameNode")
	local language = getCurrentLanguage()

	if nameNode then
		self._mainAnim:addCallbackAtFrame(19, function()
			nameNode:gotoAndPlay(0)
		end)
		nameNode:addEndCallback(function()
			nameNode:stop()
		end)

		local name_1 = nameNode:getChildByName("name_1")
		local name_2 = nameNode:getChildByName("name_2")
		local name_3 = nameNode:getChildByName("name_3")
		local nameLabel1 = ""
		local nameLabel2 = ""
		local nameLabel3 = ""
		local length = utf8.len(title)

		if language ~= GameLanguageType.CN then
			local strs = string.split(title, " ")
			local length = #strs

			for j = 1, length do
				local num = strs[j]

				if j > 1 and j == length then
					nameLabel2 = nameLabel2 .. num

					if j == length then
						nameLabel3 = utf8.sub(title, #title, #title)
					end
				else
					nameLabel1 = nameLabel1 .. " " .. num
				end
			end

			nameLabel1 = string.trim(nameLabel1)

			if stageName ~= "stage_3" then
				nameLabel2 = nameLabel1
				nameLabel1 = nameLabel2
				nameLabel3 = utf8.sub(nameLabel, #nameLabel, #nameLabel)
			end
		else
			for j = 1, length do
				local num = utf8.sub(title, j, j)

				if j == length - 1 or j == length then
					nameLabel2 = nameLabel2 .. num

					if j == length then
						nameLabel3 = num
					end
				else
					nameLabel1 = nameLabel1 .. num
				end
			end
		end

		local name1 = cc.Label:createWithTTF(nameLabel1, CUSTOM_TTF_FONT_1, 60)

		name1:enableOutline(cc.c4b(35, 15, 5, 255), 1)
		name1:setAnchorPoint(cc.p(0, 0.5))
		name1:addTo(name_1):posite(-60, 10)

		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(127, 127, 127, 255)
			}
		}
		local name2 = cc.Label:createWithTTF(nameLabel2, CUSTOM_TTF_FONT_1, 78)

		if language ~= GameLanguageType.CN then
			name2 = cc.Label:createWithTTF(nameLabel2, CUSTOM_TTF_FONT_1, 60)
		end

		name2:enableOutline(cc.c4b(35, 15, 5, 255), 1)
		name2:setAnchorPoint(cc.p(1, 0.5))
		name2:addTo(name_2):posite(120, -16)
		name2:setAdditionalKerning(-15)

		local name3 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 78)

		if language ~= GameLanguageType.CN and stageName ~= "stage_3" then
			name3 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 60)
		end

		name3:setAnchorPoint(cc.p(1, 0.5))
		name3:addTo(name_3):posite(155, -19)
		name3:setOpacity(90)

		local name4 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 78)

		if language ~= GameLanguageType.CN and stageName ~= "stage_3" then
			name4 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 60)
		end

		name4:setAnchorPoint(cc.p(1, 0.5))
		name4:addTo(name_3):posite(175, -19)
		name4:setOpacity(50)
		name1:setOverflow(cc.LabelOverflow.SHRINK)
		name1:setDimensions(220, 90)
		name2:setOverflow(cc.LabelOverflow.SHRINK)
		name2:setDimensions(260, 160)
		name3:setOverflow(cc.LabelOverflow.SHRINK)
		name3:setDimensions(200, 160)
		name4:setOverflow(cc.LabelOverflow.SHRINK)
		name4:setDimensions(200, 160)

		if language ~= GameLanguageType.CN then
			name2:setLineSpacing(-30)
			name2:setAdditionalKerning(1)

			if stageName ~= "stage_3" then
				if stageName == "stage_2" then
					name3:posite(#nameLabel2 * 29, -85)
					name4:posite(#nameLabel2 * 29 + 10, -85)
				else
					name3:posite(#nameLabel2 * 30, -85)
					name4:posite(#nameLabel2 * 30 + 10, -85)
				end

				name1:posite(-20, 10)
				name2:posite(120, -16)
				name2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
			else
				name3:posite(#nameLabel2 * 43, -19)
				name4:posite(#nameLabel2 * 43 + 10, -19)
				name1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
			end
		else
			name1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
		end
	end

	local extraBgAnim = self._mainAnim:getChildByName("extraBgAnim")

	if extraBgAnim then
		local bgNode1 = extraBgAnim:getChildByName("bg1")
		local bgNode2 = extraBgAnim:getChildByName("bg2")

		if bgNode1 then
			local bg1 = ccui.ImageView:create(path .. "_1.jpg")

			bg1:addTo(bgNode1):posite(0, 0)
		end

		if bgNode2 then
			local bg2 = ccui.ImageView:create(path .. "_1.jpg")

			bg2:addTo(bgNode2):posite(0, 0)
		end
	end

	self:getView():getChildByFullName("exploreTimesPanel.text"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self:getView():getChildByFullName("exploreTimesPanel.times"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self._progress:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self._rewardClone:getChildByFullName("targetNum"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
end

function ExploreStageMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kPower
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("EXPLORE_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self:updateDailyRewardTimes()

	local tipBtn = self:getView():getChildByFullName("tipBtn")

	tipBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function ExploreStageMediator:updateDailyRewardTimes()
	local dailyRewardPanel = self:getView():getChildByFullName("dailyRewardPanel")
	local times = self._exploreSystem:getDailyRecommendTimes()
	local mapDailyRewardTime = self._exploreSystem:getMapDailyRewardTime()
	local textLabel = dailyRewardPanel:getChildByFullName("text")
	local timeLabel = dailyRewardPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. mapDailyRewardTime)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)
	textLabel:disableEffect(1)
	timeLabel:disableEffect(1)

	if times <= 0 then
		textLabel:setTextColor(cc.c3b(255, 255, 255))
		timeLabel:setTextColor(cc.c3b(255, 255, 255))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	else
		textLabel:setTextColor(cc.c3b(186, 238, 22))
		timeLabel:setTextColor(cc.c3b(186, 238, 22))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
	end

	local exploreTimesPanel = self:getView():getChildByFullName("exploreTimesPanel")
	local times = self._exploreSystem:getEnterTimes()
	local enterTotalTimes = self._exploreSystem:getEnterTotalTimes()
	local textLabel = exploreTimesPanel:getChildByFullName("text")
	local timeLabel = exploreTimesPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. enterTotalTimes)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		exploreTimesPanel:setPositionX(600)
	end
end

function ExploreStageMediator:initPointView()
	self._stageNode = {}

	local length = #self._pointIds

	for i = 1, length do
		local id = self._pointIds[i]
		local panel = self._mainAnim:getChildByName("stage_" .. i)

		if panel and id then
			local data = self._exploreSystem:getMapPointObjById(id)
			local name = cc.Label:createWithTTF(data:getName(), TTF_FONT_FZYH_M, 25)

			name:setAnchorPoint(cc.p(0, 0.5))
			name:addTo(panel):posite(-175, 5)
			name:setName("NameSprite")
			name:setOverflow(cc.LabelOverflow.SHRINK)
			name:setDimensions(130, 50)
			name:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

			local numPanel = self._mainAnim:getChildByName("num_" .. i)
			local num = cc.Label:createWithTTF(i, CUSTOM_TTF_FONT_2, 100)

			num:setAnchorPoint(cc.p(0, 0.5))
			num:setColor(cc.c3b(0, 0, 0))
			num:addTo(numPanel):posite(5, -10)

			local iconPanel = self._mainAnim:getChildByName("icon_" .. i)

			iconPanel:removeAllChildren()

			local image = ccui.ImageView:create(data:getImg())

			image:addTo(iconPanel):posite(0, 0)
			image:setName("IconSprite")
			image:setTouchEnabled(true)
			image:addClickEventListener(function()
				self:onClickPoint(i)
			end)

			local pos = data:getFirstRewardPosition()
			local rewardBox = self:initTaskView(panel, data:getLock(), i, pos)

			if data:getLock() then
				if rewardBox then
					rewardBox:getChildByName("rewardBtn"):setSwallowTouches(false)
					rewardBox:setOpacity(127)
				end

				local lockImage = ccui.ImageView:create("xlg_bg_suo.png", 1)

				lockImage:addTo(panel):posite(-38, 6)
				lockImage:setName("LockSprite")
			else
				if rewardBox then
					rewardBox:getChildByName("rewardBtn"):setSwallowTouches(true)
					rewardBox:setOpacity(255)
				end

				if self._exploreSystem:isRecommendPoint(data:getWeekRecommend()) then
					self:initRecommendImg(panel)
				end
			end

			self._stageNode[i] = {
				panel = panel,
				numPanel = numPanel,
				iconPanel = iconPanel
			}
		end
	end
end

function ExploreStageMediator:initRecommendImg(panel)
	local image = cc.Sprite:createWithSpriteFrameName("common_bg_tuijian.png")

	image:setAnchorPoint(cc.p(0, 1))
	image:addTo(panel):posite(-205, 60)
	image:setName("RecommendSprite")
	image:setGlobalZOrder(10)

	local num = cc.Label:createWithTTF(Strings:get("EXPLORE_UI22"), CUSTOM_TTF_FONT_1, 22)

	num:addTo(image):posite(34, 33)
	num:setTextColor(cc.c3b(0, 0, 0))
	num:enableOutline(cc.c4b(186, 238, 22, 255), 1)
	num:setGlobalZOrder(11)
end

function ExploreStageMediator:updateData()
	self._mapTypeObj = self._exploreSystem:getMapTypesDic(self._mapTypeId)
	self._pointId = self._pointId or self._pointIds[1]
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._mapTask = self._exploreSystem:getMapTask(self._mapTypeObj:getSystemTaskIds())
end

function ExploreStageMediator:updateView()
	self:updateReward()

	local length = #self._pointIds

	for i = 1, length do
		local id = self._pointIds[i]
		local panel = self._stageNode[i].panel

		if panel and id then
			local data = self._exploreSystem:getMapPointObjById(id)
			local lockImage = panel:getChildByName("LockSprite")

			if lockImage then
				lockImage:setVisible(data:getLock())
			end

			local pos = data:getFirstRewardPosition()
			local rewardBox = self:initTaskView(panel, data:getLock(), i, pos)

			if data:getLock() then
				if rewardBox then
					rewardBox:getChildByName("rewardBtn"):setSwallowTouches(false)
					rewardBox:setOpacity(127)
				end
			elseif rewardBox then
				rewardBox:getChildByName("rewardBtn"):setSwallowTouches(true)
				rewardBox:setOpacity(255)
			end

			local iconPanel = self._stageNode[i].iconPanel
			local iconSprite = iconPanel:getChildByName("IconSprite")

			if iconSprite then
				local recommondTip = iconSprite:getChildByName("RecommendSprite")

				if recommondTip then
					local isRecommend = not data:getLock() and self._exploreSystem:isRecommendPoint(data:getWeekRecommend())

					recommondTip:setVisible(isRecommend)
				end
			end
		end
	end
end

function ExploreStageMediator:updateReward()
	local dpMax = self._mapTypeObj:getTotalTaskDp()

	self._progress:setString(self._mapTypeObj:getDpNum())
	self._loadingBar:setPercent(self._mapTypeObj:getDpNum() / dpMax * 100)

	local taskRewards = self._mapTypeObj:getDPTaskReward()

	for i = 1, #taskRewards do
		self._loadingBg:removeChildByTag(12138 + i)

		local reward = taskRewards[i]
		local panel = self._rewardClone:clone()

		panel:setVisible(true)
		panel:setTag(12138 + i)
		panel:setPositionX(self._loadingBg:getContentSize().width * (tonumber(reward.count) / dpMax))
		panel:addTo(self._loadingBg)

		local rewardStatus = self._mapTypeObj:getRewardMap()[reward.count]

		panel:getChildByName("targetNum"):setString(reward.count)
		panel:addClickEventListener(function()
			self:onClickRewardTask(reward)
		end)

		local boxImg = panel:getChildByName("bxImg")

		boxImg:removeAllChildren()

		local bgPath = "renwu_bg_bxd_1.png"

		if rewardStatus == 0 and tonumber(reward.count) <= self._mapTypeObj:getDpNum() then
			local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

			redPoint:addTo(boxImg):offset(43, 28):setLocalZOrder(10):setScale(0.7)

			bgPath = "renwu_bg_bxd_2.png"
		end

		local child = ccui.ImageView:create(bgPath, 1)

		child:setPosition(18, 6)
		child:setScale(0.7)
		boxImg:addChild(child)

		local animName = boxRewardImg[reward.icon]
		local child = ccui.ImageView:create(animName[1], 1)

		child:setPosition(18, 8)
		child:setScale(0.35)
		boxImg:addChild(child)
	end
end

function ExploreStageMediator:initTaskView(parent, lock, index, pos)
	local data = self._mapTask[index]
	local panel = parent:getChildByFullName("RewardBox")

	if not data then
		if panel then
			panel:removeFromParent()
		end

		return nil
	end

	if data.status + 1 == 3 then
		if panel then
			panel:removeFromParent()
		end

		return nil
	end

	if not panel then
		panel = self._rewardTaskClone:clone()

		panel:setVisible(true)
		panel:addTo(parent):posite(pos[1], pos[2])
		panel:setName("RewardBox")
	end

	local btn = panel:getChildByName("rewardBtn")

	btn:setTouchEnabled(not lock)
	btn:addClickEventListener(function()
		self:onClickReward(data)
	end)
	btn:removeAllChildren()

	local bgPath = "renwu_bg_bxd_1.png"

	if data.status == TaskStatus.kFinishNotGet then
		local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(btn):offset(48, 48):setScale(0.7):setLocalZOrder(10)

		bgPath = "renwu_bg_bxd_2.png"
	end

	local bgImage = ccui.ImageView:create(bgPath, 1)

	bgImage:setPosition(28, 26)
	btn:setScale(0.8)
	btn:addChild(bgImage)

	local animName = boxRewardImg["4"]
	local child = ccui.ImageView:create(animName[1], 1)

	child:setScale(0.5)
	child:addTo(bgImage):center(bgImage:getContentSize())

	return panel
end

function ExploreStageMediator:onGetRewardCallback(event)
	local response = event:getData().response
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = response
	}))
end

function ExploreStageMediator:onClickReward(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local rewardStatus = data.status

	if rewardStatus == 1 then
		self._taskSystem:requestTaskReward({
			taskId = data.id
		})

		return
	end

	local boxData = {
		title = "EXPLORE_UI35",
		status = data.status,
		desc = data.desc .. Strings:get("EXPLORE_UI50"),
		reward = data.reward,
		taskValues = data.taskValues
	}
	local view = self:getInjector():getInstance("ExploreRewardBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, boxData))
end

function ExploreStageMediator:onClickBack()
	self:dismiss()
end

function ExploreStageMediator:onClickPoint(index)
	local id = self._pointIds[index]
	local data = self._exploreSystem:getMapPointObjById(id)

	if not id or not data then
		return
	end

	if data:getLock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = data:getLockTip()
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

	local view = self:getInjector():getInstance("ExplorePointInfo")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		pointId = data:getId()
	}))
end

function ExploreStageMediator:onClickRewardTask(reward)
	local rewardStatus = self._mapTypeObj:getRewardMap()[reward.count]

	if rewardStatus == 0 and tonumber(reward.count) <= self._mapTypeObj:getDpNum() then
		local function callBack(data)
			self:updateData()
			self:updateView()

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data.data.rewards
			}))
		end

		local param = {
			groupId = self._mapTypeId,
			dp = reward.count
		}

		self._exploreSystem:requestGetDPTaskReward(callBack, param)

		return
	end

	local got = rewardStatus == 1

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	reward.desc = Strings:get("EXPLORE_UI18", {
		num = reward.count
	})
	reward.got = got

	local view = self:getInjector():getInstance("ExploreRewardBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, reward))
end

function ExploreStageMediator:onClickDpTask()
	local view = self:getInjector():getInstance("ExploreDPTaskView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		id = self._mapTypeId
	}))
end

function ExploreStageMediator:initStoryPoint()
	local customKey = CustomDataKey.kExploreBeforeStory .. self._mapTypeId
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)
	local storyLink = self._mapTypeObj:getBeforeStory()

	if storyLink ~= "" then
		local function callback()
			self._storyPoint:setVisible(true)

			local storyName = self._mapTypeObj:getBeforeStoryName()
			local pos = self._mapTypeObj:getBeforeStoryPosition()

			self._storyPoint:setPosition(cc.p(pos[1], pos[2]))
			self._storyPoint:getChildByName("storyName"):setString(storyName)
		end

		if not customData then
			local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(true)
			storyAgent:trigger(storyLink, nil, function()
				callback()

				local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
				local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

				StatisticSystem:send({
					id_first = 1,
					op_type = "plot_world_map",
					type = "plot_end",
					point = "plot_end",
					plot_id = storyLink,
					plot_name = self._mapTypeObj:getBeforeStoryName(),
					totaltime = endTs - startTs,
					detail = statisticsData.detail,
					amount = statisticsData.amount,
					misc = statisticsData.misc
				})
			end)
			self._customDataSystem:setValue(PrefixType.kGlobal, customKey, "1")
		else
			callback()
		end
	end
end

function ExploreStageMediator:onClickTip()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageSp_Map_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ExploreStageMediator:onClickStoryPoint()
	local storyLink = self._mapTypeObj:getBeforeStory()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)

	local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()

	local function endCallback()
		local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
		local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

		StatisticSystem:send({
			id_first = 0,
			op_type = "plot_world_map",
			type = "plot_end",
			point = "plot_end",
			plot_id = storyLink,
			plot_name = self._mapTypeObj:getBeforeStoryName(),
			totaltime = endTs - startTs,
			detail = statisticsData.detail,
			amount = statisticsData.amount,
			misc = statisticsData.misc
		})
	end

	storyAgent:trigger(storyLink, nil, endCallback)
end

function ExploreStageMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/Layer_exploreStage.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 43, false)
end

function ExploreStageMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local btnPoint = self._mainAnim:getChildByName("icon_1")

		if btnPoint:getChildByName("IconSprite") then
			btnPoint = btnPoint:getChildByName("IconSprite")
		end

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if btnPoint then
			storyDirector:setClickEnv("ExploreStageMediator.btnPoint", btnPoint, function(sender, eventType)
				self:onClickPoint(1)
			end)
		end

		storyDirector:notifyWaiting("enter_ExploreStageMediator")
	end))

	self:getView():runAction(sequence)
end

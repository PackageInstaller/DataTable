-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportStageWxhMediator.lua

ActivitySagaSupportStageWxhMediator = class("ActivitySagaSupportStageWxhMediator", DmAreaViewMediator, _M)

ActivitySagaSupportStageWxhMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivitySagaSupportStageWxhMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivitySagaSupportStageWxhMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.scheduleBtn"] = {
		ignoreClickAudio = true,
		func = "onClickScheduleBtn"
	},
	["main.rankBtn"] = {
		ignoreClickAudio = true,
		func = "onClickRankBtn"
	},
	["main.scoreBtn"] = {
		ignoreClickAudio = true,
		func = "onClickScoreBtn"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}
local statusTextImg = {
	[ActivitySupportStatus.Preparing] = "wah_VS.png",
	[ActivitySupportStatus.Starting] = "wah_PK.png",
	[ActivitySupportStatus.Ended] = "wah_KO.png"
}
local statusText1 = {
	[ActivitySupportStatus.Preparing] = Strings:get("Activity_Saga_UI_3"),
	[ActivitySupportStatus.Starting] = "times",
	[ActivitySupportStatus.Ended] = Strings:get("Activity_Saga_UI_4")
}
local enterBg = {
	[ActivitySupportViewEnter.Stage] = "asset/scene/bg_beijing.jpg",
	[ActivitySupportViewEnter.Main] = "asset/scene/bg_yingyuanzhong_bj.jpg"
}
local resultImg = {
	loser = "z_taotai.png",
	winner = "z_jingji.png"
}
local itemUseAnimationByQuality = {
	[2] = {
		sound = "Se_Effect_Support_Green",
		effect = "lv_yingyuanyemian"
	},
	[3] = {
		sound = "Se_Effect_Support_Blue",
		effect = "lan_yingyuanyemian"
	},
	[4] = {
		sound = "Se_Effect_Support_Purple",
		effect = "zi_yingyuanyemian"
	},
	[5] = {
		sound = "Se_Effect_Support_Orange",
		effect = "chen_yingyuanyemian"
	}
}

ActivitySupportViewEnter = {
	Main = 2,
	Stage = 1
}

function ActivitySagaSupportStageWxhMediator:initialize()
	super.initialize(self)
end

function ActivitySagaSupportStageWxhMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySagaSupportStageWxhMediator:disposeView()
	self:stopTimer()

	if self._toastPanel then
		self._toastPanel:stopAllActions()
	end

	if self._addPanel then
		self._addPanel:stopAllActions()
	end

	self:stopEffect()
end

function ActivitySagaSupportStageWxhMediator:onRegister()
	super.onRegister(self)
	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_SAGA_SCORE, self, self.updateRedPoint)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._stagePanel = self._main:getChildByName("stagePanel")
	self._mainPanel = self._main:getChildByName("mainPanel")
	self._topClonePanel1 = self:getView():getChildByName("topClonePanel1")

	self._topClonePanel1:setVisible(false)

	self._topClonePanel2 = self:getView():getChildByName("topClonePanel2")

	self._topClonePanel2:setVisible(false)

	self._toastPanel = self._mainPanel:getChildByFullName("toastPanel")

	self._toastPanel:setVisible(false)

	local bg = self._toastPanel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)

	self._primeTextPosX = self._toastPanel:getChildByFullName("clipNode.text"):getPositionX()
	self._primeTextPosY = self._toastPanel:getChildByFullName("clipNode.text"):getPositionY()

	self._toastPanel:getChildByFullName("clipNode.text"):getVirtualRenderer():setDimensions(330, 0)

	self._addPanel = self._mainPanel:getChildByFullName("addPanel")

	self._addPanel:setVisible(false)

	self._addPanelPosX = self._addPanel:getPositionX()
	self._addPanelPosY = self._addPanel:getPositionY()

	local btns = {
		"scheduleBtn",
		"rankBtn",
		"scoreBtn"
	}

	for i = 1, 3 do
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(167, 186, 255, 255)
			}
		}
		local lineGradiantDir2 = {
			x = 0,
			y = -1
		}
		local btn = self._main:getChildByFullName(btns[i])

		btn:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))
		btn:getChildByFullName("redPoint"):setVisible(false)
	end

	self._stagePanel:getChildByFullName("popularityValue1"):enableOutline(cc.c4b(0, 0, 0, 76.5), 1)
	self._stagePanel:getChildByFullName("popularityValue2"):enableOutline(cc.c4b(0, 0, 0, 76.5), 1)
	self._stagePanel:getChildByName("timeValue"):enableOutline(cc.c4b(0, 0, 0, 76.5), 1)
	self._stagePanel:getChildByFullName("pkNode1.supportBtn.txt"):setString(Strings:get("Activity_Saga_yingyuananniu_wxh"))
	self._stagePanel:getChildByFullName("pkNode2.supportBtn.txt"):setString(Strings:get("Activity_Saga_yingyuananniu_wxh"))
end

function ActivitySagaSupportStageWxhMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivitySagaSupportStageWxhMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local config = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		complexTitle = {
			{
				str = Strings:get("Activity_Saga_UI_35_wxh")
			}
		}
	}

	self._topInfoWidget:updateView(config)
end

function ActivitySagaSupportStageWxhMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()

	self._enterView = data.enterView or ActivitySupportViewEnter.Stage
	self._heroId = data.heroId or nil

	self:initData()
	self:initView()
	self:updateRedPoint()
	self:showChat()
end

function ActivitySagaSupportStageWxhMediator:resumeWithData()
	self:doReset()
end

function ActivitySagaSupportStageWxhMediator:refreshView()
	self:doReset()
end

function ActivitySagaSupportStageWxhMediator:doReset()
	self:disposeView()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivitySagaSupportStageWxhMediator:initData()
	self._config = self._activity:getActivityConfig()
	self._periodsInfo = self._activity:getPeriodsInfo()
	self._periodId = self._periodsInfo.periodId
	self._curPeriod = self._activity:getSupportCurPeriodData()
end

function ActivitySagaSupportStageWxhMediator:initView()
	local sceneValue = self._main:getChildByName("sceneValue")

	sceneValue:setString(Strings:get(self._curPeriod.config.Name))

	local sceneValueTime = self._main:getChildByName("sceneValueTime")

	if self._curPeriod.data.status == ActivitySupportStatus.Preparing then
		self:setTimer(self._curPeriod.data.startTime, Strings:get("Activity_Saga_UI_8"), ActivitySupportStatus.Preparing, sceneValueTime)
	else
		sceneValueTime:setString("")
	end

	self:updateStageView()
	self:updateMainView()
	self:playBackgroundMusic()
end

function ActivitySagaSupportStageWxhMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	if bgm then
		AudioEngine:getInstance():playBackgroundMusic(bgm)
	end
end

function ActivitySagaSupportStageWxhMediator:updateMainView()
	if self._enterView == ActivitySupportViewEnter.Stage then
		return
	end

	if not self._heroId then
		return
	end

	self._imageBg:loadTexture(enterBg[self._enterView])
	self._stagePanel:setVisible(false)
	self._mainPanel:setVisible(true)

	local data = self._curPeriod.data
	local popularity = data.popularity

	self._mainPanel:getChildByFullName("popularityValue"):setString(Strings:get("Activity_Saga_UI_9"))
	self._mainPanel:getChildByFullName("popularityValueBitmapFontLabel"):setString(tostring(popularity[self._heroId]))

	local roleNode = self._mainPanel:getChildByFullName("roleNode")

	roleNode:removeAllChildren()

	local hd = self._activity:getHeroDataById(self._heroId)
	local modelId = hd.ModelId
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = modelId
	})

	img:addTo(roleNode):posite(50, -85)
	img:setScale(0.86)

	self._mainRoleNode = roleNode

	local name = ConfigReader:requireRecordById("RoleModel", modelId).Name

	self._mainPanel:getChildByFullName("name"):setString(Strings:get(name))

	local clubAddNode = self._mainPanel:getChildByFullName("clubAddNode")

	clubAddNode:getChildByFullName("clubAddValue"):setString(Strings:get("Activity_Saga_UI_5"))

	local num = data.clubAdd[self._heroId] < 0 and 0 or data.clubAdd[self._heroId]

	clubAddNode:getChildByFullName("clubAddValue1"):setString(num * 100 .. "%")
	clubAddNode:getChildByFullName("clubAddBtn"):setTouchEnabled(true)

	local function callFunc(sender, eventType)
		self:onClickClubAddBtn()
	end

	mapButtonHandlerClick(nil, clubAddNode:getChildByFullName("clubAddBtn"), {
		func = callFunc
	})

	local itemPanel = self._mainPanel:getChildByFullName("itemPanel")

	itemPanel:removeAllChildren()

	self._bagSystem = self._developSystem:getBagSystem()

	local itemAddClone = self._mainPanel:getChildByFullName("itemAddClone")

	itemAddClone:setVisible(false)

	local items = self._activity:getSupportItems()

	for i = 1, #items do
		local rewardData = {
			type = 2,
			amount = self._bagSystem:getItemCount(items[i]),
			code = items[i]
		}
		local icon = IconFactory:createRewardIcon(rewardData, {
			showAmount = true,
			notGray = true,
			isWidget = true
		})

		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setScaleNotCascade(0.8)
		icon:addTo(itemPanel):posite((i - 1) * 113 + 17, 18)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})

		local r = self._config.ClubAttrItem[items[i]]

		if r then
			local addTxt = itemAddClone:clone()

			addTxt:addTo(icon):posite(-33, 87)
			addTxt:setScale(1.25)
			addTxt:setVisible(true)

			local r = self._config.ClubAttrItem[items[i]]

			if data.clubItemUseCount[self._heroId] then
				if not data.clubItemUseCount[self._heroId][items[i]] then
					local uc = 0

					if uc then
						if uc >= #r - 1 then
							local var_14_1 = r[#r]

							if not r[#r] then
								var_14_1 = r[uc + 1]

								if not r[uc + 1] then
									local n = r[1]

									addTxt:getChildByFullName("itemAddTxt"):setString(Strings:get("Activity_Saga_UI_11") .. "+" .. n.Attr * 100 .. "%")
								end
							end
						end
					end
				end
			end
		end

		local function callFunc(sender, eventType)
			self:onClickItemBtn(rewardData)
		end

		mapButtonHandlerClick(nil, icon, {
			func = callFunc
		})
	end

	self._mainPanel:getChildByFullName("itemTipTxt"):setString(Strings:get("Activity_Saga_UI_10_wxh"))
	self._toastPanel:stopAllActions()
	self._toastPanel:setVisible(false)
	self._addPanel:stopAllActions()
	self._addPanel:setVisible(false)
end

function ActivitySagaSupportStageWxhMediator:updateStageView()
	if self._enterView == ActivitySupportViewEnter.Main then
		return
	end

	self._stagePanel:setVisible(true)
	self._mainPanel:setVisible(false)

	local data = self._curPeriod.data

	self._imageBg:loadTexture(enterBg[self._enterView])
	self._stagePanel:getChildByName("stageValue"):loadTexture(statusTextImg[data.status], 1)

	local timeTxt = statusText1[data.status]

	self._stagePanel:getChildByName("timeValue"):setString(timeTxt)

	if timeTxt == "times" then
		self:setTimer(data.resetTime, "", ActivitySupportStatus.Starting, self._stagePanel:getChildByName("timeValue"))
	end

	local popularity = data.popularity
	local heros = data.heros
	local left = 0
	local right = 0

	for heroId, idx in pairs(heros) do
		local node = self._stagePanel:getChildByName("pkNode" .. idx)

		self._stagePanel:getChildByFullName("popularityValue" .. idx):setString(Strings:get("Activity_Saga_UI_9") .. "：" .. tostring(popularity[heroId]))

		left = idx == 1 and popularity[heroId] or left
		right = idx == 2 and popularity[heroId] or right

		local roleNode = node:getChildByFullName("roleNode")

		roleNode:removeAllChildren()

		local hd = self._activity:getHeroDataById(heroId)
		local modelId = hd.ModelId
		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = modelId
		})

		img:addTo(roleNode):posite(52, -78)
		img:setScale(0.65)

		local modelName = ConfigReader:requireRecordById("RoleModel", modelId).Name

		node:getChildByFullName("name"):setString(Strings:get(modelName))

		local supportBtn = node:getChildByFullName("supportBtn")
		local clubAddBg = node:getChildByFullName("clubAddBg")
		local resultNode = node:getChildByFullName("result")
		local result = resultNode:getChildByFullName("result")
		local resultAnim = resultNode:getChildByFullName("anim")

		supportBtn:setVisible(false)
		clubAddBg:setVisible(false)
		result:setVisible(false)
		result:setLocalZOrder(999)
		resultNode:removeChildByName("jinjiAnim")

		if data.status == ActivitySupportStatus.Ended then
			result:setVisible(true)

			if data.winHeroId == heroId then
				if self._jinjiAnim then
					self._jinjiAnim:stop()
					self._jinjiAnim:removeFromParent()

					self._jinjiAnim = nil
				end

				self._jinjiAnim = cc.MovieClip:create("wuxiuyingyuan_wuxiuyingyuan")

				self._jinjiAnim:addTo(resultAnim):posite(230, 65)
				self._jinjiAnim:setName("jinjiAnim")
				result:loadTexture(resultImg.winner, 1)
			else
				result:loadTexture(resultImg.loser, 1)
			end
		else
			supportBtn:setVisible(true)
			supportBtn:setTouchEnabled(true)

			local function callFunc(sender, eventType)
				if self._curPeriod.data.status ~= ActivitySupportStatus.Starting then
					self:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get("Activity_Saga_UI_Tips_1")
					}))
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

					return
				end

				self._heroId = heroId

				self:onClickSupport()
			end

			mapButtonHandlerClick(nil, node:getChildByFullName("supportBtn"), {
				func = callFunc
			})

			if data.clubAdd and data.clubAdd[heroId] and data.clubAdd[heroId] > 0 then
				clubAddBg:setVisible(true)

				local clubAddValue = clubAddBg:getChildByFullName("clubAddValue")

				clubAddValue:setString(Strings:get("Activity_Saga_UI_5"))

				local clubAddValue1 = clubAddBg:getChildByFullName("clubAddValue1")

				clubAddValue1:setString("+" .. data.clubAdd[heroId] * 100 .. "%")
			end
		end

		local topNode = node:getChildByFullName("topNode")
		local name = topNode:getChildByFullName("name")

		name:setString(Strings:get(modelName) .. Strings:get("Activity_Saga_UI_40_wxh"))

		local txt = topNode:getChildByFullName("txt")
		local panel = topNode:getChildByFullName("panel")

		panel:removeAllChildren()

		local rankData = self._periodsInfo.rank[heroId]

		for i = 1, 3 do
			local d = rankData[i]

			if idx == 1 then
				if not self._topClonePanel1 then
					local cn = self._topClonePanel2
					local n = cn:clone()

					n:addTo(panel)
					n:setAnchorPoint(1, 1)
					n:setVisible(true)
					n:setPosition(cc.p(142, panel:getContentSize().height - (i - 1) * cn:getContentSize().height))

					local rankImg = n:getChildByFullName("rankImg")

					rankImg:loadTexture(RankTopImage[i], 1)

					if d then
						local topClonePanel = n:getChildByFullName("topClonePanel")
						local positionImg = n:getChildByFullName("positionImg")

						topClonePanel:setVisible(true)
						positionImg:setVisible(false)

						local headImg = topClonePanel:getChildByFullName("headImg")
						local headIcon, oldIcon = IconFactory:createPlayerIcon({
							clipType = 4,
							frameStyle = 1,
							id = d.headImage,
							headFrameId = d.headFrame
						})

						headIcon:addTo(headImg):center(headImg:getContentSize())
						oldIcon:setScale(0.4)
						headIcon:setScale(0.6)
						topClonePanel:getChildByFullName("name"):setString(d.nickname)
						topClonePanel:getChildByFullName("supportValue"):setString(Strings:get("Activity_Saga_UI_14") .. ":" .. CurrencySystem:formatCurrency(d.value))
					else
						local topClonePanel = n:getChildByFullName("topClonePanel")
						local positionImg = n:getChildByFullName("positionImg")

						topClonePanel:setVisible(false)
						positionImg:setVisible(true)
					end

					n:getChildByFullName("bg2"):setVisible(i == 1)
				end
			end
		end
	end

	local loadingBar = self._stagePanel:getChildByName("LoadingBar_1")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(50, 10, 10, 10))

	local ratio = 50
	local offset = 78.5

	if left ~= right then
		ratio = left / (left + right) * 100
		ratio = offset < left / (left + right) * 100 and offset or ratio
		ratio = ratio < 100 - offset and 100 - offset or ratio
	end

	loadingBar:setPercent(ratio)
end

function ActivitySagaSupportStageWxhMediator:stopEffect()
	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroEffect)

		self._heroEffect = nil
	end
end

function ActivitySagaSupportStageWxhMediator:setTalkShow(_content, _time, _ignoreCallback, _itemId)
	self:stopEffect()

	local content = _content
	local sound = content.sound
	local itemId = _itemId

	if itemId then
		local configitem = ConfigReader:getRecordById("ItemConfig", itemId)

		if configitem and itemUseAnimationByQuality[configitem.Quality] then
			local soundStr = itemUseAnimationByQuality[configitem.Quality].sound

			AudioEngine:getInstance():playEffect(soundStr, false, function()
				return
			end)
		end
	end

	self._heroEffect, _ = AudioEngine:getInstance():playEffect(sound, false, function()
		return
	end)

	local tip = Strings:get(content.tip)
	local qipaoAnim = self._toastPanel:getChildByFullName("QiPaoAnim")

	if not qipaoAnim then
		local qipao = self._toastPanel:clone()

		qipao:setVisible(true)
		qipao:setPosition(cc.p(0, 0))
		qipao:setName("ToastPanel")
		self._toastPanel:removeAllChildren()

		qipaoAnim = cc.MovieClip:create("qipao_haogandutisheng")

		qipaoAnim:addTo(self._toastPanel)
		qipaoAnim:setName("QiPaoAnim")
		qipaoAnim:setPosition(cc.p(0, 0))
		qipaoAnim:addCallbackAtFrame(21, function()
			qipaoAnim:stop()
		end)

		self._qipaoAnimPanel = qipaoAnim:getChildByFullName("qipaoPanel")

		qipao:addTo(self._qipaoAnimPanel)
	end

	qipaoAnim:gotoAndPlay(0)
	self._toastPanel:stopAllActions()
	self._toastPanel:setVisible(true)
	self._toastPanel:setOpacity(255)

	local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")

	text:setString(tip)
	text:stopAllActions()
	text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))
	self:setTextAnim()

	if not _ignoreCallback then
		self._toastPanel:runAction(cc.Sequence:create(cc.DelayTime:create(_time or 2), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._toastPanel:setOpacity(255)
			self._toastPanel:setVisible(false)
		end)))
	else
		self._toastPanel:setOpacity(255)
	end
end

function ActivitySagaSupportStageWxhMediator:setAddShow(_data, _time, _ignoreCallback)
	self._addPanel:stopAllActions()
	self._addPanel:setVisible(true)
	self._addPanel:setPosition(cc.p(self._addPanelPosX, self._addPanelPosY))

	local addTxt = _data.popularity

	if _data.allClubAdd and _data.allClubAdd > 0 then
		addTxt = addTxt .. "(" .. _data.allClubAdd .. ")"
	end

	self._addPanel:getChildByFullName("addTxt1"):setString(Strings:get("Activity_Saga_UI_9") .. "：+" .. addTxt)
	self._addPanel:getChildByFullName("addTxt2"):setString(Strings:get("Activity_Saga_UI_13") .. "：+" .. _data.allScore)
	self._addPanel:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(self._addPanelPosX, self._addPanelPosY + 50)), cc.DelayTime:create(_time or 2), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		if DisposableObject:isDisposed(self) then
			return
		end

		self._addPanel:setOpacity(255)
		self._addPanel:setVisible(false)
	end)))
end

function ActivitySagaSupportStageWxhMediator:setRoleAni(itemId)
	if DisposableObject:isDisposed(self._mainRoleNode) then
		return
	end

	local configitem = ConfigReader:getRecordById("ItemConfig", itemId)

	if configitem and itemUseAnimationByQuality[configitem.Quality] then
		local animStr = itemUseAnimationByQuality[configitem.Quality].effect
		local itemAnim = cc.MovieClip:create(animStr)

		itemAnim:addTo(self._mainRoleNode):posite(0, 50)
		itemAnim:addEndCallback(function(fid, mc)
			mc:stop()
			mc:removeFromParent()
		end)
	end
end

function ActivitySagaSupportStageWxhMediator:setTextAnim()
	local clipNode = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode")
	local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function ActivitySagaSupportStageWxhMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ActivitySagaSupportStageWxhMediator:setTimer(_times, _text, _status, _node)
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = _times * 0.001
	local remainTime = endMills - remoteTimestamp
	local fmtStr = "${H}:${M}:${S}"
	local txt = TimeUtil:formatTime(fmtStr, remainTime)

	_node:setString(_text .. txt)

	if remainTime > 0 and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			remainTime = endMills - remoteTimestamp

			if remainTime <= 0 then
				self:stopTimer()

				local params = {
					doActivityType = 101
				}

				self._activitySystem:requestDoActivity(self._activity:getId(), params, function(response)
					self._activity:synchronizePeriodsInfo(response.data)

					if DisposableObject:isDisposed(self) then
						return
					end

					self:refreshView()
				end)

				return
			end

			local txt = TimeUtil:formatTime(fmtStr, remainTime)

			_node:setString(_text .. txt)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ActivitySagaSupportStageWxhMediator:showChat()
	local view = self:getInjector():getInstance("SmallChat")

	if view then
		view:setAnchorPoint(cc.p(0.5, 0.5))
		view:setPosition(cc.p(603, 304))

		local chatViewPanel = self:getView():getChildByName("chatNode")

		chatViewPanel:addChild(view)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:enterWithData(nil)

			self._chatMediator = mediator
		end
	end
end

function ActivitySagaSupportStageWxhMediator:onClickItemBtn(_data)
	if not _data then
		return
	end

	if _data.amount < 1 then
		local param = {
			needNum = 1,
			isNeed = true,
			hasWipeTip = true,
			itemId = _data.code,
			hasNum = _data.amount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	elseif _data.amount > 1 then
		local data = {
			selectType = SelectItemType.kForUse,
			title = Strings:get("UITitle_CH_Piliangshiyong"),
			title1 = Strings:get("UITitle_EN_Piliangshiyong"),
			entryId = _data.code,
			callBackFuncx = function(_, _count)
				self:useItemCallBack(_data, _count)
			end
		}

		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local bagBatchUseSellMediator = self:getInjector():getInstance("ActivitySagaBatchUseSellView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bagBatchUseSellMediator, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, nil))
	else
		self:useItemCallBack(_data, 1)
	end
end

function ActivitySagaSupportStageWxhMediator:useItemCallBack(_data, _count)
	local data = {
		doActivityType = 102,
		itemId = _data.code,
		count = _count,
		heroId = self._heroId
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		if not response.data then
			return
		end

		if response.data.periods then
			self._activity:synchronizePeriodsInfo(response.data.periods)
		end

		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshView()
		self:setBuyEndAni(_data.code, response.data, 2)
		self:dispatch(Event:new(EVT_ACTIVITY_SAGA_SCORE))

		if response.data.buffFull then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Activity_Saga_UI_buffFull")
			}))
		end
	end)
end

function ActivitySagaSupportStageWxhMediator:setBuyEndAni(itemId, data, times)
	local content = self._activity:getTalkShow(self._activityId, self._heroId, itemId)

	if content then
		self:setTalkShow(content, times, nil, itemId)
	end

	self:setAddShow(data, times)
	self:setRoleAni(itemId)
end

function ActivitySagaSupportStageWxhMediator:onClickSupport()
	self:stopTimer()

	self._enterView = ActivitySupportViewEnter.Main

	self:updateMainView()

	local hd = self._activity:getHeroDataById(self._heroId)
	local content = hd.Bubble.Stand

	AudioEngine:getInstance():playEffect("Se_Alert_Equip_Powerup", false)
	self:setTalkShow(content, 2)
end

function ActivitySagaSupportStageWxhMediator:onClickClubAddBtn()
	local data = {
		doActivityType = 104
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		if not response.data then
			return
		end

		local list = {}

		if not response.data[self._heroId] then
			for key, value in pairs(response.data[self._heroId]) do
				list[#list + 1] = value
			end

			table.sort(list, function(a, b)
				return a.score > b.score
			end)
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

			local view = self:getInjector():getInstance("ActivitySagaSupportClubView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				data = list,
				activityId = self._activityId
			}))
		end
	end)
end

function ActivitySagaSupportStageWxhMediator:onClickScheduleBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSagaSupportSchedule(self._activityId)
end

function ActivitySagaSupportStageWxhMediator:onClickRankBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ActivitySagaSupportRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		periodId = self._periodId,
		activityId = self._activityId
	}))
end

function ActivitySagaSupportStageWxhMediator:onClickScoreBtn()
	local data = self._curPeriod.data

	if data.status == ActivitySupportStatus.Ended then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Activity_Saga_UI_15")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ActivitySagaSupportScoreRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activity = self._activity,
		activityId = self._activityId
	}))
end

function ActivitySagaSupportStageWxhMediator:onClickRule()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._activity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivitySagaSupportStageWxhMediator:onClickBack(sender, eventType)
	if self._enterView == ActivitySupportViewEnter.Stage then
		self:dismiss()
	end

	if self._enterView == ActivitySupportViewEnter.Main then
		self._enterView = ActivitySupportViewEnter.Stage

		self:updateStageView()
	end
end

function ActivitySagaSupportStageWxhMediator:updateRedPoint()
	if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
		return
	end

	local status = self._activity:getSupportScoreRewardRedPoint()

	self:getView():getChildByFullName("main.scoreBtn.redPoint"):setVisible(status)
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockDectiveMediator.lua

ActivityBlockDectiveMediator = class("ActivityBlockDectiveMediator", DmAreaViewMediator, _M)

ActivityBlockDectiveMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockDectiveMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockDectiveMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.panel_jiacheng.heroTouch"] = {
		ignoreClickAudio = true,
		func = "onClickAttrAdd"
	},
	["main.btn_emBattle"] = {
		ignoreClickAudio = true,
		func = "onClickEmBattle"
	},
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.btn_change"] = {
		ignoreClickAudio = true,
		func = "onClickchange"
	},
	["btnPanel.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["btnPanel.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.panel_item1"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	}
}
local kModelType = {
	kSurface = "Surface",
	kHero = "Hero"
}
local kModelBtnRes = {
	[kModelType.kSurface] = "common_btn_skin.png",
	[kModelType.kHero] = "wsj_yyyjs.png"
}

function ActivityBlockDectiveMediator:initialize()
	super.initialize(self)
end

function ActivityBlockDectiveMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockDectiveMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockDectiveMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._topPanel = self:getView():getChildByName("topinfo_node")
	self._main = self:getView():getChildByName("main")
	self._bgPanel = self._main:getChildByFullName("Node_17")
	self._imgTitle = self._main:getChildByFullName("Image_1")
	self._imageBg = self._main:getChildByName("bg")
	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._surfaceBtn1 = self._main:getChildByName("surfacebtn1")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._titlePanel = self._main:getChildByFullName("panel_item1")
	self._addPanel1 = self._main:getChildByFullName("panel_jiacheng")
	self._addPanel = self._main:getChildByFullName("panel_jiacheng.Panel_519")
	self._emBattleBtn = self._main:getChildByFullName("btn_emBattle")
	self._changeBtn = self._main:getChildByFullName("btn_change")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._titleText = self._titlePanel:getChildByFullName("Text_422")
	self._remainLabel = self._titlePanel:getChildByFullName("Text_423")
	self._endText = self._titlePanel:getChildByFullName("Text_423_0")
	self._dropPanel = self._main:getChildByFullName("panel_jiacheng.dropPanel")
	self._addText = self._main:getChildByFullName("panel_jiacheng.Text_381")
	self._dropText = self._main:getChildByFullName("panel_jiacheng.Text_381_0")

	self._timeNode:setScale(0)

	self._imgTitlePosX, self._imgTitlePosY = self._imgTitle:getPosition()

	self._imgTitle:setPositionX(self._imgTitle:getPositionX() + 250)
	self._imageBg:setScale(0.7)

	self._taskPosX, self._taskPosY = self._taskBtn:getPosition()
	self._changePosX, self._changePosY = self._changeBtn:getPosition()
	self._emBattlePosX, self._emBattlePosY = self._emBattleBtn:getPosition()

	self._taskBtn:setPositionY(self._taskPosY - 160)
	self._changeBtn:setPositionY(self._changePosY - 160)
	self._emBattleBtn:setPositionY(self._emBattlePosY - 160)

	self._titlePosX, self._titlePosY = self._titlePanel:getPosition()
	self._addPosX, self._addPosY = self._addPanel1:getPosition()

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(129, 149, 223, 255)
		}
	}

	self._titleText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 1,
		y = -1
	}))
end

function ActivityBlockDectiveMediator:setupTopInfoWidget()
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

function ActivityBlockDectiveMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local currencyInfo = self._activity:getResourcesBanner()
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = currencyInfo
	}

	self._topInfoWidget:updateView(config)
	self._topPanel:setContentSize(cc.size(#currencyInfo * 150 + 152, 75))
end

function ActivityBlockDectiveMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()

	self._canChangeHero = true

	self:initData()
	self:initAnim()
	self:initView()
end

function ActivityBlockDectiveMediator:initAnim()
	self._imageBg:loadTexture(self._activity:getBgPath())

	local anim = cc.MovieClip:create("ruchang_yongwuruchang")

	anim:addTo(self._bgPanel):offset(0, -75)
	anim:addCallbackAtFrame(104, function(cid, mc)
		anim:stop()
	end)

	local mc_add = anim:getChildByFullName("mc_add")

	self._titlePanel:changeParent(mc_add):center(mc_add:getContentSize())

	local mc_drop = anim:getChildByFullName("mc_drop")

	self._addPanel1:changeParent(mc_drop):center(mc_drop:getContentSize()):offset(-60, -70)

	local moveTo = cc.MoveTo:create(0.3333333333333333, cc.p(self._imgTitlePosX, self._imgTitlePosY))
	local fadeIn = cc.FadeIn:create(0.2)
	local spawn = cc.Spawn:create(moveTo, fadeIn)

	self._imgTitle:runAction(spawn)
	self._timeNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.ScaleTo:create(0.2, 1)))
	self._imageBg:runAction(cc.ScaleTo:create(0.3333333333333333, 1))
	self._taskBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.23333333333333334, cc.p(self._taskPosX, self._taskPosY + 20)), cc.MoveTo:create(0.1, cc.p(self._taskPosX, self._taskPosY))))
	self._changeBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.23333333333333334, cc.p(self._changePosX, self._changePosY + 20)), cc.MoveTo:create(0.1, cc.p(self._changePosX, self._changePosY))))
	self._emBattleBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.23333333333333334, cc.p(self._emBattlePosX, self._emBattlePosY + 20)), cc.MoveTo:create(0.1, cc.p(self._emBattlePosX, self._emBattlePosY))))
end

function ActivityBlockDectiveMediator:setAdditionHero()
	local btns = self._activity:getButtonConfig()

	if btns.blockParams and btns.blockParams.heroes then
		local length = #btns.blockParams.heroes

		for i = 1, length do
			local pos = self._addPanel:getChildByName("item" .. i)

			if pos then
				local id = btns.blockParams.heroes[i]
				local icon = IconFactory:createHeroIconForReward({
					star = 0,
					id = id
				})

				icon:addTo(self._addPanel):setScale(0.5)
				icon:setAnchorPoint(cc.p(0, 0))
				icon:setPosition(pos:getPosition())
				icon:setRotation(-15)

				local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

				image:addTo(icon):posite(92, 20):setScale(1.2)
			end
		end
	end

	if btns.blockParams and btns.blockParams.rewards then
		local length = #btns.blockParams.rewards

		for i = 1, length do
			local reward = btns.blockParams.rewards[i]
			local nodepos = self._dropPanel:getChildByName("Node_" .. i)

			if nodepos and reward then
				local icon = IconFactory:createRewardIcon(reward, {
					showAmount = false,
					notShowQulity = true
				})

				icon:addTo(self._dropPanel):setScale(0.26)
				icon:setPosition(nodepos:getPosition())
			end
		end
	end
end

function ActivityBlockDectiveMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityBlockDectiveMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockDectiveMediator:initData()
	self._taskActivities = self._activity:getTaskActivities()
	self._monsterShopActivity = self._activity:getMonsterShopActivity()
	self._blockActivity = self._activity:getBlockMapActivity()
	self._roleIndex = 1
	self._roles = self._activity:getRoleParams()
end

function ActivityBlockDectiveMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:setAdditionHero()
	self:playBackgroundMusic()
end

function ActivityBlockDectiveMediator:initInfo()
	local emBattleText2 = self:getView():getChildByFullName("main.btn_emBattle.Text_2")
	local emBattleText3 = self:getView():getChildByFullName("main.btn_emBattle.Text_3")
	local rewardtext3 = self:getView():getChildByFullName("main.btn_change.Text_1")

	rewardtext3:setString(Strings:get("Activity_Detective_UI_05"))

	local taskBtntext = self:getView():getChildByFullName("main.taskBtn.text")
	local taskBtntext_1 = self:getView():getChildByFullName("main.taskBtn.text_1")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		for i = 2, 5 do
			local text = self._changeBtn:getChildByName("Text_" .. i)

			text:setVisible(false)
		end

		taskBtntext:setVisible(false)
		taskBtntext_1:setVisible(true)
		emBattleText3:setVisible(false)
		emBattleText2:setPosition(cc.p(50, 25))
		rewardtext3:setPosition(cc.p(62, 25))
		rewardtext3:setFontSize(24)
		rewardtext3:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		rewardtext3:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		rewardtext3:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		rewardtext3:getVirtualRenderer():setDimensions(90, 50)
		emBattleText2:setFontSize(24)
	else
		taskBtntext_1:setVisible(false)

		for i = 1, 5 do
			local text = self._changeBtn:getChildByName("Text_" .. i)

			text:setString(Strings:get("Activity_Detective_UI_0" .. i + 4))
		end
	end

	self._titleText:setString(Strings:get("Activity_Detective_UI_01"))
	self._addText:setString(Strings:get("Activity_Detective_UI_03"))
	self._dropText:setString(Strings:get("Activity_Detective_UI_04"))
	self._endText:setString(Strings:get("Activity_Detective_UI_02"))
	self._remainLabel:setPositionX(self._endText:getPositionX() - self._endText:getContentSize().width)

	local redPoint = self._taskBtn:getChildByName("redPoint")
	local hasRed = false

	if self._taskActivities then
		for i = 1, #self._taskActivities do
			if self._taskActivities[i]:hasRedPoint() then
				hasRed = true

				break
			end
		end
	end

	redPoint:setVisible(hasRed)

	local redPoint = self._titlePanel:getChildByName("redPoint")

	redPoint:setVisible(self._blockActivity and self._blockActivity:hasRedPoint())
end

function ActivityBlockDectiveMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._activity:getTimeStr())

	if self._activity then
		if not self._blockActivity then
			self._remainLabel:setString(Strings:get("SubActivity_Halloween_EndTip_AB_1st"))

			return
		end

		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local timeStamp = self._blockActivity:getTimeFactor()
		local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
		local table = {
			year = y,
			month = mon,
			day = d,
			hour = h,
			min = m,
			sec = s
		}

		self._endTime = TimeUtil:timeByRemoteDate(table)

		if remoteTimestamp < self._endTime then
			if self._timer then
				return
			end

			local function checkTimeFunc()
				remoteTimestamp = self._activitySystem:getCurrentTime()

				local remainTime = self._endTime - remoteTimestamp

				if remainTime <= 0 then
					if DisposableObject:isDisposed(self) then
						return
					end

					self._timer:stop()

					self._timer = nil

					self._remainLabel:setString(Strings:get("SubActivity_Halloween_EndTip_AB_1st"))

					return
				end

				local str = ""
				local fmtStr = "${d}:${H}:${M}:${S}"
				local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
				local parts = string.split(timeStr, ":", nil, true)
				local timeTab = {}

				timeTab.day = tonumber(parts[1])
				timeTab.hour = tonumber(parts[2])
				timeTab.min = tonumber(parts[3])

				if timeTab.day > 0 then
					str = timeTab.day .. Strings:get("TimeUtil_Day")
				elseif timeTab.hour > 0 then
					str = timeTab.hour .. Strings:get("TimeUtil_Hour")
				else
					timeTab.min = math.max(1, timeTab.min)
					str = timeTab.min .. Strings:get("TimeUtil_Min")
				end

				self._remainLabel:setString(Strings:get("Activity_Detective_UI_10", {
					time = str
				}))
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		end
	end
end

function ActivityBlockDectiveMediator:initRoleTimer()
	if self._roleTimer then
		self._roleTimer:stop()
	end

	local function checkTimeFunc()
		self._roleIndex = self._roleIndex + 1

		if self._roleIndex > #self._roles then
			self._roleIndex = 1
		end

		self:updateRolePanel()
	end

	self._roleTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 5, false)
end

function ActivityBlockDectiveMediator:updateRolePanel()
	local type_ = self._roles[self._roleIndex].type
	local model = self._roles[self._roleIndex].model

	self._roleUrl = self._roles[self._roleIndex].url

	local desc = Strings:get(self._roles[self._roleIndex].desc)

	self._tipNode:getChildByName("text"):setString(desc)

	local showTip = true

	if self._roleUrl then
		local showSurface = self._roleUrl ~= ""

		if type_ == kModelType.kSurface then
			local surfaces = self._surfaceSystem:getSurfaceById(model)

			if surfaces:getUnlock() then
				showTip = false
			end

			model = ConfigReader:getDataByNameIdAndKey("Surface", model, "Model")
		elseif type_ == kModelType.kHero then
			local hero = self._heroSystem:getHeroById(model)

			if hero then
				showTip = false
			end

			model = IconFactory:getRoleModelByKey("HeroBase", model)
		end

		self._roleNode:removeAllChildren()

		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = model
		})

		img:addTo(self._roleNode):posite(50, -50)
		img:setScale(0.78)

		if not self._roleMark then
			img:setScale(1)

			local posX, posY = img:getPosition()

			img:setPositionX(posX - 75)

			local moveTo = cc.MoveTo:create(0.3333333333333333, cc.p(posX, posY))
			local fadeIn = cc.FadeIn:create(0.2)
			local scale = cc.ScaleTo:create(0.3333333333333333, 0.78)
			local spawn = cc.Spawn:create(moveTo, fadeIn, scale)

			img:runAction(spawn)
		end

		self._roleMark = true

		self._surfaceBtn:setVisible(showTip and showSurface)
		self._surfaceBtn1:setVisible(not showTip)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByFullName("img"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityBlockDectiveMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockDectiveMediator:refreshView()
	self:doReset()
end

function ActivityBlockDectiveMediator:onClickBack(sender, eventType)
	self:getView():stopAllActions()
	self:dismiss()
end

function ActivityBlockDectiveMediator:onClickRule()
	local rules = self._activity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockDectiveMediator:onClickAttrAdd()
	if not self._blockActivity then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._blockActivity:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockDectiveMediator:onClickTask()
	self._taskActivities = self._activity:getTaskActivities()

	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityBlockDectiveMediator:onClickchange()
	self._monsterShopActivity = self._activity:getMonsterShopActivity()

	if not self._monsterShopActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.shopEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterBlockMonsterShopView(self._activityId)
end

function ActivityBlockDectiveMediator:onClickEmBattle()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterTeam(self._activityId, self._blockActivity)
end

function ActivityBlockDectiveMediator:onClickSurface()
	if not self._roleUrl or self._roleUrl == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._roleUrl)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	else
		entry:response(context, params)
	end
end

function ActivityBlockDectiveMediator:onClickStage()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterBlockMap(self._activityId)
end

function ActivityBlockDectiveMediator:onClickLeft()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.5)

	self._roleIndex = self._roleIndex - 1

	if self._roleIndex < 1 then
		self._roleIndex = #self._roles
	end

	self:updateRolePanel()
end

function ActivityBlockDectiveMediator:onClickRight()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.5)

	self._roleIndex = self._roleIndex + 1

	if self._roleIndex > #self._roles then
		self._roleIndex = 1
	end

	self:updateRolePanel()
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockMusicMediator.lua

ActivityBlockMusicMediator = class("ActivityBlockMusicMediator", DmAreaViewMediator, _M)

ActivityBlockMusicMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockMusicMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockMusicMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.stagePanel.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.stagePanel.heroTouch"] = {
		ignoreClickAudio = true,
		func = "onClickAttrAdd"
	},
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.teamBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTeam"
	},
	["main.eggBtn"] = {
		ignoreClickAudio = true,
		func = "onClickEgg"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.btnNode.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.btnNode.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
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

function ActivityBlockMusicMediator:initialize()
	super.initialize(self)
end

function ActivityBlockMusicMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockMusicMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockMusicMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._titleImage = self._main:getChildByName("titleImage")

	self._titleImage:ignoreContentAdaptWithSize(true)

	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._stagePanel = self._main:getChildByName("stagePanel")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._eggBtn = self._main:getChildByName("eggBtn")
	self._teamBtn = self._main:getChildByName("teamBtn")
end

function ActivityBlockMusicMediator:setTimerString(timeStr, timeTip)
	if not self._richTextRemainTime then
		local remainLabel = self._stagePanel:getChildByName("remainTime")

		remainLabel:setString("")

		self._richTextRemainTime = ccui.RichText:createWithXML("", {})

		self._richTextRemainTime:setAnchorPoint(remainLabel:getAnchorPoint())
		self._richTextRemainTime:setPosition(cc.p(remainLabel:getPosition()))
		self._richTextRemainTime:addTo(remainLabel:getParent())
	end

	local txt = "<outline color='#618A2B' size = '2'><font face='asset/font/CustomFont_FZYH_R.TTF' size='20' color='#FFD200'>" .. timeStr .. "</font><font face='asset/font/CustomFont_FZYH_R.TTF' size='20' color='#FFFFFF'>" .. timeTip .. "</font></outline>"

	self._richTextRemainTime:setString(txt)
end

function ActivityBlockMusicMediator:setupTopInfoWidget()
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

function ActivityBlockMusicMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = self._model:getResourcesBanner()
	}

	self._topInfoWidget:updateView(config)
end

function ActivityBlockMusicMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock
	self._model = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._model then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()

	self._canChangeHero = true

	self:initData()
	self:initView()
end

function ActivityBlockMusicMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockMusicMediator:initData()
	self._blockActivity = self._model:getBlockMapActivity()
	self._taskActivities = self._model:getTaskActivities()
	self._jumpActivity = self._model:getJumpActivity()
	self._roleIndex = 1
	self._roles = self._model:getRoleParams()
end

function ActivityBlockMusicMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
end

function ActivityBlockMusicMediator:playBackgroundMusic()
	local bgm = self._model:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityBlockMusicMediator:initInfo()
	local eggBtnText = self:getView():getChildByFullName("main.eggBtn.text")
	local taskBtnText = self:getView():getChildByFullName("main.taskBtn.text")
	local teamBtnText = self:getView():getChildByFullName("main.teamBtn.text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		print("getCurrentLanguage")
		eggBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		eggBtnText:getVirtualRenderer():setDimensions(90, 50)
		eggBtnText:setPosition(cc.p(50, 17))
		taskBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		taskBtnText:getVirtualRenderer():setDimensions(90, 50)
		taskBtnText:setPosition(cc.p(50, 0))
		teamBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		teamBtnText:getVirtualRenderer():setDimensions(90, 50)
		teamBtnText:setPosition(cc.p(50, 0))
	else
		taskBtnText:getVirtualRenderer():setLineSpacing(-15)
		eggBtnText:getVirtualRenderer():setLineSpacing(-15)
		teamBtnText:getVirtualRenderer():setLineSpacing(-15)
		eggBtnText:getVirtualRenderer():setDimensions(30, 102)
		taskBtnText:getVirtualRenderer():setDimensions(25, 73)
		teamBtnText:getVirtualRenderer():setDimensions(25, 73)
	end

	self._imageBg:loadTexture(self._model:getBgPath())
	self._titleImage:loadTexture(self._model:getTitlePath(), 1)

	local btns = self._model:getButtonConfig()
	local tipStr = self._model:getActivityConfig().SubActivityEndTip

	self._endTip = {}

	local redPoint = self._stagePanel:getChildByName("redPoint")

	redPoint:setVisible(self._blockActivity and self._blockActivity:hasRedPoint())

	local title = self._stagePanel:getChildByName("title")
	local image = self._stagePanel:getChildByName("image")

	image:ignoreContentAdaptWithSize(true)

	local itemNode = self._stagePanel:getChildByName("itemNode")

	itemNode:removeAllChildren()

	local heroNode = self._stagePanel:getChildByName("heroNode")

	heroNode:removeAllChildren()

	if btns.blockParams then
		image:loadTexture(btns.blockParams.icon .. ".png", 1)
		title:setString(btns.blockParams.title)

		if btns.blockParams.rewards then
			local length = math.ceil(#btns.blockParams.rewards / 4)

			for i = 1, length do
				for jj = 1, 4 do
					local index = 4 * (i - 1) + jj
					local reward = btns.blockParams.rewards[index]

					if reward then
						local icon = IconFactory:createRewardIcon(reward, {
							showAmount = false,
							notShowQulity = true
						})

						icon:addTo(itemNode):setScale(0.26)

						local x = 33 * (jj - 1)
						local y = -30 * (i - 1)

						icon:setPosition(cc.p(x, y))
					end
				end
			end
		end

		if btns.blockParams.heroes then
			local length = #btns.blockParams.heroes

			for i = 1, length do
				local id = btns.blockParams.heroes[i]
				local icon = IconFactory:createHeroIconForReward({
					star = 0,
					id = id
				})

				icon:addTo(heroNode):setScale(0.5)

				local x = 30 * (3 - length) + 68 * (i - 1)

				icon:setPositionX(x)

				local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

				image:addTo(icon):posite(92, 20):setScale(1.2)
			end
		end

		self._endTip.blockEndTip = Strings:get(tipStr, {
			activityId = title
		})
	end

	local redPoint = self._eggBtn:getChildByName("redPoint")

	redPoint:setVisible(self._jumpActivity and self._jumpActivity:hasRedPoint())

	local image = self._eggBtn:getChildByName("image")

	image:ignoreContentAdaptWithSize(true)

	local text = self._eggBtn:getChildByName("text")

	if btns.eggParams and btns.eggParams.icon then
		image:loadTexture(btns.eggParams.icon .. ".png", 1)

		local title = btns.eggParams.title

		text:setString(title)

		self._endTip.eggEndTip = Strings:get(tipStr, {
			activityId = title
		})
	end

	if self._model:getActivityConfig().ButtonIcon then
		image:loadTexture(self._model:getActivityConfig().ButtonIcon .. ".png", 1)
	end

	if self._model:getActivityConfig().ButtonText then
		text:setString(Strings:get(self._model:getActivityConfig().ButtonText))
	end

	local redPoint = self._teamBtn:getChildByName("redPoint")

	redPoint:setVisible(false)

	self._endTip.taskEndTip = Strings:get(tipStr, {
		activityId = Strings:get("ActivityBlock_UI_10")
	})

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

	if not self._stageAnim then
		self._stageAnim = cc.MovieClip:create("yinyuejie_TX_senlinyinyuejie")

		self._stageAnim:setPosition(cc.p(150, 150))
		self._stageAnim:addTo(self._stagePanel)
	end
end

function ActivityBlockMusicMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._model:getTimeStr())

	if self._blockActivity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()

		self._endTime = self._blockActivity:getEndTime() / 1000

		if remoteTimestamp < self._endTime then
			if self._timer then
				return
			end

			local function checkTimeFunc()
				remoteTimestamp = self._activitySystem:getCurrentTime()

				local remainTime = self._endTime - remoteTimestamp

				if remainTime <= 0 then
					self._timer:stop()

					self._timer = nil

					self:setTimerString("", Strings:get("ActivityBlock_UI_8"))

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

				self:setTimerString(str, Strings:get("ActivityBlock_UI_24", {
					time = ""
				}))
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		else
			self:setTimerString("", Strings:get("ActivityBlock_UI_8"))
		end
	else
		self:setTimerString("", Strings:get("ActivityBlock_UI_8"))
	end
end

function ActivityBlockMusicMediator:initRoleTimer()
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

function ActivityBlockMusicMediator:updateRolePanel()
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

		img:addTo(self._roleNode):posite(50, -100)
		img:setScale(0.78)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByName("Image_71"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityBlockMusicMediator:doReset()
	self:stopTimer()

	self._model = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockMusicMediator:refreshView()
	self:doReset()
end

function ActivityBlockMusicMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockMusicMediator:onClickStage()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterBlockMap(self._activityId)
end

function ActivityBlockMusicMediator:onClickAttrAdd()
	if not self._blockActivity then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._blockActivity:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockMusicMediator:onClickRule()
	local rules = self._model:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockMusicMediator:onClickTask()
	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityBlockMusicMediator:onClickTeam()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterTeam(self._activityId, self._blockActivity)
end

function ActivityBlockMusicMediator:onClickEgg()
	local url = self._model:getActivityConfig().ExchangeUrl

	if url then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end

		return
	end

	if not self._jumpActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.eggEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterEasterEgg({
		activityId = self._activityId
	})
end

function ActivityBlockMusicMediator:onClickSurface()
	if not self._roleUrl or self._roleUrl == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._roleUrl)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	else
		entry:response(context, params)
	end
end

function ActivityBlockMusicMediator:onClickLeft()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._roleIndex = self._roleIndex - 1

	if self._roleIndex < 1 then
		self._roleIndex = #self._roles
	end

	self:updateRolePanel()
end

function ActivityBlockMusicMediator:onClickRight()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._roleIndex = self._roleIndex + 1

	if self._roleIndex > #self._roles then
		self._roleIndex = 1
	end

	self:updateRolePanel()
end

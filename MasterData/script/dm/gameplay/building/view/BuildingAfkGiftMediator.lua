-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingAfkGiftMediator.lua

BuildingAfkGiftMediator = class("BuildingAfkGiftMediator", DmAreaViewMediator, _M)

BuildingAfkGiftMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingAfkGiftMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
BuildingAfkGiftMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
BuildingAfkGiftMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
BuildingAfkGiftMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

local function formatUnorderTable(unorderTable, compFunc)
	local _tab = {}

	for k, v in pairs(unorderTable) do
		_tab[#_tab + 1] = k
	end

	if compFunc then
		table.sort(_tab, compFunc)
	end

	return _tab
end

local kBtnHandlers = {
	["leftActionPanel.panel.btnPanel.node.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["leftActionPanel.panel.btnPanel.node.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["leftActionPanel.panel.btnPanel.btnGift"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGift"
	},
	["leftActionPanel.panel.btnPanel.btnDate"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDate"
	},
	["leftActionPanel.panel.btnPanel.btnEvent"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickEvent"
	},
	bustbtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBust"
	},
	movebtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMove"
	}
}
local kPanelType = {
	kBtnPanel = 1,
	kGiftPanel = 3,
	kSetBoardHero = 4,
	kActionPanel = 2
}
local kTabBtnData = {
	{
		viewName = "HeroShowOwnView",
		tabName = Strings:get("Board_Hero_Set_Text1"),
		tabName1 = Strings:get("UITitle_EN_Kanbanniang")
	},
	{
		viewName = "HeroStrengthEvolutionView",
		tabName = Strings:get("Board_Hero_Set_Text2"),
		tabName1 = Strings:get("UITitle_EN_Beijing")
	}
}
local kRightTabPos = {
	{
		cc.p(20, 297)
	},
	{
		cc.p(-21, 345),
		cc.p(12, 254)
	}
}
local heroVoiceList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_VoiceList", "content")

function BuildingAfkGiftMediator:initialize()
	super.initialize(self)
end

function BuildingAfkGiftMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._playInfoWidget then
		self._playInfoWidget:dispose()

		self._playInfoWidget = nil
	end

	if self._dailyGiftTimer then
		LuaScheduler:getInstance():unschedule(self._dailyGiftTimer)

		self._dailyGiftTimer = nil
	end

	super.dispose(self)
end

function BuildingAfkGiftMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._shopSystem = self._developSystem:getShopSystem()
	self._settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()
	self._bustBtn = self:getView():getChildByFullName("bustbtn")

	self._bustBtn:setVisible(false)

	self._moveBtn = self:getView():getChildByFullName("movebtn")

	self._moveBtn:setVisible(false)

	self._sendBtn = self:bindWidget("leftActionPanel.giftPanel.sendBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickGiftSend, self)
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_AFKGIFT_SET_SHOWHERO, self, self.changeHero)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_VIEWBG_PREVIEW, self, self.setMainBg)

	local image1 = self:getView():getChildByName("Image_3")

	AdjustUtils.ignorSafeAreaRectForNode(image1, AdjustUtils.kAdjustType.Left)

	local image2 = self:getView():getChildByName("Image_2")

	AdjustUtils.ignorSafeAreaRectForNode(image2, AdjustUtils.kAdjustType.Right)
end

function BuildingAfkGiftMediator:enterWithData(data)
	self._canSetBoardHero = data.canSetBoardHero
	self._hugAdd = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroAfkEventLove", "content")
	self._canChange = true

	self:initData(data)
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initView()
	self:dailyGiftTimer()

	if data.type == kPanelType.kBtnPanel then
		self._timer = LuaScheduler:getInstance():schedule(handler(self, self.onTick), 1, false)
	end

	if self._canSetBoardHero then
		local soundId = "Voice_" .. self._heroId .. "_36"
		local trueSoundId

		self._soundId, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			self._soundId = nil

			if checkDependInstance(self) then
				self._talkPanel:setVisible(false)
			end
		end)

		local str = ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc")
		local text = self._talkPanel:getChildByFullName("clipNode.text")

		text:setString(Strings:get(str))
	elseif data.type == kPanelType.kGiftPanel then
		local random = math.random(0, 1)
		local soundId = random == 0 and "Voice_" .. self._heroId .. "_66" or "Voice_" .. self._heroId .. "_67"
		local str = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc")
		local text = self._talkPanel:getChildByFullName("clipNode.text")

		text:setString(Strings:get(str))

		self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			self._soundId = nil

			if checkDependInstance(self) then
				self._talkPanel:setVisible(false)
			end
		end)
	else
		self._talkPanel:setVisible(false)
	end
end

function BuildingAfkGiftMediator:dailyGiftTimer()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)

	self._dailyGiftTimer = LuaScheduler:getInstance():schedule(function()
		local isActivity = activitySystem:hasRedPointForActivity(DailyGift)

		self._dailyGiftBtn:setGray(not isActivity)
		self._dailyGiftBtn:getChildByName("redPoint"):setVisible(isActivity)
	end, 1, true)
end

function BuildingAfkGiftMediator:resumeWithData()
	self:initView()
end

function BuildingAfkGiftMediator:resetView(data)
	self:initData(data)
	self:updateView()
end

function BuildingAfkGiftMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topNode")

	topInfoNode:setLocalZOrder(999)

	local infoConfig = {
		CurrencyIdKind.kDiamond,
		CurrencyIdKind.kPower,
		CurrencyIdKind.kCrystal,
		CurrencyIdKind.kGold
	}
	local config = {
		style = 1,
		currencyInfo = infoConfig,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickRemove, self)
		},
		title = Strings:get("Daily_Gift_Title")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BuildingAfkGiftMediator:onClickBack()
	if self._type ~= kPanelType.kBtnPanel then
		self:resetView({
			type = kPanelType.kBtnPanel,
			id = self._heroId
		})

		return
	end

	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end

	self:dismiss()
end

function BuildingAfkGiftMediator:onClickRemove()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end

	if self._canSetBoardHero then
		local settingSystem = self:getInjector():getInstance(SettingSystem)
		local curBgId = settingSystem:getHomeBgId()

		if self._bgImageId ~= curBgId then
			settingSystem:setHomeBgId(self._bgImageId)
			self:dispatch(Event:new(EVT_HOME_SET_VIEWBG))
		end

		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

		customDataSystem:setValue(PrefixType.kGlobal, "BoardHeroId", self._heroId)
		self:dispatch(Event:new(EVT_HOME_SET_SHOWHERO, {
			heroId = self._heroId
		}))
	end

	self:dismiss()
end

function BuildingAfkGiftMediator:initData(data)
	self._curIdIndex = 1
	self._type = data.type
	self._heroId = data.id

	self:updateData()

	self._herosList = self._heroSystem:getOwnHeroIds()
	self._teamPets = data.dropHeroList or {}
	self._idList = {}

	for i = 1, #self._teamPets do
		self._idList[#self._idList + 1] = self._teamPets[i].id
	end

	for i = 1, #self._idList do
		if self._idList[i] == data.id then
			self._curIdIndex = i

			break
		end
	end

	self._lastRandom = -1
end

function BuildingAfkGiftMediator:updateData()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroObj = self._heroData
	self._actionStatus = nil

	if self._heroObj then
		if self._heroObj:getNextEventType() == "gift" then
			self._actionStatus = kPanelType.kGiftPanel
		elseif self._heroObj:getNextEventType() == "hug" then
			self._actionStatus = kPanelType.kActionPanel
		end
	end
end

function BuildingAfkGiftMediator:initWidgetInfo()
	self._main = self:getView()
	self._heroPanel = self._main:getChildByFullName("heroPanel")
	self._talkPanel = self._main:getChildByFullName("leftActionPanel.panel.adjustNode.talkPanel")
	self._btnPanel = self._main:getChildByFullName("leftActionPanel.panel.btnPanel")
	self._btnGift = self._btnPanel:getChildByFullName("btnGift")
	self._btnDate = self._btnPanel:getChildByFullName("btnDate")
	self._btnEvent = self._btnPanel:getChildByFullName("btnEvent")
	self._actionPanel = self._main:getChildByFullName("leftActionPanel.actionPanel")
	self._handImage = self._actionPanel:getChildByFullName("handImage")
	self._handPosition = {
		x = self._handImage:getPositionX(),
		y = self._handImage:getPositionY()
	}
	self._giftPanel = self._main:getChildByFullName("leftActionPanel.giftPanel")
	self._dailyGiftBtn = self._main:getChildByFullName("leftActionPanel.panel.btnPanel.btnDailyGift")

	self._dailyGiftBtn:setVisible(false)

	self._tabClone = self:getView():getChildByName("tabClone")
	self._rightActNode = self:getView():getChildByFullName("right_node")

	local text = self._talkPanel:getChildByFullName("clipNode.text")

	text:setLineSpacing(4)
	text:getVirtualRenderer():setMaxLineWidth(330)

	local bubbleBg = self._talkPanel:getChildByName("talkBg")

	self._primeTextPosX = text:getPositionX()
	self._primeTextPosY = text:getPositionY()

	bubbleBg:ignoreContentAdaptWithSize(true)
	self:setMainBg()

	local leftBtn = self._btnPanel:getChildByFullName("node.left")
	local rightBtn = self._btnPanel:getChildByFullName("node.right")

	CommonUtils.runActionEffect(leftBtn:getChildByName("leftBtn"), "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(rightBtn:getChildByName("rightBtn"), "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)
	leftBtn:setVisible(not self._canSetBoardHero)
	rightBtn:setVisible(not self._canSetBoardHero)

	if self._canSetBoardHero then
		self._rightActNode:setVisible(true)
		self._moveBtn:setVisible(true)
		self:createTabController()
	else
		self._rightActNode:setVisible(false)
	end

	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._heroId)

	self._talkPanel:setVisible(not isHide)
	self._btnGift:getChildByFullName("name_1"):setString(Strings:get("Village_UI3") .. Strings:get("Village_UI4"))
	self._btnDate:getChildByFullName("name_1"):setString(Strings:get("Village_UI5") .. Strings:get("Village_UI6"))
end

function BuildingAfkGiftMediator:initTabBtn()
	self._tabBtns = {}

	local index = 0

	for i = 1, #kTabBtnData do
		local data = kTabBtnData[i]
		local tabName = data.tabName
		local tabName1 = data.tabName1

		index = index + 1

		local btn = self._tabClone:clone()

		btn:addTo(self:getView():getChildByFullName("right_node"))
		btn:getChildByFullName("dark_1.text"):setString(tabName)
		btn:getChildByFullName("light_1.text"):setString(tabName)

		if btn:getChildByFullName("dark_1.text1") then
			btn:getChildByFullName("dark_1.text1"):setString(tabName1)
			btn:getChildByFullName("light_1.text1"):setString(tabName1)
		end

		btn:setTag(i)

		btn.trueIndex = index
		self._tabBtns[i] = btn
	end

	local length = table.nums(self._tabBtns)
	local positions = kRightTabPos[length]

	for i, v in pairs(self._tabBtns) do
		local btn = self._tabBtns[i]
		local index = btn.trueIndex

		btn:setPosition(positions[index])
	end
end

function BuildingAfkGiftMediator:createTabController()
	self:initTabBtn()

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end, {
		showAnim = 2
	})

	self._tabController:selectTabByTag(1)
end

function BuildingAfkGiftMediator:onClickTab(name, tag)
	local view
	local viewNode = self:getView():getChildByName("viewNode")

	viewNode:removeAllChildren()

	if tag == 1 then
		self._bustBtn:setVisible(true)

		view = self:getInjector():getInstance("SetBoardHeroView")

		view:addTo(viewNode)
		AdjustUtils.adjustLayoutByType(view, AdjustUtils.kAdjustType.Right)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		mediator:enterWithData({
			heroId = self._heroId,
			mediator = self
		})
	elseif tag == 2 then
		self._bustBtn:setVisible(true)

		view = self:getInjector():getInstance("SetHomeBgPopView")

		view:addTo(viewNode)
		AdjustUtils.adjustLayoutByType(view, AdjustUtils.kAdjustType.Right)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		mediator:enterWithData({
			setHomeBgId = self._bgImageId
		})
	end
end

function BuildingAfkGiftMediator:setMainBg(event)
	local eventData

	if event then
		eventData = event:getData()
	end

	local bgImageId, needShowTips

	if eventData and eventData.bgId then
		bgImageId = eventData.bgId
		needShowTips = true
	else
		local settingSys = self:getInjector():getInstance(SettingSystem)

		bgImageId = settingSys:getHomeBgId()
	end

	self._bgImageId = bgImageId
	self._switchBgTag = -999

	local bgImage = self:getView():getChildByFullName("homeBgPanel.bgImage")
	local flashPanel = self:getView():getChildByFullName("homeBgPanel.bgFlashPanel")

	flashPanel:removeAllChildren()

	local timeTable = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "Loop")
	local keyTab = formatUnorderTable(timeTable, function(a, b)
		local aParts = string.split(a, ":", nil, true)
		local bParts = string.split(b, ":", nil, true)
		local aStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = aParts[1],
			min = aParts[2],
			sec = aParts[3]
		})
		local bStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = bParts[1],
			min = bParts[2],
			sec = bParts[3]
		})

		return aStamp < bStamp
	end)
	local curTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local switchBgTag = #keyTab

	local function comp(switchTime, realTime)
		local parts = string.split(switchTime, ":", nil, true)
		local switchTimeStemp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = parts[1],
			min = parts[2],
			sec = parts[3]
		})

		return switchTimeStemp <= realTime
	end

	for k, v in ipairs(keyTab) do
		if not comp(keyTab[k], curTimeStamp) then
			switchBgTag = k - 1

			break
		end
	end

	if switchBgTag < 1 then
		switchBgTag = #keyTab
	end

	if switchBgTag == self._switchBgTag then
		return
	end

	self._switchBgTag = switchBgTag

	local tabValue = timeTable[keyTab[self._switchBgTag]]
	local BGBackgroundId = tabValue.BG
	local imageInfo = ConfigReader:getRecordById("BackGroundPicture", BGBackgroundId)
	local winSize = cc.Director:getInstance():getWinSize()

	if imageInfo.Picture and imageInfo.Picture ~= "" then
		bgImage:setVisible(true)
		bgImage:ignoreContentAdaptWithSize(true)
		bgImage:loadTexture("asset/scene/" .. imageInfo.Picture .. ".jpg")

		if winSize.height < 641 then
			bgImage:setScale(winSize.width / 1386)
		end
	end

	local flashId = imageInfo.Flash1

	if flashId and flashId ~= "" then
		local mc = cc.MovieClip:create(flashId)

		mc:addTo(flashPanel):center(flashPanel:getContentSize())
		self:setClimateScene(mc)

		if winSize.height < 641 then
			mc:setScale(winSize.width / 1386)
		end

		local extFlashId = imageInfo.Flash2

		if extFlashId and extFlashId ~= "" then
			local extMc = cc.MovieClip:create(extFlashId)

			if extMc then
				extMc:addTo(flashPanel):center(flashPanel:getContentSize())
				extMc:setScale(winSize.width / 1386)
			end
		end
	end

	if imageInfo.Extra and imageInfo.Extra ~= "" then
		local extraView = cc.CSLoader:createNode("asset/ui/" .. imageInfo.Extra .. ".csb")

		extraView:addTo(flashPanel):center(flashPanel:getContentSize())

		if winSize.height < 641 then
			extraView:setScale(winSize.width / 1386)
		end
	end

	local settingSystem = self:getInjector():getInstance(SettingSystem)
	local isRandom = settingSystem:getSettingModel():getRoleAndBgRandom()

	needShowTips = needShowTips and not isRandom

	if needShowTips then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tip_SetHomeBG_Suc")
		}))
	end
end

function BuildingAfkGiftMediator:setClimateScene(node)
	local settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()
	local weathData = settingModel:getWeatherData()
	local climateDay = GameStyle:getClimateById(weathData.conditionIdDay)

	if Climate2LayerName[climateDay] then
		local layer = node:getChildByName(Climate2LayerName[climateDay])

		if layer then
			local climateMc = cc.MovieClip:create(Climate2MCName[climateDay])

			climateMc:addTo(layer)
		end
	end
end

function BuildingAfkGiftMediator:updateHero()
	self._touchTimes = 0

	local heroNameText = self:getView():getChildByName("heroName")
	local name, _ = self._heroData:getName()

	heroNameText:setString(name)

	local heroNameBg = self:getView():getChildByName("heroNameBg")
	local nameSize = heroNameText:getContentSize()

	heroNameBg:setContentSize(cc.size(nameSize.width + 25, 96.36))
	self._heroPanel:removeAllChildren()

	self._sharedSpine = nil

	local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = self._heroData:getModel(),
		useAnim = self._settingModel:getRoleDynamic()
	})

	img:setTouchEnabled(true)
	img:setScale(1.1)
	img:setPosition(cc.p(self._heroPanel:getContentSize().width / 2 - 10, self._heroPanel:getContentSize().height / 2 - 44))
	self._heroPanel:addChild(img)

	local size = img:getContentSize()
	local offSetX = size.width / 2

	if spineani then
		spineani:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)

		self._sharedSpine = spineani
	end

	local surfaceId = self._heroData:getSurfaceId()
	local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
	local num = #surfaceData

	for i = 1, num do
		local _info = surfaceData[i]
		local touchPanel = ccui.Layout:create()

		touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

		local point = _info.point

		if point[1] == "all" then
			local size = img:getContentSize()

			touchPanel:setContentSize(cc.size(size.width / 2 * picInfo.zoom, size.height * picInfo.zoom))
			touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
		else
			touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
			touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + offSetX, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
		end

		if GameConfigs.HERO_TOUCHVIEW_DEBUG then
			touchPanel:setBackGroundColorType(1)
			touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
			touchPanel:setBackGroundColorOpacity(180)
		end

		touchPanel:setTouchEnabled(true)
		touchPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				if self._sharedSpine and self._sharedSpine:hasAnimation(_info.action) then
					self._sharedSpine:playAnimation(0, _info.action, true)
				end

				if self._soundId then
					return
				end

				self._touchTimes = self._touchTimes + 1

				local soundId = AudioTimerSystem:getHeroTouchSoundByPart(self._heroId, _info.part, self._touchTimes)
				local isExistStr = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "CueName"))
				local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
				local isHide = table.indexof(HideVoice, self._heroId)

				if isExistStr and isExistStr ~= "Voice_Default" and not isHide then
					self._talkPanel:setVisible(true)

					local text = self._talkPanel:getChildByFullName("clipNode.text")

					text:stopAllActions()
					text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

					local trueSoundId

					self._soundId, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
						self._soundId = nil

						if checkDependInstance(self) then
							self._talkPanel:setVisible(false)
						end
					end)

					local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc"))

					text:setString(str)
					self:setTextAnim()

					self._lastClickSound = soundId
				end
			end
		end)
		touchPanel:addTo(img, num + 1 - i)
	end
end

function BuildingAfkGiftMediator:setTextAnim()
	local clipNode = self._talkPanel:getChildByName("clipNode")
	local text = clipNode:getChildByName("text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function BuildingAfkGiftMediator:initView()
	self:updateHero()
	self:updateView()
end

function BuildingAfkGiftMediator:updateView()
	self._btnPanel:setVisible(false)
	self._actionPanel:setVisible(false)
	self._giftPanel:setVisible(false)

	if self._type == kPanelType.kBtnPanel then
		self:initBtnPanel()
	elseif self._type == kPanelType.kActionPanel then
		self:initActionPanel()
	elseif self._type == kPanelType.kGiftPanel then
		self:initGiftPanel()
	elseif self._type == kPanelType.kSetBoardHero then
		self:runStartAction()
	end

	if #self._idList < 2 then
		self._btnPanel:getChildByFullName("node.left"):setVisible(false)
		self._btnPanel:getChildByFullName("node.right"):setVisible(false)
	end
end

function BuildingAfkGiftMediator:initBtnPanel()
	self._btnPanel:setVisible(true)

	local numPanel = self._btnPanel:getChildByFullName("numPanel")
	local label = numPanel:getChildByName("LoveNum")

	if not label then
		local fntFile = "asset/font/love_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(numPanel):center(numPanel:getContentSize()):offset(-7, -2)
		label:setName("LoveNum")
	end

	local loveLevel = self._heroData:getLoveLevel()

	label:setString(loveLevel)

	local var_32_0

	if not self._btnPanel:getChildByFullName("progress.ProgressTimer") then
		do
			local barImage = cc.Sprite:createWithSpriteFrameName("zc_img_hgd02.png")
			local progrLoading = cc.ProgressTimer:create(barImage)

			progrLoading:setType(0)
			progrLoading:setReverseDirection(false)
			progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
			progrLoading:setMidpoint(cc.p(0.5, 0.5))
			progrLoading:addTo(self._btnPanel:getChildByFullName("progress"))
			progrLoading:setPosition(cc.p(0, 0))
			progrLoading:setName("ProgressTimer")
		end

		var_32_0 = self._heroData:getLoveModule()
	end

	local progressNum = self._heroData:getLoveExp() / var_32_0:getCurMaxExp() * 100

	self._btnPanel:getChildByFullName("progress.ProgressTimer"):setPercentage((self._heroSystem:isLoveLevelMax(self._heroId) or nil) and 100)
	self._btnGift:setGray(false)
	self._btnGift:getChildByFullName("lockPanel"):setVisible(false)
	self._btnDate:setGray(false)
	self._btnDate:getChildByFullName("lockPanel"):setVisible(false)

	if not self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift, true, true) then
		self._btnGift:setGray(true)
		self._btnGift:getChildByFullName("lockPanel"):setVisible(true)
	end

	if not self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kDate, true, true) then
		self._btnDate:setGray(true)
		self._btnDate:getChildByFullName("lockPanel"):setVisible(true)
	end

	self._btnEvent:setTouchEnabled(false)
	self._btnEvent:setGray(true)

	if self._actionStatus and self._heroObj and self._buildingSystem:getHeroCanEvent(self._heroObj._id) then
		self._btnEvent:setTouchEnabled(true)
		self._btnEvent:setGray(false)
	end

	self:runStartAction()
end

function BuildingAfkGiftMediator:onTick()
	if self._actionStatus and self._heroObj and self._buildingSystem:getHeroCanEvent(self._heroObj._id) then
		self._btnEvent:setTouchEnabled(true)
		self._btnEvent:setGray(false)
	end
end

function BuildingAfkGiftMediator:initActionPanel()
	self._actionPanel:setVisible(true)
	self._handImage:setPosition(cc.p(self._handPosition.x, self._handPosition.y))

	local offset = self._heroData:getHandOffset()

	self._handImage:offset(offset[1], offset[2])

	local touchPanel = self._actionPanel:getChildByFullName("touchPanel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickTouchHead(sender, eventType)
	end)
end

function BuildingAfkGiftMediator:initGiftPanel()
	self._giftPanel:setVisible(true)

	local loveModule = self._heroData:getLoveModule()
	local conversation = ""

	conversation = loveModule:getGiftEventDesc()
	self._greeting = Strings:get(conversation.greeting[1])
	self._answer = Strings:get(conversation.answer[1])

	local itemNode = self._giftPanel:getChildByFullName("itemNode")
	local giftList = loveModule:getLovelyGift()
	local count = 1
	local id

	for k, v in pairs(giftList) do
		count = count + 1

		if count == 2 then
			id = k
		end
	end

	itemNode:removeAllChildren()

	local icon = IconFactory:createIcon({
		amount = 1,
		id = id
	}, {
		showAmount = true
	})

	icon:addTo(itemNode)
	icon:setPosition(cc.p(0, 0))
	self:runStartAction()
end

function BuildingAfkGiftMediator:onClickGiftSend()
	local loveMudole = self._heroData:getLoveModule()
	local giftlist = loveMudole:getLovelyGift()
	local param = {}

	param.heroId = self._heroId
	param.itemId = ""

	local count = 1

	for k, v in pairs(giftlist) do
		count = count + 1

		if count == 2 then
			param.itemId = k
		end
	end

	local num = self._bagSystem:getItemCount(param.itemId)
	local data = {}

	data.buyType = 2

	local price = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroAfkEventGiftPrice", "content")
	local quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", param.itemId, "Quality")
	local addExp = self._heroSystem:getGiftAddExpByQuality(quality)
	local extExp = self._heroSystem:getGiftAddExpById(self._heroId, param.itemId)
	local addLove = self._hugAdd + addExp + extExp

	if num <= 0 then
		local view = self:getInjector():getInstance("ShopBuyView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			buyType = 2,
			itemid = param.itemId,
			costType = price[tostring(quality)].type,
			cost = price[tostring(quality)],
			callback = callback,
			bufFun = function(...)
				self._gallerySystem:requestDoAfkEvent(param, function(response)
					self:showUpAnim(addLove)

					if self._heroObj then
						self._heroObj._heroEventState = 3
					end

					self:onClickBack()
				end)
			end
		}))

		return
	end

	self._gallerySystem:requestDoAfkEvent(param, function(response)
		self:showUpAnim(addLove)

		if self._heroObj then
			self._heroObj._heroEventState = 3
		end

		self:onClickBack()
	end)
end

function BuildingAfkGiftMediator:onClickTouchHead(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		-- block empty
	elseif eventType == ccui.TouchEventType.moved then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended then
		local param = {}

		param.heroId = self._heroId
		param.itemId = ""

		self._gallerySystem:requestDoAfkEvent(param, function(response)
			self:showUpAnim(self._hugAdd)

			if self._heroObj then
				self._heroObj._heroEventState = 3
			end

			self:onClickBack()
		end)
	end
end

function BuildingAfkGiftMediator:showUpAnim(num)
	self._btnPanel:removeChildByName("LoveAnim")

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local heroSystem = developSystem:getHeroSystem()
	local isLoveLevelMax = heroSystem:isLoveLevelMax(self._heroId)
	local anim = IconFactory:createLoveUpAnim(self._heroId, num, nil, isLoveLevelMax)

	if anim then
		anim:addTo(self._btnPanel)
		anim:setPosition(cc.p(147, 150))
		anim:setName("LoveAnim")
	end
end

function BuildingAfkGiftMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex < 1 then
		self._curIdIndex = #self._idList
	end

	local heroId = self._idList[self._curIdIndex]

	self._heroId = heroId or self._heroId

	self:updateData()
	self:initBtnPanel()
	self:updateHero()
end

function BuildingAfkGiftMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex > #self._idList then
		self._curIdIndex = 1
	end

	local heroId = self._idList[self._curIdIndex]

	self._heroId = heroId or self._heroId

	self:updateData()
	self:initBtnPanel()
	self:updateHero()
end

function BuildingAfkGiftMediator:changeHero(event)
	local heroId = event:getData().heroId

	if self._heroId ~= heroId then
		self._heroId = heroId

		self:updateData()

		local settingSystem = self:getInjector():getInstance(SettingSystem)
		local isRandom = settingSystem:getSettingModel():getRoleAndBgRandom()

		if isRandom == false then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Home_ShowHero_Reset")
			}))
		end
	end

	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)

		self._soundId = nil
	end

	self._talkPanel:setVisible(false)
	self:updateHero()
end

function BuildingAfkGiftMediator:onClickGift()
	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift)
end

function BuildingAfkGiftMediator:onClickDate()
	local hero = self._heroSystem:getHeroById(self._heroId)

	if not hero:getDateStory() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Item_PleaseWait")
		}))

		return
	end

	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kDate)
end

function BuildingAfkGiftMediator:onClickEvent()
	self:resetView({
		type = self._actionStatus,
		id = self._heroId
	})
end

function BuildingAfkGiftMediator:runStartAction()
	local panel = self:getView():getChildByFullName("leftActionPanel.panel")

	panel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/BuildingAfkGift.csb")

	panel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function BuildingAfkGiftMediator:onClickDailyGift()
	local isActivity, tips = self:checkDailyGift()

	if isActivity then
		local view = self:getInjector():getInstance("DailyGiftView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function BuildingAfkGiftMediator:checkDailyGift()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local config = ConfigReader:getDataByNameIdAndKey("Activity", DailyGift, "ActivityConfig")
	local curList = config.FreeStamina
	local tag = -1

	for i = 1, #curList do
		local status, isTomorrow = activitySystem:isCanGetStamina(curList[i].Time, curList[i].Order)

		if status == StaminaRewardTimeStatus.kNow then
			return true
		end

		if status == StaminaRewardTimeStatus.kAfter and not isTomorrow then
			tag = i

			break
		end
	end

	if tag == -1 then
		return false, Strings:get("Daily_Gift_Fin")
	else
		local time = config.FreeStamina[tag].Time
		local str1 = time[1]
		local str2 = time[2]
		local splite1 = string.split(str1, ":")

		str1 = splite1[1] .. ":" .. splite1[2]

		local splite2 = string.split(str2, ":")

		str2 = splite2[1] .. ":" .. splite2[2]

		return false, Strings:get("Daily_Gift_NextTime", {
			time1 = str1,
			time2 = splite2[1] .. ":" .. splite2[2]
		})
	end
end

function BuildingAfkGiftMediator:spineAnimEvent(event)
	if event.type == "complete" and event.animation ~= "animation" then
		self._sharedSpine:playAnimation(0, "animation", true)
	end
end

function BuildingAfkGiftMediator:checkSoundUnlock(heroId, soundId)
	local hero = self._heroSystem:getHeroById(heroId)
	local giftTimes = hero:getGiftTimes()
	local sound = {}

	sound.config = ConfigReader:getRecordById("Sound", soundId)

	function sound:setUnlock(unlock)
		return
	end

	function sound:getUnlockDesc()
		return self.config.UnlockDesc
	end

	function sound:getUnlockCondition()
		if not self.config.Unlock then
			return self.config.Unlock
		end
	end

	return self._heroSystem:getSoundUnlock(hero, sound)
end

function BuildingAfkGiftMediator:onClickBust()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)

		self._soundId = nil
	end

	local view = self:getInjector():getInstance("HeroShowHeroPicView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = self._heroId,
		setHomeBgId = self._bgImageId
	}))
end

function BuildingAfkGiftMediator:onClickMove()
	self:dispatch(Event:new(EVT_HOMEVIEW_SETBORAD_MOVE))
	self:onClickRemove()
end

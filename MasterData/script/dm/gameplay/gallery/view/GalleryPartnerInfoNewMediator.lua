-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerInfoNewMediator.lua

GalleryPartnerInfoNewMediator = class("GalleryPartnerInfoNewMediator", DmAreaViewMediator, _M)

GalleryPartnerInfoNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryPartnerInfoNewMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryPartnerInfoNewMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
GalleryPartnerInfoNewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
require("dm.gameplay.gallery.view.GalleryPartnerPastCell")

local kBtnHandlers = {
	["main.ruleBtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickShowTips"
	},
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.tabBg.giftBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickGift"
	},
	["main.tabBg.dateBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickDate"
	},
	["main.tabBg.exploreBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickExplore"
	},
	["main.tabBg.awakenBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickAwaken"
	},
	["main.tabBg.oldBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickOld"
	},
	["main.tabBg.detailBtn"] = {
		clickAudio = "Se_Click_Tab_5",
		func = "onClickDetail"
	}
}
local kGossipDescColor = {
	album_bg_tag01 = cc.c3b(69, 90, 16),
	album_bg_tag02 = cc.c3b(255, 255, 255),
	album_bg_tag03 = cc.c3b(121, 121, 121)
}
local kGossipDescPos = {
	cc.p(282, 78),
	cc.p(16, 32),
	cc.p(306, 23),
	cc.p(51, -23)
}

function GalleryPartnerInfoNewMediator:initialize()
	super.initialize(self)
end

function GalleryPartnerInfoNewMediator:dispose()
	super.dispose(self)
end

function GalleryPartnerInfoNewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROCOMPOSE_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_HEROREWARD_SUCC, self, self.refreshReward)
end

function GalleryPartnerInfoNewMediator:enterWithData(data)
	self._data = data

	self:initWidgetInfo()
	self:initData(data)
	self:initView()
	self:runStartAnim()
	self:setupTopInfoWidget()
	self:setBottomBtnState(data.tabIndex or 1)
end

function GalleryPartnerInfoNewMediator:resumeWithData()
	self:refreshData()
	self:refreshView()
	self._lovePanel:setOpacity(255)
	self._tabBg:setOpacity(255)
	self._main:getChildByFullName("ruleBtn"):setOpacity(255)
end

function GalleryPartnerInfoNewMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryPartnerInfoNewMediator:initData(data)
	self._heroId = data.id or ""
	self._heroIds = data.ids or {}
	self._curIdIndex = 1
	self._curPageIndex = nil

	for i = 1, #self._heroIds do
		if self._heroId == self._heroIds[i] then
			self._curIdIndex = i

			break
		end
	end

	self._heroInfos = self._gallerySystem:getHeroInfos(self._heroId)
	self._attrData = {}

	if self._heroSystem:hasHero(self._heroId) then
		local hero = self._heroSystem:getHeroById(self._heroId)

		self._attrData = hero:getLoveModule():getTotalLoveExtraBonus()

		self:refreshPastData()
	end

	self._canChange = true
	self._upAnimPanel = self:getView():getChildByFullName("upAnimPanel")

	self._upAnimPanel:setVisible(false)

	self._galleryCellWidget = self:autoManageObject(self:getInjector():injectInto(GalleryGiftCellWidget:new(self._giftPanel)))

	local data = {
		type = "gift",
		id = self._heroId,
		upAnimPanel = self._upAnimPanel,
		lovePanel = self._lovePanel,
		meditor = self
	}

	self._galleryCellWidget:initViewShow(data)
end

function GalleryPartnerInfoNewMediator:refreshPastData()
	self._storyArray = self._gallerySystem:getHeroStory(self._heroId)

	local heroRewards = self._gallerySystem:getHeroRewards()

	self._isShowPastRed = not heroRewards[self._heroId]

	self._oldBtn:getChildByFullName("redPoint"):setVisible(self._isShowPastRed)
end

function GalleryPartnerInfoNewMediator:refreshReward(event)
	local response = event:getData().data

	if response and response.reward then
		local view = self:getInjector():getInstance("getRewardView")
		local this = self

		local function callback()
			local storyDirector = this:getInjector():getInstance(story.StoryDirector)

			storyDirector:notifyWaiting("exit_GetRewardView_suc")
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = false,
			rewards = response.reward,
			callback = callback
		}))
	end
end

function GalleryPartnerInfoNewMediator:initWidgetInfo()
	self._tabBg = self:getView():getChildByFullName("main.tabBg")
	self._bonusPanel = self:getView():getChildByFullName("bonusPanel")

	self._bonusPanel:setVisible(false)

	self._main = self:getView():getChildByFullName("main")
	self._introductionPanel = self._main:getChildByFullName("Panel_1")
	self._oldPanel = self._main:getChildByFullName("Panel_2")
	self._giftPanel = self._main:getChildByFullName("Panel_3")
	self._tipsPanel = self._main:getChildByFullName("tipsPanel")

	self._tipsPanel:setVisible(false)

	self._heroPanel = self._main:getChildByFullName("heroPanel")
	self._heroIcon = self._heroPanel:getChildByFullName("heroIcon")
	self._debrisBtn = self._heroPanel:getChildByFullName("debrisBtn")
	self._gossipPanel = self._introductionPanel:getChildByFullName("gossipPanel")
	self._gossipClone = self._introductionPanel:getChildByFullName("gossipClone")

	self._gossipClone:setVisible(false)

	self._infoPanel = self._introductionPanel:getChildByFullName("infoPanel")
	self._lovePanel = self._main:getChildByFullName("lovePanel")
	self._loadingBar = self._lovePanel:getChildByName("loading")
	self._loveExp = self._lovePanel:getChildByName("loveExp")
	self._namePanel = self._introductionPanel:getChildByFullName("namePanel")
	self._leftBtn = self._main:getChildByFullName("left")
	self._rightBtn = self._main:getChildByFullName("right")
	self._dateBtn = self._tabBg:getChildByFullName("dateBtn")
	self._exploreBtn = self._tabBg:getChildByFullName("exploreBtn")

	self._exploreBtn:setVisible(false)

	self._awakenBtn = self._tabBg:getChildByFullName("awakenBtn")
	self._detailBtn = self._tabBg:getChildByFullName("detailBtn")
	self._oldBtn = self._tabBg:getChildByFullName("oldBtn")
	self._giftBtn = self._tabBg:getChildByFullName("giftBtn")
	self._closeBtn = self._tabBg:getChildByFullName("closeBtn")

	self._closeBtn:setVisible(false)

	self._lockTip = self._tabBg:getChildByFullName("lockTip")

	self._lockTip:setVisible(false)

	self._linkImage = self._heroPanel:getChildByFullName("linkImage")

	self._linkImage:setVisible(false)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setTouchEnabled(true)
	self._touchPanel:setSwallowTouches(true)
	self._touchPanel:addClickEventListener(function()
		if self._bonusPanel:isVisible() then
			self._bonusPanel:setVisible(false)
		end

		if self._tipsPanel:isVisible() then
			self._tipsPanel:setVisible(false)
		end

		self._touchPanel:setVisible(false)
	end)
	self._touchPanel:setVisible(false)
	CommonUtils.runActionEffect(self._leftBtn:getChildByFullName("leftBtn"), "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(self._rightBtn:getChildByFullName("rightBtn"), "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)

	self._rewardTip = self._lovePanel:getChildByName("rewardTip")

	self._rewardTip:setVisible(false)
	self._lovePanel:getChildByName("text"):enableOutline(cc.c4b(140, 20, 40, 153), 2)
	self._loveExp:enableOutline(cc.c4b(140, 20, 40, 153), 2)
	self._lovePanel:getChildByFullName("loveLevel"):enableOutline(cc.c4b(140, 20, 40, 153), 2)
	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._bottomBtns = {}
	self._bottomBtns[#self._bottomBtns + 1] = {
		btn = self._detailBtn,
		panel = self._introductionPanel
	}
	self._bottomBtns[#self._bottomBtns + 1] = {
		btn = self._giftBtn,
		panel = self._giftPanel
	}
	self._bottomBtns[#self._bottomBtns + 1] = {
		btn = self._dateBtn
	}
	self._bottomBtns[#self._bottomBtns + 1] = {
		btn = self._oldBtn,
		panel = self._oldPanel
	}
end

function GalleryPartnerInfoNewMediator:initView()
	self:refreshView()

	local heroPanel = self._heroPanel:getChildByFullName("touchPanel")

	heroPanel:setTouchEnabled(false)
	heroPanel:addClickEventListener(function()
		self:onClickHeroIcon()
	end)

	local maxImage = self._lovePanel:getChildByName("maxImage")

	maxImage:setTouchEnabled(true)
	maxImage:addClickEventListener(function()
		if self._heroSystem:hasHero(self._heroId) then
			self:onClickBonus(maxImage, self._attrData, true)
		end
	end)

	local language = getCurrentLanguage()
	local tips = self._gallerySystem:getGalleryRule()
	local panelSize = self._tipsPanel:getContentSize()
	local space = 18
	local PositionY = 18

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		if language ~= GameLanguageType.CN then
			text:setLineSpacing(1)
		else
			text:setLineSpacing(space)
		end

		text:getVirtualRenderer():setMaxLineWidth(385)
		text:addTo(self._tipsPanel):setTag(i)
		text:setAnchorPoint(cc.p(0, 1))

		PositionY = PositionY + text:getContentSize().height + 18
	end

	if PositionY > panelSize.height then
		panelSize.height = PositionY

		self._tipsPanel:setContentSize(panelSize)
	end

	for i = 1, #tips do
		local prewText = self._tipsPanel:getChildByTag(i - 1)
		local text = self._tipsPanel:getChildByTag(i)

		if prewText then
			local topPosY = prewText:getPositionY() - prewText:getContentSize().height

			text:setPosition(cc.p(10, topPosY - space))
		else
			text:setPosition(cc.p(10, panelSize.height - 15))
		end
	end
end

function GalleryPartnerInfoNewMediator:refreshData()
	if next(self._heroIds) then
		self._heroId = self._heroIds[self._curIdIndex]
	end

	self._heroInfos = self._gallerySystem:getHeroInfos(self._heroId)
	self._data.id = self._heroId
	self._attrData = {}

	if self._heroSystem:hasHero(self._heroId) then
		local hero = self._heroSystem:getHeroById(self._heroId)

		self._attrData = hero:getLoveModule():getTotalLoveExtraBonus()

		self:refreshPastData()
	end
end

function GalleryPartnerInfoNewMediator:refreshView()
	self:refreshBtnState()
	self:refreshArrowState()
	self:refreshInfo()
	self:refreshLove()
end

function GalleryPartnerInfoNewMediator:refreshBtnState()
	local hero = self._heroSystem:getHeroById(self._heroId)

	if not hero then
		return
	end

	self._tabBg:removeChildByName("LockTip")
	self._dateBtn:setColor(cc.c3b(255, 255, 255))

	if not hero:getDateStory() then
		self:createLickTip(self._dateBtn)
	else
		local dateUnlock, unlockLevel = self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kDate, true, true)

		if not dateUnlock then
			self._dateBtn:setColor(cc.c3b(48, 46, 46))

			local lockTip = self._lockTip:clone()

			lockTip:setVisible(true)
			lockTip:addTo(self._dateBtn:getParent())
			lockTip:setPosition(self._dateBtn:getPosition()):offset(5, 0)
			lockTip:getChildByFullName("text"):setString(Strings:get("GALLERY_UI_ImpressLv", {
				num = unlockLevel
			}))
			lockTip:setName("LockTip")
		end
	end

	if self._heroSystem:checkHaveAwaken(self._heroId) == false then
		self._awakenBtn:setVisible(false)
	else
		self._awakenBtn:setVisible(true)
	end
end

function GalleryPartnerInfoNewMediator:createLickTip(node)
	local lockTip = self._lockTip:clone()

	lockTip:setVisible(true)
	lockTip:addTo(node:getParent())
	lockTip:setPosition(node:getPosition()):offset(5, 0)
	lockTip:getChildByFullName("text"):setString(Strings:get("Unlock_Memory_Tips"))
	lockTip:getChildByFullName("text1"):setString("")
	lockTip:setName("LockTip")
	lockTip:removeChildByName("lockImg")
	node:setColor(cc.c3b(48, 46, 46))
end

function GalleryPartnerInfoNewMediator:refreshArrowState()
	if self._curPageIndex == 1 then
		self._leftBtn:setVisible(self._curIdIndex ~= 1 and #self._heroIds > 0)
		self._rightBtn:setVisible(self._curIdIndex ~= #self._heroIds and #self._heroIds > 0)
	else
		self._leftBtn:setVisible(false)
		self._rightBtn:setVisible(false)
	end
end

function GalleryPartnerInfoNewMediator:refreshInfo()
	for i = 1, 9 do
		local panel = self._infoPanel:getChildByFullName("infoPanel_" .. i)

		panel:getChildByName("desc"):setString(self._heroInfos["info" .. i][1])

		local info = panel:getChildByName("info")

		info:setString(self._heroInfos["info" .. i][2])
	end

	self._namePanel:getChildByFullName("name"):setString(self._heroInfos.name)

	local cvname = Strings:get("GALLERY_UI10", {
		cvname = self._heroInfos.cvname
	})

	self._namePanel:getChildByFullName("cvname"):setString(cvname)

	local length = utf8.len(cvname)

	if length > 10 then
		self._namePanel:getChildByFullName("cvname"):setFontSize(22)
	else
		self._namePanel:getChildByFullName("cvname"):setFontSize(24)
	end

	if self._heroSystem:isLinkStageHero(self._heroId) then
		self._linkImage:setVisible(true)
	else
		self._linkImage:setVisible(false)
	end

	local historyHero = ConfigReader:getDataByNameIdAndKey("GalleryHeroInfo", self._heroId, "HistoryHero")
	local targetHero = Strings:get("GALLERY_UI52", {
		name = Strings:get(historyHero)
	})

	self._namePanel:getChildByFullName("targetHero"):setString(targetHero)

	local gossips = self._heroInfos.gossips

	self._gossipPanel:removeAllChildren()

	self._gossipArr = {}

	local index = 1

	for desc, value in pairs(gossips) do
		local panel = self._gossipClone:clone()

		panel:setVisible(true)
		panel:loadTexture(value[3] .. ".png", 1)
		panel:addTo(self._gossipPanel)
		panel:setPosition(kGossipDescPos[index])
		panel:getChildByName("desc"):setString(Strings:get(desc))
		panel:getChildByName("desc"):setColor(kGossipDescColor[value[3]])

		self._gossipArr[#self._gossipArr + 1] = panel
		index = index + 1
	end

	table.sort(self._gossipArr, function(a, b)
		return a:getPositionY() > b:getPositionY()
	end)

	local hasHero = self._heroSystem:hasHero(self._heroId)

	self._debrisBtn:setVisible(not hasHero)
	self._heroIcon:setGray(not hasHero)
	self._gossipPanel:setVisible(hasHero)
	self._tabBg:setVisible(hasHero)

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._heroId)

	if hasHero and (not self._gallerySystem:isPastOpen(self._heroId) or true) then
		roleModel = self._heroSystem:getHeroById(self._heroId):getModel()
	end

	self._heroIcon:removeAllChildren()

	local heroIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel,
		useAnim = hasHero
	})

	heroIcon:addTo(self._heroIcon)
	heroIcon:setPosition(cc.p(200, 80))
end

function GalleryPartnerInfoNewMediator:refreshLove()
	local loveLevel = 0
	local loveExp = 0
	local progress = 0
	local hero = self._heroSystem:getHeroById(self._heroId)
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._heroId)
	local max = self._heroSystem:isLoveLevelMax(self._heroId)

	if self._heroSystem:hasHero(self._heroId) then
		roleModel = hero:getModel()
		loveLevel = hero:getLoveLevel()
		loveExp = hero:getLoveExp()
		progress = loveExp / hero:getLoveModule():getCurMaxExp() * 100

		self._loveExp:setString(loveExp .. "/" .. hero:getLoveModule():getCurMaxExp())
		self._loadingBar:setPercent(progress)

		if max then
			self._loadingBar:setPercent(100)
			self._loveExp:setString(Strings:get("GALLERY_UI33"))
		end
	else
		loveLevel = 0
		loveExp = 0

		local totalExp = self._gallerySystem:getCurLoveMaxExp(self._heroId, 0)

		self._loveExp:setString("0/" .. totalExp)
		self._loadingBar:setPercent(0)
	end

	self._lovePanel:getChildByFullName("loveLevel"):setString(loveLevel)

	local bonusData = self._gallerySystem:getCurLoveExtraBonus(self._heroId, loveLevel, loveExp)
	local loading = self._loadingBar

	loading:removeAllChildren()

	for i = 1, #bonusData do
		local data = bonusData[i]
		local rewardTip = self._rewardTip:clone()

		rewardTip:setVisible(data.proportion > 0)
		rewardTip:addTo(loading)

		local icon = rewardTip:getChildByFullName("icon")

		icon:setTouchEnabled(true)
		icon:addClickEventListener(function()
			self:onClickBonus(icon, data)
		end)
		rewardTip:setPosition(cc.p(loading:getContentSize().width * data.proportion, -31.5))

		if data.proportion == 1 then
			rewardTip:offset(-2, 0)
		end

		local fullBg = rewardTip:getChildByFullName("fullBg")
		local fullBgEnd = rewardTip:getChildByFullName("fullBgEnd")
		local full = rewardTip:getChildByFullName("full")

		full:setVisible(max or progress >= data.proportion * 100)
		fullBg:setVisible(data.proportion < 1)
		fullBgEnd:setVisible(data.proportion == 1)

		local heroNode = rewardTip:getChildByFullName("hero")
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = roleModel
		})

		heroImg:addTo(heroNode):center(heroNode:getContentSize()):setScale(0.2)
	end
end

function GalleryPartnerInfoNewMediator:refreshInnerAttrPanel(data, title)
	local titleAttr = self._bonusPanel:getChildByFullName("title_attr")

	titleAttr:setVisible(false)

	local titleInfo = self._bonusPanel:getChildByFullName("title_info")

	titleInfo:setVisible(false)

	local titleTotal = self._bonusPanel:getChildByFullName("title_total")

	titleTotal:setVisible(false)

	local textLabel = self._bonusPanel:getChildByName("text_clone")

	textLabel:setVisible(false)

	local list = data.param

	if title and #list == 0 then
		self._bonusPanel:setVisible(false)

		return
	end

	local panel = self._bonusPanel:getChildByName("panel")

	panel:removeAllChildren()

	local height = 40
	local posY = 15

	if title then
		titleTotal:setVisible(true)

		local length = math.ceil(#list / 2)

		for i = 1, length do
			local node = textLabel:clone()

			for j = 1, 2 do
				local index = 2 * (i - 1) + j
				local str = list[index]

				if str then
					local text = node:getChildByFullName("text_" .. j)
					local attr = node:getChildByFullName("attr_" .. j)

					text:setVisible(true)
					text:setString(str[1])
					attr:setVisible(true)
					attr:setString(str[2])

					local image = text:getChildByFullName("image")

					image:setVisible(true)
					image:loadTexture(AttrTypeImage[str[3]], 1)
				end
			end

			node:setVisible(true)
			node:addTo(panel)
			node:setPosition(cc.p(0, posY + (length - i) * 35))

			height = height + 30
		end

		titleTotal:setPositionY(posY + length * 30 + 15)

		height = height + 30

		self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(302, height))
	else
		local infoList = {}
		local attrList = {}

		for key, value in pairs(list) do
			if type(value) == "table" then
				attrList[#attrList + 1] = {
					value[1],
					value[2],
					value[3]
				}
			else
				infoList[#infoList + 1] = value
			end
		end

		if #attrList > 0 then
			titleAttr:setVisible(true)

			local length = math.ceil(#attrList / 2)

			for i = 1, length do
				local node = textLabel:clone()

				for j = 1, 2 do
					local index = 2 * (i - 1) + j
					local str = attrList[#attrList + 1 - index]

					if str then
						local text = node:getChildByFullName("text_" .. j)
						local attr = node:getChildByFullName("attr_" .. j)

						text:setVisible(true)
						text:setString(str[1])
						attr:setVisible(true)
						attr:setString(str[2])

						local image = text:getChildByFullName("image")

						image:setVisible(true)
						image:loadTexture(AttrTypeImage[str[3]], 1)
					end
				end

				node:setVisible(true)
				node:addTo(panel)
				node:setPosition(cc.p(0, posY + (i - 1) * 30))

				height = height + 30
			end

			titleAttr:setPositionY(posY + length * 30 + 15)

			posY = posY + (length + 1) * 30 + 25
			height = height + 30
		end

		if #infoList > 0 then
			titleInfo:setVisible(true)

			local node = textLabel:clone()
			local str = ""

			for i = 1, #infoList do
				str = str .. infoList[i] .. "        "
			end

			node:getChildByFullName("text_1"):setVisible(true)
			node:getChildByFullName("text_1"):setString(str)
			node:setVisible(true)
			node:addTo(panel)
			node:setPosition(cc.p(0, posY))

			height = height + 30

			titleInfo:setPositionY(posY + 30 + 15)

			height = height + 55
		end

		self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(302, height))
	end
end

function GalleryPartnerInfoNewMediator:refreshOld()
	return
end

function GalleryPartnerInfoNewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
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

function GalleryPartnerInfoNewMediator:onClickBack()
	self:dismiss()
end

function GalleryPartnerInfoNewMediator:onClickShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(true)
		self._touchPanel:setVisible(true)
	end
end

function GalleryPartnerInfoNewMediator:onClickGift()
	if self._curPageIndex == 2 then
		return
	end

	self:setBottomBtnState(2)
	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift, false, false, function()
		return
	end)
end

function GalleryPartnerInfoNewMediator:onClickDate()
	local hero = self._heroSystem:getHeroById(self._heroId)

	if not hero:getDateStory() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Item_PleaseWait")
		}))

		return
	end

	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kDate)
end

function GalleryPartnerInfoNewMediator:onClickOld()
	if self._curPageIndex == 4 then
		return
	end

	local info = {
		node = self._oldPanel,
		mediator = self,
		id = self._heroId,
		bg = self._heroInfos.bg,
		storyArray = self._storyArray
	}

	self._oldCell = self._oldCell or GalleryPartnerPastCell:new()

	self._oldCell:setupView(info)
	self:setBottomBtnState(4)
end

function GalleryPartnerInfoNewMediator:onClickDetail()
	self:setBottomBtnState(1)
end

function GalleryPartnerInfoNewMediator:setBottomBtnState(index)
	if index == 3 then
		return
	end

	if index == 4 then
		local unlock, targetLevel, targetExp = self._gallerySystem:isPastOpen(self._heroId)

		if not unlock then
			local tip = Strings:get("GALLERY_UnlockTips", {
				num = targetLevel
			})

			self:dispatch(ShowTipEvent({
				tip = (targetExp ~= 0 or nil) and Strings:get("GALLERY_UnlockTips2", {
					num = targetLevel,
					exp = targetExp
				})
			}))
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end
	end

	if self._curPageIndex == index then
		return
	end

	self._curPageIndex = index

	for i, v in ipairs(self._bottomBtns) do
		local select = v.btn:getChildByFullName("Image_2")

		select:setVisible(index == i)

		if v.panel then
			v.panel:setVisible(index == i)
		end
	end

	if index == 4 and self._isShowPastRed then
		local params = {
			heroId = self._heroId
		}

		self._gallerySystem:requestGalleryHeroReward(params)
	end

	if index == 2 and self._heroSystem:hasHero(self._heroId) then
		local data = {
			type = "gift",
			id = self._heroId,
			upAnimPanel = self._upAnimPanel,
			lovePanel = self._lovePanel,
			meditor = self
		}

		self._galleryCellWidget:setupView(data)
	end

	self:refreshArrowState()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
end

function GalleryPartnerInfoNewMediator:onClickExplore()
	local heroStoryBlockId = ConfigReader:getDataByNameIdAndKey("HeroBase", self._heroId, "HeroStoryMap")

	if heroStoryBlockId and heroStoryBlockId ~= "" then
		local stageSystem = self:getInjector():getInstance(StageSystem)

		stageSystem:tryEnterHeroStory({
			heroId = self._heroId
		})
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Item_PleaseWait")
		}))
	end
end

function GalleryPartnerInfoNewMediator:onClickAwaken()
	if self._heroSystem:checkHaveAwaken(self._heroId) then
		self._heroSystem:tryEnterAwakenShowView(self._heroId)
	end
end

function GalleryPartnerInfoNewMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex <= 1 then
		self._curIdIndex = 1
	end

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerInfoNewMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex >= #self._heroIds then
		self._curIdIndex = #self._heroIds
	end

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerInfoNewMediator:onClickHeroIcon()
	local heroData = self._heroSystem:getHeroInfoById(self._heroId)

	if not heroData then
		return
	end

	if heroData.showType == HeroShowType.kCanComp then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local config = PrototypeFactory:getInstance():getHeroPrototype(self._heroId):getConfig()

		local function callBack(data)
			local view = self:getInjector():getInstance("newHeroView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				heroId = data.id
			}))
		end

		self._bagSystem:requestHeroCompose(config.ItemId, callBack)
	elseif heroData.showType == HeroShowType.kHas then
		-- block empty
	elseif heroData.showType == HeroShowType.kNotOwn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local heroId = self._heroId
		local config = PrototypeFactory:getInstance():getHeroPrototype(heroId):getConfig()
		local needCount = self._heroSystem:getHeroComposeFragCount(heroId)
		local hasCount = self._heroSystem:getHeroDebrisCount(heroId)
		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = config.ItemId,
			hasNum = hasCount,
			needNum = needCount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function GalleryPartnerInfoNewMediator:onClickBonus(sender, data, showTitle)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

	self._bonusPanel:setPositionX(self._bonusPanel:getParent():convertToNodeSpace(targetPos).x)
	self._bonusPanel:setVisible(true)
	self:refreshInnerAttrPanel(data, showTitle)
	self._touchPanel:setVisible(true)
end

function GalleryPartnerInfoNewMediator:runStartAnim()
	self._heroPanel:stopAllActions()

	local heroPanel = self._heroPanel:getChildByFullName("touchPanel")

	self._heroPanel:setVisible(false)
	self._heroPanel:setRotation(25)
	self._heroPanel:setOpacity(0)
	self._heroPanel:fadeIn({
		time = 0.2
	})

	local callfunc = cc.CallFunc:create(function()
		self._main:setVisible(true)
		self._tabBg:setVisible(self._heroSystem:hasHero(self._heroId))
		self._heroPanel:setVisible(true)
		self:setupClickEnvs()
	end)
	local delay = cc.DelayTime:create(0.3)
	local rotate1 = cc.RotateTo:create(0.2, -8)
	local rotate2 = cc.RotateTo:create(0.1, 0)
	local callfunc1 = cc.CallFunc:create(function()
		heroPanel:setTouchEnabled(true)
	end)
	local seq = cc.Sequence:create(delay, callfunc, rotate1, rotate2, callfunc1)

	self._heroPanel:runAction(seq)

	for i = 1, #self._gossipArr do
		local panel = self._gossipArr[i]

		panel:setVisible(false)

		delay = cc.DelayTime:create(0.5 + (i - 1) * 0.1)
		callfunc = cc.CallFunc:create(function()
			panel:setVisible(true)
		end)

		panel:setOpacity(0)

		local fade = cc.FadeIn:create(0.2)
		local resize = cc.ScaleTo:create(0.2, 1.1)
		local spawn = cc.Spawn:create(callfunc, resize, fade)
		local resize1 = cc.ScaleTo:create(0.08, 0.9)
		local resize2 = cc.ScaleTo:create(0.2, 1)

		seq = cc.Sequence:create(delay, spawn, resize1, resize2)

		panel:runAction(seq)
	end
end

function GalleryPartnerInfoNewMediator:showPastAnim()
	local heroPanel = self._heroPanel:getChildByFullName("touchPanel")

	heroPanel:setTouchEnabled(false)
	self._heroPanel:stopAllActions()
	self._lovePanel:fadeOut({
		time = 0.4
	})
	self._tabBg:fadeOut({
		time = 0.4
	})
	self._main:getChildByFullName("ruleBtn"):fadeOut({
		time = 0.2
	})

	local view = self:getInjector():getInstance("GalleryPartnerPastView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = self._heroId,
		bg = self._heroInfos.bg,
		storyArray = self._storyArray
	}))
	heroPanel:setTouchEnabled(true)

	local image = self:getView():getChildByName("image")

	image:stopAllActions()

	local rotate = cc.RotateTo:create(0.3, 20)
	local moveto1 = cc.MoveTo:create(0.3, cc.p(1660, -470))
	local spawn = cc.Spawn:create(rotate, moveto1)

	image:runAction(spawn)

	moveto1 = cc.MoveTo:create(0.1, cc.p(200, 611))

	local moveto2 = cc.MoveTo:create(0.2, cc.p(-672, 1098))

	seq = cc.Sequence:create(moveto1, moveto2)

	self._heroPanel:runAction(seq)
end

function GalleryPartnerInfoNewMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local jushiBtn = self._tabBg:getChildByFullName("oldBtn")

		storyDirector:setClickEnv("GalleryPartnerInfoNewMediator.jushiBtn", jushiBtn, function(sender, eventType)
			self:onClickOld()
		end)
		storyDirector:notifyWaiting("enter_GalleryPartnerInfoNewMediator")
	end))

	self:getView():runAction(sequence)
end

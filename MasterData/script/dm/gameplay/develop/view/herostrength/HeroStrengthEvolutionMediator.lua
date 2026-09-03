-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthEvolutionMediator.lua

HeroStrengthEvolutionMediator = class("HeroStrengthEvolutionMediator", DmAreaViewMediator, _M)

local kBtnHandlers = {
	["mainpanel.evelitionNode.evolutionpanel.descBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onDescClicked"
	}
}
local kCostNodePos = {
	{
		cc.p(66, 158),
		cc.p(343, 158)
	},
	{
		cc.p(66, 158),
		cc.p(343, 158),
		cc.p(343, 118)
	},
	{
		cc.p(66, 158),
		cc.p(343, 158),
		cc.p(66, 118),
		cc.p(343, 118)
	}
}

function HeroStrengthEvolutionMediator:initialize()
	super.initialize(self)
end

function HeroStrengthEvolutionMediator:dispose()
	super.dispose(self)
end

function HeroStrengthEvolutionMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._upBtn = self:bindWidget("mainpanel.evelitionNode.evolutionpanel.evolutionbtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onEvolutionClicked, self)
		}
	})
end

function HeroStrengthEvolutionMediator:refreshViewByCurreny(heroId)
	self:refreshEvolutionData()
end

function HeroStrengthEvolutionMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self:refreshEvolutionData()
end

function HeroStrengthEvolutionMediator:refreshData(heroId)
	self._heroId = heroId or self._heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)

	local itemIdArr = self._heroData:getQualityCostItem()

	self._itemList = {}

	if itemIdArr then
		for i = 1, #itemIdArr do
			local configData = itemIdArr[i]
			local itemCache = self._itemList[i]

			if not itemCache then
				itemCache = {
					index = i,
					needCount = configData.amount,
					itemId = configData.id
				}
				self._itemList[#self._itemList + 1] = data
			end

			itemCache.hasCount = self._bagSystem:getItemCount(itemCache.itemId)
		end
	end

	self._posArr = kCostNodePos[#self._itemList]
	self._evoUpViewData = {
		level = 0,
		levelRequest = 0,
		heroId = self._heroId,
		quality = {},
		qualityId = {},
		qualityLevel = {},
		attr = {
			attack = {
				0,
				0
			},
			hp = {
				0,
				0
			},
			defense = {
				0,
				0
			},
			speed = {
				0,
				0
			}
		}
	}
end

function HeroStrengthEvolutionMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel.evelitionNode")
	self._evolutionPanel = self._mainPanel:getChildByFullName("evolutionpanel")
	self._sourcePanel = self._evolutionPanel:getChildByFullName("costNode4.costBg")
	self._levelLimit = self._evolutionPanel:getChildByFullName("levelLimit")
	self._soulPanel = self._evolutionPanel:getChildByFullName("soulshowpanel")
	self._evolutionBtn = self._evolutionPanel:getChildByFullName("evolutionbtn")
	self._topNode = self._mainPanel:getChildByFullName("topNode")

	local addImg = self._sourcePanel:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kGold)
	end)
	self._mainPanel:getChildByFullName("text"):enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)
	GameStyle:setCostNodeEffect(self._evolutionPanel:getChildByFullName("costNode1"))
	GameStyle:setCostNodeEffect(self._evolutionPanel:getChildByFullName("costNode2"))
	GameStyle:setCostNodeEffect(self._evolutionPanel:getChildByFullName("costNode3"))
	GameStyle:setCostNodeEffect(self._evolutionPanel:getChildByFullName("costNode4"))

	local combatPanel = self._evolutionPanel:getChildByFullName("descBg.combatPanel")
	local text1 = combatPanel:getChildByFullName("des_1.text")
	local text2 = combatPanel:getChildByFullName("des_2.text")
	local lineGradiantVec1 = {
		{
			ratio = 0.6,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(180, 180, 180, 255)
		}
	}

	text1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	text2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	GameStyle:setCommonOutlineEffect(self._levelLimit:getChildByFullName("label_1"))
end

function HeroStrengthEvolutionMediator:createItemNodes()
	self._itemNodes = {}

	local maxNum = 3

	for pos = 1, maxNum do
		self._itemNodes[pos] = self._evolutionPanel:getChildByFullName("costNode" .. pos)

		self._itemNodes[pos]:setVisible(false)

		local addImg = self._itemNodes[pos]:getChildByFullName("costBg.addImg")
		local touchPanel = addImg:getChildByFullName("touchPanel")

		touchPanel:setVisible(true)
		touchPanel:setTouchEnabled(true)
		touchPanel:addClickEventListener(function()
			self:onTouchItemClicked(pos)
		end)
	end
end

function HeroStrengthEvolutionMediator:refreshView(heroId)
	heroId = heroId or self._heroId

	self:refreshEvolutionData()
end

function HeroStrengthEvolutionMediator:refreshEvolutionData()
	self:createItemNodes()

	local nextQualityId = self._heroData:getNextQualityId()

	if nextQualityId == "" then
		self._topNode:setVisible(true)
		self:refreshTopView()
		self._evolutionPanel:setVisible(false)

		return
	end

	self._topNode:setVisible(false)
	self._evolutionPanel:setVisible(true)

	local qualityPanel = self._evolutionPanel:getChildByFullName("qualityPanel")
	local name = self._heroData:getName()
	local nextQuality = self._heroData:getNextQuality()
	local nextQualityLevel = self._heroData:getNextQualityLevel()
	local leftPanel = qualityPanel:getChildByFullName("leftPanel")
	local rightPanel = qualityPanel:getChildByFullName("rightPanel")

	self:refreshHeroIcon(leftPanel, name, self._heroData:getQuality(), self._heroData:getQualityLevel())
	self:refreshHeroIcon(rightPanel, name, nextQuality, nextQualityLevel)

	self._evoUpViewData.quality = {
		self._heroData:getQuality(),
		nextQuality
	}
	self._evoUpViewData.qualityId = {
		self._heroData:getQualityId(),
		self._heroData:getNextQualityId()
	}
	self._evoUpViewData.qualityLevel = {
		self._heroData:getQualityLevel(),
		nextQualityLevel
	}
	self._evoUpViewData.attr.attack[1] = self._heroData:getAttack()
	self._evoUpViewData.attr.hp[1] = self._heroData:getHp()
	self._evoUpViewData.attr.defense[1] = self._heroData:getDefense()
	self._evoUpViewData.attr.speed[1] = self._heroData:getSpeed()

	local level = self._heroData:getLevel()

	if self._heroSystem:isHeroExpMax(self._heroId) then
		level = level + 1
	end

	local a, b, c, d, combat = self._heroData:getNextStarEffect({
		qualityId = nextQualityId,
		level = level
	})

	self._evoUpViewData.attr.attack[2] = a - self._heroData:getAttack()
	self._evoUpViewData.attr.hp[2] = c - self._heroData:getHp()
	self._evoUpViewData.attr.defense[2] = b - self._heroData:getDefense()
	self._evoUpViewData.attr.speed[2] = d - self._heroData:getSpeed()
	self._evoUpViewData.level = self._heroData:getLevel()
	self._evoUpViewData.levelRequest = self._heroData:getCurMaxLevel()

	self:refreshItemNodes()
	self:refreshCostView()
	self:refreshPreView(combat)
end

function HeroStrengthEvolutionMediator:refreshHeroIcon(panel, name, quality, qualityLevel)
	panel:removeChildByName("HeroIcon")

	local leftNameNg = panel:getChildByFullName("nameBg")
	local leftName = panel:getChildByFullName("name")
	local qualityLevel_ = qualityLevel == 0 and "" or "+" .. qualityLevel

	leftName:setString(name .. qualityLevel_)
	leftNameNg:setLocalZOrder(2)
	leftName:setLocalZOrder(2)
	GameStyle:setHeroNameByQuality(leftName, quality)

	local icon = IconFactory:createHeroLargeIcon({
		id = self._heroId,
		rarity = self._heroData:getRarity()
	}, {
		hideAll = true
	})

	icon:addTo(panel):center(panel:getContentSize())
	icon:setName("HeroIcon")
	icon:setScale(0.7)
	icon:offset(0, -15)
end

function HeroStrengthEvolutionMediator:refreshItemNodes()
	self._itemEngouh = true

	for i = 1, #self._itemNodes do
		local data = self._itemList[i]

		if data then
			local parentNode = self._itemNodes[i]

			parentNode:setVisible(true)
			parentNode:setPosition(self._posArr[i])

			local isEnough = data.hasCount >= data.needCount
			local info = {
				scaleRatio = 0.7,
				id = data.itemId
			}
			local iconpanel = parentNode:getChildByFullName("costBg.iconpanel")

			iconpanel:removeAllChildren()

			local costIcon = IconFactory:createPic(info)

			costIcon:addTo(iconpanel)
			costIcon:setPosition(cc.p(iconpanel:getContentSize().width / 2, iconpanel:getContentSize().height / 2 - 2))
			costIcon:setGray(not isEnough)

			local addImg = parentNode:getChildByFullName("costBg.addImg")

			addImg:setVisible(not isEnough)

			local enoughImg = parentNode:getChildByFullName("costBg.bg.enoughImg")
			local costPanel = parentNode:getChildByFullName("costBg.costPanel")

			costPanel:setVisible(true)

			local cost = costPanel:getChildByFullName("cost")
			local costLimit = costPanel:getChildByFullName("costLimit")

			cost:setString(data.hasCount)
			costLimit:setString("/" .. data.needCount)
			costLimit:setPositionX(cost:getContentSize().width)
			costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))

			local colorNum1 = isEnough and 1 or 7

			cost:setTextColor(GameStyle:getColor(colorNum1))
			costLimit:setTextColor(GameStyle:getColor(colorNum1))
			enoughImg:setVisible(isEnough)

			if not isEnough then
				self._itemEngouh = isEnough
			end
		end
	end
end

function HeroStrengthEvolutionMediator:refreshCostView()
	local currencyCost = self._heroData:getQualityCostCurrency()
	local costNum = currencyCost[1].amount
	local costId = currencyCost[1].id

	self._costNum = costNum
	self._evolutionGoldEnough = CurrencySystem:checkEnoughGold(self, costNum, nil, {
		tipType = "none"
	})

	self._evolutionPanel:getChildByFullName("costNode4"):setPosition(self._posArr[#self._posArr])

	local iconpanel = self._sourcePanel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local costIcon = IconFactory:createPic({
		scaleRatio = 0.7,
		id = costId
	}, {
		largeIcon = true
	})

	costIcon:addTo(iconpanel):center(iconpanel:getContentSize())

	local addImg = self._sourcePanel:getChildByFullName("addImg")

	addImg:setVisible(not self._evolutionGoldEnough)
	iconpanel:setGray(not self._evolutionGoldEnough)

	local enoughImg = self._sourcePanel:getChildByFullName("bg.enoughImg")
	local costLabel = self._sourcePanel:getChildByFullName("cost")

	costLabel:setVisible(true)
	costLabel:setString(costNum)

	local colorType = self._evolutionGoldEnough and 1 or 7

	costLabel:setTextColor(GameStyle:getColor(colorType))
	enoughImg:setVisible(self._evolutionGoldEnough)

	local level = self._heroData:getLevel()

	self._levelEnough = level >= self._heroData:getLevelRequest()

	local levelTip = self._levelLimit:getChildByFullName("label_1")

	levelTip:setVisible(not self._levelEnough)

	if levelTip:isVisible() then
		local str = Strings:get("HEROS_UI59", {
			level = self._heroData:getLevelRequest()
		})

		levelTip:setString(str)
	end

	local str = Strings:get("HEROS_UI60")

	self._levelLimit:getChildByFullName("label_2"):setString(str)
end

function HeroStrengthEvolutionMediator:refreshPreView(combatPre)
	local combatPanel = self._evolutionPanel:getChildByFullName("descBg.combatPanel")
	local text1 = combatPanel:getChildByFullName("des_1.text")
	local text2 = combatPanel:getChildByFullName("des_2.text")
	local combat = self._heroData:getCombat()

	text1:setString(combat)
	text2:setString(combatPre)

	local lockPanel = self._evolutionPanel:getChildByFullName("descBg.lockPanel")

	lockPanel:setVisible(false)

	local nextLevelRequest = self._heroData:getNextQualityMaxLevel()

	if self._evoUpViewData.levelRequest ~= nextLevelRequest then
		lockPanel:setVisible(true)

		local text1 = lockPanel:getChildByFullName("des_1.text")
		local text2 = lockPanel:getChildByFullName("des_2.text")
		local str1 = Strings:get("Strenghten_Text78", {
			level = self._evoUpViewData.levelRequest
		})
		local str2 = Strings:get("Strenghten_Text78", {
			level = nextLevelRequest
		})

		text1:setString(str1)
		text2:setString(str2)
	end
end

function HeroStrengthEvolutionMediator:refreshTopView()
	local nextQualityId = self._heroData:getNextQualityId()

	if nextQualityId ~= "" then
		return
	end

	local system = self:getInjector():getInstance(CustomDataSystem)
	local currentQualityId = self._heroData:getQualityId()
	local topDateLabel = self._topNode:getChildByFullName("date")

	topDateLabel:setString("")

	if system:getValue(PrefixType.kGlobal, currentQualityId) then
		topDateLabel:setString(system:getValue(PrefixType.kGlobal, currentQualityId))
	end

	local config = ConfigReader:getRecordById("HeroBase", self._heroData:getId())
	local qualityId = config.BaseQualityAttr

	self._topNode:getChildByFullName("quality_6"):setVisible(false)

	for i = 1, 5 do
		if qualityId ~= "" then
			local qualityPanel = self._topNode:getChildByFullName("quality_" .. i)
			local qualityLevelLabel = qualityPanel:getChildByFullName("text")
			local showQualityId = self:checkQuality(qualityId)
			local qualityConfig = ConfigReader:getRecordById("HeroQuality", showQualityId)

			qualityId = qualityConfig.NextQuality

			local lvlQua = qualityConfig.QualityLevel

			qualityLevelLabel:setString(lvlQua == 0 and "" or "+" .. lvlQua)
			GameStyle:setHeroNameByQuality(qualityLevelLabel, qualityConfig.Quality)

			local qualityDateLabel = qualityPanel:getChildByFullName("date")

			qualityDateLabel:setString("")

			if system:getValue(PrefixType.kGlobal, showQualityId) then
				qualityDateLabel:setString(system:getValue(PrefixType.kGlobal, showQualityId))
			end
		end
	end
end

function HeroStrengthEvolutionMediator:checkQuality(qualityId)
	local qualityConfig = ConfigReader:getRecordById("HeroQuality", qualityId)
	local nextQualityId = qualityConfig.NextQuality

	if nextQualityId ~= "" then
		qualityConfig = ConfigReader:getRecordById("HeroQuality", nextQualityId)

		while qualityConfig and qualityConfig.QualityLevel ~= 0 do
			qualityId = nextQualityId
			nextQualityId = qualityConfig.NextQuality
			qualityConfig = ConfigReader:getRecordById("HeroQuality", qualityConfig.NextQuality)
		end

		return qualityId
	end

	return qualityId
end

function HeroStrengthEvolutionMediator:refreshAllView()
	self:refreshView()
end

function HeroStrengthEvolutionMediator:onEvolutionClicked()
	if not self._itemEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010009")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._evolutionGoldEnough then
		CurrencySystem:checkEnoughGold(self, self._costNum)
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._levelEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010028")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._mediator:stopHeroEffect()

	local param = {}

	for key, value in pairs(self._evoUpViewData) do
		param[key] = value
	end

	local qualityId = self._heroData:getNextQualityId()

	local function callBack()
		local currentTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
		local curData = TimeUtil:localDate("*t", currentTimeStamp)
		local dateStr = curData.year .. "." .. curData.month .. "." .. curData.day
		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

		customDataSystem:setValue(PrefixType.kGlobal, qualityId, dateStr, function()
			local view = self:getInjector():getInstance("HeroEvolutionUpTipView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, param))
		end)
	end

	self._heroSystem:requestHeroEvolutionUp(self._heroId, callBack)
end

function HeroStrengthEvolutionMediator:onTouchItemClicked(index)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local data = self._itemList[index]
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = data.itemId,
		hasNum = data.hasCount,
		needNum = data.needCount
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, nil))
end

function HeroStrengthEvolutionMediator:onDescClicked()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("ARENAVIEW_NOTICE")
	}))
end

function HeroStrengthEvolutionMediator:runStartAction()
	local mainPanel = self:getView():getChildByFullName("mainpanel")

	mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenEvolution.csb")

	mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local bgAnim1 = self._evolutionPanel:getChildByFullName("descBg.combatPanel.bgAnim1")

	if not bgAnim1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim1)
		anim:setName("BgAnim")
	end

	bgAnim1:getChildByFullName("BgAnim"):gotoAndStop(1)

	local bgAnim2 = self._evolutionPanel:getChildByFullName("descBg.lockPanel.bgAnim2")

	if not bgAnim2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim2)
		anim:setName("BgAnim")
	end

	bgAnim2:getChildByFullName("BgAnim"):gotoAndStop(1)

	local bgAnim3 = self._evolutionPanel:getChildByFullName("qualityPanel.image")

	if not bgAnim3:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("jiantoudonghua_jiantoudonghua")

		anim:addCallbackAtFrame(50, function()
			anim:stop()
		end)
		anim:addTo(bgAnim3)
		anim:setName("BgAnim")
		anim:offset(10, 5)
	end

	bgAnim3:getChildByFullName("BgAnim"):gotoAndStop(1)

	local costNode1 = self._evolutionPanel:getChildByFullName("costNode1")
	local costNode2 = self._evolutionPanel:getChildByFullName("costNode2")
	local costNode3 = self._evolutionPanel:getChildByFullName("costNode3")
	local costNode4 = self._evolutionPanel:getChildByFullName("costNode4")

	costNode1:setOpacity(0)
	costNode2:setOpacity(0)
	costNode3:setOpacity(0)
	costNode4:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "BgAnim1" then
			bgAnim1:getChildByFullName("BgAnim"):gotoAndPlay(1)
			costNode1:setOpacity(255)
			GameStyle:runCostAnim(costNode1)
		end

		if str == "BgAnim2" then
			bgAnim2:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "BgAnim3" then
			bgAnim3:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "CostAnim2" then
			costNode2:setOpacity(255)
			costNode3:setOpacity(255)
			GameStyle:runCostAnim(costNode2)
			GameStyle:runCostAnim(costNode3)
		end

		if str == "CostAnim3" then
			costNode4:setOpacity(255)
			GameStyle:runCostAnim(costNode4)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

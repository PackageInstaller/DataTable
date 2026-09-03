-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroEvolutionView.lua

HeroEvolutionView = class("HeroEvolutionView", DisposableObject, _M)

HeroEvolutionView:has("_view", {
	is = "r"
})
HeroEvolutionView:has("_info", {
	is = "r"
})
HeroEvolutionView:has("_mediator", {
	is = "r"
})

local componentPath = "asset/ui/StrengthenEvolutionNew.csb"

function HeroEvolutionView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._developSystem = self._mediator:getInjector():getInstance("DevelopSystem")
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:refreshData(info.heroId)
	self:createView(info)
	self:updateView(info)
	super.initialize(self)
end

function HeroEvolutionView:refreshData(heroId)
	self._heroId = heroId or self._heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._showLevel = self._heroData:getLevel()
	self._maxLevel = self._heroData:getCurMaxLevel()
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

	self._playerLevelRequest = self._heroData:getPlayerLevelRequest()
	self._playerLevelEnough = self._developSystem:getLevel() >= self._playerLevelRequest
end

function HeroEvolutionView:dispose()
	super.dispose(self)
end

function HeroEvolutionView:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(componentPath)
	self._touchLayer = self._view:getChildByName("touchLayer")
	self._showPanel = self._view:getChildByFullName("showpanel")

	self._touchLayer:setVisible(false)

	self._maxLevelImg = self._showPanel:getChildByFullName("maxLevel")

	self._maxLevelImg:setVisible(false)

	self._mainPanel = self._showPanel:getChildByFullName("evolutionNode")
	self._playerLvlRequest = self._showPanel:getChildByFullName("playerLevelRequest")

	self._playerLvlRequest:setVisible(false)

	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._upBtn = self._mainPanel:getChildByFullName("upBtn")

	self._upBtn:addClickEventListener(function()
		self:onEvolutionClicked()
	end)
	self._mainPanel:getChildByFullName("upBtn.name1"):setString("")
	self._infoPanel:getChildByFullName("level_1"):setString(self._showLevel .. "/" .. self._maxLevel)

	self._sourcePanel = self._mainPanel:getChildByFullName("costNode2.costBg")

	local addImg = self._sourcePanel:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self._mediator, CurrencyType.kGold)
	end)

	local lvLabel = self._infoPanel:getChildByFullName("lvLabel")

	GameStyle:setCommonOutlineEffect(lvLabel)

	local level1 = self._infoPanel:getChildByFullName("level_1")

	GameStyle:setCommonOutlineEffect(level1)

	for i = 1, 4 do
		local node = self._infoPanel:getChildByName("des_" .. i)
		local text = node:getChildByFullName("text")

		GameStyle:setCommonOutlineEffect(text)
	end

	GameStyle:setCostNodeEffect(self._mainPanel:getChildByFullName("costNode1"))
	GameStyle:setCostNodeEffect(self._mainPanel:getChildByFullName("costNode2"))
	self:createItemNodes()
	self:showCustomAnim()
	self:createProgress()
end

function HeroEvolutionView:createItemNodes()
	self._itemNodes = {}

	local maxNum = 1

	for pos = 1, maxNum do
		self._itemNodes[pos] = self._mainPanel:getChildByFullName("costNode" .. pos)

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

function HeroEvolutionView:showCustomAnim()
	local bgAnim = self._showPanel:getChildByFullName("bgAnim")

	bgAnim:removeAllChildren()

	self._customAnim1 = cc.MovieClip:create("zongdhbbbb_yinghunshengji")

	self._customAnim1:addTo(bgAnim):center(bgAnim:getContentSize())
	self._customAnim1:gotoAndStop(0)
	self._customAnim1:offset(0, -60)
	self._customAnim1:setScale(1.2)
	self._customAnim1:setGray(true)
	self._customAnim1:addEndCallback(function()
		self._customAnim1:gotoAndStop(0)
	end)
end

function HeroEvolutionView:createProgress()
	local heroNode = self._showPanel:getChildByFullName("heroNode")

	heroNode:getChildByFullName("bg1"):setLocalZOrder(2)
	heroNode:getChildByFullName("bg2"):setLocalZOrder(3)

	local node = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe8",
		id = self._heroData:getModel()
	})

	node:addTo(heroNode):center(heroNode:getContentSize())
	node:setLocalZOrder(1)

	local barImage = cc.Sprite:createWithSpriteFrameName("yinghun_lg.png")

	self._progrLoading = cc.ProgressTimer:create(barImage)

	self._progrLoading:setType(0)
	self._progrLoading:setReverseDirection(false)
	self._progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
	self._progrLoading:setMidpoint(cc.p(0.5, 0.5))
	self._progrLoading:addTo(heroNode)
	self._progrLoading:setPosition(cc.p(89, 85))
	self._progrLoading:setLocalZOrder(4)
end

function HeroEvolutionView:updateView()
	if self._heroSystem:isHeroLevelMax(self._heroId) and self._heroData:getNextQualityId() == "" then
		self._progrLoading:setPercentage(100)
		self._maxLevelImg:setVisible(true)
		self._mainPanel:setVisible(false)
		self._playerLvlRequest:setVisible(false)
	elseif self._heroData:getNextQualityId() ~= "" then
		self._maxLevelImg:setVisible(false)
		self._mainPanel:setVisible(true)

		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		self._progrLoading:setPercentage(self._heroData:getExp() / nextExp * 100)
		self._playerLvlRequest:setVisible(not self._playerLevelEnough)
		self._playerLvlRequest:removeAllChildren()

		if self._playerLvlRequest:isVisible() then
			local str = Strings:get("HeroStar_PlayerLevel", {
				level = self._playerLevelRequest,
				fontName = TTF_FONT_FZYH_M
			})
			local contentText = ccui.RichText:createWithXML(str, {})

			contentText:setAnchorPoint(cc.p(0.5, 0.5))
			contentText:addTo(self._playerLvlRequest):offset(0, 0)
		end

		self:refreshItemNodes()
		self:refreshCostView()
		self:refreshPreView()
		self._upBtn:setGray(not self._playerLevelEnough or not self._itemEngouh or not self._evolutionGoldEnough or not self._levelEnough)
	end
end

function HeroEvolutionView:refreshView(heroId)
	self:refreshData(heroId)
	self:updateView(heroId)
end

function HeroEvolutionView:refreshItemNodes()
	self._itemEngouh = true

	for i = 1, #self._itemNodes do
		local data = self._itemList[i]

		if data then
			local parentNode = self._itemNodes[i]

			parentNode:setVisible(true)

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

function HeroEvolutionView:refreshCostView()
	local currencyCost = self._heroData:getQualityCostCurrency()
	local costNum = currencyCost[1].amount
	local costId = currencyCost[1].id

	self._costNum = costNum
	self._evolutionGoldEnough = CurrencySystem:checkEnoughGold(self._mediator, costNum, nil, {
		tipType = "none"
	})

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
end

function HeroEvolutionView:refreshPreView()
	local nextQuality = self._heroData:getNextQuality()
	local nextQualityId = self._heroData:getNextQualityId()
	local nextQualityLevel = self._heroData:getNextQualityLevel()

	self._evoUpViewData.quality = {
		self._heroData:getQuality(),
		nextQuality
	}
	self._evoUpViewData.qualityId = {
		self._heroData:getQualityId(),
		nextQualityId
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

	self._levelEnough = level >= self._heroData:getLevelRequest()

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

	self._infoPanel:getChildByFullName("des_1.text"):setString(self._heroData:getAttack())
	self._infoPanel:getChildByFullName("des_2.text"):setString(self._heroData:getHp())
	self._infoPanel:getChildByFullName("des_3.text"):setString(self._heroData:getDefense())
	self._infoPanel:getChildByFullName("des_4.text"):setString(self._heroData:getSpeed())
	self._infoPanel:getChildByFullName("des_1.extandText"):setString("+" .. a - self._heroData:getAttack())
	self._infoPanel:getChildByFullName("des_2.extandText"):setString("+" .. c - self._heroData:getHp())
	self._infoPanel:getChildByFullName("des_3.extandText"):setString("+" .. b - self._heroData:getDefense())
	self._infoPanel:getChildByFullName("des_4.extandText"):setString("+" .. d - self._heroData:getSpeed())

	local atkShow = a - self._heroData:getAttack() > 0
	local hpShow = c - self._heroData:getHp() > 0
	local defShow = b - self._heroData:getDefense() > 0
	local speedShow = d - self._heroData:getSpeed() > 0

	self._infoPanel:getChildByFullName("des_1.extandText"):setVisible(atkShow)
	self._infoPanel:getChildByFullName("des_2.extandText"):setVisible(hpShow)
	self._infoPanel:getChildByFullName("des_3.extandText"):setVisible(defShow)
	self._infoPanel:getChildByFullName("des_4.extandText"):setVisible(speedShow)

	local preNode = self._mainPanel:getChildByFullName("preNode")
	local text1 = preNode:getChildByFullName("des_1.text")
	local text2 = preNode:getChildByFullName("des_2.text")
	local name = self._heroData:getName()
	local qualityLevel_ = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()

	text1:setString(name .. qualityLevel_)
	GameStyle:setHeroNameByQuality(text1, self._heroData:getQuality(), 2)

	local qualityLevel_ = nextQualityLevel == 0 and "" or "+" .. nextQualityLevel

	text2:setString(name .. qualityLevel_)
	GameStyle:setHeroNameByQuality(text2, nextQuality, 2)

	local levelNode = preNode:getChildByFullName("levelNode")

	levelNode:setVisible(false)

	local nextLevelRequest = self._heroData:getNextQualityMaxLevel()

	if self._evoUpViewData.levelRequest ~= nextLevelRequest then
		levelNode:setVisible(true)

		local text1 = levelNode:getChildByFullName("level1.text")
		local text2 = levelNode:getChildByFullName("level2.text")
		local str1 = Strings:get("HEROS_UI64") .. self._evoUpViewData.levelRequest
		local str2 = nextLevelRequest

		text1:setString(str1)
		text2:setString(str2)
		GameStyle:setCommonOutlineEffect(text1, 219.29999999999998, 2)
		GameStyle:setCommonOutlineEffect(text2, 219.29999999999998, 2)
	end
end

function HeroEvolutionView:onEvolutionClicked()
	if not self._playerLevelEnough then
		local str = Strings:get("HeroStar_PlayerLevelTips", {
			level = self._playerLevelRequest
		})

		self._mediator:dispatch(ShowTipEvent({
			tip = str
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._itemEngouh then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010009")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._evolutionGoldEnough then
		CurrencySystem:checkEnoughGold(self._mediator, self._costNum)
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._levelEnough then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010028")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local param = {}

	for key, value in pairs(self._evoUpViewData) do
		param[key] = value
	end

	local function callBack()
		local view = self._mediator:getInjector():getInstance("HeroEvolutionUpTipView")

		self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, param))
	end

	self._heroSystem:requestHeroEvolutionUp(self._heroId, callBack)
end

function HeroEvolutionView:onTouchItemClicked(index)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local data = self._itemList[index]
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = data.itemId,
		hasNum = data.hasCount,
		needNum = data.needCount
	}
	local view = self._mediator:getInjector():getInstance("sourceView")

	self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, nil))
end

function HeroEvolutionView:runStartAnim()
	self._touchLayer:setVisible(true)
	self._showPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline(componentPath)

	self._showPanel:runAction(action)
	action:gotoFrameAndPlay(0, 27, false)
	action:setTimeSpeed(1.2)

	local costNode1 = self._mainPanel:getChildByFullName("costNode1")
	local costNode2 = self._mainPanel:getChildByFullName("costNode2")

	GameStyle:runCostAnim(costNode1)
	GameStyle:runCostAnim(costNode2)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "EndAnim1" then
			self._touchLayer:setVisible(false)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

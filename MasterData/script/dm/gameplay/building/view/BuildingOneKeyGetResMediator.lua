-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingOneKeyGetResMediator.lua

require("dm.gameplay.building.view.MinusView")

BuildingOneKeyGetResMediator = class("BuildingOneKeyGetResMediator", DmPopupViewMediator)

BuildingOneKeyGetResMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingOneKeyGetResMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
BuildingOneKeyGetResMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function calcQuadraticAction(pX, pY, distance, target, actTimes, endPosX, endPosY)
	local d = distance
	local times = math.abs(distance)
	local dx = 1 * distance / times
	local i = 1
	local callFunc = cc.CallFunc:create(function()
		local x = pX + i * dx
		local y = pY + d * d / 50 - 0.08 * math.pow(i * dx - d / 2, 2)

		target:setPosition(cc.p(x, y))

		i = i + 1
	end)
	local seq = cc.Sequence:create(cc.DelayTime:create(0.01), callFunc)
	local action

	target:runAction(actTimes > 2 and cc.Sequence:create(cc.Repeat:create(seq, times), cc.MoveTo:create(0.5, cc.p(endPosX, endPosY)), cc.ScaleTo:create(0.1, 0.8), cc.CallFunc:create(function()
		target:removeFromParent()
	end)) or cc.Sequence:create(cc.Repeat:create(seq, times), cc.CallFunc:create(function()
		calcQuadraticAction(pX + d, pY, distance * 0.7, target, actTimes + 1, endPosX, endPosY)
	end)))
end

local clickEventMap = {
	Panel_touch = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCancleBtn"
	},
	["main.PanelTouch_tip"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHideTips"
	},
	["main.tips"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickShowTips"
	}
}
local mcName = {
	IR_Crystal = "sj_lingquziyuan",
	IR_Gold = "jinbi_lingquziyuan"
}
local resNodeOrder = {
	[KBuildingType.kGoldOre] = 1,
	[KBuildingType.kCrystalOre] = 2,
	[KBuildingType.kExpOre] = 3
}
local cardItemList = {
	[KBuildingType.kGoldOre] = {
		code = "IM_VillageGoldOre_6",
		amount = 0,
		type = RewardType.kItem
	},
	[KBuildingType.kCrystalOre] = {
		code = "IM_VillageCrystalOre_6",
		amount = 0,
		type = RewardType.kItem
	},
	[KBuildingType.kExpOre] = {
		code = "IM_VillageExpOre_6",
		amount = 0,
		type = RewardType.kItem
	},
	All = {
		code = "IM_VillageAllOre_1",
		amount = 0,
		type = RewardType.kItem
	}
}
local topCurrencyPos = {}

function BuildingOneKeyGetResMediator:initialize()
	super.initialize(self)
end

function BuildingOneKeyGetResMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingOneKeyGetResMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
	self:initCurrencyPos()
end

function BuildingOneKeyGetResMediator:initCurrencyPos()
	local topView
	local mediatorMap = self:getMediatorMap()

	for k, v in pairs(mediatorMap._registeredMediators) do
		if v:getViewName() == "homeView" then
			topView = v:getView()
		end
	end

	if not topView then
		return
	end

	local parentView = topView:getChildByFullName("currencyinfo_node.currency_bar_4")
	local targetNode = parentView:getChildByName("icon_node")
	local goldPos = parentView:convertToWorldSpace(cc.p(targetNode:getPositionX(), targetNode:getPositionY()))

	goldPos = topView:convertToNodeSpace(goldPos)
	parentView = topView:getChildByFullName("currencyinfo_node.currency_bar_3")
	targetNode = parentView:getChildByName("icon_node")

	local crysPos = parentView:convertToWorldSpace(cc.p(targetNode:getPositionX(), targetNode:getPositionY()))

	crysPos = topView:convertToNodeSpace(crysPos)

	local bagNodeParent = topView:getChildByFullName("mTopFuncLayout")
	local bagNode = bagNodeParent:getChildByFullName("mBagNode")
	local bagNodePos = bagNodeParent:convertToWorldSpace(cc.p(bagNode:getPositionX(), bagNode:getPositionY()))

	bagNodePos = topView:convertToNodeSpace(bagNodePos)
	topCurrencyPos = {
		IR_Gold = goldPos,
		IR_Crystal = crysPos
	}

	local expChargeItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpChargeItem", "content")

	for i = 1, #expChargeItem do
		mcName[expChargeItem[i]] = "pz_lingquziyuan"
		topCurrencyPos[expChargeItem[i]] = bagNodePos
	end
end

function BuildingOneKeyGetResMediator:mapEventListeners()
	return
end

function BuildingOneKeyGetResMediator:enterWithData()
	self._nodeOutList = {}
	self._nodeResList = {}
	self._nodeCardList = {}
	self._emptyCardList = {}
	self._curCardCount = {}
	self._canGetResSta = false

	self:setupView()
	self:refreshView()
	self:refreshCard()
	self:initAnim()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:refreshView()
	end, 1, false)

	AudioEngine:getInstance():playEffect("Se_Alert_Pop", false)
end

function BuildingOneKeyGetResMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tipsPanel = self._mainPanel:getChildByName("tipsPanel")
	self._tipsTouchPanel = self._mainPanel:getChildByName("PanelTouch_tip")

	local emptyCardImg = self._mainPanel:getChildByFullName("Image_no_card")
	local minusPanel = self._mainPanel:getChildByFullName("minusPanel")
	local Image_add_extra = self._mainPanel:getChildByFullName("Image_add_extra")

	emptyCardImg:setPositionY(2000)
	minusPanel:setPositionY(2000)
	Image_add_extra:setPositionY(2000)
	self._tipsTouchPanel:setVisible(false)
	self:setupTips()

	self._nodeOutList[#self._nodeOutList + 1] = {
		t = KBuildingType.kGoldOre,
		n = self._mainPanel:getChildByFullName("Node_res1"),
		currencyType = CurrencyType.kGold
	}
	self._nodeOutList[#self._nodeOutList + 1] = {
		t = KBuildingType.kCrystalOre,
		n = self._mainPanel:getChildByFullName("Node_res2"),
		currencyType = CurrencyType.kCrystal
	}
	self._nodeOutList[#self._nodeOutList + 1] = {
		t = KBuildingType.kExpOre,
		n = self._mainPanel:getChildByFullName("Node_res3"),
		currencyType = CurrencyType.kExp
	}

	local addImg = self._mainPanel:getChildByFullName("Image_add_extra")
	local nodeRes = self._mainPanel:getChildByFullName("Node_1.Node_res")
	local rewardList = {
		[KBuildingType.kGoldOre] = {
			type = 2,
			code = "IR_Gold",
			amount = 1
		},
		[KBuildingType.kCrystalOre] = {
			type = 2,
			code = "IR_Crystal",
			amount = 1
		},
		[KBuildingType.kExpOre] = {
			type = 2,
			code = "PlayerHeroExp",
			amount = 1
		}
	}

	if getCurrentLanguage() ~= GameLanguageType.CN then
		nodeRes:setScale(0.8)
	end

	addImg:setVisible(false)

	for resType, rewardData in pairs(rewardList) do
		local iconNode = cc.Node:create()

		iconNode:addTo(nodeRes)

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:addTo(iconNode, 1):center(iconNode:getContentSize())
		icon:setScaleNotCascade(0.7)
		icon:setName("icon")
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			swallowTouches = true,
			needDelay = true
		})

		local cloneAddImg = addImg:clone()

		cloneAddImg:setVisible(false)
		cloneAddImg:setTag(1234)
		cloneAddImg:setPosition(cc.p(40, 40))
		cloneAddImg:addTo(iconNode, 99999)

		local name = RewardSystem:getName(rewardData)
		local nameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 16, cc.size(86, 80))

		nameText:setAlignment(1, 0)
		nameText:setAnchorPoint(cc.p(0.5, 1))
		nameText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
		nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -83)

		self._nodeResList[resType] = iconNode
	end

	local textDesNone = self._mainPanel:getChildByFullName("Node_1.Node_none.Text")

	textDesNone:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local Text_timeDes = self._mainPanel:getChildByFullName("Text_timeDes")

	Text_timeDes:setPositionX(300)

	local Text_time = self._mainPanel:getChildByFullName("Text_time")

	Text_time:setPositionX(Text_timeDes:getPositionX() + Text_timeDes:getContentSize().width + 10)

	self._getResBtn = self:bindWidget("main.sureBtn", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickGetRes, self)
		}
	})
	self._cancleBtn = self:bindWidget("main.cancleBtn", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickCancleBtn, self)
		}
	})

	for k, v in pairs(self._nodeOutList) do
		local type = v.currencyType
		local node = v.n
		local addImg = node:getChildByFullName("Image_add")

		addImg:setTouchEnabled(true)
		addImg:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					_currencyType = type
				}))
			end
		end)
	end

	self:stepCardIcon()
end

function BuildingOneKeyGetResMediator:stepCardIcon()
	local nodeRes = self._mainPanel:getChildByFullName("Node_2.Node_res")
	local bgImg = self._mainPanel:getChildByFullName("Node_2.Image_2")
	local emptyCardImg = self._mainPanel:getChildByFullName("Image_no_card")
	local minusPanel = self._mainPanel:getChildByFullName("minusPanel")

	emptyCardImg:setVisible(false)
	minusPanel:setVisible(false)

	local width = bgImg:getContentSize().width
	local iconPosX = {
		[KBuildingType.kGoldOre] = width / 5,
		[KBuildingType.kCrystalOre] = width / 5 * 2,
		[KBuildingType.kExpOre] = width / 5 * 3,
		All = width / 5 * 4
	}
	local iconPosY = -8

	for k, rewardData in pairs(cardItemList) do
		local iconNode = cc.Node:create()

		iconNode:setPosition(iconPosX[k], iconPosY)
		iconNode:addTo(nodeRes)

		local icon = IconFactory:createRewardIcon(rewardData, {
			notGray = true,
			isWidget = true
		})

		icon:addTo(iconNode, 1):center(iconNode:getContentSize())
		icon:setScaleNotCascade(0.7)
		icon:setName("icon")

		local quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", rewardData.code, "Quality")
		local name = RewardSystem:getName(rewardData)
		local nameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 16, cc.size(120, 80))

		nameText:setAlignment(1, 0)
		nameText:setAnchorPoint(cc.p(0.5, 1))
		nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -85)
		GameStyle:setQualityText(nameText, quality)

		local clonePanel = minusPanel:clone()

		clonePanel:setVisible(true)
		clonePanel:addTo(iconNode, 999):center(iconNode:getContentSize()):offset(23, 30)

		local bagSystem = self._developSystem:getBagSystem()
		local entry = bagSystem:getEntryById(rewardData.code)
		local var_14_1 = {
			useCount = 0,
			this = self
		}

		if entry then
			var_14_1.maxCount = entry.count or 0
		end

		var_14_1.itemId = rewardData.code
		var_14_1.cardIcon = icon

		local view = MinusView:new({
			node = clonePanel
		}, self.refreshResCount, var_14_1)

		view:registerMinusEventListener(clonePanel:getChildByName("minusbtn"), function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				view:onTouchBeganEvent(false)
			elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
				view:onTouchEndedEvent(false)
				self:refreshView()
			end
		end)
		view:registerPlusEventListener(icon, function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				view:onTouchBeganEvent(true)
			elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
				view:onTouchEndedEvent(true)
				self:refreshView()
			end
		end)

		self._nodeCardList[k] = iconNode

		local param = {
			needNum = 0,
			isNeed = true,
			hasNum = 0,
			hasWipeTip = true,
			itemId = rewardData.code
		}
		local cloneEmptyCard = emptyCardImg:clone()

		cloneEmptyCard:setVisible(true)
		cloneEmptyCard:addTo(nodeRes):posit(iconPosX[k], iconPosY)
		cloneEmptyCard:setTouchEnabled(true)
		cloneEmptyCard:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local view = self:getInjector():getInstance("sourceView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, param))
			end
		end)

		local emptyNameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 16, cc.size(120, 80))

		emptyNameText:setAlignment(1, 0)
		emptyNameText:setAnchorPoint(cc.p(0.5, 1))
		emptyNameText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
		emptyNameText:addTo(cloneEmptyCard):center(cloneEmptyCard:getContentSize()):offset(0, -85)
		GameStyle:setQualityText(emptyNameText, quality)

		self._emptyCardList[k] = cloneEmptyCard
	end
end

function BuildingOneKeyGetResMediator:setupTips()
	local tips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "OreCollectRule", "content")
	local space = 18
	local localLanguage = getCurrentLanguage()

	if localLanguage ~= GameLanguageType.CN then
		space = 5
	end

	local heightAll = 0

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		text:setLineSpacing(space)
		text:getVirtualRenderer():setMaxLineWidth(380)
		text:setAnchorPoint(cc.p(0, 1))
		text:addTo(self._tipsPanel)

		heightAll = heightAll + text:getContentSize().height
	end

	self._tipsPanel:setContentSize(cc.size(407, heightAll + 40))
	self._tipsPanel:removeAllChildren()

	local panelSize = self._tipsPanel:getContentSize()

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		text:setLineSpacing(space)
		text:getVirtualRenderer():setMaxLineWidth(400)
		text:addTo(self._tipsPanel):setTag(i)
		text:setAnchorPoint(cc.p(0, 1))

		local prewText = self._tipsPanel:getChildByTag(i - 1)

		if prewText then
			local topPosY = prewText:getPositionY() - prewText:getContentSize().height

			text:setPosition(cc.p(10, topPosY - space))
		else
			text:setPosition(cc.p(10, panelSize.height - 15))
		end
	end
end

function BuildingOneKeyGetResMediator:initAnim()
	for i = 1, #self._nodeOutList do
		local target = self._nodeOutList[i].n

		target:setOpacity(0)
		target:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * i), cc.FadeIn:create(0.08)))
	end

	local textTime = self._mainPanel:getChildByFullName("Text_time")

	textTime:setOpacity(0)
	textTime:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.2)))

	local timeTips = self._mainPanel:getChildByFullName("Text_timeDes")

	timeTips:setOpacity(0)
	timeTips:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.2)))

	local btn = self._cancleBtn:getView()

	btn:setOpacity(0)
	btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.2)))

	local btn = self._getResBtn:getView()

	btn:setOpacity(0)
	btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.15)))

	for k, v in pairs(self._nodeResList) do
		local target = v

		target:setOpacity(0)
		target:runAction(cc.Sequence:create(cc.DelayTime:create(0.15), cc.FadeIn:create(0.08)))
	end

	local text = self._mainPanel:getChildByFullName("Node_1.Text_3")

	text:setOpacity(0)
	text:runAction(cc.Sequence:create(cc.DelayTime:create(0.15), cc.FadeIn:create(0.08)))

	local text = self._mainPanel:getChildByFullName("Node_2.Text_3")

	text:setOpacity(0)
	text:runAction(cc.Sequence:create(cc.DelayTime:create(0.15), cc.FadeIn:create(0.08)))

	if self._canGetResSta then
		local mc = cc.MovieClip:create("baoxiang2_jiayuanshouqu")

		mc:addTo(self:getView())
		mc:setPosition(cc.p(150, 150))
		mc:addEndCallback(function()
			mc:removeFromParent()
		end)
	end
end

function BuildingOneKeyGetResMediator:refreshView()
	self._canGetResSta = false

	local outList, resList, resNoLimitList = self._buildingSystem:getAllBuildOutAndRes()
	local showOutList = {}

	for index, outInfo in pairs(self._nodeOutList) do
		local outNode = outInfo.n
		local outType = outInfo.t
		local textNum = outNode:getChildByFullName("Text")

		if not outList[outType] then
			local outNum = 0

			textNum:setString(outNum .. Strings:get("Building_Product_Unit"))

			showOutList[#showOutList + 1] = outNode
		end
	end

	local showResList = self:_refreshResCount()

	if not self._canGetResSta and self._buildingSystem:getAllExpBuildResSta() then
		self._canGetResSta = true
	end

	local nodeNone = self._mainPanel:getChildByFullName("Node_1.Node_none")
	local len = 122
	local numRes = #showResList

	if numRes > 0 then
		nodeNone:setVisible(false)

		for k, arr in pairs(showResList) do
			arr.node:setVisible(true)

			local initX = 0 - (numRes - 1) * 0.5 * len

			arr.node:setPosition(cc.p(initX + (k - 1) * len, 0))
		end
	else
		nodeNone:setVisible(true)
	end

	local time = self._buildingSystem:getBuildLastGetResTime()
	local textTime = self._mainPanel:getChildByFullName("Text_time")
	local timeDes, _timeDes = self._buildingSystem:getTimeText(time)

	textTime:setString(_timeDes)
end

function BuildingOneKeyGetResMediator:refreshCard()
	local bagSystem = self._developSystem:getBagSystem()

	for k, rewardData in pairs(cardItemList) do
		local entry = bagSystem:getEntryById(rewardData.code)

		if entry and entry.count > 0 then
			self._nodeCardList[k]:setVisible(true)
			self._emptyCardList[k]:setVisible(false)
			self._nodeCardList[k]:getChildByName("icon"):setTouchEnabled(true)
			self._nodeCardList[k]:setOpacity(255)
			self._nodeCardList[k]:getChildByName("icon"):setAmount(entry.count)
		else
			self._nodeCardList[k]:setVisible(true)
			self._nodeCardList[k]:setOpacity(100)
			self._nodeCardList[k]:getChildByName("icon"):setTouchEnabled(false)
			self._emptyCardList[k]:setVisible(true)
		end
	end
end

function BuildingOneKeyGetResMediator:refreshResCount(param)
	local itemId = param.itemId
	local cardIcon = param.cardIcon

	self._curCardCount[itemId] = param.useCount

	self:_refreshResCount()
	cardIcon:setAmount(param.maxCount - param.useCount)
end

function BuildingOneKeyGetResMediator:_refreshResCount()
	local function setAddText(label, amount)
		if type(amount) == "number" and amount > 99999 then
			local str = Strings:get("Common_Time_01")
			local amountTemp = amount / 10000

			label:setString("+" .. math.floor(amountTemp) .. str)
		else
			label:setString("+" .. amount)
		end
	end

	local baseVal = 2500
	local showResList = {}
	local outList, resList, resNoLimitList = self._buildingSystem:getAllBuildOutAndRes()

	for _type, resNode in pairs(self._nodeResList) do
		local _itemId = cardItemList[_type].code

		if not self._curCardCount[_itemId] then
			local curCount = 0
			local extraNum = (outList[_type] + baseVal) * curCount * 6
			local _itemAllId = cardItemList.All.code

			if not self._curCardCount[_itemAllId] then
				local curExtraCount = 0
				local extraNum = extraNum + (outList[_type] + baseVal) * curExtraCount
				local addImg = resNode:getChildByTag(1234)
				local addText = addImg:getChildByName("Text_num")

				setAddText(addText, extraNum)

				if not resNoLimitList[_type] then
					local outNum = 0
					local totalNum = extraNum + outNum
					local icon = resNode:getChildByFullName("icon")

					icon:setAmount(totalNum)
					addImg:setVisible(extraNum > 0)

					if totalNum > 0 then
						showResList[#showResList + 1] = {
							node = resNode,
							sort = resNodeOrder[_type]
						}

						if _type == KBuildingType.kGoldOre or _type == KBuildingType.kCrystalOre then
							self._canGetResSta = true
						end
					end

					resNode:setVisible(totalNum > 0)
				end
			end
		end
	end

	table.sort(showResList, function(a, b)
		return a.sort < b.sort
	end)

	return showResList
end

function BuildingOneKeyGetResMediator:onClickGetRes()
	if self._canGetResSta then
		self._buildingSystem:sendOneKeyCollectRes("onekey", true, function(rewards)
			local view = self:getInjector():getInstance("getRewardView")
			local delegate = __associated_delegate__(self)({
				willClose = function(self, popUpMediator, data)
					self:close()
				end
			})

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				needClick = true,
				rewards = rewards
			}, delegate))

			for k, v in ipairs(rewards) do
				local name = mcName[v.code]
				local endPos = topCurrencyPos[v.code]

				for i = 1, 10 do
					local mc = cc.MovieClip:create(name)

					if mc and endPos then
						mc:setScale(0.55)
						mc:addTo(view, 10)
						mc:setPosition(cc.p(568, 320))

						local random1 = math.random(40, 110)
						local random2 = math.random(1, 2)
						local randomTime = math.random(1, 100)
						local dis = random2 == 1 and random1 or -random1

						performWithDelay(mc, function()
							calcQuadraticAction(568, 320, dis, mc, 1, endPos.x, endPos.y)
						end, randomTime / 100)
					end
				end
			end
		end, self._curCardCount)
	else
		self:close()
	end
end

function BuildingOneKeyGetResMediator:onClickCancleBtn()
	self:close()
end

function BuildingOneKeyGetResMediator:onClickShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._tipsPanel:setVisible(true)
		self._tipsTouchPanel:setVisible(true)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(false)
		self._tipsTouchPanel:setVisible(false)
	end
end

function BuildingOneKeyGetResMediator:onClickHideTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(false)
		self._tipsTouchPanel:setVisible(false)
	end
end

function BuildingOneKeyGetResMediator:collectResSuc(event)
	return
end

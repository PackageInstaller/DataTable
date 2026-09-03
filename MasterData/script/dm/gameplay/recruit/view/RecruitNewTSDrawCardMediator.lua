-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitNewTSDrawCardMediator.lua

RecruitNewTSDrawCardMediator = class("RecruitNewTSDrawCardMediator", DmAreaViewMediator, _M)

RecruitNewTSDrawCardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RecruitNewTSDrawCardMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")
RecruitNewTSDrawCardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
RecruitNewTSDrawCardMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local textshadow_Name = {
	width = 4,
	color = cc.c4b(0, 0, 0, 90),
	size = cc.size(0, -3)
}
local kBtnHandlers = {
	["main.node1.recruitBtn1"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRecruit1Clicked"
	},
	["main.node2.recruitBtn2"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRecruit2Clicked"
	},
	["moreNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMore"
	},
	touchLayer = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickHideTip"
	}
}
local Tsoul_LevelMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_LevelMax", "content")

function RecruitNewTSDrawCardMediator:initialize()
	super.initialize(self)
end

function RecruitNewTSDrawCardMediator:dispose()
	super.dispose(self)
end

function RecruitNewTSDrawCardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._bagSystem = self._developSystem:getBagSystem()
end

function RecruitNewTSDrawCardMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUIT_SUCC, self, self.onRecruitSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onResetRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.onDiffRefresh)
end

function RecruitNewTSDrawCardMediator:enterWithData(data)
	self._activity = nil

	local activities = self._activitySystem:getActivitiesByType(ActivityType.kDRAWCARDTS)

	for id, activity in pairs(activities) do
		if self._activitySystem:isActivityOpen(id) and not self._activitySystem:isActivityOver(id) then
			self._activity = activity

			break
		end
	end

	if not self._activity then
		return
	end

	local activityConfig = self._activity:getActivityConfig()

	self._recruitManager = self._recruitSystem:getManager()
	self._recruitDataShow = self._recruitManager:getRecruitPoolById(activityConfig.DRAW)
	self._currencyInfo = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_Resource", "content")
	self._currencyInfos = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_Resource1", "content")

	self:setupTopInfoWidget()
	self:initNode()
	self:initView()
end

function RecruitNewTSDrawCardMediator:onDiffRefresh(event)
	self:onResetRefresh()
end

function RecruitNewTSDrawCardMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfo = {}

	for i = #self._currencyInfo, 1, -1 do
		currencyInfo[#self._currencyInfo - i + 1] = self._currencyInfo[i]
	end

	local config = {
		style = 1,
		hideLine = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("DrawCard_TS_2UP_1_Name")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	self._topInfoNode = topInfoNode
end

function RecruitNewTSDrawCardMediator:initNode()
	self._main = self:getView():getChildByFullName("main")
	self._recruitBtn1 = self:getView():getChildByFullName("main.node1.recruitBtn1")
	self._recruitBtn2 = self:getView():getChildByFullName("main.node2.recruitBtn2")

	self._recruitBtn1:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 114.75), 2)
	self._recruitBtn2:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 114.75), 2)

	self._drawNode = self._main:getChildByFullName("drawNum")
	self._drawNum = self._drawNode:getChildByFullName("text")
	self._moreNode = self:getView():getChildByFullName("moreNode")

	self._moreNode:setVisible(false)

	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)
	self._main:getChildByFullName("Image_257"):loadTexture(CommonUtils.getPathByType("STORY_ALPHA", "drawcard_bg_ts.png"))

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 222, 0, 255)
		}
	}

	self._moreNode:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local detailPanel = self._main:getChildByFullName("tipBtn")

	detailPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickPreview()
		end
	end)
end

function RecruitNewTSDrawCardMediator:initView()
	self:updateCostNode()
	self:refreshUREQuipInfo()
	self:refreshDrawNum()
end

function RecruitNewTSDrawCardMediator:onResetRefresh()
	self._activity = nil

	local activities = self._activitySystem:getActivitiesByType(ActivityType.kDRAWCARDTS)

	for id, activity in pairs(activities) do
		if self._activitySystem:isActivityOpen(id) and not self._activitySystem:isActivityOver(id) then
			self._activity = activity

			break
		end
	end

	if not self._activity then
		self:onClickBack()

		return
	end

	local activityConfig = self._activity:getActivityConfig()

	self._recruitManager = self._recruitSystem:getManager()
	self._recruitDataShow = self._recruitManager:getRecruitPoolById(activityConfig.DRAW)

	self:initView()
end

function RecruitNewTSDrawCardMediator:refreshDrawNum()
	local n = self._recruitSystem:getDrawTimeById(self._recruitDataShow:getId())

	n = n and n["1"] or 0

	local str = Strings:get("RecruitHero_Times", {
		num = n
	})

	self._drawNum:setString(str)

	local imgbg = self._drawNode:getChildByFullName("Image_1")

	imgbg:setContentSize(cc.size(self._drawNum:getAutoRenderSize().width + 100, imgbg:getContentSize().height))
end

function RecruitNewTSDrawCardMediator:onClickPreview()
	local function callback(rewards)
		local view = self:getInjector():getInstance("recruitHeroPreviewView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			recruitPool = self._recruitDataShow,
			rewards = rewards
		}))
	end

	local showRewards = self._recruitDataShow:getShowRewards()
	local key = next(showRewards)

	if not key or key == "" then
		return
	end

	local params = {
		drawID = self._recruitDataShow:getId(),
		key = key
	}

	self._recruitSystem:requestRewardPreview(params, callback)
end

function RecruitNewTSDrawCardMediator:onClickBack()
	self:getView():stopAllActions()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function RecruitNewTSDrawCardMediator:updateCostNode()
	local costNode1 = self._main:getChildByFullName("node1.recruitBtn1")
	local costNode2 = self._main:getChildByFullName("node2.recruitBtn2")
	local id = self._recruitDataShow:getId()
	local hasLeft = ""
	local costData

	if self._recruitDataShow:getRealCostIdAndCount()[1] then
		local costCount, offCount = self._recruitDataShow:getRealCostIdAndCount()[1], 100
		local time = self._recruitDataShow:getRecruitTimes()[1]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, costCount, time)
		end

		self:initCostNode(costCount, costNode1, offCount)
		self._recruitBtn1:getChildByFullName("text"):setString(Strings:get(self._recruitDataShow:getShortDesc()[1]))
		self._recruitBtn1:getChildByFullName("text_1"):setString(Strings:get(self._recruitDataShow:getShortDescEn()[1]))

		if self._recruitDataShow:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = self._recruitDataShow:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end
	end

	if self._recruitDataShow:getRealCostIdAndCount()[2] then
		self._recruitBtn2:setVisible(true)

		local costCount, offCount = self._recruitDataShow:getRealCostIdAndCount()[2], 100
		local time = self._recruitDataShow:getRecruitTimes()[2]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, costCount, time)
		end

		if hasLeft == "" and self._recruitDataShow:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = self._recruitDataShow:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end

		self:initCostNode(costCount, costNode2, offCount)
		self._recruitBtn2:getChildByFullName("text"):setString(Strings:get(self._recruitDataShow:getShortDesc()[2]))
		self._recruitBtn2:getChildByFullName("text_1"):setString(Strings:get(self._recruitDataShow:getShortDescEn()[2]))
	else
		self._recruitBtn2:setVisible(false)
	end
end

function RecruitNewTSDrawCardMediator:initCostNode(recruitCost, costNode, offCount)
	local icon1 = costNode:getChildByFullName("icon")
	local name1 = costNode:getChildByFullName("name")
	local freeText = costNode:getChildByFullName("freeText")
	local costId = recruitCost.costId
	local costCount = recruitCost.costCount

	if costCount == 0 then
		icon1:setVisible(false)
		name1:setVisible(false)
		freeText:setVisible(true)
	else
		icon1:setVisible(true)
		name1:setVisible(true)
		freeText:setVisible(false)

		local prototype = ItemPrototype:new(costId)
		local item = Item:new(prototype)

		name1:setString(item:getName() .. "  x" .. costCount)
		icon1:removeAllChildren()

		local costIcon = IconFactory:createPic({
			id = costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.45)
		costIcon:addTo(icon1):center(icon1:getContentSize())

		if costId ~= "IM_DiamondDraw" and costId ~= "IM_DiamondDrawEX" then
			icon1:setPositionY(15)
		end

		icon1:setPositionX(name1:getPositionX() - name1:getContentSize().width / 2 - 2)
	end

	local costOffBg = costNode:getChildByFullName("costOffBg")

	if offCount ~= 100 then
		costOffBg:setVisible(true)
		costOffBg:getChildByFullName("costOff"):setString(100 - offCount .. "%")
	else
		costOffBg:setVisible(false)
	end
end

function RecruitNewTSDrawCardMediator:refreshUREQuipInfo()
	local type = self._recruitDataShow:getType()
	local titleImg = self._main:getChildByName("Image_148")

	titleImg:loadTexture(self._recruitDataShow:getPreview().tittletips .. ".png")

	local tsoulInfo = self._recruitDataShow:getRoleDetail()

	if tsoulInfo then
		self._main:setVisible(true)

		for i = 1, #tsoulInfo do
			local tsoulData = tsoulInfo[i]
			local tsoulSuitId = tsoulData.TsoulSuit
			local suitData = ConfigReader:getRecordById("TsoulSuit", tsoulSuitId)
			local equipId = suitData.Part[2]
			local equipNode = self._main:getChildByName("equip" .. i)
			local config = ConfigReader:getRecordById("Tsoul", equipId)
			local iconPanel = equipNode:getChildByName("icon")

			iconPanel:removeAllChildren()

			local path = GameStyle:getItemFile(config.Icon)
			local icon = ccui.ImageView:create(path)

			icon:addTo(iconPanel):center(iconPanel:getContentSize())

			local imgRartiy = equipNode:getChildByName("Image_r")

			imgRartiy:ignoreContentAdaptWithSize(true)
			imgRartiy:loadTexture(GameStyle:getEquipRarityImage(suitData.SuitRareity + 9))
			imgRartiy:setScale(0.7)

			local btn = equipNode:getChildByName("Image_14")

			btn:addClickEventListener(function()
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self._touchLayer:setVisible(true)
				self:onClickShowTip(tsoulSuitId)
			end)

			local nameText = equipNode:getChildByName("Text_name")

			nameText:setString(Strings:get(suitData.Name))
		end

		local desc = self._recruitDataShow:getUPDesc()

		if self._main:getChildByName("richDesc1") then
			self._main:removeChildByName("richDesc1")
		end

		if self._main:getChildByName("richDesc2") then
			self._main:removeChildByName("richDesc2")
		end

		local rich1 = ccui.RichText:createWithXML(Strings:get(desc[1], {
			fontName = TTF_FONT_FZYH_M
		}), {})

		rich1:setAnchorPoint(0, 0.5)
		rich1:addTo(self._main):posite(320, 250):setName("richDesc1")

		local rich1 = ccui.RichText:createWithXML(Strings:get(desc[2], {
			fontName = TTF_FONT_FZYH_M
		}), {})

		rich1:setAnchorPoint(0, 0.5)
		rich1:addTo(self._main):posite(526, 184):setName("richDesc2")
	else
		self._main:setVisible(false)
	end

	local timeDetailPanel = self._main:getChildByFullName("leftTimeNode")
	local timeText = timeDetailPanel:getChildByFullName("text")

	timeText:setString(self._activity:getTimeStr1())

	self._linkStr = self._recruitDataShow:getLink()

	self._moreNode:setVisible(self._linkStr ~= "")
end

function RecruitNewTSDrawCardMediator:checkHasTimesLimit(recruitDataShow, realTimes)
	local id = recruitDataShow:getId()

	if recruitDataShow:hasDrawLimit() then
		local time = self._recruitSystem:getDrawTimeById(id)
		local timeLimit = recruitDataShow:getDrawLimit()

		time = time["1"] or time[tostring(realTimes)]
		time = tonumber(time)

		if timeLimit <= time or realTimes > timeLimit - time then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Recruit_Times_Out")
			}))

			return true
		end
	end

	return false
end

function RecruitNewTSDrawCardMediator:onRecruit1Clicked()
	self._recruitIndex = 1

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitDataShow, times)

	if hasLimit then
		return
	end

	local costId = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costCount

	if times ~= 1 then
		local countData = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex]

		costCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, countData, times)
		costCount = costCount.costCount
	end

	local param = {
		id = id,
		times = times
	}

	if self._bagSystem:checkCostEnough(costId, costCount, {
		notShowTip = true
	}) then
		self._recruitSystem:requestRecruit(param)
	elseif RecruitCurrencyStr.KUserDefault[costId] then
		self:buyCard(costId, costCount, param)
	else
		self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})
	end
end

function RecruitNewTSDrawCardMediator:buyCard(costId, costCount, param)
	if self._recruitSystem:getCanAutoBuy(costId) then
		self:autoBuy(costId, costCount, param)

		return
	end

	local view = self:getInjector():getInstance("RecruitBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemId = costId,
		costCount = costCount,
		param = param
	}))
end

function RecruitNewTSDrawCardMediator:autoBuy(costId, costCount, param)
	if param.times == 1 then
		if not RecruitCurrencyStr.KBuyPrice.single[costId] then
			local price = RecruitCurrencyStr.KBuyPrice.ten[costId]
			local hasCount = self._bagSystem:getItemCount(costId)
			local num = costCount - hasCount
			local cost = num * price
			local hasDiamondCount = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)
			local canBuy = cost <= hasDiamondCount

			if not canBuy then
				local data = {
					title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
					content = RecruitCurrencyStr.KGoToShop[costId],
					sureBtn = {},
					cancelBtn = {}
				}
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if data.response == "ok" then
						outSelf._shopSystem:tryEnter({
							shopId = "Shop_Mall"
						})
					end
				end

				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))

				return
			else
				self._recruitSystem:requestRecruit(param)
			end
		end
	end
end

function RecruitNewTSDrawCardMediator:onRecruit2Clicked()
	self._recruitIndex = 2

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitDataShow, times)

	if hasLimit then
		return
	end

	local costId = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costCount

	if times ~= 1 then
		local countData = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex]

		costCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, countData, times)
		costCount = costCount.costCount
	end

	local param = {
		id = id,
		times = times
	}

	if self._bagSystem:checkCostEnough(costId, costCount) then
		self._recruitSystem:requestRecruit(param)
	elseif RecruitCurrencyStr.KUserDefault[costId] then
		self:buyCard(costId, costCount, param)
	else
		self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})
	end
end

function RecruitNewTSDrawCardMediator:onRecruitSucc(event)
	local data = event:getData()

	if data == nil then
		return
	end

	data.recruitId = self._recruitDataShow:getId()
	data.recruitIndex = self._recruitIndex
	data.activityId = self._activity:getId()
	self._recruitManager = self._recruitSystem:getManager()

	local recruitPool = self._recruitManager:getRecruitPoolById(data.recruitId)

	if recruitPool then
		local view = self:getInjector():getInstance("RecruitTSResultView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end

	self:refreshDrawNum()
end

function RecruitNewTSDrawCardMediator:onClickMore()
	if self._linkStr == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._linkStr)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	else
		entry:response(context, params)
	end
end

function RecruitNewTSDrawCardMediator:onClickShowTip(suitId)
	local suitData = ConfigReader:getRecordById("TsoulSuit", suitId)

	for i = 1, 3 do
		local node = self._touchLayer:getChildByFullName("Panel_clone" .. i)
		local tid = suitData.Part[i]
		local tsoulConfig = ConfigReader:getRecordById("Tsoul", tid)
		local iconPanel = node:getChildByFullName("Panel_name.icon")

		iconPanel:removeAllChildren()
		iconPanel:setScale(0.7)

		local path = GameStyle:getItemFile(tsoulConfig.Icon)
		local icon = ccui.ImageView:create(path)

		icon:addTo(iconPanel):center(iconPanel:getContentSize())

		local imgRartiy = node:getChildByFullName("Panel_name.Image_293")

		imgRartiy:ignoreContentAdaptWithSize(true)
		imgRartiy:loadTexture(GameStyle:getEquipRarityImage(suitData.SuitRareity + 9))
		imgRartiy:setScale(0.7)
		node:getChildByFullName("Panel_name.Text_name"):setString(Strings:get(tsoulConfig.Name))

		local attrNode = node:getChildByFullName("Node_1")
		local img = attrNode:getChildByName("image")
		local text = attrNode:getChildByName("text_name")
		local text2 = attrNode:getChildByName("text_value")
		local imgDi = attrNode:getChildByName("Image_70")
		local imgLock = attrNode:getChildByName("Image_lock")

		text2:setVisible(false)
		imgLock:setVisible(false)
		imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KNormal], ccui.TextureResType.plistType)
		img:loadTexture(AttrTypeImage[tsoulConfig.Baseattr], ccui.TextureResType.plistType)
		text:setString(getAttrNameByType(tsoulConfig.Baseattr) .. " :   " .. tsoulConfig.Baseattrnum + tsoulConfig.Levelup * (Tsoul_LevelMax[tostring(tsoulConfig.Rareity)] - 1))

		local listView = node:getChildByFullName("addlistView")

		listView:setScrollBarEnabled(false)
		listView:removeAllChildren()

		local width = listView:getContentSize().width
		local addAttr = tsoulConfig.Addattr
		local attrNames = {}

		for i, v in ipairs(addAttr) do
			attrNames[i] = getAttrNameByType(v)
		end

		local des = Strings:get("TimeSoul_Preview_Desc_2", {
			Addattr = table.concat(attrNames, ","),
			fontName = TTF_FONT_FZYH_M
		})
		local label = ccui.RichText:createWithXML(des, {})

		label:renderContent(width, 0)
		listView:removeAllChildren()
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, 0))

		local height = label:getContentSize().height
		local newPanel = ccui.Layout:create()

		newPanel:setContentSize(cc.size(width, height))
		label:addTo(newPanel)
		listView:pushBackCustomItem(newPanel)

		local listView = node:getChildByFullName("suitlistView")

		listView:setScrollBarEnabled(false)

		local width = listView:getContentSize().width
		local suitData = ConfigReader:getRecordById("TsoulSuit", tsoulConfig.Suitid)
		local SuitDesc = suitData.SuitDesc
		local keys = {}

		keys.fontName = TTF_FONT_FZYH_M

		for k, v in pairs(SuitDesc) do
			local attrType = suitData.Suitattr[tonumber(k - 1)] or suitData.Suitlevattr[1]
			local attrNum = suitData.Partattr[tonumber(k - 1)] or suitData.Partlevattr[1]

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrNum = attrNum * 100 .. "%"
			end

			keys["Suitattr" .. k] = getAttrNameByType(attrType)
			keys["Partattr" .. k] = attrNum
		end

		local des = Strings:get("TimeSoul_Preview_Desc_3", keys)
		local label = ccui.RichText:createWithXML(des, {})

		label:renderContent(width, 0)
		listView:removeAllChildren()
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, 0))

		local height = label:getContentSize().height
		local newPanel = ccui.Layout:create()

		newPanel:setContentSize(cc.size(width, height))
		label:addTo(newPanel)
		listView:pushBackCustomItem(newPanel)
	end
end

function RecruitNewTSDrawCardMediator:onClickHideTip(sender, eventType)
	self._touchLayer:setVisible(false)
end

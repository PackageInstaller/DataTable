-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitNewDrawCardMediator.lua

require("dm.gameplay.develop.model.hero.Hero")

RecruitNewDrawCardMediator = class("RecruitNewDrawCardMediator", DmAreaViewMediator, _M)

RecruitNewDrawCardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RecruitNewDrawCardMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")
RecruitNewDrawCardMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RecruitNewDrawCardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
RecruitNewDrawCardMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local DrawCardStiveExReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DrawCard_StiveExReward", "content")
local textshadow_Name = {
	width = 4,
	color = cc.c4b(0, 0, 0, 90),
	size = cc.size(0, -3)
}
local kBtnHandlers = {
	["main.Panel_rank.btn_rule"] = "onClickRankRule",
	["main.Panel_rank.tipBtn"] = "onClickRule",
	recruitSkip = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSkip"
	},
	["moreNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMore"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTip"
	}
}
local rankImg = {
	"img_zlb_no1.png",
	"img_zlb_no2.png",
	"img_zlb_no3.png"
}
local rankDiImg = {
	"hd_sprank_no1.png",
	"hd_sprank_no2.png",
	"hd_sprank_no3.png",
	"hd_sprank_no4.png"
}

function RecruitNewDrawCardMediator:initialize()
	super.initialize(self)
end

function RecruitNewDrawCardMediator:dispose()
	super.dispose(self)
end

function RecruitNewDrawCardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()

	self._bagSystem = self._developSystem:getBagSystem()

	local position = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_SP_Position", "content")

	self._posX_bg_1 = position["1"]
	self._posX_bg_2 = position["2"]
	self._posX_hero = position["3"]
	self._posX_top = position["4"]

	local speed = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_SP_Speed", "content")

	self._rata_posX_bg_1 = speed["1"]
	self._rata_posX_bg_2 = speed["2"]
	self._rata_posX_hero = speed["3"]
	self._rata_posX_top = speed["4"]
end

function RecruitNewDrawCardMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUIT_SUCC, self, self.onRecruitSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUITNEWDRAWCARD_REFRESH, self, self.refreshCurrentPage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.refreshCurrentPage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.onDoActivityCallBack)
end

function RecruitNewDrawCardMediator:enterWithData(data)
	self._currencyInfo = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "SPDrawCard_Resource", "content")
	self._currencyInfos = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_Resource1", "content")

	self:setupTopInfoWidget()
	self:initData()
	self:initNode()
	self:initView()
	self:bindWidgets()
	self:getRankList()
	self:createTableView()
	self:setupScoreRewardPanel()
	self:updateView()
end

function RecruitNewDrawCardMediator:updateView()
	self:updateMyInfo()
	self._tableView:reloadData()
	self:updateScoreRewardPanel()

	local tenTimes = self._activity:getTenTimes()
	local singleTimes = self._activity:getSingleTimes()

	if self._descLabel then
		self._descLabel:removeFromParent()
		self._background:removeFromParent()
	end

	self._descLabel = cc.Label:createWithTTF(Strings:get("DrawCard_danchou", {
		factor1 = singleTimes,
		factor2 = tenTimes
	}), TTF_FONT_FZYH_R, 20)

	self._descLabel:addTo(self._main, 99):setPosition(940, 15)
	self._descLabel:setVisible(id ~= RecruitNewPlayerPool)

	self._background = cc.Sprite:createWithSpriteFrameName("bg_huoqu_title_name.png")

	self._background:addTo(self._main):setPosition(cc.p(self._descLabel:getPositionX() - 5, self._descLabel:getPositionY() - 5))
	self._background:setContentSize(self._descLabel:getContentSize())
	self:refreshMoreNode()
end

function RecruitNewDrawCardMediator:refreshMoreNode()
	self._linkStr = self._recruitDataShow:getLink()

	self._moreNode:setVisible(self._linkStr ~= "")
end

function RecruitNewDrawCardMediator:initData()
	local activities = self._activitySystem:getActivitiesByType(ActivityType.kDRAWCARDSP)

	self._recruitActivitys = {}

	for id, activity in pairs(activities) do
		if self._activitySystem:isActivityOpen(id) and not self._activitySystem:isActivityOver(id) then
			local recruitData = {}

			recruitData.activity = activity
			self._activity = activity
			self._activityId = id
			recruitData.pool = activity:getRecruitPool()
			self._recruitActivitys[#self._recruitActivitys + 1] = recruitData
		end
	end

	self._curTabType = 1
	self._recruitDataShow = {}
	self._recruitActivityShow = {}

	if #self._recruitActivitys > 0 then
		self._recruitDataShow = self._recruitActivitys[self._curTabType].pool
		self._recruitActivityShow = self._recruitActivitys[self._curTabType].activity
	end

	self._allSubView = {}
	self._changingView = false
	self._rankList = self._activity:getRank()
	self._rewardList = self._activity:getRewardList()
	self._recruitPools = self._activity:getRecruitPools()

	local activityConfig = self._recruitActivityShow:getActivityConfig()

	self._drawCardItemId = activityConfig.drawCardItem
end

function RecruitNewDrawCardMediator:getRankList()
	local data = {
		startRank = 1,
		doActivityType = 102,
		endRank = 50
	}

	self._activitySystem:requestDoActivity(self._activityId, data)
end

function RecruitNewDrawCardMediator:onDoActivityCallBack(event)
	local data = event:getData()
	local response = data.response
	local param = data.param

	if response.data.rankInfo and response.data.rankInfo.rid then
		self._mySelfRid = response.data.rankInfo.rid
	end

	if param.doActivityType == 101 then
		self:updateRankList(response.data.rankPlayers)
		self:updateView()
	elseif param.doActivityType == 102 then
		self:updateRankList(response.data.rankPlayers)
		self:updateView()
	elseif param.doActivityType == 103 then
		self:showRewardView(response.data)
		self:updateView()
	end
end

function RecruitNewDrawCardMediator:showRewardView(data)
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		rewards = data.rewards
	}))
end

function RecruitNewDrawCardMediator:onRecruitSucc(event)
	local data = event:getData()

	self._touchLayer:setVisible(true)

	local data = event:getData()

	if data == nil then
		self._touchLayer:setVisible(false)

		return
	end

	data.recruitId = self._recruitDataShow:getId()
	self._recruitManager = self._recruitSystem:getManager()

	local recruitPool = self._recruitManager:getRecruitPoolById(data.recruitId)

	if rankInfo and rankInfo.rid then
		self._mySelfRid = rankInfo.rid
	end

	if recruitPool then
		self:updateRankList(rankPlayers)
		self:enterResultWithData(data)
	end

	self:refreshCurrentPage()
end

function RecruitNewDrawCardMediator:refreshCurrentPage()
	local activities = self._activitySystem:getActivitiesByType(ActivityType.kDRAWCARDSP)

	self._recruitActivitys = {}

	for id, activity in pairs(activities) do
		if self._activitySystem:isActivityOpen(id) and not self._activitySystem:isActivityOver(id) then
			local recruitData = {}

			recruitData.activity = activity
			recruitData.pool = activity:getRecruitPool()
			self._recruitActivitys[#self._recruitActivitys + 1] = recruitData
		end
	end

	table.sort(self._recruitActivitys, function(a, b)
		return a.pool:getRank() > b.pool:getRank()
	end)

	if self._recruitActivitys == nil or #self._recruitActivitys == 0 then
		self:onClickBack()

		return
	end

	self._recruitDataShow = self._recruitActivitys[self._curTabType].pool
	self._recruitActivityShow = self._recruitActivitys[self._curTabType].activity
end

function RecruitNewDrawCardMediator:setupTopInfoWidget()
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
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	self._topInfoNode = topInfoNode
end

function RecruitNewDrawCardMediator:initNode()
	self._topPanel = self:getView():getChildByFullName("topPanel")

	self._topPanel:setVisible(false)

	self._heroNamePanel_SP = self:getView():getChildByFullName("heroNamePanel_SP")

	self._heroNamePanel_SP:setVisible(false)

	self._checkBtnPanel = self:getView():getChildByFullName("checkBtn")

	self._checkBtnPanel:setVisible(false)

	self._moreNode = self:getView():getChildByFullName("moreNode")

	self._moreNode:setVisible(false)

	self._main = self:getView():getChildByFullName("main")
	self._listPanel = self._main:getChildByFullName("listPanel")
	self._pageView = self._main:getChildByFullName("PageView")
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	self._recruitSkip = self:getView():getChildByFullName("recruitSkip")

	self._recruitSkip:setVisible(false)
	self._recruitSkip:setLocalZOrder(100)

	self._resultMain = self:getView():getChildByFullName("resultMain")

	self._resultMain:setVisible(false)

	self._rankPanel = self._main:getChildByName("Panel_rank")
	self._rankCell = self._rankPanel:getChildByName("cell")

	self._rankCell:setVisible(false)

	self._rankRuleBtn = self._rankPanel:getChildByName("btn_rule")
	self._ruleBubble = self._main:getChildByName("bubble")

	self._ruleBubble:setLocalZOrder(1000):offset(150, 0)
	self._ruleBubble:setVisible(false)
	self._ruleBubble:setTouchEnabled(false)
	self._ruleBubble:setSwallowTouches(false)

	self._drawNode = self._topPanel:getChildByFullName("drawNum")
	self._drawNum = self._drawNode:getChildByFullName("text")

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Skip"), TTF_FONT_FZYH_R, 24)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(self._recruitSkip):offset(self._recruitSkip:getContentSize().width * 0.5, self._recruitSkip:getContentSize().height * 0.6)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

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

	self._showResult = nil
	self._bestRarity = 11
	self._soundId = nil
	self._linkStr = ""

	self:createVideoSprite()
end

function RecruitNewDrawCardMediator:showResult()
	if self._showResult then
		self._showResult()

		self._showResult = nil

		self._recruitSkip:setVisible(false)

		if self._videoSprite then
			self._videoSprite:removeFromParent()
			self:createVideoSprite()
		end

		self._bestRarity = 11

		if self._soundId then
			AudioEngine:getInstance():stopEffect(self._soundId)

			self._soundId = nil
		end
	end
end

function RecruitNewDrawCardMediator:createVideoSprite()
	self._videoSprite = VideoSprite.create("video/recruitAnim.usm", function(sprite, eventName)
		if eventName == ResultAnimOfRarity[self._bestRarity][2] then
			self:showResult()
		end
	end, nil, true)

	self:getView():addChild(self._videoSprite)
	self._videoSprite:setPosition(cc.p(568, 320))
	self._videoSprite:setVisible(false)
	self._videoSprite:getPlayer():pause(true)
end

function RecruitNewDrawCardMediator:onClickSkip()
	self._animSkip = true

	self:showResult()
end

function RecruitNewDrawCardMediator:initView()
	self:initPageView()
end

function RecruitNewDrawCardMediator:initPageView()
	local view = self._main:getChildByName("pageView")
	local delegate, outself = {}, self

	function delegate:getPageNum()
		return #outself._recruitActivitys
	end

	function delegate:getPageByIndex(index)
		return outself:getPageByIndex(index)
	end

	function delegate:pageTouchedAtIndex(index)
		return
	end

	function delegate:setPageIndex(index)
		outself:setPageIndex(index)
	end

	function delegate:flipEndCallBack(node, index)
		outself:doLogicAfterChangePage()
	end

	local data = {
		notUseCirculation = true,
		view = view,
		delegate = delegate
	}

	self._flipView = PageViewUtil:new(data)

	self._flipView:reloadData()
end

function RecruitNewDrawCardMediator:setPageIndex(index)
	self._curTabType = index
	self._allSubView = {}

	if #self._recruitActivitys > 0 then
		self._recruitDataShow = self._recruitActivitys[self._curTabType].pool
		self._recruitActivityShow = self._recruitActivitys[self._curTabType].activity
	end

	local pageTipPanel = self._main:getChildByName("pageTipPanel")

	for i = 1, #self._recruitActivitys do
		local image = i == self._curTabType and "drawcard_bg_sp_qiehuan1.png" or "drawcard_bg_sp_qiehuan2.png"

		pageTipPanel:getChildByTag(i):loadTexture(image, ccui.TextureResType.plistType)
	end
end

function RecruitNewDrawCardMediator:setPageViewIndicator()
	local pageTipPanel = self._main:getChildByName("pageTipPanel")
	local pageView = self._main:getChildByName("pageView")

	pageTipPanel:removeAllChildren()

	local width = 0

	for i = 1, #self._recruitActivitys do
		local image = i == self._curTabType and "drawcard_bg_sp_qiehuan1.png" or "drawcard_bg_sp_qiehuan2.png"
		local img = ccui.ImageView:create(image, 1)

		img:setAnchorPoint(cc.p(0.5, 0.5))
		img:setTag(i)
		img:addTo(pageTipPanel)
		img:setPosition(cc.p((img:getContentSize().width + 8) * (i - 1), 10))

		width = img:getContentSize().width * i
	end

	pageTipPanel:setContentSize(cc.size(width, 50))
	pageTipPanel:setVisible(#self._recruitActivitys ~= 0)
	pageView:setVisible(#self._recruitActivitys ~= 0)
end

function RecruitNewDrawCardMediator:getPageByIndex(index)
	if index < 1 or index > #self._recruitActivitys then
		return nil
	end

	local winSize = cc.Director:getInstance():getWinSize()
	local pagePool = self._recruitActivitys[index].pool
	local pageActivity = self._recruitActivitys[index].activity
	local subView = {}
	local subLayout = ccui.Layout:create()

	subLayout:setContentSize(winSize)
	subLayout:setAnchorPoint(cc.p(0.5, 0.5))
	subLayout:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
	subLayout:setTag(index)

	subView.subLayout = subLayout

	local bgLayout_1 = ccui.Layout:create()

	bgLayout_1:setContentSize(winSize)
	bgLayout_1:setAnchorPoint(cc.p(0.5, 0.5))
	bgLayout_1:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
	bgLayout_1:addTo(subLayout)
	bgLayout_1:setTag(1)

	subView.bgLayout_1 = bgLayout_1

	local bgName_1 = pagePool:getPreview().SPbmg
	local bg_1 = ccui.ImageView:create("asset/ui/recruit/" .. bgName_1 .. ".png")

	bg_1:addTo(bgLayout_1)
	bg_1:setPosition(cc.p(winSize.width / 2, winSize.height / 2))

	local bgLayout_2 = ccui.Layout:create()

	bgLayout_2:setContentSize(winSize)
	bgLayout_2:setAnchorPoint(cc.p(0.5, 0.5))
	bgLayout_2:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
	bgLayout_2:addTo(subLayout)
	bgLayout_2:setClippingEnabled(true)
	bgLayout_2:setTag(2)

	subView.bgLayout_2 = bgLayout_2

	local lang_bgName = pagePool:getPreview().bannerbmg
	local lang_bg = ccui.ImageView:create("asset/lang_ui/recruit/" .. lang_bgName .. ".png")

	lang_bg:addTo(bgLayout_2)
	lang_bg:setPosition(cc.p(winSize.width / 2, winSize.height / 2))

	self._lang_bg_size = lang_bg:getContentSize()

	local heroLayout = self:createHeroPanelView(pagePool, pageActivity)

	heroLayout:addTo(subLayout)

	subView.heroLayout = heroLayout

	local topPanel = self:createTopPanelView(pagePool, pageActivity, index)

	topPanel:addTo(subLayout)

	subView.topLayout = topPanel
	self._allSubView[index] = subView

	return subLayout
end

function RecruitNewDrawCardMediator:createHeroPanelView(pagePool, pageActivity)
	local winSize = cc.Director:getInstance():getWinSize()
	local heroLayout = ccui.Layout:create()

	heroLayout:setContentSize(winSize)
	heroLayout:setAnchorPoint(cc.p(0.5, 0.5))
	heroLayout:setPosition(cc.p(winSize.width / 2, winSize.height / 2))

	local heroInfo = pagePool:getRoleDetail()

	if heroInfo then
		for i = 1, #heroInfo do
			local heroData = heroInfo[i]
			local heroId = heroData.hero

			if heroId then
				local scale = heroData.ModelIdOffset.scale
				local pos = cc.p(heroData.ModelIdOffset.pos[1], heroData.ModelIdOffset.pos[2])
				local useAnim = tonumber(heroData.modeltype) > 0
				local config = ConfigReader:getRecordById("HeroBase", tostring(heroId))

				if config.Rareity == 15 then
					self:createSPHeroImage(heroLayout, heroId, scale, pos, useAnim)
				end
			end
		end
	end

	return heroLayout
end

function RecruitNewDrawCardMediator:createTopPanelView(pagePool, pageActivity, index)
	local winSize = cc.Director:getInstance():getWinSize()
	local topPanel = self._topPanel:clone()

	topPanel:setVisible(true)
	topPanel:setPosition(cc.p(winSize.width / 2, winSize.height / 2 - 320))

	local recruitBtn1 = topPanel:getChildByFullName("nodePanel_1.recruitBtn1")

	recruitBtn1:addClickEventListener(function(sender, eventType)
		self:onRecruit1Clicked(sender, eventType)
	end)

	local recruitBtn2 = topPanel:getChildByFullName("nodePanel_2.recruitBtn2")

	recruitBtn2:addClickEventListener(function(sender, eventType)
		self:onRecruit2Clicked(sender, eventType)
	end)

	if pagePool and pageActivity then
		local heroInfo = pagePool:getRoleDetail()

		if heroInfo then
			for i = 1, #heroInfo do
				local heroData = heroInfo[i]
				local heroId = heroData.hero

				if heroId then
					local config = ConfigReader:getRecordById("HeroBase", tostring(heroId))
					local namePanel = self._heroNamePanel_SP:clone()

					namePanel:setVisible(config.Rareity == 15)
					namePanel:addTo(topPanel)
					namePanel:setPosition(cc.p(540 + heroData.detail[1], 320 + heroData.detail[2]))

					local image_Name_Bg = namePanel:getChildByFullName("Image_109")
					local node_Rareity = namePanel:getChildByFullName("node_Rareity")

					node_Rareity:removeAllChildren()

					if config.Rareity == 15 then
						local rarityAnim = IconFactory:getHeroRarityAnim(config.Rareity)

						rarityAnim:addTo(node_Rareity)
						rarityAnim:setPosition(cc.p(0, 40))
					else
						local rareityImage = ccui.ImageView:create(GameStyle:getHeroRarityImage(config.Rareity), 1)

						rareityImage:setAnchorPoint(cc.p(0.5, 0))
						rareityImage:setScale(0.61)
						rareityImage:addTo(node_Rareity)
					end

					local nameText = namePanel:getChildByFullName("Text_132")

					nameText:enableShadow(textshadow_Name.color, textshadow_Name.size, textshadow_Name.width)
					nameText:setString(Strings:get(config.Name))

					if config.Rareity == 15 then
						local width_Name = cc.Label:createWithTTF(Strings:get(config.Name), CUSTOM_TTF_FONT_1, 40)

						width_Name:enableOutline(cc.c4b(0, 0, 0, 255), 1)

						if width_Name:getContentSize().width > 150 then
							image_Name_Bg:setScaleX(1.8)
						end
					end

					local nicheText = namePanel:getChildByFullName("Text_131")

					nicheText:setString(Strings:get(config.Position))

					local Image_bg = namePanel:getChildByFullName("Image_bg")

					Image_bg:setScaleX(nicheText:getContentSize().width / 156)

					local btn = self._checkBtnPanel:clone()

					btn:setVisible(config.Rareity == 15)
					btn:addTo(topPanel)
					btn:setPosition(cc.p(568 + heroData.position[1], 320 + heroData.position[2]))
					btn:addClickEventListener(function()
						self:onClickHeroInfo(heroId)
					end)
				end
			end
		end

		self:initRecruitButtonNode(topPanel, pagePool, pageActivity)
		self:initRewardPanelNode(topPanel, pagePool, pageActivity)

		local rateIPanel = topPanel:getChildByFullName("rateIPanel")

		rateIPanel:removeAllChildren()

		local lang_bgName = pagePool:getPreview().chancetips
		local lang_img = ccui.ImageView:create("asset/lang_ui/recruit/" .. lang_bgName .. ".png")

		lang_img:setAnchorPoint(cc.p(0.5, 0.5))
		lang_img:addTo(rateIPanel)
	end

	return topPanel
end

function RecruitNewDrawCardMediator:initRecruitButtonNode(topPanel, pagePool, pageActivity)
	local costNode1 = topPanel:getChildByFullName("nodePanel_1")
	local costNode2 = topPanel:getChildByFullName("nodePanel_2")
	local id = pagePool:getId()
	local hasLeft = ""
	local costData

	if pagePool:getRealCostIdAndCount()[1] then
		local costCount, offCount = pagePool:getRealCostIdAndCount()[1], 100
		local time = pagePool:getRecruitTimes()[1]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(pagePool, costCount, time)
		end

		self:initCostNode(costCount, costNode1, offCount)
		costNode1:getChildByFullName("text"):setString(Strings:get(pagePool:getShortDesc()[1]))
		costNode1:getChildByFullName("text_1"):setString(Strings:get(pagePool:getShortDescEn()[1]))

		if pagePool:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = pagePool:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end
	end

	if pagePool:getRealCostIdAndCount()[2] then
		local costCount, offCount = pagePool:getRealCostIdAndCount()[2], 100
		local time = pagePool:getRecruitTimes()[2]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(pagePool, costCount, time)
		end

		if hasLeft == "" and pagePool:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = pagePool:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end

		self:initCostNode(costCount, costNode2, offCount)
		costNode2:getChildByFullName("text"):setString(Strings:get(pagePool:getShortDesc()[2]))
		costNode2:getChildByFullName("text_1"):setString(Strings:get(pagePool:getShortDescEn()[2]))
	else
		costNode1:setPositionX(629)
		costNode2:setVisible(false)
	end
end

function RecruitNewDrawCardMediator:initCostNode(recruitCost, costNode, offCount)
	local icon1 = costNode:getChildByFullName("iconNode")
	local name1 = costNode:getChildByFullName("name")
	local costId = recruitCost.costId
	local costCount = recruitCost.costCount

	if costCount == 0 then
		icon1:setVisible(false)
		name1:setVisible(false)
	else
		icon1:setVisible(true)
		name1:setVisible(true)

		local prototype = ItemPrototype:new(costId)
		local item = Item:new(prototype)

		name1:setString(item:getName() .. "  x" .. costCount)

		local costIcon = IconFactory:createPic({
			id = costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.4)
		costIcon:setAnchorPoint(cc.p(0.5, 0.5))
		costIcon:addTo(icon1)
	end

	local costOffBg = costNode:getChildByFullName("costOffBg")

	if offCount ~= 100 then
		costOffBg:setVisible(true)
		costOffBg:getChildByFullName("costOff"):setString(100 - offCount .. "%")
	else
		costOffBg:setVisible(false)
	end
end

function RecruitNewDrawCardMediator:initRewardPanelNode(topPanel, pagePool, pageActivity)
	local timeDetailPanel = topPanel:getChildByFullName("timeDetailPanel")
	local timeText = timeDetailPanel:getChildByFullName("timeText")

	timeText:enableShadow(textshadow_Name.color, cc.size(0, -2), 2)

	local startTimeStr = TimeUtil:localDate("%Y.%m.%d %H:%M", pageActivity:getStartTime() / 1000)
	local endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", pageActivity:getEndTime() / 1000)

	timeText:setString(startTimeStr .. "-" .. endTime)

	local detailPanel = timeDetailPanel:getChildByFullName("detailPanel")

	detailPanel:setTouchEnabled(true)
	detailPanel:setSwallowTouches(false)
	detailPanel:addTouchEventListener(function()
		self:onClickTip()
	end)
	detailPanel:setVisible(false)
end

function RecruitNewDrawCardMediator:onClickHeroInfo(heroId)
	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = heroId
	}))
end

function RecruitNewDrawCardMediator:onClickPreview()
	local heroes
	local activityConfig = self._recruitActivityShow:getActivityConfig()

	heroes = activityConfig.drawhero

	local function callback(rewards)
		local view = self:getInjector():getInstance("recruitHeroPreviewView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			showSpHero = true,
			recruitPool = self._recruitDataShow,
			rewards = rewards,
			heroes = heroes
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

function RecruitNewDrawCardMediator:onClickTip()
	if self._changingView then
		return
	end

	self:onClickPreview()

	do return end

	local type = self._recruitDataShow:getType()

	if type == RecruitPoolType.kActivity then
		local view = self:getInjector():getInstance("RecruitTipView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			info = self._recruitDataShow:getPoolInfo()
		}))
	elseif type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub then
		local function callback(rewards)
			local view = self:getInjector():getInstance("RecruitCommonPreviewView")

			self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				recruitPool = self._recruitDataShow,
				rewards = rewards,
				remainTimes = self._remainTimes
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
	else
		self:onClickPreview()
	end
end

function RecruitNewDrawCardMediator:refreshRewardPanelNode(topPanel, pageActivity, useReward)
	if pageActivity == nil then
		pageActivity = self._recruitActivityShow
	end

	local rewardPanel = topPanel:getChildByFullName("rewardPanel")
	local Text_1 = rewardPanel:getChildByFullName("Text_1")
	local Text_2 = rewardPanel:getChildByFullName("Text_2")
	local Text_3 = rewardPanel:getChildByFullName("Text_3")
	local Text_4 = rewardPanel:getChildByFullName("Text_4")
	local Text_5 = topPanel:getChildByFullName("Text_5")
	local progressBg = rewardPanel:getChildByFullName("progressBg")
	local redPoint = rewardPanel:getChildByFullName("redPoint")
	local timeDetailPanel = topPanel:getChildByFullName("timeDetailPanel")

	timeDetailPanel:setPositionY(0)
	redPoint:setVisible(false)
	Text_5:setVisible(false)

	local currentTime = self._gameServerAgent:remoteTimestamp()

	if pageActivity:getIsDrawCardBagin(currentTime) then
		local drawTime = pageActivity:getDrawTime()

		if useReward == false then
			rewardPanel:setVisible(false)
			timeDetailPanel:setPositionY(-65)
			Text_5:setVisible(true)
			Text_5:enableShadow(textshadow_Name.color, cc.size(0, -2), 2)

			drawTime = pageActivity:getTotalDrawTime()
		end

		local timeRewardData = pageActivity:getShowTimeRewardData()
		local round = pageActivity:getRound()
		local maxDrawTime = timeRewardData.showData.DrawCardTimes
		local beforeDrawTime = timeRewardData.showData.DrawCardTimesF

		if timeRewardData.isFull then
			-- block empty
		end

		local str = Strings:get("DrawCard_SP_UI_3") .. " , " .. Strings:get("DrawCard_SP_UI_4")

		Text_1:setString(str)
		Text_2:setString(Strings:get("DrawCard_SP_UI_11") .. drawTime)
		Text_5:setString(Strings:get("DrawCard_SP_UI_11") .. drawTime)
		Text_2:setColor(cc.c3b(157, 225, 4))
		Text_3:setString("" .. beforeDrawTime)
		Text_4:setString("" .. maxDrawTime)

		local exBar = rewardPanel:getChildByFullName("progressBg.exBar")
		local rate = (drawTime - beforeDrawTime) / (maxDrawTime - beforeDrawTime)

		exBar:setPercent(math.min(rate, 1) * 100)

		if timeRewardData.isFull then
			redPoint:setVisible(true)
		end

		progressBg:setPositionX(Text_3:getPositionX() + Text_3:getContentSize().width + 6)
		Text_4:setPositionX(progressBg:getPositionX() + 152)
	else
		Text_1:setPositionY(80)
		Text_2:setPositionY(55)
		Text_3:setVisible(false)
		Text_4:setVisible(false)
		progressBg:setVisible(false)

		if pageActivity:getCanGainReward() then
			redPoint:setVisible(true)
		end
	end
end

function RecruitNewDrawCardMediator:viewTouchEvent(touch, event)
	local eventType = event:getEventCode()

	self:onTouchScreen(touch, eventType)
end

function RecruitNewDrawCardMediator:doLogicAfterChangePage()
	local winSize = cc.Director:getInstance():getWinSize()
	local frontID = self._curTabType - 1
	local nextID = self._curTabType + 1

	if frontID > 0 then
		local subView = self._allSubView[frontID]

		if subView then
			subView.bgLayout_1:setPositionX(winSize.width / 2 - self._posX_bg_1)
			subView.bgLayout_2:setPositionX(winSize.width / 2 - self._posX_bg_2)
			subView.heroLayout:setPositionX(winSize.width / 2 - self._posX_hero)
			subView.topLayout:setPositionX(winSize.width / 2 - self._posX_top)
		end
	end

	if nextID <= #self._allSubView then
		local subView = self._allSubView[nextID]

		if subView then
			subView.bgLayout_1:setPositionX(winSize.width / 2 + self._posX_bg_1)
			subView.bgLayout_2:setPositionX(winSize.width / 2 + self._posX_bg_2)
			subView.heroLayout:setPositionX(winSize.width / 2 + self._posX_hero)
			subView.topLayout:setPositionX(winSize.width / 2 + self._posX_top)
		end
	end

	local subView = self._allSubView[self._curTabType]

	if subView then
		subView.bgLayout_1:setPositionX(winSize.width / 2)
		subView.bgLayout_2:setPositionX(winSize.width / 2)
		subView.heroLayout:setPositionX(winSize.width / 2)
		subView.topLayout:setPositionX(winSize.width / 2)
	end
end

function RecruitNewDrawCardMediator:createSPHeroImage(parent, heroId, scale, heroPos, useAnim)
	local winSize = cc.Director:getInstance():getWinSize()
	local heroLayout_Sp = ccui.Layout:create()
	local clippingHeight = 123

	heroLayout_Sp:setContentSize(cc.size(2000, self._lang_bg_size.height))
	heroLayout_Sp:setAnchorPoint(cc.p(0.5, 0.5))
	heroLayout_Sp:setPosition(cc.p(winSize.width / 2, winSize.height / 2 + clippingHeight))
	heroLayout_Sp:addTo(parent)
	heroLayout_Sp:setClippingEnabled(true)

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroImage = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel,
		useAnim = useAnim
	})

	if heroImage then
		local heroImage = ccui.ImageView:create("asset/ui/recruit/sp_kachi_jsd_huahaiji.png")
	end

	heroImage:addTo(heroLayout_Sp)
	heroImage:setTouchEnabled(false)
	heroImage:setScale(scale)
	heroImage:setPosition(cc.p(875 + heroPos.x, 320 + heroPos.y))
end

function RecruitNewDrawCardMediator:createSSRHeroImage(parent, heroId, scale, pos, maskScaleY)
	local path = self:getHeroImagePath(heroId)
	local winSize = cc.Director:getInstance():getWinSize()
	local heroLayout_SSR = ccui.Layout:create()

	heroLayout_SSR:setContentSize(winSize)
	heroLayout_SSR:setAnchorPoint(cc.p(0.5, 0.5))
	heroLayout_SSR:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
	heroLayout_SSR:addTo(parent)

	local heroSprite = cc.Sprite:create(path)
	local size = heroSprite:getContentSize()

	heroSprite:setPosition(cc.p(size.width / 2, size.height / 2))

	local nameBg_mask = cc.Sprite:createWithSpriteFrameName("sp_kachi_zz.png")
	local size_mask = nameBg_mask:getContentSize()

	nameBg_mask:setPosition(cc.p(size.width / 2, size_mask.height / 2 * maskScaleY))
	nameBg_mask:setScaleX(15)
	nameBg_mask:setScaleY(maskScaleY)

	local rtx = cc.RenderTexture:create(size.width, size.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

	heroSprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ZERO))
	nameBg_mask:setBlendFunc(cc.blendFunc(gl.ZERO, gl.ONE_MINUS_SRC_ALPHA))
	rtx:begin()
	heroSprite:visit()
	nameBg_mask:visit()
	rtx:endToLua()

	local texture = rtx:getSprite():getTexture()

	texture:setAntiAliasTexParameters()

	local retval = cc.Sprite:createWithTexture(texture)

	retval:setScale(1.5)
	retval:setFlippedY(true)
	retval:addTo(heroLayout_SSR)
	retval:setScale(scale)
	retval:setPosition(cc.p(568 + (winSize.width - 1136) / 2 + pos.x, 320 + (winSize.height - 640) / 2 + pos.y))
end

function RecruitNewDrawCardMediator:getHeroImagePath(heroId)
	local roleModel = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "RoleModel")
	local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Bust4")
	local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Model")
	local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "CommonResource")

	if not commonResource or commonResource == "" then
		commonResource = modelID
	end

	local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)

	return (string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename))
end

function RecruitNewDrawCardMediator:onTouchScreen(sender, eventType)
	local winSize = cc.Director:getInstance():getWinSize()
	local origin_Pos = cc.p(winSize.width / 2, winSize.height / 2)

	if eventType == ccui.TouchEventType.began then
		self._changingView = true
		self._pos_satrt = sender:getLocation()
	elseif eventType == ccui.TouchEventType.moved then
		self._changingView = true

		local pos_moved = sender:getLocation()
		local intervals_posX = pos_moved.x - self._pos_satrt.x

		self._pos_satrt = pos_moved

		self:doMoveLogic(intervals_posX, pos_moved.x - origin_Pos.x, false)
	elseif eventType == ccui.TouchEventType.ended then
		self._changingView = false

		local pos = sender:getLocation()

		self:doMoveLogic(0, pos.x - origin_Pos.x, true)
	elseif eventType == ccui.TouchEventType.canceled then
		self._changingView = false

		self:doMoveLogic(0, 0, true)
	end
end

function RecruitNewDrawCardMediator:doMoveLogic(intervals_posX, direction, doReset)
	local winSize = cc.Director:getInstance():getWinSize()
	local frontID = self._curTabType - 1
	local nextID = self._curTabType + 1

	if frontID > 0 then
		local subView = self._allSubView[frontID]

		if subView then
			if doReset then
				subView.bgLayout_1:setPositionX(winSize.width / 2 - self._posX_bg_1)
				subView.bgLayout_2:setPositionX(winSize.width / 2 - self._posX_bg_2)
				subView.heroLayout:setPositionX(winSize.width / 2 - self._posX_hero)
				subView.topLayout:setPositionX(winSize.width / 2 - self._posX_top)
			else
				subView.bgLayout_1:setPositionX(subView.bgLayout_1:getPositionX() + intervals_posX * self._rata_posX_bg_1)
				subView.bgLayout_2:setPositionX(subView.bgLayout_2:getPositionX() + intervals_posX * self._rata_posX_bg_2)
				subView.heroLayout:setPositionX(subView.heroLayout:getPositionX() + intervals_posX * self._rata_posX_hero)
				subView.topLayout:setPositionX(subView.topLayout:getPositionX() + intervals_posX * self._rata_posX_top)
			end
		end
	end

	if nextID <= #self._allSubView then
		local subView = self._allSubView[nextID]

		if subView then
			if doReset then
				subView.bgLayout_1:setPositionX(winSize.width / 2 + self._posX_bg_1)
				subView.bgLayout_2:setPositionX(winSize.width / 2 + self._posX_bg_2)
				subView.heroLayout:setPositionX(winSize.width / 2 + self._posX_hero)
				subView.topLayout:setPositionX(winSize.width / 2 + self._posX_top)
			else
				subView.bgLayout_1:setPositionX(subView.bgLayout_1:getPositionX() + intervals_posX * self._rata_posX_bg_1)
				subView.bgLayout_2:setPositionX(subView.bgLayout_2:getPositionX() + intervals_posX * self._rata_posX_bg_2)
				subView.heroLayout:setPositionX(subView.heroLayout:getPositionX() + intervals_posX * self._rata_posX_hero)
				subView.topLayout:setPositionX(subView.topLayout:getPositionX() + intervals_posX * self._rata_posX_top)
			end
		end
	end

	local subView = self._allSubView[self._curTabType]

	if subView then
		if doReset then
			subView.bgLayout_1:setPositionX(winSize.width / 2)
			subView.bgLayout_2:setPositionX(winSize.width / 2)
			subView.heroLayout:setPositionX(winSize.width / 2)
			subView.topLayout:setPositionX(winSize.width / 2)
		else
			subView.bgLayout_1:setPositionX(subView.bgLayout_1:getPositionX() + intervals_posX * self._rata_posX_bg_1)
			subView.bgLayout_2:setPositionX(subView.bgLayout_2:getPositionX() + intervals_posX * self._rata_posX_bg_2)
			subView.heroLayout:setPositionX(subView.heroLayout:getPositionX() + intervals_posX * self._rata_posX_hero)
			subView.topLayout:setPositionX(subView.topLayout:getPositionX() + intervals_posX * self._rata_posX_top)
		end
	end
end

function RecruitNewDrawCardMediator:onClickBack()
	self:getView():stopAllActions()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function RecruitNewDrawCardMediator:onRecruit1Clicked()
	if self._changingView then
		return
	end

	self._recruitIndex = 1

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
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

	if self._bagSystem:checkCostEnough(costId, costCount) or self._bagSystem:checkCostEnough(self._drawCardItemId, costCount) then
		self._activitySystem:requestRecruitActivity(self._recruitActivityShow:getId(), param, nil)
	elseif costId == CurrencyIdKind.kDiamondDrawItem then
		self:buyCard(costId, costCount, param, self._recruitActivityShow:getId())
	else
		self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})
	end
end

function RecruitNewDrawCardMediator:onRecruit2Clicked()
	if self._changingView then
		return
	end

	self._recruitIndex = 2

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
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

	if self._bagSystem:checkCostAllEnough(costId, self._drawCardItemId, costCount) then
		self._activitySystem:requestRecruitActivity(self._recruitActivityShow:getId(), param, nil)
	elseif costId == CurrencyIdKind.kDiamondDrawItem then
		self:buyCard(costId, costCount, param, self._recruitActivityShow:getId())
	else
		self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})
	end
end

function RecruitNewDrawCardMediator:checkHasTimesLimit(recruitDataShow, realTimes)
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

function RecruitNewDrawCardMediator:buyCard(costId, costCount, param, activityId)
	if self._recruitSystem:getCanAutoBuy(costId) then
		self:autoBuy(costId, costCount, param, activityId)

		return
	end

	local view = self:getInjector():getInstance("RecruitBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemId = costId,
		costCount = costCount,
		param = param,
		activityId = activityId
	}))
end

function RecruitNewDrawCardMediator:autoBuy(costId, costCount, param, activityId)
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
				self._activitySystem:requestRecruitActivity(activityId, param, nil)
			end
		end
	end
end

function RecruitNewDrawCardMediator:onTouchGetReward(sender, eventType)
	if self._changingView then
		return
	end

	if eventType == ccui.TouchEventType.ended then
		local currentTime = self._gameServerAgent:remoteTimestamp()

		if self._recruitActivityShow:getIsDrawCardBagin(currentTime) then
			local timeRewardData = self._recruitActivityShow:getShowTimeRewardData()

			if timeRewardData.isFull then
				local data = {
					doActivityType = 102,
					round = timeRewardData.showRound,
					TimeReward = timeRewardData.showTimeRewardId
				}

				self._activitySystem:requestRecruitActivityReward(self._recruitActivityShow:getId(), nil, data, nil)
			end
		elseif self._recruitActivityShow:getCanGainReward() then
			local subActivity = self._recruitActivityShow:getSubActivity()

			if subActivity then
				local oneTask = subActivity:getSortActivityList()[1]
				local data = {
					doActivityType = 101,
					taskId = oneTask:getId()
				}

				self._activitySystem:requestRecruitActivityReward(self._recruitActivityShow:getId(), subActivity:getId(), data, nil)
			end
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DrawCard_SP_UI_9")
			}))
		end
	end
end

function RecruitNewDrawCardMediator:enterResultWithData(data)
	self:getView():stopAllActions()

	self._showAnimNodes = {}
	self._animSkip = false
	self._canClose = false

	self:initResultData(data)
	self:initResultView()

	self._refreshTabBtn = false
end

function RecruitNewDrawCardMediator:initResultData(data)
	self._heroesArr = {}

	local recruitId = data.recruitId

	self._recruitPool = self._recruitManager:getRecruitPoolById(recruitId)
	self._rewards = data.rewards
	self._extraRewards = data.extraRewards or {}
	self._realRecruitTimes = #self._rewards
end

function RecruitNewDrawCardMediator:addShare()
	local data = {
		enterType = ShareEnterType.KRecruitTen,
		node = self._resultMain,
		preConfig = function()
			return
		end,
		endConfig = function()
			return
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function RecruitNewDrawCardMediator:initResultView()
	self._resultMain:removeAllChildren()
	self._resultMain:setVisible(false)

	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()
	local showBtnsPanel = true

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip then
		local itemResult = cc.CSLoader:createNode("asset/ui/RecruitHeroResult.csb")

		itemResult:addTo(self._resultMain):center(self._resultMain:getContentSize())

		self._itemResult = itemResult:getChildByFullName("diamondResult")

		self._itemResult:setSwallowTouches(false)
		self._itemResult:getChildByFullName("touchLayer"):setVisible(false)

		self._bg = self._itemResult:getChildByFullName("bg")
		self._cloneNode = self._itemResult:getChildByFullName("cloneNode")

		self._cloneNode:setVisible(false)

		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")
		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		local rebuyBtn = self._itemResult:getChildByFullName("buttons_panel.rebuy_btn")
		local sureBtn = self._itemResult:getChildByFullName("buttons_panel.sure_btn")

		self._rebuyBtn = self:bindWidget(rebuyBtn, OneLevelViceButton, {
			ignoreAddKerning = true,
			handler = {
				clickAudio = "Se_Click_Common_1",
				func = bind1(self.onClickRebuy, self)
			}
		})
		self._sureBtn = self:bindWidget(sureBtn, OneLevelMainButton, {
			handler = {
				clickAudio = "Se_Click_Common_1",
				func = bind1(self.onClickClose, self)
			}
		})
		self._costIconNode = self._btnsPanel:getChildByFullName("rebuy_btn.cost_icon")
		self._costText = self._btnsPanel:getChildByFullName("rebuy_btn.cost_text")
		self._descText = self._itemResult:getChildByFullName("desc_text")

		self._descText:setVisible(cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip)

		if self._refreshTabBtn then
			sureBtn:setPositionX(260)
			rebuyBtn:setVisible(false)
		else
			sureBtn:setPositionX(108)
			rebuyBtn:setVisible(true)
		end
	else
		showBtnsPanel = false

		local itemResult = cc.CSLoader:createNode("asset/ui/RecruitHeroResult.csb")

		itemResult:addTo(self._resultMain):center(self._resultMain:getContentSize())

		self._itemResult = itemResult:getChildByFullName("diamondResult")
		self._descText = self._itemResult:getChildByFullName("desc_text")

		GameStyle:setCommonOutlineEffect(self._descText, 219.29999999999998)

		self._bg = self._itemResult:getChildByFullName("bg")

		self._bg:removeAllChildren()
		self._itemResult:setSwallowTouches(false)
		self._itemResult:getChildByFullName("touchLayer"):addClickEventListener(function()
			if self._canClose then
				self:onClickClose()
			end
		end)

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")
		self._cloneNode = self._itemResult:getChildByFullName("cloneNode")

		self._cloneNode:setVisible(false)
	end

	self._showResult = self._showResult or function(videoSprite)
		self._touchLayer:setVisible(false)

		if self._animSkip and #self._heroesArr > 0 then
			local heroes = {}

			for i = 1, #self._heroesArr do
				local data = self._heroesArr[i]

				if data.newHero or data.rarity >= 14 then
					table.insert(heroes, data)
				end
			end

			self._heroesArr = heroes
		end

		if #self._heroesArr == 0 then
			self._resultMain:setVisible(true)
			self:showResultAnim(showBtnsPanel)
		else
			self._resultMain:setVisible(false)
			self:showNewHeroView(self._heroesArr)
		end
	end

	local hideAnim = (cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip) and self._realRecruitTimes == 1 or HIDE_RECRUIT_ANIM

	if not hideAnim then
		self._soundId = AudioEngine:getInstance():playEffect("Se_Effect_Card", false)

		self._videoSprite:setVisible(true)
		self._videoSprite:getPlayer():pause(false)
		self._recruitSkip:setVisible(true)

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]
			local recruitRewardType = self:checkRewardType(rewardData)
			local heroId

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				heroId = itemConfig.TargetId.id
			elseif recruitRewardType == RecruitRewardType.kHero then
				heroId = rewardData.code
			end

			if heroId then
				local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
				local rarity = heroConfig.Rareity

				self._bestRarity = math.max(self._bestRarity, rarity)
			end
		end

		local frame = ResultAnimOfRarity[self._bestRarity][1]
		local callback = ResultAnimOfRarity[self._bestRarity][2]

		self._videoSprite:addFrameEvent(callback, frame)
	end

	if self._realRecruitTimes == 1 then
		self:showOneAnim()
	else
		self:showTenAnim()
	end

	if hideAnim then
		self._showResult()
	end
end

function RecruitNewDrawCardMediator:refreshBg(heroId)
	local party = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Party")

	if not party then
		local partys = {
			GalleryPartyType.kBSNCT,
			GalleryPartyType.kXD,
			GalleryPartyType.kMNJH,
			GalleryPartyType.kDWH,
			GalleryPartyType.kWNSXJ,
			GalleryPartyType.kSSZS,
			GalleryPartyType.kUNKNOWN
		}
		local num = math.random(1, 6)

		party = partys[num]
	end

	local bgPanel = self._bg

	bgPanel:removeAllChildren()

	local bgAnim = GameStyle:getHeroPartyBg(party)

	bgAnim:addTo(bgPanel):center(bgPanel:getContentSize())
	bgPanel:setScale(1.2)
	bgPanel:runAction(cc.ScaleTo:create(0.2, 1))
end

function RecruitNewDrawCardMediator:showResultAnim(showBtnsPanel)
	local cardType = self._recruitDataShow:getType()
	local showBtnsPanel = showBtnsPanel or cardType ~= RecruitPoolType.kActivity and cardType ~= RecruitPoolType.kDiamond
	local length = #self._showAnimNodes

	self._btnsPanel:setVisible(false)
	self._btnsPanel:setOpacity(0)
	self._btnsPanel:setVisible(showBtnsPanel)

	if length == 1 then
		local showAnim = table.remove(self._showAnimNodes, 1)

		if showAnim.tag ~= "HERO" then
			showAnim:setVisible(true)
			showAnim.nameText:fadeIn({
				time = 0.1
			})

			if showAnim.icon.ignoreMoveAction then
				if showAnim.tag == "EQUIP" then
					showAnim.icon:getChildByFullName("EquipAnim"):gotoAndPlay(0)
					showAnim.icon:setPositionY(-40)
				end
			else
				showAnim.icon:runAction(cc.MoveTo:create(0.1, cc.p(0, -40)))
			end
		else
			showAnim:gotoAndPlay(0)
		end

		self._canClose = true

		self._btnsPanel:setVisible(showBtnsPanel)
		self._btnsPanel:fadeIn({
			time = 0.2
		})
	else
		for i = 1, length + 1 do
			local time = 0.06666666666666667
			local delay = cc.DelayTime:create(time * (i - 1))
			local showAnim = table.remove(self._showAnimNodes, 1)

			if showAnim then
				showAnim:setVisible(false)

				local callback = cc.CallFunc:create(function()
					if showAnim.tag ~= "HERO" then
						showAnim:setVisible(true)
						showAnim.nameText:fadeIn({
							time = 0.1
						})

						if showAnim.icon.ignoreMoveAction then
							if showAnim.tag == "EQUIP" then
								showAnim.icon:getChildByFullName("EquipAnim"):gotoAndPlay(0)
								showAnim.icon:setPositionY(-40)
							end
						else
							showAnim.icon:runAction(cc.MoveTo:create(0.1, cc.p(0, -40)))
						end
					else
						showAnim:addCallbackAtFrame(13, function()
							if i >= 6 then
								showAnim:setLocalZOrder(1)
							end
						end)
						showAnim:setVisible(true)
						showAnim:gotoAndPlay(0)
					end
				end)

				self:getView():runAction(cc.Sequence:create(delay, callback))
			else
				delay = cc.DelayTime:create(time * (2 + i))

				local callback = cc.CallFunc:create(function()
					self._canClose = true

					self._btnsPanel:setVisible(showBtnsPanel)
					self._btnsPanel:fadeIn({
						time = 0.2
					})
				end)

				self:getView():runAction(cc.Sequence:create(delay, callback))
			end
		end

		if not showBtnsPanel then
			local callback = cc.CallFunc:create(function()
				self:addShare()
			end)

			self:getView():runAction(cc.Sequence:create(cc.DelayTime:create(0.8), callback))
		end
	end
end

function RecruitNewDrawCardMediator:checkRewardType(reward)
	local recruitRewardType

	return reward.type == 3 and RecruitRewardType.kHero or reward.type == 2 and reward.heroId and RecruitRewardType.kHeroConvert or RecruitRewardType.kPieceOrItem
end

function RecruitNewDrawCardMediator:showOneAnim()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp then
		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")

		self._itemPanel:removeAllChildren()

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		self._btnsPanel:setVisible(true)
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		local heroId, rarity
		local rewardData = self._rewards[1]

		if rewardData then
			local recruitRewardType = self:checkRewardType(rewardData)
			local data

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				data = {
					newHero = false,
					heroId = itemConfig.TargetId.id,
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
					fragmentCount = rewardData.amount
				}
			elseif recruitRewardType == RecruitRewardType.kHero then
				local itemId = rewardData.code

				data = {
					newHero = true,
					heroId = itemId,
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
				}
			end

			if data then
				if not rarity then
					heroId = data.heroId
					rarity = data.rarity
				elseif rarity < data.rarity then
					heroId = data.heroId
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
				end

				self:createRewardHero(data, cc.p(350, 200), nil, rewardData)
				self:refreshBg(heroId)
			else
				self:createRewardItem(self._rewards[1], cc.p(350, 170), kItemScale[15])
				self:refreshBg()
			end
		end
	elseif cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip then
		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")

		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		self._btnsPanel:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()
		self:createRewardItem(self._rewards[1], cc.p(350, 170), kItemScale[15])
		self:refreshBg()
	else
		self:refreshExtraRewardDesc()
		self._itemResult:getChildByFullName("itemPanel"):removeAllChildren()
		self._itemResult:setVisible(true)

		local heroId, rarity
		local rewardData = self._rewards[1]

		if rewardData then
			local recruitRewardType = self:checkRewardType(rewardData)
			local data

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				data = {
					newHero = false,
					heroId = itemConfig.TargetId.id,
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
					fragmentCount = rewardData.amount
				}
			elseif recruitRewardType == RecruitRewardType.kHero then
				local itemId = rewardData.code

				data = {
					newHero = true,
					heroId = itemId,
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
				}
			end

			if data then
				if not rarity then
					heroId = data.heroId
					rarity = data.rarity
				elseif rarity < data.rarity then
					heroId = data.heroId
					rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
				end

				self:createRewardHero(data, cc.p(350, 170), nil, rewardData)
			end
		end

		self:refreshBg(heroId)
	end
end

function RecruitNewDrawCardMediator:showTenAnim()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp then
		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		local itemArr = {}
		local changePos = false
		local heroId, rarity

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]

			if rewardData then
				local recruitRewardType = self:checkRewardType(rewardData)
				local data

				if recruitRewardType == RecruitRewardType.kHeroConvert then
					local itemId = rewardData.code
					local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

					data = {
						newHero = false,
						heroId = itemConfig.TargetId.id,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
						fragmentCount = rewardData.amount
					}
				elseif recruitRewardType == RecruitRewardType.kHero then
					local itemId = rewardData.code

					data = {
						newHero = true,
						heroId = itemId,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
					}
				end

				if data then
					if not rarity then
						heroId = data.heroId
						rarity = data.rarity
					elseif rarity < data.rarity then
						heroId = data.heroId
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
					end

					changePos = true
					itemArr[#itemArr + 1] = self:createRewardHero(data, ItemsPosition2[i], true, rewardData, 0.5)
				else
					itemArr[#itemArr + 1] = self:createRewardItem(rewardData, ItemsPosition2[i], kItemScale[13])
				end
			end
		end

		if changePos then
			for i = 1, #itemArr do
				itemArr[i]:setPosition(ItemsPosition3[i])
			end
		end

		self:refreshBg(heroId)
	elseif cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip then
		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]
			local item = self:createRewardItem(rewardData, ItemsPosition5[i])

			if i <= 5 then
				item:setLocalZOrder(2)
			else
				item:setLocalZOrder(1)
			end
		end

		self:refreshBg()
	else
		self:refreshExtraRewardDesc()
		self._itemResult:getChildByFullName("itemPanel"):removeAllChildren()
		self._itemResult:setVisible(true)

		local cloneNode = self._itemResult:getChildByFullName("cloneNode")

		cloneNode:setVisible(false)

		local heroId, rarity
		local length = math.min(#self._rewards, 10)

		for i = 1, length do
			local rewardData = self._rewards[i]

			if rewardData then
				local recruitRewardType = self:checkRewardType(rewardData)
				local data

				if recruitRewardType == RecruitRewardType.kHeroConvert then
					local itemId = rewardData.code
					local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

					data = {
						newHero = false,
						heroId = itemConfig.TargetId.id,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
						fragmentCount = rewardData.amount
					}
				elseif recruitRewardType == RecruitRewardType.kHero then
					local itemId = rewardData.code

					data = {
						newHero = true,
						heroId = itemId,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
					}
				end

				if data then
					if not rarity then
						heroId = data.heroId
						rarity = data.rarity
					elseif rarity < data.rarity then
						heroId = data.heroId
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
					end

					self:createRewardHero(data, cc.p(ItemsPosition4[i].x, ItemsPosition4[i].y), true, rewardData)
				end
			end
		end

		self:refreshBg(heroId)
	end
end

function RecruitNewDrawCardMediator:createRewardItem(reward, pos, scale)
	local resFile = "asset/ui/RecruitItemNode.csb"
	local node = cc.CSLoader:createNode(resFile)
	local itemIconNode = node:getChildByFullName("icon_node")
	local nameText = node:getChildByFullName("name_text")

	nameText:setString(RewardSystem:getName(reward))
	nameText:setOpacity(0)

	node.nameText = nameText

	if reward.type == RewardType.kEquip then
		local config = ConfigReader:getRecordById("HeroEquipBase", reward.code)
		local rarity = config.Rareity
		local info = RewardSystem:parseInfo(reward)
		local icon = ccui.Widget:create()

		icon:setContentSize(cc.size(110, 110))

		local anim = cc.MovieClip:create(kEquipRarityAnim[rarity])

		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:addTo(icon):center(icon:getContentSize())
		anim:setName("EquipAnim")

		local equipNode = anim:getChildByFullName("equipNode")

		if equipNode then
			anim:offset(12, 30)

			local iconNode1 = equipNode:getChildByFullName("icon")
			local iconNode2 = equipNode:getChildByFullName("iconNode")
			local bgFile = GameStyle:getEquipRarityRectFile(rarity)
			local bgImage = IconFactory:createSprite(bgFile)

			bgImage:addTo(iconNode2)

			local equipIcon = IconFactory:createRewardEquipIcon(info, {
				hideLevel = true,
				notShowQulity = true
			})

			equipIcon:addTo(iconNode1):posite(-3.5, -1.5)

			icon.ignoreMoveAction = true
		else
			local iconNode1 = anim:getChildByFullName("iconNode")
			local equipIcon = IconFactory:createRewardEquipIcon(info, {
				hideLevel = true
			})

			equipIcon:addTo(iconNode1)
		end

		icon:addTo(itemIconNode)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			swallowTouches = true,
			needDelay = true
		})
		GameStyle:setRarityText(nameText, rarity)
		icon:setAnchorPoint(cc.p(0.5, 0))
		icon:setPositionY(40)

		if not scale then
			icon:setScale(kItemScale[rarity])
		else
			icon:setScale(scale)
		end

		node.icon = icon
		node.tag = "EQUIP"

		table.insert(self._showAnimNodes, node)
	else
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		icon:setContentSize(cc.size(110, 110))
		icon:addTo(itemIconNode)
		GameStyle:setQualityText(nameText, RewardSystem:getQuality(reward))
		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setPositionY(20)

		node.icon = icon
		icon.ignoreMoveAction = true

		local scale = scale or 1

		icon:setScale(scale)
		nameText:setPositionY(-icon:getContentSize().height * scale / 2 - 1)

		node.tag = "ITEM"

		table.insert(self._showAnimNodes, node)
	end

	node:setVisible(false)
	node:addTo(self._itemResult:getChildByFullName("itemPanel"))
	node:setPosition(pos)
	node:setLocalZOrder(2)

	return node
end

function RecruitNewDrawCardMediator:createRewardHero(data, pos, adjustZoom, rewardData, scale)
	table.insert(self._heroesArr, data)

	local heroId = data.heroId
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local showAnim = cc.MovieClip:create("show_choukajieguokapai")

	showAnim:addTo(self._itemResult:getChildByFullName("itemPanel"))
	showAnim:setPosition(pos)
	showAnim:setLocalZOrder(2)
	showAnim:addEndCallback(function()
		showAnim:stop()
	end)
	showAnim:setPlaySpeed(1.5)

	showAnim.tag = "HERO"

	table.insert(self._showAnimNodes, showAnim)

	local node1 = showAnim:getChildByFullName("node_1")
	local node2 = showAnim:getChildByFullName("node_2")
	local node = self._cloneNode:clone()

	node:setVisible(true)
	node:setScale(1)

	local rarityAnimName = kRoleRarityAnim[heroConfig.Rareity][1]
	local zoom = scale or kRoleRarityAnim[heroConfig.Rareity][2]
	local newImage = kRoleRarityAnim[heroConfig.Rareity][3]
	local anim = cc.MovieClip:create(rarityAnimName)

	anim:addTo(node:getChildByFullName("bg")):center(node:getChildByFullName("bg"):getContentSize()):offset(-3, 88)

	if adjustZoom then
		node:setScale(zoom)
	end

	local nameBg = node:getChildByFullName("nameBg")

	nameBg:loadTexture(kRoleRarityNameBg[heroConfig.Rareity])

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local roleAnim = anim:getChildByFullName("roleAnim")
	local roleNode = roleAnim:getChildByFullName("roleNode")
	local realImage = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe7_1",
		id = roleModel
	})

	realImage:addTo(roleNode)

	local starPanel = node:getChildByFullName("starPanel")

	for i = 1, 3 do
		local starIcon = starPanel:getChildByFullName("star" .. i)

		starIcon:setVisible(i <= heroConfig.BaseStar)
	end

	starPanel:setContentSize(cc.size(32 * heroConfig.BaseStar, 67))

	local name = node:getChildByFullName("name")

	name:setString(Strings:get(heroConfig.Name))

	local rarityNode = node:getChildByFullName("rarity")

	rarityNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rarityNode:ignoreContentAdaptWithSize(true)

	local occupationNode = node:getChildByFullName("occupation")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroConfig.Type)

	occupationNode:loadTexture(occupationImg)

	local newHero = data.newHero
	local tipImage = node:getChildByFullName("new")

	tipImage:setVisible(newHero)

	local debrisPanel = node:getChildByFullName("debrisPanel")

	debrisPanel:setVisible(not newHero)

	if debrisPanel:isVisible() then
		local text = debrisPanel:getChildByFullName("text")

		text:setString(rewardData.amount)

		local num = DrawCardStiveExReward[tostring(heroConfig.Rareity)]

		if num then
			local rewardNum = debrisPanel:getChildByFullName("rewardNum")

			rewardNum:removeAllChildren()

			num = num * rewardData.amount

			rewardNum:setString(num)

			local icon = IconFactory:createPic({
				id = DrawCardStiveExReward.reward
			})

			icon:addTo(rewardNum):posite(-30, 15):setScale(1.7)
			rewardNum:setPositionX(text:getPositionX() + text:getContentSize().width / 2)
		end
	else
		tipImage:loadTexture(newImage, 1)
	end

	if node1 then
		node:addTo(node1):posite(0, 0)
	end

	if node2 then
		local node3 = node:clone()

		node3:addTo(node2):posite(0, 0)
	end

	return showAnim
end

function RecruitNewDrawCardMediator:setButtonAndDesc()
	local str = Strings:get("RecruitGoldResult_Text2", {
		recuritTimes = self._recruitPool:getRecruitTimes()[self._recruitIndex]
	})

	self._rebuyBtn:setButtonName(str)
	self:refreshExtraRewardDesc()
end

function RecruitNewDrawCardMediator:refreshExtraRewardDesc()
	local normalReward = self._recruitPool:getNormalReward()

	if not normalReward or #normalReward <= 0 then
		self._descText:setVisible(false)

		return
	end

	local normalItemName = RewardSystem:getName(normalReward[1])
	local amount = normalReward[1].amount
	local str = ""

	if #self._extraRewards > 0 then
		local at = 0

		for i = 1, #self._extraRewards do
			at = at + self._extraRewards[i].amount
		end

		local reward = self._extraRewards[1]
		local itemName1 = RewardSystem:getName(reward)

		str = Strings:get("RecruitGoldResult_Text4", {
			itemName = normalItemName,
			itemCount = amount * self._realRecruitTimes,
			itemName1 = itemName1,
			itemCount1 = at
		})
	else
		str = Strings:get("RecruitGoldResult_Text3", {
			itemName = normalItemName,
			itemCount = amount * self._realRecruitTimes
		})
	end

	self._descText:setString(str)

	if self._descText:getChildByFullName("image") then
		self._descText:getChildByFullName("image"):setPositionX(self._descText:getContentSize().width / 2)
	end
end

function RecruitNewDrawCardMediator:showNewHeroView(heroArr, animFrame)
	if DisposableObject:isDisposed(self) then
		return
	end

	if #heroArr > 0 then
		local data = table.remove(heroArr, 1)
		local id = data.heroId
		local newHero = data.newHero

		if id then
			local function callback()
				self:showNewHeroView(heroArr, 5)
			end

			local view = self:getInjector():getInstance("newHeroView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				heroId = id,
				callback = callback,
				newHero = newHero,
				animFrame = animFrame,
				fragmentCount = data.fragmentCount
			}))
		end
	else
		self._resultMain:setVisible(true)
		self:showResultAnim()
	end
end

function RecruitNewDrawCardMediator:updateResultView(event)
	return
end

function RecruitNewDrawCardMediator:setupCostView()
	local costCount = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex]
	local time = self._recruitPool:getRecruitTimes()[self._recruitIndex]

	if time ~= 1 then
		costCount = self._recruitSystem:getRecruitRealCost(self._recruitPool, costCount, time)
	end

	local costId = costCount.costId
	local count = costCount.costCount

	if count == 0 then
		self._costIconNode:setVisible(false)
		self._costText:setString(Strings:get("Recruit_Free"))
		self._costText:setPositionX(0)
	else
		local text = "x" .. count

		self._costIconNode:setVisible(true)

		local costIcon = self._costIconNode:getChildByFullName("icon_img")

		if costIcon then
			costIcon:removeFromParent()
		end

		costIcon = IconFactory:createPic({
			id = costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.46)
		costIcon:addTo(self._costIconNode):setName("icon_img")
		self._costText:setPositionX(20)
		self._costText:setString(text)
		self._costIconNode:setPositionX(-self._costText:getContentSize().width / 2 - 5)
	end
end

function RecruitNewDrawCardMediator:createHeroNode(heroInfo, recruitRewardType, type)
	local resFile = "asset/ui/RecruitHeroNode.csb"
	local node = cc.CSLoader:createNode(resFile)
	local rareNode = node:getChildByName("rare_icon")
	local roleNode = node:getChildByName("role_node")
	local newImage = node:getChildByFullName("newImage")

	newImage:setVisible(false)

	local covertDescText = node:getChildByFullName("covert_desc")

	covertDescText:setVisible(false)

	local heroId = heroInfo.heroId
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroAnim = RoleFactory:createHeroAnimation(roleModel)

	heroAnim:setAnchorPoint(cc.p(0.5, 0))
	heroAnim:addTo(roleNode)
	heroAnim:setScale(0.6)
	heroAnim:setPosition(cc.p(roleNode:getContentSize().width / 2, 40))
	rareNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rareNode:ignoreContentAdaptWithSize(true)
	rareNode:setScale(0.8)

	if recruitRewardType == RecruitRewardType.kHero then
		newImage:setVisible(true)
	elseif recruitRewardType == RecruitRewardType.kHeroConvert then
		local amount = heroInfo.amount

		covertDescText:setVisible(true)
		covertDescText:getChildByName("text"):setString(amount)
	end

	return node
end

function RecruitNewDrawCardMediator:createTableView()
	local size = self._rankCell:getContentSize()

	self._rankCellSize = size

	local function scrollViewDidScroll(table)
		if self:getView():getChildByTag(ItemTipsViewTag) then
			self:getView():removeChildByTag(ItemTipsViewTag)
		end

		self._moveTable = true
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._rankCell:clone()

			sprite:setVisible(true)
			sprite:setPosition(-2, 7)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(123)

			local cell_Old = cell:getChildByTag(123)

			self:updateTableCell(cell_Old, idx + 1)
			cell:setTag(idx)
		else
			local cell_Old = cell:getChildByTag(123)

			self:updateTableCell(cell_Old, idx + 1)
			cell:setTag(idx)
		end

		cell:setVisible(true)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._activity:getRankAmount()
	end

	local tableView = cc.TableView:create(cc.size(410, 260))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(3, 56)
	tableView:setDelegate()
	self._rankPanel:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView
end

function RecruitNewDrawCardMediator:updateTableCell(cell, index)
	local record = self._rankList[index]
	local nameText = cell:getChildByName("Text_name")
	local scoreText = cell:getChildByName("Text_score")
	local img_paiming = cell:getChildByName("img_paiming")

	img_paiming:setVisible(false)

	local nilImage = cell:getChildByName("Image_nil")
	local rankText = cell:getChildByName("Text_rank")

	nilImage:setVisible(false)
	rankText:removeAllChildren()

	local cellDi = cell:getChildByName("Image_di")

	if index > 3 then
		cellDi:loadTexture(rankDiImg[4], 1)
	else
		cellDi:loadTexture(rankDiImg[index], 1)
	end

	if cell.anim then
		cell.anim:removeFromParent(true)

		cell.anim = nil
	end

	if cell.tipsRt then
		cell.tipsRt:setVisible(false)
	end

	nameText:setPositionY(25.53)
	nilImage:setPositionY(25.53)
	scoreText:setPositionY(25.53)

	if record.ishasHero then
		nameText:setString(record.name)
		scoreText:setString(record.score)

		if record.rid == self._mySelfRid then
			-- block empty
		else
			nameText:setPositionY(20.53)
		end
	else
		nameText:setString("")
		nameText:setTouchEnabled(false)
		scoreText:setString("")
		nilImage:setVisible(true)
	end

	rankText:setString("")

	if index > 3 then
		rankText:setString(index)
	else
		local img = rankImg[index]

		img_paiming:loadTexture(img, 1)
		img_paiming:setVisible(true)
		img_paiming:ignoreContentAdaptWithSize(true)
		img_paiming:setScale(1)
	end

	local iconTag = 10000
	local rewardPanel = cell:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local rewardId = record.RankReward
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	if rewards then
		local size = cc.size(50, 50)

		for i = 1, 3 do
			local reward = rewards[i]

			if reward then
				local icon = IconFactory:createRewardIcon(reward, {
					ignoreAnim = true,
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				icon:setAnchorPoint(cc.p(0, 0.5))
				icon:addTo(rewardPanel, 1, iconTag + i):posite(5 + (i - 1) * 42, 18)
				icon:setScale(0.35)

				if icon.getAmountLabel then
					local label = icon:getAmountLabel()

					if label then
						label:setScale(2)
					end

					local amountBg = icon:getChildByName("AmountBg")
				end
			end
		end
	end
end

function RecruitNewDrawCardMediator:updateMyInfo()
	local myRankText = self._rankPanel:getChildByName("Text_rank")
	local index = -1

	for i = 1, #self._rankList do
		if self._rankList[i].rid == self._mySelfRid and self._rankList[i].ishasHero then
			index = self._rankList[i].Sort
		end
	end

	myRankText:setString(index)

	if index == -1 then
		myRankText:setString(Strings:get("Activity_Jump_UI_19"))
	end

	local myScoreText = self._rankPanel:getChildByName("Text_score")

	myScoreText:setString(self._activity:getCurScore())
	self._rankRuleBtn:setVisible(true)

	self._selfRankIndex = index

	if index > 0 then
		if self._activity:getCurScore() >= self._rankList[index].RankStand then
			-- block empty
		else
			self:runRuleBubbleAnim()
		end
	else
		self:runRuleBubbleAnim()
	end

	if not self._rankRuleBtn:isVisible() then
		self._ruleBubble:setVisible(false)
	end
end

function RecruitNewDrawCardMediator:bindWidgets()
	local btn_Refresh = self._main:getChildByFullName("Panel_rank.btn_refresh")

	btn_Refresh:setTouchEnabled(true)
	btn_Refresh:setVisible(true)
	btn_Refresh:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getRankList()
		end
	end)
end

function RecruitNewDrawCardMediator:runRuleBubbleAnim()
	local lastInfo = self._rankList[#self._rankList]
	local score = 0

	score = lastInfo.ishasHero and lastInfo.score or lastInfo.RankStand

	self._ruleBubble:setVisible(true)
	self._ruleBubble:setOpacity(0)
	self._ruleBubble:stopAllActions()

	local bubbleText = self._ruleBubble:getChildByName("Text_str")

	if not self._selfRankIndex or self._selfRankIndex < 0 then
		bubbleText:setString(Strings:get("LimitIdol_Bubble_1"))
	else
		bubbleText:setString(Strings:get("DrawSoleMate_Tips_001", {
			score1 = self._rankList[self._selfRankIndex].RankStand
		}))
	end

	local fadeIn = cc.FadeIn:create(0.3)
	local delay1 = cc.DelayTime:create(5)
	local fadeOut = cc.FadeOut:create(0.3)
	local sequence = cc.Sequence:create(fadeIn, delay1, fadeOut)

	self._ruleBubble:runAction(sequence)
end

function RecruitNewDrawCardMediator:updateScoreRewardPanel()
	local realIndex = 0

	self._rewardPanelList = self._rewardPanelList or {}

	for i, rewardPanel in pairs(self._rewardPanelList) do
		local data = self._scoreList[i]
		local status = data.status

		if status == ActivityTaskStatus.kFinishNotGet then
			rewardPanel.image_box:loadTexture("baoxiang_5_2.png", 1)
		elseif status == ActivityTaskStatus.kGet then
			rewardPanel.image_box:loadTexture("baoxiang_5_3.png", 1)
		end

		if realIndex == 0 and status ~= ActivityTaskStatus.kGet then
			realIndex = i
		end
	end

	self._scoreText:setString(self._activity:getCurScore())

	local percent = self:getRealPercent()

	self._progBar:setPercent(percent)

	if realIndex > 4 then
		local offsetX = (realIndex - 2) * self._cellWidth
		local maxX = self._listView:getInnerContainer():getContentSize().width - self._listView:getContentSize().width

		offsetX = math.min(maxX, offsetX)

		self._listView:getInnerContainer():setPositionX(-offsetX)
	end

	local data = self._scoreList[#self._scoreList]
	local status = data.status

	if status == ActivityTaskStatus.kGet then
		self._bubblePanel:setVisible(false)
	else
		self:relocateBubblePos()
		self._bubblePanel:setColorTransform(ColorTransform(1, 1, 1, 0))
		self._bubblePanel:setVisible(true)
	end
end

function RecruitNewDrawCardMediator:getRealPercent()
	local precent = 0
	local curdiffpercent = 0
	local onePercent = 100 / #self._scoreList
	local score = self._activity:getCurScore()

	for i = 1, #self._scoreList do
		local scoreData = self._scoreList[i]

		if score > scoreData.score then
			precent = onePercent * i
		else
			if score <= self._scoreList[1].score then
				curdiffpercent = score / self._scoreList[1].score * onePercent
			else
				local curdiffcount = score - self._scoreList[i - 1].score
				local diffpercent = onePercent
				local diffcount = self._scoreList[i].score - self._scoreList[i - 1].score

				curdiffpercent = curdiffcount / diffcount * diffpercent
			end

			precent = precent + curdiffpercent

			break
		end
	end

	return precent
end

function RecruitNewDrawCardMediator:setupScoreRewardPanel(isAdjust)
	self._scoreList = self._activity:getScoreRewardList()

	local scorePanel = self._main:getChildByName("Panel_score")

	scorePanel:setLocalZOrder(1000)

	self._scorePanel = scorePanel
	self._bubblePanel = scorePanel:getChildByName("Panel_bubble")

	self._bubblePanel:setVisible(false)

	local listView = scorePanel:getChildByName("ListView")

	listView:setScrollBarEnabled(false)

	self._listView = listView
	self._scoreText = scorePanel:getChildByName("Text_score")

	local rewardCell = scorePanel:getChildByName("reward")

	rewardCell:setVisible(false)

	local progImg = scorePanel:getChildByName("Image_prog")

	progImg:offset(0, 0)

	self._progBar = progImg:getChildByName("progressbar")

	local size = progImg:getContentSize()
	local cellWidth = math.floor(size.width / #self._scoreList)

	self._cellWidth = cellWidth

	if #self._scoreList > 5 then
		cellWidth = math.floor(size.width / 5)

		progImg:setContentSize(cc.size(cellWidth * #self._scoreList, size.height))

		local changeWidth = cellWidth * #self._scoreList - size.width
		local barSize = self._progBar:getContentSize()

		self._progBar:setContentSize(cc.size(barSize.width + changeWidth, barSize.height))
	end

	local barSize = self._progBar:getContentSize()

	cellWidth = barSize.width / #self._scoreList

	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(progImg:getContentSize().width + 30, listView:getContentSize().height))
	progImg:changeParent(layout):posite(0, 40)
	listView:pushBackCustomItem(layout)
	listView:forceDoLayout()

	self._maxScore = 0
	self._rewardPanelList = {}

	for i, v in pairs(self._scoreList) do
		local rewardPanel = rewardCell:clone()

		rewardPanel:setVisible(true)
		rewardPanel:addTo(layout):posite(i * cellWidth - 28, 35)

		local scoreText = rewardPanel:getChildByName("Text_score")

		scoreText:setString(v.score)

		rewardPanel.image_box = rewardPanel:getChildByName("Image_box")
		rewardPanel.scoreText = scoreText

		local touch = rewardPanel:getChildByName("touch")

		touch:addClickEventListener(function(sender, eventType)
			self:onClickRewardPanel(sender, eventType, i)
		end)

		local node = RedPoint:createDefaultNode()

		node:setLocalZOrder(10)

		local redPoint = RedPoint:new(node, rewardPanel, function()
			return v.status == ActivityTaskStatus.kFinishNotGet
		end)

		redPoint:offset(3, 3)

		self._rewardPanelList[#self._rewardPanelList + 1] = rewardPanel
		self._maxScore = v.score
	end

	listView:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.moved then
			self:relocateBubblePos()
		end
	end)
end

function RecruitNewDrawCardMediator:onClickRewardPanel(sender, eventType, index)
	local data = self._scoreList[index]
	local status = data.status

	if status == ActivityTaskStatus.kFinishNotGet then
		local data = {
			doActivityType = 103,
			targetScore = data.score
		}

		self._activitySystem:requestDoActivity(self._activity:getId(), data)
	else
		local view = self:getInjector():getInstance("LimitRecruitBoxView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end
end

function RecruitNewDrawCardMediator:relocateBubblePos()
	local viewSize = self._listView:getContentSize()
	local innerSize = self._listView:getInnerContainer():getContentSize()
	local baseX = viewSize.width - innerSize.width + self._cellWidth
	local posX = self._listView:getInnerContainer():getPositionX()

	if posX < baseX then
		local x = 500 - (baseX - posX)

		if x > 485 then
			x = 485
		end

		self._bubblePanel:setPositionX(x)
	else
		self._bubblePanel:setPositionX(485)
	end
end

function RecruitNewDrawCardMediator:getRankList()
	local data = {
		startRank = 1,
		doActivityType = 102,
		endRank = 50
	}

	self._activitySystem:requestDoActivity(self._activityId, data)
end

function RecruitNewDrawCardMediator:updateRankList(rankinfos)
	if not rankinfos then
		return
	end

	for i = 1, #self._rankList do
		local rankInfo = self._rankList[i]

		rankInfo.ishasHero = false
	end

	for i, player in pairs(rankinfos) do
		local state = false

		for k, rank in pairs(self._rankList) do
			if not state and not rank.ishasHero then
				rank.score = player.value
				rank.name = player.nickname
				rank.rid = player.rid
				rank.ishasHero = true
				state = true
			end
		end
	end
end

function RecruitNewDrawCardMediator:onClickClose(sender, eventType)
	self:getView():stopAllActions()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_recruitHeroDiamondResul_view")
	self._resultMain:removeAllChildren()
	self._resultMain:setVisible(false)
end

function RecruitNewDrawCardMediator:onClickRebuy(sender, eventType)
	if not self._canClose then
		return
	end

	local times = self._recruitPool:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitPool, times)

	if hasLimit then
		return
	end

	local costId = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex].costCount
	local bagSystem = self:getInjector():getInstance("DevelopSystem"):getBagSystem()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()
	local param = {
		id = id,
		times = times
	}

	if bagSystem:checkCostEnough(costId, costCount) then
		self._recruitSystem:requestRecruit(param)
	elseif costId == CurrencyIdKind.kDiamondDrawItem then
		self:buyCard(costId, costCount, param)
	else
		self._resultMain:removeAllChildren()
		self._resultMain:setVisible(false)
		bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})
	end
end

function RecruitNewDrawCardMediator:onClickRankRule(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:runRuleBubbleAnim()
	end
end

function RecruitNewDrawCardMediator:onClickRule(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("LimitRecruitRuleView")
		local ruleList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ATLE_Desc", "content"), self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			activityId = self._activityId,
			ruleList = ruleList
		}))
	end
end

function RecruitNewDrawCardMediator:onClickMore()
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

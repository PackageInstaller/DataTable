-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/SourceMediator.lua

require("dm.gameplay.base.URLContext")
require("dm.gameplay.base.UrlEntry")

SourceMediator = class("SourceMediator", DmPopupViewMediator, _M)

SourceMediator:has("_player", {
	is = "r"
}):injectWith("Player")
SourceMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {}

KSourceType = {
	kShop = 1,
	kMain = 2,
	kCheckLeftCount = 6,
	kElite = 3,
	kActivity = 5,
	kHeroStroy = 4,
	kNull = 0 or ""
}

local kSourceSort = {
	[KSourceType.kShop] = 5,
	[KSourceType.kActivity] = 4,
	[KSourceType.kElite] = 3,
	[KSourceType.kMain] = 2,
	[KSourceType.kHeroStroy] = 1,
	[KSourceType.kNull] = 0
}
local StageName = {
	NORMAL = "CUSTOM_DETAIL_COMMON",
	ELITE = "CUSTOM_DETAIL_ELITE"
}

function SourceMediator:initialize()
	super.initialize(self)
end

function SourceMediator:dispose()
	self:dispatch(Event:new(EVT_SOURCE_REFRESH))
	super.dispose(self)
end

function SourceMediator:userInject()
	self._developSystem = self:getInjector():getInstance(DevelopSystem)
	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
end

function SourceMediator:onRemove()
	super.onRemove(self)
end

function SourceMediator:enterWithData(data)
	self._itemData = data

	self:setUpView()
	self:setupClickEnvs()
end

function SourceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")
	self._viewPanel = self._main:getChildByFullName("tableView")
	self._blockPanel = self._main:getChildByName("block")

	self._blockPanel:setVisible(false)

	self._cellPanel = self._main:getChildByName("cellmodel")

	self._cellPanel:setVisible(false)

	local bgNode = self._main:getChildByFullName("bgNode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("SOURCE_TITLE"),
		title1 = Strings:get("UITitle_EN_Huodetujing"),
		bgSize = {
			width = 835,
			height = 580
		}
	})

	local nameLabel = self._main:getChildByFullName("nameLabel")

	nameLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 2)

	local descText = self._main:getChildByFullName("Text_desc")

	descText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local ownText = self._main:getChildByFullName("Text_owncount")
	local needText = self._main:getChildByFullName("Text_needcount")

	ownText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	needText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function SourceMediator:setUpView()
	self._sourceList = RewardSystem:getResource(tostring(self._itemData.itemId)) or {}
	self._noTips = self._main:getChildByName("Text_notips")

	self._noTips:setVisible(false)

	if #self._sourceList == 0 then
		self._noTips:setVisible(true)
		self._noTips:getChildByFullName("text"):setString(Strings:get("HEROS_UI13"))
	else
		local canEnter = {}
		local lock = {}

		for k, v in ipairs(self._sourceList) do
			local sourceConfig = ConfigReader:getRecordById("ItemResource", v)

			assert(sourceConfig, "ItemResource not found for item.." .. self._itemData.itemId .. "..resourceId.." .. v)

			if not sourceConfig.ResourceType then
				local resourceType = KSourceType.kNull

				if sourceConfig then
					if not sourceConfig.URL then
						local url = ""

						if url == nil or url == "" then
							local var_7_2 = {
								id = v
							}

							var_7_2.sort = kSourceSort[resourceType] or 0
							lock[#lock + 1] = var_7_2
						else
							local entry, params = UrlEntryManage.resolveUrlWithUserData(url)
							local unlock = UrlEntryManage.checkEnabledWithUserData(url)

							if not unlock then
								local pointId = params.pointId

								if pointId ~= nil then
									local pointInfo = self._stageSystem:getPointById(pointId)

									if not pointInfo then
										local var_7_3 = {
											stageType = -1,
											pointIndex = -1,
											mapIndex = -1,
											id = v
										}

										var_7_3.sort = kSourceSort[resourceType] or 0
										lock[#lock + 1] = var_7_3
									else
										local _tabValue = {}

										_tabValue.id = v
										_tabValue.pointIndex = pointInfo:getIndex()
										_tabValue.mapIndex = pointInfo:getOwner():getIndex()
										_tabValue.stageType = pointInfo:getType() == StageType.kElite and 1 or 0
										_tabValue.sort = kSourceSort[sourceConfig] or 0
										lock[#lock + 1] = _tabValue
									end
								else
									local var_7_4 = {
										id = v
									}

									var_7_4.sort = kSourceSort[sourceConfig] or 0
									lock[#lock + 1] = var_7_4
								end
							else
								local pointId = params.pointId

								if pointId ~= nil then
									local pointInfo = self._stageSystem:getPointById(pointId)
									local starNum = pointInfo and pointInfo:getStarCount() or 0
									local challengeTimes = pointInfo:getChallengeTimes()

									if challengeTimes > 0 then
										local _tabValue = {}

										_tabValue.id = v
										_tabValue.pointIndex = pointInfo:getIndex()
										_tabValue.mapIndex = pointInfo:getOwner():getIndex()
										_tabValue.stageType = pointInfo:getType() == StageType.kElite and 1 or 0
										_tabValue.sort = kSourceSort[resourceType] or 0
										_tabValue.starNum = starNum == 3 and 1 or 0
										canEnter[#canEnter + 1] = _tabValue
									else
										local _tabValue = {}

										_tabValue.id = v
										_tabValue.pointIndex = pointInfo:getIndex()
										_tabValue.mapIndex = pointInfo:getOwner():getIndex()
										_tabValue.stageType = pointInfo:getType() == StageType.kElite and 1 or 0
										_tabValue.sort = kSourceSort[resourceType] or 0
										lock[#lock + 1] = _tabValue
									end
								else
									local var_7_5 = {
										stageType = -1,
										pointIndex = -1,
										mapIndex = -1,
										id = v
									}

									var_7_5.sort = kSourceSort[resourceType] or 0
									canEnter[#canEnter + 1] = var_7_5
								end
							end
						end
					end
				end
			end
		end

		table.sort(canEnter, function(a, b)
			if a.sort == b.sort then
				if a.starNum == b.starNum then
					if a.stageType == b.stageType then
						if a.mapIndex == b.mapIndex then
							return a.pointIndex > b.pointIndex
						else
							return a.mapIndex > b.mapIndex
						end
					else
						return a.stageType > b.stageType
					end
				else
					return a.starNum > b.starNum
				end
			else
				return a.sort > b.sort
			end
		end)
		table.sort(lock, function(a, b)
			if a.sort == b.sort then
				if a.stageType == b.stageType then
					if a.mapIndex ~= nil and b.mapIndex ~= nil then
						if a.mapIndex == b.mapIndex then
							return a.pointIndex < b.pointIndex
						else
							return a.mapIndex < b.mapIndex
						end
					else
						return a.mapIndex ~= nil
					end
				else
					return a.stageType < b.stageType
				end
			else
				return a.sort > b.sort
			end
		end)

		self._sourceList = {}

		for k, v in ipairs(canEnter) do
			self._sourceList[#self._sourceList + 1] = v.id
		end

		for k, v in ipairs(lock) do
			self._sourceList[#self._sourceList + 1] = v.id
		end

		self:createSourceList()
	end

	self:refreshView()

	if self._itemData.hideProgress then
		self._main:getChildByFullName("Text_desc"):setVisible(false)
		self._main:getChildByFullName("Text_owncount"):setVisible(false)
		self._main:getChildByFullName("Text_needcount"):setVisible(false)
	end
end

function SourceMediator:refreshView()
	local needCountLabel = self._main:getChildByName("Text_needcount")

	needCountLabel:setVisible(self._itemData.needNum > 0)
	needCountLabel:setString("/" .. self._itemData.needNum)

	local ownCountLabel = self._main:getChildByName("Text_owncount")
	local hasNum = self._bagSystem:getItemCount(self._itemData.itemId)

	ownCountLabel:setString(hasNum)

	if hasNum < self._itemData.needNum then
		ownCountLabel:setTextColor(cc.c3b(255, 135, 135))
	else
		ownCountLabel:setTextColor(cc.c3b(205, 250, 100))
	end

	needCountLabel:setPositionX(ownCountLabel:getPositionX() + ownCountLabel:getContentSize().width + 4)

	local itemPanel = self._main:getChildByFullName("itemPanel")

	itemPanel:removeAllChildren()

	local info = {
		id = self._itemData.itemId,
		amount = hasNum
	}
	local icon = IconFactory:createItemIcon(info, {
		showAmount = false,
		notShowQulity = false,
		isWidget = true
	})

	icon:addTo(itemPanel):center(itemPanel:getContentSize())
	icon:setScale(0.85)
	icon:setNotEngouhState(false)

	local nameLabel = self._main:getChildByFullName("nameLabel")

	nameLabel:setString(RewardSystem:getName({
		id = self._itemData.itemId
	}))
	GameStyle:setQualityText(nameLabel, RewardSystem:getQuality({
		id = self._itemData.itemId
	}))

	if self._tabelView then
		self._tabelView:reloadData()
	end
end

function SourceMediator:createSourceList()
	local width, height = 690, 128

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(-8, -34)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(123)
		end

		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._sourceList
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	tableView:setTag(1234)

	self._tabelView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._viewPanel:addChild(tableView, 900)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
end

function SourceMediator:createCell(cell, index)
	local sourceId = self._sourceList[index]
	local sourceConfig = ConfigReader:getRecordById("ItemResource", tostring(sourceId))

	if not sourceConfig then
		cell:setVisible(false)

		return
	end

	local blockPanel = cell:getChildByName("block")
	local desc = cell:getChildByName("Text_desc")

	desc:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local goBtn = cell:getChildByName("btn_go")
	local notopenImg = cell:getChildByName("Image_notopen")

	desc:setVisible(false)
	notopenImg:setVisible(false)
	goBtn:setVisible(false)

	local titleText = cell:getChildByName("Text_name")

	titleText:setString(Strings:get(sourceConfig.ResourceText))

	local url = sourceConfig.URL

	if url == nil or url == "" then
		desc:setVisible(true)
		desc:setString(Strings:get(sourceConfig.Text))

		return
	end

	local entry, params = UrlEntryManage.resolveUrlWithUserData(url)
	local unlock = UrlEntryManage.checkEnabledWithUserData(url)
	local goBtnState = true

	goBtn:getChildByName("Text_btn"):setString(Strings:get("SOURCE_DESC2"))
	goBtn:addClickEventListener(function()
		self:onClickGo(sourceConfig)
	end)

	if (sourceConfig.ResourceType == KSourceType.kMain or sourceConfig.ResourceType == KSourceType.kElite) and params.pointId ~= nil then
		if not blockPanel then
			blockPanel = self._blockPanel:clone()

			blockPanel:addTo(cell):posite(25, 37)
		end

		blockPanel:setVisible(true)

		goBtnState = self:setBlockPanel(blockPanel, params)

		if not unlock then
			local pointInfo = self._stageSystem:getPointById(params.pointId)

			if pointInfo then
				goBtn:addClickEventListener(function()
					self:onClickEnterLastElite(sourceConfig.ResourceType)
				end)
			else
				goBtn:addClickEventListener(function()
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Tips_BlockUnopen")
					}))
				end)
			end
		end
	elseif sourceConfig.ResourceType == KSourceType.kHeroStroy then
		desc:setVisible(true)
		desc:setString(Strings:get(sourceConfig.Text))

		local mapId = ConfigReader:getDataByNameIdAndKey("HeroBase", params.heroId, "HeroStoryMap")
		local _map = self._stageSystem:getHeroStoryMapById(mapId)

		if _map then
			local point = _map._indexToPoints[params.index]

			if point and point:getStarCount() == 3 then
				goBtn:getChildByName("Text_btn"):setString(Strings:get("Sweep_Set_Amount", {
					num = 1
				}))
				goBtn:addClickEventListener(function()
					if point:getChallengeTimes() < 1 then
						self:dispatch(ShowTipEvent({
							tip = Strings:get("HeroStory_Today_Finish")
						}))
					else
						self:onSweepHeroStory(point:getPointId(), point:getMainShowItem())
					end
				end)
			end
		end

		if not unlock then
			goBtn:addClickEventListener(function()
				self:onClickEnterHeroStory(sourceConfig)
			end)
		end
	elseif sourceConfig.ResourceType == KSourceType.kActivity then
		if blockPanel then
			blockPanel:setVisible(false)
		end

		desc:setVisible(true)
		desc:setString(Strings:get(sourceConfig.Text))

		if string.find(url, "view://CarnivalView") then
			unlock = true
			self._activitySystem = self:getInjector():getInstance("ActivitySystem")

			local unlock1 = self._activitySystem:checkCarnival()
			local carnival = self._activitySystem:getActivityById("Carnival")

			if not unlock1 or not carnival then
				goBtnState = false

				local regionText = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

				regionText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
				regionText:addTo(cell):setName("text")
				regionText:setPositionX(goBtn:getPositionX())
				regionText:setPositionY(goBtn:getPositionY() + 10)
				regionText:setString(Strings:get("Resource_IHF_ZTXChang_No"))
			elseif carnival:isScoreRewardReceived(5) and carnival:isScoreRewardReceived(10) and carnival:isScoreRewardReceived(15) then
				goBtnState = false

				local regionText = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

				regionText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
				regionText:addTo(cell):setName("text")
				regionText:setPositionX(goBtn:getPositionX())
				regionText:setPositionY(goBtn:getPositionY() + 10)
				regionText:setString(Strings:get("CUSTOM_REWARD_ALREADY_RECEIVE"))
			else
				goBtnState = true
			end
		end
	elseif sourceConfig.ResourceType == KSourceType.kCheckLeftCount then
		if goBtnState then
			local leftCount, tip = UrlEntryManage.checkLeftTimesWithUserData(url)

			assert(leftCount ~= nil, "UrlEntry config or function checkLeftCount not find.." .. tostring(tip))

			if leftCount <= 0 then
				goBtnState = false

				local regionText = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

				regionText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
				regionText:addTo(cell):setName("text")
				regionText:setPositionX(goBtn:getPositionX())
				regionText:setPositionY(goBtn:getPositionY() + 10)
				regionText:setString(tip)
			end
		end

		if blockPanel then
			blockPanel:setVisible(false)
		end

		desc:setVisible(true)
		desc:setString(Strings:get(sourceConfig.Text))
	else
		if blockPanel then
			blockPanel:setVisible(false)
		end

		desc:setVisible(true)
		desc:setString(Strings:get(sourceConfig.Text))
	end

	goBtn:setVisible(goBtnState)

	if not unlock then
		notopenImg:setVisible(true)
	end
end

function SourceMediator:setBlockPanel(blockPanel, params)
	local eliteSweepOver = false
	local pointId = params.pointId
	local blockConfig = ConfigReader:getRecordById("BlockPoint", pointId)
	local indexInfo = self._stageSystem:parseStageIndex(pointId, params.stageType)
	local pointInfo = self._stageSystem:getPointById(pointId)
	local nameStr = Strings:get(StageName[params.stageType])
	local nameText = blockPanel:getChildByName("blockname")

	nameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	nameText:setString(Strings:get("SOURCE_DESC4", {
		mapIndex = params.chapterIndex,
		pointIndex = indexInfo.pointIndex,
		degree = nameStr
	}))

	if getCurrentLanguage() ~= GameLanguageType.CN then
		nameText:setPositionX(330)
	end

	local starPanel = blockPanel:getChildByFullName("starPanel")

	starPanel:setPositionX(nameText:getPositionX() + nameText:getContentSize().width + 20)

	local starNum = pointInfo and pointInfo:getStarCount() or 0
	local starState = pointInfo and pointInfo:getStarState() or {}

	for i = 1, 3 do
		local starPanel = starPanel:getChildByFullName("star" .. i)
		local star = starPanel:getChildByName("star")

		star:setVisible(starState[i])
	end

	local wipeOne = blockPanel:getChildByName("btn_wipeone")
	local wipeMulti = blockPanel:getChildByName("btn_wipemulti")

	wipeOne:setVisible(false)
	wipeMulti:setVisible(false)
	self:createFallItems(blockPanel, blockConfig)

	if not ((pointInfo or nil) and pointInfo:isUnlock()) then
		return true
	end

	local challengetimes = blockPanel:getChildByFullName("challengetimes")

	challengetimes:setOpacity(0)
	challengetimes:setVisible(false)

	if pointInfo:getType() == StageType.kElite then
		if starNum == 3 then
			local challengeTimes = pointInfo:getChallengeTimes()

			if challengeTimes > 0 then
				local config = ConfigReader:getRecordById("Reset", "EliteStage_FreeTimes")

				challengetimes:setString(Strings:get("HEROS_UI15", {
					num = pointInfo:getChallengeTimes() .. "/" .. config.ResetSystem.storage
				}))
				wipeOne:setVisible(true)
				wipeMulti:setVisible(true)
			else
				challengetimes:setString(Strings:get("Time_UseingUp"))

				eliteSweepOver = true
			end

			challengetimes:setVisible(true)

			local text = wipeMulti:getChildByName("Text_btn")

			text:setString(Strings:get("Sweep_Set_Amount", {
				num = 5
			}))
		end
	else
		local text = wipeMulti:getChildByName("Text_btn")

		text:setString(Strings:get("CUSTOM_DETAIL_SWEEP_TEN"))

		if starNum == 3 then
			wipeOne:setVisible(true)
			wipeMulti:setVisible(true)
		end
	end

	wipeOne:addClickEventListener(function()
		self:onClickWipeOne(pointId)
	end)
	wipeMulti:addClickEventListener(function()
		self:onClickWipeMulti(pointId)
	end)

	return not wipeMulti:isVisible() and not eliteSweepOver
end

function SourceMediator:createFallItems(blockPanel, blockConfig)
	local rewards = RewardSystem:getRewardsById(blockConfig.ShowItem)
	local targetImg = blockPanel:getChildByName("targetImg")

	targetImg:setVisible(false)

	for i = 1, #rewards do
		local reward = rewards[i]
		local iconbg = blockPanel:getChildByName("icon" .. i)

		iconbg:removeAllChildren()

		local icon = IconFactory:createRewardIcon(reward)

		icon:setScaleNotCascade(0.55)
		icon:addTo(iconbg):center(iconbg:getContentSize())
		IconFactory:bindTouchHander(iconbg, IconTouchHandler:new(self), reward, {
			needDelay = true
		})

		if self._itemData.itemId == tostring(reward.code) then
			local posX = 12
			local posY = iconbg:getPositionY() + iconbg:getContentSize().height - 5

			targetImg:setPosition(cc.p(posX, posY))
			targetImg:setVisible(true)
		end
	end
end

function SourceMediator:onClickGo(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local url = data.URL

	dump(url, "url >>>>>>>>>>>")

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

	if entry then
		params.hasWipeTip = self._itemData.hasWipeTip

		if GameConfigs.closeWipeTip then
			params.hasWipeTip = nil
		end

		params.itemNeedCount = self._itemData.needNum
		params.itemHasCount = self._itemData.hasNum
		params.itemId = self._itemData.itemId

		self._stageSystem:setEnterPoint(params.enterPoint)
		entry:response(context, params)

		if not DisposableObject:isDisposed(self) then
			self:close()
		end
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	end
end

function SourceMediator:onClickEnterLastElite(resourceType)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local isEliteOpen = systemKeeper:canShow("Elite_Block")

	if resourceType == KSourceType.kElite then
		if not StageType.kElite then
			local _stageType = StageType.kNormal

			if not isEliteOpen then
				_stageType = StageType.kNormal
			end

			local mapIndex = self._stageSystem:getLastOpenMapIndex(_stageType)

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, self:getInjector():getInstance("CommonStageChapterView"), {}, {
				chapterIndex = mapIndex,
				stageType = _stageType
			}))
			self:close()
		end
	end
end

function SourceMediator:onClickEnterHeroStory(data)
	local url = data.URL
	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

	if entry then
		params.index = nil

		entry:response(context, params)
		self:close()
	end
end

function SourceMediator:onSweepHeroStory(pointId, MainShowItem)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._stageSystem:requestHeroStageSweep(pointId, 1, nil, function(data)
		data.param = {
			wipeTimes = 1,
			pointId = pointId
		}
		data.itemId = MainShowItem

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageSweepView"), {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end)
end

function SourceMediator:onClickWipeOne(pointId)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local cfg = self._stageSystem:getPointConfigById(pointId)

	if self._developSystem:getEnergy() < cfg.StaminaCost then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
		}))
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return
	end

	self:blockSweep(1, pointId)
end

function SourceMediator:onClickWipeMulti(pointId)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local cfg = self._stageSystem:getPointConfigById(pointId)

	if self._developSystem:getEnergy() < cfg.StaminaCost then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
		}))
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return
	end

	if cfg.Type == StageType.kNormal then
		self:blockSweep(10, pointId)
	elseif cfg.Type == StageType.kElite then
		self:blockSweep(5, pointId)
	end
end

function SourceMediator:onClickClose()
	self:close()
end

function SourceMediator:blockSweep(times, pointId)
	local pointInfo = self._stageSystem:getPointById(pointId)
	local indexInfo = self._stageSystem:parseStageIndex(pointId, pointInfo:getType())
	local starNum = pointInfo and pointInfo:getStarCount() or 0

	if starNum < 3 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_UNLOCK_SWEEP")
		}))

		return
	end

	if pointInfo:getType() == StageType.kElite and pointInfo:getChallengeTimes() < 1 then
		local data = {}

		data.mapId = pointInfo:_getConfig().Map
		data.pointId = pointId
		data.resetTimes = pointInfo:getResetTimes()
		data.resetCost = pointInfo:getResetCost()

		local view = self:getInjector():getInstance("StageResetView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			coverView = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))

		return
	end

	local param = {
		mapId = self._stageSystem:index2MapId(indexInfo.mapIndex, pointInfo:getType()),
		pointId = pointId,
		wipeTimes = times
	}
	local wipeTarget = {}

	wipeTarget[self._itemData.itemId] = self._itemData.needNum

	self._stageSystem:requestStageSweep(param.mapId, pointId, times, wipeTarget, function(data)
		data.param = param
		data.itemId = self._itemData.itemId
		data.needNum = self._itemData.needNum

		local view = self:getInjector():getInstance("StageSweepView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			coverView = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end)
end

function SourceMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if self._tabelView then
			for i = 1, #self._sourceList do
				local index = i
				local cell = self._tabelView:cellAtIndex(index - 1)

				if cell then
					local cell_Old = cell:getChildByTag(123)
					local goBtn = cell_Old:getChildByName("btn_go")

					storyDirector:setClickEnv("SourceView.goBtn" .. index, goBtn, function(sender, eventType)
						local sourceId = self._sourceList[index]
						local sourceConfig = ConfigReader:getRecordById("ItemResource", tostring(sourceId))

						self:onClickGo(sourceConfig)
					end)
				end
			end
		end

		storyDirector:notifyWaiting("enter_Source_View")
	end))

	self:getView():runAction(sequence)
end

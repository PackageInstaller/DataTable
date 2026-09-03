-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreFinishMediator.lua

ExploreFinishMediator = class("ExploreFinishMediator", DmPopupViewMediator, _M)

ExploreFinishMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreFinishMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

local kColumnNum = 5

function ExploreFinishMediator:initialize()
	super.initialize(self)
end

function ExploreFinishMediator:dispose()
	super.dispose(self)
end

function ExploreFinishMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function ExploreFinishMediator:enterWithData(data)
	self:initData(data)
	self:initRewardData()
	self:initWidget()
	self:initMVPView()
	self:intiFinishView()
	self:intiPlayerView()

	local size = cc.size(530, 303)

	self:initTableView(size)
	self:setupView()
end

function ExploreFinishMediator:initData(data)
	self._callback = data.callback
	data = data.data
	self._curGroupId = data.curGroupId

	local curPointId = data.curPointId

	self._pointData = self._exploreSystem:getMapPointObjById(curPointId)
	self._teamList = self._pointData:getTeams()
	self._playerExpNum = data.playerExp
	self._taskStatus = data.taskStatus
	self._taskDesc = data.taskDesc
	self._heroId = self._pointData:getPointHead()
	self._progressNum = data.progressNum
	self._viewState = 1
	self._taskRewards = data.taskRewards or {}
	self._recommendRewards = data.recommendRewards or {}
	self._bagRewards = data.rewards or {}
	self._pointRewards = data.progressReward or {}
	self._extraRewards = data.actExtraRewards or {}
	self._showDataNum = #self._teamList
end

function ExploreFinishMediator:initRewardData()
	self._hasRewards = false
	self._rewards = {}

	local rewards = {}
	local hasRecommend = false

	local function isEquip(type)
		if type == RewardType.kEquip then
			return true
		end

		return false
	end

	local function addRewards(rewards, reward)
		if isEquip(reward.type) then
			for j = 1, reward.amount do
				table.insert(rewards, reward)
			end
		else
			table.insert(rewards, reward)
		end
	end

	for i = 1, #self._taskRewards do
		local reward = self._taskRewards[i]

		if reward.type ~= 11 and reward.type ~= 10 then
			reward.quality = RewardSystem:getQuality(reward)

			addRewards(rewards, reward)
		end
	end

	for i = 1, #self._recommendRewards do
		local reward = self._recommendRewards[i]

		if reward.type ~= 11 and reward.type ~= 10 then
			hasRecommend = true
			reward.recommend = true
			reward.quality = RewardSystem:getQuality(reward)

			addRewards(rewards, reward)
		end
	end

	if #rewards > 0 then
		self._hasRewards = true

		self:sortRewards(rewards)

		if hasRecommend then
			local var_6_0 = Strings:get("EXPLORE_UI97")

			if not var_6_0 then
				var_6_0 = Strings:get("EXPLORE_UI118")

				do
					local str = var_6_0

					table.insert(self._rewards, {
						rewards = rewards,
						str = str
					})
				end

				local rewards = {}

				for i = 1, #self._bagRewards do
					local reward = self._bagRewards[i]

					if reward.type ~= 11 and reward.type ~= 10 then
						reward.quality = RewardSystem:getQuality(reward)

						addRewards(rewards, reward)
					end
				end

				for i = 1, #self._pointRewards do
					local reward = self._pointRewards[i]

					if reward.type ~= 11 and reward.type ~= 10 then
						reward.quality = RewardSystem:getQuality(reward)
						reward.progress = true

						addRewards(rewards, reward)
					end
				end

				for i = 1, #self._extraRewards do
					local reward = self._extraRewards[i]

					if reward.type ~= 11 and reward.type ~= 10 then
						reward.quality = RewardSystem:getQuality(reward)
						reward.extra = true

						addRewards(rewards, reward)
					end
				end

				if #rewards > 0 then
					self._hasRewards = true

					self:sortRewards(rewards)

					local str = Strings:get("EXPLORE_UI94")

					table.insert(self._rewards, {
						rewards = rewards,
						str = str
					})
				end

				if not self._hasRewards then
					local str = Strings:get("EXPLORE_UI94")

					table.insert(self._rewards, {
						str = str
					})
				end
			end
		end
	end
end

function ExploreFinishMediator:sortRewards(rewards)
	table.sort(rewards, function(a, b)
		local itemConfigA = ConfigReader:getRecordById("ItemConfig", a.code)
		local itemConfigB = ConfigReader:getRecordById("ItemConfig", b.code)
		local equipConfigA = ConfigReader:getRecordById("HeroEquipBase", a.code)
		local equipConfigB = ConfigReader:getRecordById("HeroEquipBase", b.code)
		local currencyA = itemConfigA and itemConfigA.Page == ItemPages.kCurrency
		local currencyB = itemConfigB and itemConfigB.Page == ItemPages.kCurrency

		if itemConfigA and itemConfigB then
			if currencyA == currencyB then
				if a.quality == b.quality then
					if itemConfigA.Sort == itemConfigB.Sort then
						return false
					end

					return itemConfigA.Sort < itemConfigB.Sort
				end

				return a.quality > b.quality
			end

			return currencyA and not currencyB
		elseif equipConfigA and equipConfigB then
			if equipConfigA.Rareity == equipConfigB.Rareity then
				if equipConfigA.Sort == equipConfigB.Sort then
					return false
				end

				return equipConfigA.Sort < equipConfigB.Sort
			end

			return equipConfigA.Rareity > equipConfigB.Rareity
		end

		if currencyA and not currencyB then
			return true
		elseif not currencyA and currencyB then
			return false
		end

		return not itemConfigA and itemConfigB
	end)
end

function ExploreFinishMediator:initWidget()
	self._touchPanel = self:getView():getChildByName("touchPanel")

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickClose(sender, eventType)
	end)
	self._touchPanel:setSwallowTouches(false)

	self._mainPanel = self:getView():getChildByName("main")
	self._panel = self._mainPanel:getChildByName("panel")
	self._finishPanel = self._mainPanel:getChildByName("finishPanel")
	self._playerExp = self._mainPanel:getChildByName("playerExp")

	self._playerExp:setVisible(false)

	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)

	self._cellWidth = self._cellPanel:getContentSize().width
	self._cellHeight = self._cellPanel:getContentSize().height

	local titleBg = self._cellPanel:getChildByFullName("titleBg")
	local text = titleBg:getChildByFullName("text")

	text:ignoreContentAdaptWithSize(false)
	text:setContentSize(cc.size(100, 30))

	self._tipMark = self._finishPanel:getChildByName("tipMark")

	self._tipMark:setVisible(false)
end

function ExploreFinishMediator:initBagData()
	self._allEntryIds = self._exploreSystem:getAllEntryIds()

	local kTabFilterMap = self._exploreSystem:getTabFilterMap()
	local filterFunc = kTabFilterMap[1]

	assert(filterFunc ~= nil)

	for _, entryId in ipairs(self._allEntryIds) do
		local entry = self._exploreSystem:getEntryById(entryId)

		if entry then
			local isVisible = entry.item:getIsVisible()

			if (isVisible or entry.item:getType() == ItemPages.kCurrency and entry.item:getSubType() ~= ItemTypes.K_POWER and entry.count > 0) and filterFunc(entry.item) then
				self._curEntryIds[#self._curEntryIds + 1] = entryId
			end
		end
	end
end

function ExploreFinishMediator:setupView()
	local sloganPanel = self._mainPanel:getChildByFullName("sloganPanel")

	sloganPanel:setOpacity(0)

	local doneMark = self._finishPanel:getChildByName("donemark")
	local todoMark = self._finishPanel:getChildByName("todomark")

	doneMark:setOpacity(0)
	doneMark:setScale(4)
	todoMark:setScale(4)
	todoMark:setOpacity(0)
	self._panel:setOpacity(0)

	local animPanel = self._mainPanel:getChildByName("animPanel")
	local anim = cc.MovieClip:create("tansuotj_fubenjiesuan")

	anim:addTo(animPanel)
	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addCallbackAtFrame(9, function()
		sloganPanel:fadeIn({
			time = 0.3333333333333333
		})
	end)

	local targetPanel = self._finishPanel:getChildByFullName("targetPanel")
	local posX1 = targetPanel:getPositionX()
	local posY1 = targetPanel:getPositionY()
	local pos = cc.p(posX1, posY1)

	targetPanel:setPositionX(posX1 - 30)
	targetPanel:setOpacity(0)
	anim:addCallbackAtFrame(11, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		targetPanel:runAction(cc.Spawn:create(fadeIn, moveTo))
	end)

	local progressPanel = self._finishPanel:getChildByFullName("progressPanel")
	local posX2 = progressPanel:getPositionX()
	local posY2 = progressPanel:getPositionY()
	local pos = cc.p(posX2, posY2)

	progressPanel:setPositionX(posX1 - 30)
	progressPanel:setOpacity(0)
	anim:addCallbackAtFrame(13, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		progressPanel:runAction(cc.Spawn:create(fadeIn, moveTo))
	end)
	anim:addCallbackAtFrame(15, function()
		local spawn = cc.Spawn:create(cc.ScaleTo:create(0.16666666666666666, 0.9), cc.FadeIn:create(0.16666666666666666))
		local scaleTo1 = cc.ScaleTo:create(0.13333333333333333, 1.2)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)

		doneMark:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			doneMark:setOpacity(100)
		end), spawn, scaleTo1, scaleTo2))

		spawn = cc.Spawn:create(cc.ScaleTo:create(0.16666666666666666, 0.9), cc.FadeIn:create(0.16666666666666666))
		scaleTo1 = cc.ScaleTo:create(0.13333333333333333, 1.2)
		scaleTo2 = cc.ScaleTo:create(0.1, 1)

		todoMark:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			todoMark:setOpacity(100)
		end), spawn, scaleTo1, scaleTo2))
	end)
	anim:addCallbackAtFrame(20, function()
		self._panel:fadeIn({
			time = 0.3
		})
	end)

	local heroNode = anim:getChildByFullName("roleNode")

	heroNode:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._heroId)
	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	heroNode:addChild(img)
	img:setScale(0.8)
	img:setPosition(cc.p(100, -50))
end

function ExploreFinishMediator:initMVPView()
	local sloganPanel = self._mainPanel:getChildByFullName("sloganPanel")
	local sloganLabel = sloganPanel:getChildByName("slogan")
	local image1 = sloganPanel:getChildByFullName("image1")
	local image2 = sloganPanel:getChildByFullName("image2")
	local slogan = ConfigReader:getDataByNameIdAndKey("HeroBase", self._heroId, "MVPText")

	sloganLabel:setString(Strings:get(slogan))

	local size = sloganLabel:getContentSize()

	image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
end

function ExploreFinishMediator:intiFinishView()
	local titletitle = self._finishPanel:getChildByFullName("targetPanel.title")
	local desc = self._finishPanel:getChildByFullName("targetPanel.desc")

	desc:getVirtualRenderer():setLineSpacing(8)
	desc:setPositionX(titletitle:getPositionX() + titletitle:getAutoRenderSize().width + 10)

	local doneMark = self._finishPanel:getChildByName("donemark")
	local todoMark = self._finishPanel:getChildByName("todomark")
	local progress1 = self._finishPanel:getChildByFullName("progressPanel.progress")
	local loadingBar = self._finishPanel:getChildByFullName("progressPanel.loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))
	desc:setString(self._taskDesc)
	doneMark:setVisible(self._taskStatus ~= 0)
	todoMark:setVisible(self._taskStatus == 0)
	progress1:setString(self._progressNum .. "%")
	loadingBar:setPercent(self._progressNum)
end

function ExploreFinishMediator:intiPlayerView()
	local mLevelNum = self._playerExp:getChildByFullName("mLevelNum")

	mLevelNum:setString(self._developSystem:getLevel())

	local mExpNum = self._playerExp:getChildByFullName("mExpNum")

	mExpNum:setString("+" .. self._playerExpNum)

	local loadingBar = self._playerExp:getChildByFullName("loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	local player = self._developSystem:getPlayer()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local currentExp = player:getExp()
	local percent = currentExp / config.PlayerExp * 100

	loadingBar:setPercent(percent)
end

function ExploreFinishMediator:initTableView(size)
	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
	end

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		local index = idx + 1

		if self._viewState == 1 then
			local team = self._teamList[index]
			local heroes = team:getHeroes()
			local length = #heroes
			local lineNum = math.ceil(length / kColumnNum)
			local height = self._cellHeight + 100 * (lineNum - 1) + 10

			return self._cellWidth, height
		elseif self._viewState == 2 and self._hasRewards then
			local rewards = self._rewards[index].rewards
			local length = #rewards
			local lineNum = math.ceil(length / kColumnNum)
			local height = self._cellHeight + 100 * (lineNum - 1) + 15

			return self._cellWidth, height
		end

		return self._cellWidth, self._cellHeight
	end

	local function numberOfCellsInTableView(table)
		return self._showDataNum
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(size)

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._panel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function ExploreFinishMediator:createCell(cell, index)
	cell:removeAllChildren()

	if self._viewState == 1 then
		self:createTeamCell(cell, index)
	elseif self._viewState == 2 then
		local data = self._rewards[index]

		if not self._hasRewards then
			self:createEmptyCell(cell, data.str)
		else
			self:createRewardCell(cell, data.rewards, data.str)
		end
	end
end

function ExploreFinishMediator:createTeamCell(parent, index)
	local cell = self._cellPanel:clone()

	cell:setVisible(true)

	local team = self._teamList[index]
	local heroes = team:getHeroes()
	local length = #heroes
	local lineNum = math.ceil(length / kColumnNum)
	local height = self._cellHeight + 100 * (lineNum - 1) + 10

	cell:setContentSize(cc.size(self._cellWidth, height))
	cell:getChildByFullName("bg"):setContentSize(cc.size(508, height - 25))
	cell:getChildByFullName("bg"):offset(0, 5)

	local titleBg = cell:getChildByFullName("titleBg")

	titleBg:setPositionY(height - 25)
	titleBg:getChildByFullName("text"):setString(Strings:get("EXPLORE_UI107", {
		num = index
	}))

	for ii = 1, lineNum do
		for j = 1, kColumnNum do
			local index = kColumnNum * (ii - 1) + j
			local hero = heroes[index]

			if hero then
				local heroInfo = self:getHeroInfoById(hero)
				local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
					rarityAnim = true,
					hideStar = true
				})

				petNode:setScale(0.5)
				petNode:addTo(cell)

				local posX = 80 + 100 * (j - 1)
				local posY = height - 90 - 100 * (ii - 1)

				petNode:setPosition(cc.p(posX, posY))
			end
		end
	end

	cell:addTo(parent):posite(0, 0)
end

function ExploreFinishMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		quality = heroInfo:getQuality(),
		rarity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost()
	}
end

function ExploreFinishMediator:createRewardCell(parent, rewards, str)
	local cell = self._cellPanel:clone()

	cell:setVisible(true)

	local length = #rewards
	local lineNum = math.ceil(length / kColumnNum)
	local height = self._cellHeight + 100 * (lineNum - 1) + 15

	cell:setContentSize(cc.size(self._cellWidth, height))
	cell:getChildByFullName("bg"):setContentSize(cc.size(508, height - 25))
	cell:getChildByFullName("bg"):offset(0, 5)

	local titleBg = cell:getChildByFullName("titleBg")

	titleBg:setPositionY(height - 25)
	titleBg:getChildByFullName("text"):setString(str)

	for ii = 1, lineNum do
		for j = 1, kColumnNum do
			local index = kColumnNum * (ii - 1) + j
			local reward = rewards[index]

			if reward then
				local icon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				icon:addTo(cell):setScale(0.7)

				local posX = 70 + 95 * (j - 1)
				local posY = height - 90 - 100 * (ii - 1)

				icon:setPosition(cc.p(posX, posY))

				if reward.progress or reward.extra then
					if reward.progress then
						local var_34_0 = Strings:get("EXPLORE_UI96")

						if not var_34_0 then
							var_34_0 = Strings:get("EXPLORE_UI117")

							local str = var_34_0
							local tipMark = self._tipMark:clone()

							tipMark:getChildByFullName("text"):setString(str)
							tipMark:setVisible(true)
							tipMark:addTo(icon):setScale(1.4):posite(90, 92)
						end
					end
				end
			end
		end
	end

	cell:addTo(parent):posite(0, 0)
end

function ExploreFinishMediator:createEmptyCell(parent, str)
	local cell = self._cellPanel:clone()

	cell:setVisible(true)

	local titleBg = cell:getChildByFullName("titleBg")

	titleBg:getChildByFullName("text"):setString(str)

	local str = Strings:get("EXPLORE_UI95")
	local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_M, 18)

	label:setAnchorPoint(cc.p(0, 0.5))
	label:addTo(cell):posite(38, 57)
	cell:addTo(parent):posite(0, 0)
end

function ExploreFinishMediator:onTouchMaskLayer()
	return
end

function ExploreFinishMediator:checkHasItemInfoView()
	local itemTipView = self:getView():getChildByTag(ItemTipsViewTag)
	local equipTipView = self:getView():getChildByTag(EquipTipsViewTag)
	local buffTipView = self:getView():getChildByTag(BuffTipsViewTag)

	if itemTipView or equipTipView or buffTipView then
		return true
	end

	return false
end

function ExploreFinishMediator:finishExplore()
	self._viewState = self._viewState + 1

	if self._viewState == 3 then
		if self._curGroupId then
			self._exploreSystem:cleanExploreData()

			local function callback()
				local view = self:getInjector():getInstance("ExploreView")

				self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
					curGroupId = self._curGroupId
				}))
			end

			self._rankSystem:cleanUpRankListByType(RankType.kMap)

			local sendData = {
				rankStart = 1,
				type = RankType.kMap,
				rankEnd = self._rankSystem:getRequestRankCountPerTime()
			}

			self._rankSystem:requestRankData(sendData, callback)
		else
			self:close()
		end
	elseif self._viewState == 2 then
		self._showDataNum = #self._rewards

		self._finishPanel:setVisible(false)
		performWithDelay(self:getView(), function()
			self._playerExp:setVisible(true)

			local size = cc.size(530, 347)

			self:initTableView(size)
		end, 0.03333333333333333)
	end
end

function ExploreFinishMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn and not self:checkHasItemInfoView() then
		self:finishExplore()
	end
end

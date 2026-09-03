-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticePointMediator.lua

StagePracticePointMediator = class("StagePracticePointMediator", DmAreaViewMediator, _M)

StagePracticePointMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticePointMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")

local kBtnHandlers = {
	["main.infonode.infobtn"] = "onClickInfo",
	["main.infonode.battlebtn"] = "onClickChallage"
}

function StagePracticePointMediator:initialize()
	super.initialize(self)

	self._newMessages = {}
end

function StagePracticePointMediator:dispose()
	super.dispose(self)

	if self._topInfoWidget then
		self._topInfoWidget:dispose()

		self._topInfoWidget = nil
	end
end

function StagePracticePointMediator:userInject()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
end

function StagePracticePointMediator:onRegister()
	local view = self:getView()
	local background = cc.Sprite:create("asset/ui/stagePractice/bg_practice_school2.png")

	background:addTo(view, -1):setName("backgroundBG"):center(view:getContentSize())
	self:mapButtonHandlersClick(kBtnHandlers)
	super.onRegister(self)
end

function StagePracticePointMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	self:getView():getChildByName("backgroundBG"):coverWorldRegion(targetFrame)
end

function StagePracticePointMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(60)

	local config = {
		hasAnim = true,
		currencyInfo = {
			CurrencyIdKind.kPower,
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kGold
		},
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("StagePractice_Text7")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticePointMediator:enterWithData(data)
	self._data = data

	self:setupTopInfoWidget()
	self:initNodes()
	self:initData(data)
	self:refreshData(data, true)
	self:createAnim()
	self:refreshTableView()
	self:refreshPointPanel()

	if data and data.pointId then
		local posX = self._stagePracticeSystem:getOffsetX()

		self._tableView:setContentOffset(cc.p(posX, 0))
	else
		local clonePanel = self._clonePanel
		local size = clonePanel:getContentSize()
		local viewSize = self._tableView:getViewSize()
		local containerSize = self._tableView:getContainer():getContentSize()
		local changeWidth = viewSize.width - containerSize.width

		if changeWidth < 0 then
			local posX = -(self._curPointIndex - 1) * (size.width + 5)

			if posX < changeWidth then
				posX = changeWidth
			end

			self._tableView:setContentOffset(cc.p(posX, 0))
		end
	end

	self:createAllCellAnim(function()
		self:runUnLockCellAnim()
	end)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_GETREWARD_SUCC, self, self.refreshViewByGetReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
	self:setupClickEnvs()
end

function StagePracticePointMediator:rStartAnim()
	self._infoAnim:gotoAndPlay(0)
	self._bgAnim:gotoAndPlay(0)
end

function StagePracticePointMediator:createAnim()
	local anim = cc.MovieClip:create("main_guanqiachuxian")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addTo(self._mainPanel, 999):center(self._mainPanel:getContentSize())

	local roleAnim = anim:getChildByName("hero")

	self._heroNode = cc.Node:create()

	self._heroNode:addTo(roleAnim):center(roleAnim:getContentSize()):offset(-16, -35)

	local titleAnim = anim:getChildByName("title")

	self._titleNode = cc.Node:create()

	self._titleNode:addTo(titleAnim):center(titleAnim:getContentSize()):offset(-16, -35)
	self._infoNode:removeFromParent(false)

	local infoAnim = anim:getChildByName("bg")

	self._infoNode:addTo(infoAnim):center(infoAnim:getContentSize()):offset(-720, -390)
	self._paoNode:removeFromParent(false)

	local qipaoAnim = anim:getChildByName("qipao")

	self._paoNode:addTo(qipaoAnim):center(qipaoAnim:getContentSize()):offset(-110, -80)

	self._infoAnim = anim

	local bgAnim = cc.MovieClip:create("bgdh_guanqiachuxian")

	self._bgAnim = bgAnim

	bgAnim:addEndCallback(function()
		bgAnim:stop()
	end)
	bgAnim:addTo(self._mainPanel, -1):center(self._mainPanel:getContentSize())

	local bgNodeAnim = bgAnim:getChildByName("bg")
	local bgImg = self:getView():getChildByName("backgroundBG")

	bgImg:removeFromParent(false)
	bgImg:addTo(bgNodeAnim):center(bgNodeAnim:getContentSize())
end

function StagePracticePointMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local targetNode = self:getView():getChildByFullName("main.infonode.battlebtn")
		local pointId = self._curPointData:getId()

		storyDirector:setClickEnv("stagePractice.challenge_btn", targetNode, function(sender, eventType)
			self:onClickChallage(sender, eventType, pointId)
		end)
		storyDirector:notifyWaiting("enter_stage_practice_view")
	end))

	self:getView():runAction(sequence)
end

function StagePracticePointMediator:refreshData(data, isInit)
	self._curMapData = self._stagePractice:getMapById(self._curMapId)
	self._pointList = self._curMapData:getPointArray()

	if data and data.pointId then
		for i = 1, #self._pointList do
			if self._pointList[i]:getId() == data.pointId then
				self._curPointIndex = i

				break
			end
		end
	elseif isInit then
		local lastPoint = self._pointList[#self._pointList]

		if not lastPoint:isLock() and lastPoint:getFirstPassState() == SPracticeRewardState.kHasGet then
			self._curPointIndex = 1
		else
			for i = 1, #self._pointList do
				local pointData = self._pointList[i]

				if not pointData:getHasPlay() and not pointData:isLock() then
					self._curPointIndex = i

					break
				end
			end

			for i = 1, #self._pointList do
				if self._pointList[i]:hasRedPoint() then
					self._curPointIndex = i

					break
				end
			end
		end
	end

	self._curPointData = self._curMapData:getPointByIndex(self._curPointIndex)
end

function StagePracticePointMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._clonePanel = self:getView():getChildByFullName("cellpanel")

	self._clonePanel:setVisible(false)

	self._infoNode = self._mainPanel:getChildByFullName("infonode")
	self._infoBtn = self._infoNode:getChildByName("infobtn")
	self._paoNode = self._mainPanel:getChildByFullName("paonode")

	self._paoNode:setLocalZOrder(999)

	self._costNode = self._infoNode:getChildByFullName("Image_6")
	self._bottomNode = self:getView():getChildByFullName("bottomnode")

	local declareLabel = self._paoNode:getChildByFullName("label")

	declareLabel:offset(0, -3)

	self._challangeBtn = self._infoNode:getChildByFullName("battlebtn")
	self._tipNode = self._infoNode:getChildByFullName("tipimg")

	local descLabel = self._tipNode:getChildByFullName("label")

	descLabel:offset(-2, 6)
end

function StagePracticePointMediator:initData(data)
	self._curMapId = data.mapId
	self._bagSystem = self._developSystem:getBagSystem()
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
	self._curMapIndex = 1
	self._curPointIndex = 1
end

function StagePracticePointMediator:moveAction(delayTime, targetPos, func)
	return cc.Sequence:create(cc.DelayTime:create(delayTime), cc.Spawn:create(cc.EaseExponentialOut:create(cc.MoveTo:create(0.16, cc.p(targetPos.x, targetPos.y + 10))), cc.FadeIn:create(0.16)), cc.MoveTo:create(0.1, cc.p(targetPos.x, targetPos.y)), cc.CallFunc:create(func))
end

function StagePracticePointMediator:createAllCellAnim(func)
	local children = self._tableView:getContainer():getChildren()
	local startIndex = 1

	for index = 1, #children do
		local cell = children[index]
		local posX, posY = cell:getPositionX(), cell:getPositionY()

		cell:offset(0, -115)
		cell:runAction(self:moveAction(startIndex * 0.05, cc.p(posX, posY), function()
			if index == #children and func then
				func()
			end
		end))

		startIndex = startIndex + 1
	end
end

function StagePracticePointMediator:refreshTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local clonePanel = self._clonePanel
	local size = clonePanel:getContentSize()

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		local data = self._pointList[self._curSelectIndex]

		if not data then
			return
		end

		local oldIndex = self._curPointIndex
		local curData = self._pointList[self._curSelectIndex]
		local curCell = self._tableView:cellAtIndex(self._curSelectIndex - 1)

		if curCell then
			curCell:getChildByTag(123):setClickAnim(true, curData:isLock())
		end

		if data:isLock() then
			self:dispatch(ShowTipEvent({
				tip = self._stagePracticeSystem:getPointLockTip(self._curMapId, data:getId())
			}))

			return
		end

		if oldIndex == self._curSelectIndex then
			return
		end

		local oldData = self._pointList[oldIndex]
		local oldCell = self._tableView:cellAtIndex(oldIndex - 1)

		if oldCell then
			oldCell:getChildByTag(123):setClickAnim(false, oldData:isLock())
		end

		self._curPointIndex = self._curSelectIndex

		self:refreshData()
		self:refreshPointPanel()
		self:rStartAnim()
	end

	local function cellSizeForTable(table, idx)
		return size.width + 5, size.height + 10
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = clonePanel:clone()

			sprite:setPosition(cc.p(5, 4))
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setVisible(true)
			cell:addChild(sprite, 11, 123)
			self:createCell(sprite, idx + 1)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._pointList
	end

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local safeAreaInset = director:getOpenGLView():getSafeAreaInset()
	local viewWidth = winSize.width - safeAreaInset.left - safeAreaInset.right
	local tableView = cc.TableView:create(cc.size(viewWidth, size.height))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(0, 17)
	tableView:setDelegate()
	self._bottomNode:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function StagePracticePointMediator:runUnLockCellAnim()
	local allCells = self._tableView:getContainer():getChildren()
	local index = 0

	for _, cell in pairs(allCells) do
		index = index + 1

		local node = cell:getChildByTag(123)

		if node then
			local data = self._pointList[node:getIndex()]

			if not data:isLock() and not self._stagePracticeSystem:getFlagIdState(data:getId()) then
				node:runUnLockAnim(function()
					node:setNormalState(index == self._curPointIndex, false)

					if index == #allCells then
						for i = 1, #self._pointList do
							self._stagePracticeSystem:setFlagIdState(self._pointList[i]:getId())
						end
					end
				end)
			end
		end
	end
end

local animTag = 123

function StagePracticePointMediator:createCellAnim(cell, idx)
	local data = self._pointList[idx]
	local anim = cc.MovieClip:create("yeqian_guanqiachuxian")

	anim:addTo(cell, 1, animTag):center(cell:getContentSize()):offset(4, 0)

	local name1Anim = anim:getChildByName("name1")
	local nameLabel = cc.Label:createWithTTF(data:getName(), TTF_FONT_FZYH_M, 23)

	nameLabel:setColor(cc.c3b(18, 62, 125))
	nameLabel:addTo(name1Anim):center(name1Anim:getContentSize())

	local name4Anim = anim:getChildByName("name4")
	local nameLabel = cc.Label:createWithTTF(data:getName(), TTF_FONT_FZYH_M, 23)

	nameLabel:setColor(cc.c3b(94, 72, 58))
	nameLabel:addTo(name4Anim):center(name4Anim:getContentSize())

	local starAnim = anim:getChildByName("star3")
	local allStarCount = #data:getStarCondition()

	for i = 1, allStarCount do
		if allStarCount <= data:getStar() then
			local lightImg = cc.Sprite:createWithSpriteFrameName("img_practice_star2.png")

			lightImg:addTo(starAnim):posite((i - 1) * 60, 0)
		else
			local backImg = cc.Sprite:createWithSpriteFrameName("img_practice_star1.png")

			backImg:addTo(starAnim):posite((i - 1) * 60, 0)
		end
	end

	local titleNameAnim = anim:getChildByName("titlename")
	local nameLabel = cc.Label:createWithTTF(data:getName(), TTF_FONT_FZYH_M, 23)

	nameLabel:setColor(cc.c3b(94, 72, 58))
	nameLabel:addTo(titleNameAnim):center(titleNameAnim:getContentSize())

	function cell:getAnim()
		return self:getChildByTag(animTag)
	end

	function cell:setLockState()
		local anim = self:getAnim()

		if anim then
			anim:gotoAndStop(0)
		end
	end

	function cell:setNormalState(isSelect, isLock)
		local anim = self:getAnim()

		if anim then
			if isLock then
				if isSelect then
					anim:gotoAndStop(25)
				else
					anim:gotoAndStop(0)
				end
			elseif isSelect then
				anim:gotoAndStop(100)
			else
				anim:gotoAndStop(45)
			end
		end
	end

	function cell:runUnLockAnim(func)
		local anim = self:getAnim()

		if anim then
			anim:gotoAndPlay(30)
			anim:addCallbackAtFrame(45, function(fid, mc, frameIndex)
				anim:removeCallback(fid)
				anim:stop()

				if func then
					func()
				end
			end)
		end
	end

	function cell:getIndex()
		return idx
	end

	function cell:setClickAnim(isSelect, isLock)
		local anim = self:getAnim()

		if anim then
			if isLock then
				if isSelect then
					anim:gotoAndPlay(10)
					anim:addCallbackAtFrame(25, function(fid, mc, frameIndex)
						anim:removeCallback(fid)
						anim:stop()
					end)
				else
					anim:gotoAndStop(0)
				end
			elseif isSelect then
				anim:gotoAndPlay(80)
				anim:addCallbackAtFrame(100, function(fid, mc, frameIndex)
					anim:removeCallback(fid)
					anim:stop()
				end)
			else
				anim:gotoAndPlay(115)
				anim:addCallbackAtFrame(130, function(fid, mc, frameIndex)
					anim:removeCallback(fid)
					anim:stop()
				end)
			end
		end
	end
end

function StagePracticePointMediator:createCell(cell, idx)
	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)
	cell:addTouchEventListener(function(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end)
	cell:removeChildByTag(animTag)
	self:createCellAnim(cell, idx)

	local data = self._pointList[idx]
	local isSelect = idx == self._curPointIndex
	local isLock = false

	isLock = not data:isLock() and (self._stagePracticeSystem:getFlagIdState(data:getId()) or true) or true

	cell:setNormalState(isSelect, isLock)
	self:refreshCellRedPoint(cell, idx, isLock)
end

local cellRedPointTag = 143

function StagePracticePointMediator:refreshCellRedPoint(cell, idx, isLock)
	local data = self._pointList[idx]
	local var_44_0

	if not cell:getChildByTag(cellRedPointTag) then
		cell.redPoint = RedPoint:createDefaultNode()

		cell.redPoint:addTo(cell, 99):posite(206, 100)
		cell.redPoint:setTag(cellRedPointTag)

		var_44_0 = data:hasRedPoint() and not isLock
	end

	cell.redPoint:setVisible(var_44_0)
end

function StagePracticePointMediator:refreshPointPanel()
	local mapId = self._curMapData:getId()
	local curPointId = self._curPointData:getId()
	local pointData = self._stagePracticeSystem:getPointById(mapId, curPointId)
	local canGetReward = pointData:getFirstPassState() == SPracticeRewardState.kCanGet
	local titleImg = cc.Sprite:createWithSpriteFrameName(self._curMapData:getMapPicture()[2])

	titleImg:addTo(self._titleNode)

	local getRewardBtn = self._infoNode:getChildByFullName("getrewardbtn")

	getRewardBtn:addTouchEventListener(function(sender, eventType)
		self:onGetRewardClicked(sender, eventType, idx)
	end)

	local btnImg = getRewardBtn:getChildByFullName("img")

	btnImg:setTouchEnabled(true)
	btnImg:addTouchEventListener(function(sender, eventType)
		self:onGetRewardClicked(sender, eventType, idx)
	end)
	getRewardBtn:setVisible(canGetReward)
	self._challangeBtn:setVisible(not canGetReward)

	local descStr = self._curPointData:getStageDesc()

	self._tipNode = self._infoNode:getChildByFullName("tipimg")

	self._tipNode:setVisible(false)
	self._infoBtn:setVisible(descStr ~= nil)

	local descLabel = self._tipNode:getChildByFullName("label")

	descLabel:setLineSpacing(-1)
	HeroSystem:autoTextSize(descLabel, 260, descStr)

	local nameLabel = self._infoNode:getChildByFullName("namelabel")

	nameLabel:setString(self._curPointData:getName())
	self._infoBtn:setPositionX(nameLabel:getPositionX() + nameLabel:getContentSize().width + 34)
	self._tipNode:setPositionX(534 + nameLabel:getContentSize().width)
	self:refreshRewardPanel()
	self:refreshCostPanel()
	self:refreshConditionDesc()
end

function StagePracticePointMediator:refreshConditionDesc()
	local parent = self._infoNode:getChildByFullName("conditionnode")

	parent:removeAllChildren()

	local starCondition = self._curPointData:getStarCondition()
	local conditionDes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_StarConditionDesc", "content")
	local starIds = self._curPointData:getStarIds()

	for i = 1, #starCondition do
		local node = cc.Node:create()
		local condition = starCondition[i]
		local textStr = Strings:get(conditionDes[condition.type], condition)
		local starImg = cc.Sprite:createWithSpriteFrameName("ty_x_tx.png")

		starImg:setScale(1.1)
		starImg:addTo(node)
		starImg:setGray(starIds[i] ~= true)

		local descLabel = cc.Label:createWithTTF(textStr, TTF_FONT_FZYH_M, 20)

		descLabel:setAnchorPoint(cc.p(0, 0))
		descLabel:addTo(node):posite(23, -12)
		node:addTo(parent):posite(20, 22 - 30 * i)
	end
end

function StagePracticePointMediator:refreshCostPanel()
	local canGetReward = self._curPointData:getFirstPassState() == SPracticeRewardState.kCanGet
	local costData = self._curPointData:getCost()

	if not costData then
		self._costNode:setVisible(false)

		self._goldCost = 0
		self._goldEngouh = true

		return
	end

	local costIcon = IconFactory:createPic({
		id = costData.id
	})

	costIcon:setScale(0.66)

	local mainNode = self._costNode:getChildByFullName("node")
	local width = costIcon:getContentSize().width
	local parent = mainNode:getChildByFullName("iconpanel")

	costIcon:addTo(parent):center(parent:getContentSize())

	local costLabel = mainNode:getChildByFullName("numlabel")

	self._goldEngouh = self._bagSystem:getGold() >= costData.amount
	self._goldCost = costData.amount

	local colorNum = self._goldEngouh and 1 or 6

	costLabel:setTextColor(GameStyle:getColor(colorNum))
	costLabel:setString("X" .. costData.amount)

	width = width + costLabel:getContentSize().width

	mainNode:setPositionX(46 - width / 2)
	self._costNode:setVisible(self._goldCost > 0 and not canGetReward)
end

function StagePracticePointMediator:refreshRewardPanel()
	local rewardNode = self._infoNode:getChildByFullName("node1")
	local rewardId = self._curPointData:getPassReward()
	local hasGetReward = self._curPointData:getFirstPassState() == SPracticeRewardState.kHasGet

	self:refreshRewardPanelById(rewardNode, rewardId, hasGetReward)

	local rewardNode = self._infoNode:getChildByFullName("node2")
	local rewardId = self._curPointData:getStarReward()
	local hasGetReward = self._curPointData:getFullStarReward() == SPracticeRewardState.kHasGet

	self:refreshRewardPanelById(rewardNode, rewardId, hasGetReward)

	local label = self._infoNode:getChildByFullName("titlelabel2")

	label:setVisible(self._curPointData:getType() ~= SPracticePointType.kTEACH)
end

function StagePracticePointMediator:refreshRewardPanelById(parent, rewardId, hasGetReward)
	parent:removeAllChildren()

	local canGet = self._curPointData:getFirstPassState() == SPracticeRewardState.kCanGet
	local config = ConfigReader:getRecordById("Reward", rewardId)

	if config then
		local count = #config.Content

		for i = 1, count do
			local icon = IconFactory:createRewardIcon(config.Content[i], {
				ignoreAnim = true,
				isWidget = true
			})

			icon:setScaleNotCascade(0.6)
			icon:addTo(parent, -100 - i):posite(45 + (i - 1) * 75, 27)

			if canGet then
				local anim = cc.MovieClip:create("node_xinkelingjiangli")

				anim:addTo(icon):center(icon:getContentSize())
			end

			IconFactory:bindTouchHander(icon, IconTouchHander:new(self), config.Content[i], {
				needDelay = true
			})

			if hasGetReward then
				icon:setMaskVisible(true)

				if i == count then
					local img = cc.Sprite:createWithSpriteFrameName("img_practice_chalkget.png")

					img:addTo(parent, 9999):setPosition(icon:getPosition()):offset(25, 20)
					img:setScale(1.1)
				end
			end
		end
	end
end

function StagePracticePointMediator:pushTeamView(pointData)
	local view = self:getInjector():getInstance("StagePracticeTeamView")

	local function battleCallback()
		return
	end

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stagePoint = pointData ~= nil and pointData or self._curPointData,
		battleCallback = battleCallback
	}))
end

function StagePracticePointMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

function StagePracticePointMediator:onCellClicked(sender, eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		self._curSelectIndex = idx
	end
end

function StagePracticePointMediator:onGetRewardClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local mapId = self._curMapData:getId()
		local curPointId = self._curPointData:getId()
		local pointData = self._stagePracticeSystem:getPointById(mapId, curPointId)

		if not pointId and pointData:getFirstPassState() == SPracticeRewardState.kCanGet then
			self._stagePracticeSystem:getPointReward(mapId, curPointId)
		end
	end
end

function StagePracticePointMediator:onClickInfo(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._tipNode:setVisible(true)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._tipNode:setVisible(false)
	end
end

function StagePracticePointMediator:onClickChallage(sender, eventType, pointId)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local pos = self._tableView:getContentOffset().x

		self._stagePracticeSystem:setOffsetX(pos)

		local mapId = self._curMapData:getId()

		if not pointId then
			::label_58_0::

			local curPointId = self._curPointData:getId()
			local pointData = self._stagePracticeSystem:getPointById(mapId, curPointId)

			if pointData:getConfig().SkipMatrix ~= 1 then
				self:pushTeamView(pointData)
			else
				self._stagePracticeSystem:requestBattleBefore(mapId, curPointId, nil, nil)
			end
		end
	end
end

function StagePracticePointMediator:refreshViewByGetReward(event)
	local data = event:getData()
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = data.rewards
	}))
	self:refreshData()
	self._tableView:updateCellAtIndex(self._curPointIndex - 1)
	self:refreshPointPanel()
end

function StagePracticePointMediator:refreshViewByResChange(event)
	self:refreshCostPanel()
end

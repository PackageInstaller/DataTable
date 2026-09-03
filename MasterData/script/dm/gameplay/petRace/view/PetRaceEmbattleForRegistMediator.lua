-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceEmbattleForRegistMediator.lua

PetRaceEmbattleForRegistMediator = class("PetRaceEmbattleForRegistMediator", DmAreaViewMediator)

PetRaceEmbattleForRegistMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceEmbattleForRegistMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
PetRaceEmbattleForRegistMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
PetRaceEmbattleForRegistMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kCellWidth, kCellHeight, kCellGap = 350, 148, 5
local kBtnHandlers = {
	["Panel_bottom.Image_ButtonBg.sortBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickSort"
	},
	["Panel_bottom.Image_ButtonBg.sortTypeBtn"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickSortType"
	}
}
local SortOrder = {
	Strings:get("HEROS_UI32"),
	Strings:get("HEROS_UI33")
}
local heroShowSortList = {
	Strings:get("HEROS_UI31"),
	Strings:get("HEROS_UI30"),
	Strings:get("HEROS_UI29"),
	Strings:get("HEROS_UI5"),
	Strings:get("HEROS_UI49")
}
local embattle_up_max_distance = 50
local embattle_down_max_distance = 100
local costLimit = 15

function PetRaceEmbattleForRegistMediator:onClickOneKey(sender, eventType)
	local state = self._petRaceSystem:getMyMatchState()

	if state ~= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))

		return
	end

	local function callback(response)
		self:showTip(Strings:get("Petrace_Text_15"))
		self:updateData()
		self:updataEmbattleInfo()
		self:tableViewReloadData(self._tableView)
		self:refreshListView()
	end

	self._petRaceSystem:fastEmbattle(callback, nil, true)
end

function PetRaceEmbattleForRegistMediator:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceEmbattleForRegistMediator:onEmbattleFinish(response)
	self:updateData()
	self:updataEmbattleInfo()
	self:tableViewReloadData(self._tableView)
	self:refreshListView()
	self:showTip(Strings:get("Petrace_Text_15"))
end

function PetRaceEmbattleForRegistMediator:onSendToSave(sendData)
	sendData = sendData or {}

	local state = self._petRaceSystem:getMyMatchState()

	if state ~= 0 then
		self:updateData()
		self:updataEmbattleInfo()
		self:showTip(Strings:get("Petrace_Text_13"))

		return
	end

	local function callfun(response)
		self:onEmbattleFinish(response)
	end

	self._petRaceSystem:embattle(callfun, {
		embattle = sendData
	}, true)
end

function PetRaceEmbattleForRegistMediator:initialize()
	super.initialize(self)

	self._selectIndex = 1
	self._embattleIcon = {}
	self._touchEmbattleIcon = nil
end

function PetRaceEmbattleForRegistMediator:dispose()
	if self._schedule_update then
		LuaScheduler:getInstance():unschedule(self._schedule_update)
	end

	super.dispose(self)
end

function PetRaceEmbattleForRegistMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	costLimit = self._petRaceSystem:getMaxCost()
	self._maxNumLimit = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_MaxHeros", "content")

	self:updateData()
	self._petRaceSystem:forceResetEmbattle(function(response)
		self:onEmbattleFinish(response)
	end)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._btn_one_key = self:bindWidget("Button_oneKey", TwoLevelViceButton, {
		handler = {
			func = bind1(self.onClickOneKey, self)
		}
	})

	self:getView():getChildByFullName("Text_des_embattle"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	AdjustUtils.ignorSafeAreaRectForNode(self:getView():getChildByFullName("Panel_bottom.Image_ButtonBg"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self:getView():getChildByFullName("Button_oneKey"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(self:getView():getChildByFullName("Text_des_embattle"), AdjustUtils.kAdjustType.Right)
end

function PetRaceEmbattleForRegistMediator:updateData()
	local originalEmbattleInfo = self._petRaceSystem:getEmbattleInfo()

	self._embattleInfo = {}

	local tempTable = table.deepcopy(originalEmbattleInfo)

	for i = 1, #tempTable do
		table.insert(self._embattleInfo, tempTable[i].embattle)
	end

	self._restHeros = self._petRaceSystem:getRestHeros()
	self._restHeros = self._stageSystem:getSortExtendIds(self._restHeros)
end

function PetRaceEmbattleForRegistMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
end

function PetRaceEmbattleForRegistMediator:enterWithData(data)
	self._cardsExcept = {}
	self._cardsRecommend = {}
	self._sortType = 1
	self._endTime = self._petRaceSystem:getRoundEndTime() or 0

	self:setupView()
	self:createFrame9Pos()
	self:createTeamTableView()
	self:updataEmbattleInfo()
	self:createRestHerosTableView()
	self:updateCdTime()
	self:createAnim()
end

function PetRaceEmbattleForRegistMediator:updateCdTime()
	local function update()
		self._petRaceSystem:updateTimeDes(self._node_time, 0, PetRaceEnum.state.embattle, self._endTime)
	end

	self._schedule_update = LuaScheduler:getInstance():schedule(function()
		update()
	end, 1, true)

	update()
end

function PetRaceEmbattleForRegistMediator:createFrame9Pos()
	self._frame9Pos = {}

	for i = 1, 9 do
		local locatorNode = self._node_frame9:getChildByName("Node_pos_" .. i)
		local x, y = locatorNode:getPosition()

		table.insert(self._frame9Pos, {
			x = x,
			y = y
		})
	end
end

function PetRaceEmbattleForRegistMediator:dealMoveInBattle()
	local minDistance = 99999
	local minPos = 1

	for i = 1, 9 do
		local targetPos = self._frame9Pos[i]
		local curPosX, curPosy = self._touchEmbattleIcon:getPosition()
		local distance = cc.pGetDistance(cc.p(targetPos.x, targetPos.y), cc.p(curPosX, curPosy))

		if distance <= minDistance then
			minDistance = distance
			minPos = i
		end
	end

	local key = minPos .. ""
	local sendData = self:getSaveData()
	local curTeamInfo = sendData[self._selectIndex]

	if minDistance > embattle_down_max_distance then
		if curTeamInfo and curTeamInfo[self._touchEmbattleIcon.key] then
			curTeamInfo[self._touchEmbattleIcon.key] = nil
		end

		self:onSendToSave(sendData)
	elseif minDistance < embattle_up_max_distance then
		if curTeamInfo[key] then
			curTeamInfo[key] = curTeamInfo[self._touchEmbattleIcon.key]
			curTeamInfo[self._touchEmbattleIcon.key] = curTeamInfo[key]
		else
			curTeamInfo[key] = curTeamInfo[self._touchEmbattleIcon.key]
			curTeamInfo[self._touchEmbattleIcon.key] = nil
		end

		self:onSendToSave(sendData)
	else
		self:updataEmbattleInfo()
	end
end

function PetRaceEmbattleForRegistMediator:dealMoveRestHeroIcon()
	local minDistance = 99999
	local minPos = 1

	for i = 1, 9 do
		local targetPos = self._frame9Pos[i]

		targetPos = cc.p(targetPos.x, targetPos.y)

		local curPosX, curPosy = self._touchEmbattleIcon:getPosition()
		local curPos = cc.p(curPosX, curPosy)
		local distance = cc.pGetDistance(targetPos, curPos)

		if distance < minDistance then
			minDistance = distance
			minPos = i
		end
	end

	local key = minPos .. ""

	if not self._embattleInfo[self._selectIndex] then
		local teamInfo = {}
		local curTeamInfo = table.deepcopy(teamInfo)
		local touchHeroId = self._touchEmbattleIcon.touchHeroId
		local sendData = self:getSaveData()

		if not sendData[self._selectIndex] then
			local curSendData = {}

			if minDistance < embattle_up_max_distance and touchHeroId then
				local success = false

				if curTeamInfo[key] then
					curTeamInfo[key] = self:getEmbattleHeroInfo(touchHeroId)

					local cost = self._petRaceSystem:getTeamCostByEmbattle(curTeamInfo)

					if cost > costLimit then
						success = false

						self:showTip(Strings:get("Petrace_Text_6"))
					else
						curSendData[key] = touchHeroId
						success = true
					end
				else
					curTeamInfo[key] = self:getEmbattleHeroInfo(touchHeroId)

					local cost = self._petRaceSystem:getTeamCostByEmbattle(curTeamInfo)

					if table.nums(curTeamInfo) > self._maxNumLimit then
						success = false

						self:showTip(string.format(Strings:get("Petrace_Text_17"), self._maxNumLimit))
					elseif cost > costLimit then
						success = false

						self:showTip(Strings:get("Petrace_Text_6"))
					else
						curSendData[key] = touchHeroId
						success = true
					end
				end

				if success then
					self:onSendToSave(sendData)
				end
			end

			self._touchEmbattleIcon:removeFromParent()

			self._touchEmbattleIcon = nil
		end
	end
end

function PetRaceEmbattleForRegistMediator:dealMove()
	if self._touchEmbattleIcon.isInBattle then
		self:dealMoveInBattle()
		AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)
	else
		self:dealMoveRestHeroIcon()
	end
end

function PetRaceEmbattleForRegistMediator:onTouchBegan(touch, event)
	local pt = touch:getLocation()

	for index = 1, 9 do
		local k = tostring(index)

		if self._embattleIcon[k] then
			local v = self._embattleIcon[k]
			local rect = v:getBoundingBox()

			if cc.rectContainsPoint(rect, v:getParent():convertToNodeSpace(pt)) then
				self._touchEmbattleIcon = v

				AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

				break
			end
		end
	end

	if not self._touchEmbattleIcon then
		for i = 0, #self._restHeros do
			local cell = self._tableView2:cellAtIndex(i)

			if i ~= 0 and cell then
				local view = cell:getChildByTag(12138)

				if view and view:getParent() and view.id ~= "" then
					local rect = view:getBoundingBox()

					if cc.rectContainsPoint(rect, view:getParent():convertToNodeSpace(pt)) then
						local roleModel = view.roleModel
						local isAwaken = view.awakenLevel and view.awakenLevel > 0 or false
						local hero = RoleFactory:createHeroAnimation(roleModel, isAwaken and "stand1" or "stand")

						hero:setAnchorPoint(cc.p(0.5, 0))
						hero:setScale(0.7)

						local localPos = self._node_container:convertToNodeSpace(view:getParent():convertToWorldSpace(cc.p(view:getPosition())))

						hero:setPosition(localPos.x, localPos.y)
						hero:setOpacity(125)
						hero:setVisible(false)
						self._node_container:addChild(hero)

						self._touchEmbattleIcon = hero
						self._touchEmbattleIcon.touchHeroId = view.id

						break
					end
				end
			end
		end
	end

	if self._touchEmbattleIcon then
		local x, y = self._touchEmbattleIcon:getPosition()

		self._touchEmbattleIcon.originalPos = {
			x = x,
			y = y
		}

		self._touchEmbattleIcon:setLocalZOrder(99)

		return true
	end

	return false
end

function PetRaceEmbattleForRegistMediator:onTouchMoved(touch, event)
	local curp = touch:getLocation()
	local startP = touch:getStartLocation()
	local diffx, diffy = curp.x - startP.x, curp.y - startP.y
	local localPos = self._touchEmbattleIcon:getParent():convertToNodeSpace(curp)

	if not self._touchEmbattleIcon.isInBattle then
		if math.abs(diffy) > 20 then
			self._touchEmbattleIcon:setVisible(true)
			self.listener:setSwallowTouches(true)
			self._touchEmbattleIcon:setPosition(localPos)
		end
	else
		self._touchEmbattleIcon:setPosition(localPos)
		AudioEngine:getInstance():playEffect("Se_Click_Move", false)
	end
end

function PetRaceEmbattleForRegistMediator:onTouchEnded(touch, event)
	local touchPoint = touch:getLocation()

	self:dealMove()

	if self._touchEmbattleIcon then
		self._touchEmbattleIcon:setLocalZOrder(0)

		self._touchEmbattleIcon = nil
	end

	self.listener:setSwallowTouches(false)
end

function PetRaceEmbattleForRegistMediator:onTouchCanceled(touch, event)
	if self._touchEmbattleIcon then
		local pos = self._touchEmbattleIcon.originalPos

		self._touchEmbattleIcon:setPosition(pos.x, pos.y)
		self._touchEmbattleIcon:setLocalZOrder(0)

		if not self._touchEmbattleIcon.isInBattle then
			self._touchEmbattleIcon:removeFromParent()
		end
	end

	self._touchEmbattleIcon = nil

	self.listener:setSwallowTouches(false)
end

function PetRaceEmbattleForRegistMediator:registerTouchEvent()
	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return self:onTouchBegan(touch, event)
		elseif eventType == ccui.TouchEventType.moved then
			self:onTouchMoved(touch, event)
		elseif eventType == ccui.TouchEventType.ended then
			self:onTouchEnded(touch, event)
		else
			self:onTouchCanceled(touch, event)
		end
	end

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(false)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_CANCELLED)

	local touchPanel = self:getView():getChildByName("Panel_touch")

	touchPanel:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, touchPanel)
end

function PetRaceEmbattleForRegistMediator:updataEmbattleInfo()
	if not self._embattleInfo[self._selectIndex] then
		self._node_container:removeAllChildren()

		self._embattleIcon = {}

		for k, v in pairs(self._embattleInfo[self._selectIndex]) do
			local heroId = v.heroId
			local pos = self._frame9Pos[tonumber(k)]
			local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)

			roleModel = v.surfaceId and v.surfaceId ~= "" and ConfigReader:getDataByNameIdAndKey("Surface", v.surfaceId, "Model") or roleModel

			local isAwaken = v.awakenLevel and v.awakenLevel > 0 or false
			local hero = RoleFactory:createHeroAnimation(roleModel, isAwaken and "stand1" or "stand")

			hero:addTo(self._node_container, tonumber(k))
			hero:setPosition(pos.x, pos.y)
			hero:setAnchorPoint(cc.p(0.5, 0))
			hero:setScale(0.5)

			hero.originalPos = pos
			hero.key = k
			hero.isInBattle = true
			self._embattleIcon[hero.key] = hero
		end
	end
end

function PetRaceEmbattleForRegistMediator:tableViewReloadData(view)
	local offset = view:getContentOffset()

	view:reloadData()
	view:setContentOffset(offset)
end

function PetRaceEmbattleForRegistMediator:createTeamTableView()
	local listLocator = self._panel_base:getChildByFullName("Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._embattleInfo
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return kCellWidth + kCellGap, kCellHeight
	end

	local function cellAtIndex(table, index)
		local data = {}
		local dataIndex = index + 1

		if not self._embattleInfo[dataIndex] then
			data.teamInfo = {
				self._embattleInfo[dataIndex]
			}
			data.index = dataIndex
			data.combatInfo = {
				self._petRaceSystem:getTeamCombatByEmbattle(self._embattleInfo[dataIndex])
			}
			data.costInfo = {
				self._petRaceSystem:getTeamCostByEmbattle(self._embattleInfo[dataIndex])
			}
			data.speedInfo = {
				self._petRaceSystem:getTeamSpeedByEmbattle(self._embattleInfo[dataIndex])
			}
			data.selectIndex = self._selectIndex
			data.limit = costLimit

			function data.touchCallBack(dataIndex)
				if dataIndex == self._selectIndex or self._tableView:isTouchMoved() then
					return
				end

				AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

				self._selectIndex = dataIndex

				self:tableViewReloadData(self._tableView)
				self:updataEmbattleInfo()
			end

			data.mediator = self

			local cell = table:dequeueCell()

			if cell == nil then
				cell = cc.TableViewCell:new()

				cell:setContentSize(cc.size(kCellWidth, kCellHeight))

				local roleInfoCell = self:getInjector():instantiate("PetRaceTeamCellForRegist", data)

				cell.m_RenderNode = roleInfoCell

				cell:addChild(roleInfoCell:getView())
			end

			cell.m_RenderNode:update(data, dataIndex)

			return cell
		end
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(listLocator:getPosition())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView = tableView

	listLocator:removeFromParent(true)
	self._tableView:reloadData()
end

function PetRaceEmbattleForRegistMediator:createRestHerosTableView()
	local listLocator = self._view:getChildByFullName("Panel_bottom.my_pet_bg.Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._restHeros + 1
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		if idx + 1 == 1 then
			return 110, 220
		end

		return 180, 220
	end

	local function cellAtIndex(table, index)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._myPetClone:clone()

			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setPosition(cc.p(0, 0))
			node:setTag(12138)
		end

		local cell_node = self:createTeamCell(cell, index + 1)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setPositionX(listLocator:getPositionX() - viewSize.width / 2)
	tableView:setPositionY(listLocator:getPositionY())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView2 = tableView

	listLocator:removeFromParent(true)
	self:refreshListView()
end

function PetRaceEmbattleForRegistMediator:initViewInfo()
	return
end

function PetRaceEmbattleForRegistMediator:setupView()
	self:setupTopInfoWidget()

	self._panel_base = self:getView():getChildByName("Panel_base")
	self._node_frame9 = self._panel_base:getChildByName("Node_frame9")
	self._node_container = self._node_frame9:getChildByFullName("Node_container")
	self._node_time = self:getView():getChildByName("Node_time")
	self._node_anim = self:getView():getChildByName("Node_anim")

	self._node_frame9:setLocalZOrder(10)

	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._text_sortType = self:getView():getChildByFullName("Panel_bottom.Image_ButtonBg.sortBtn.text")
	self._sortPanel = self:getView():getChildByFullName("Panel_bottom.Image_ButtonBg.sortnode")

	local sortOrder = self:getView():getChildByFullName("Panel_bottom.Image_ButtonBg.sortTypeBtn.text")

	sortOrder:setString(Strings:get("Team_Screen"))
	self:registerTouchEvent()
	self:createSortView()
end

function PetRaceEmbattleForRegistMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kHonor,
			CurrencyIdKind.kDiamond
		},
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("Petrace")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function PetRaceEmbattleForRegistMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1")
		self:dismiss()
	end
end

function PetRaceEmbattleForRegistMediator:createTeamCell(cell, index)
	local node = cell:getChildByTag(12138)

	node.id = ""
	node.roleModel = ""

	local children = node:getChildren()

	for i = 1, #children do
		children[i]:setVisible(index ~= 1)
	end

	if index == 1 then
		return
	end

	node:setVisible(true)

	local id = self._restHeros[index - 1]

	node.id = id

	local heroInfo = self:getHeroInfoById(id)

	heroInfo.id = heroInfo.roleModel
	node.roleModel = heroInfo.roleModel
	node.awakenLevel = heroInfo.awakenLevel

	self:initHero(node, heroInfo)

	return node
end

function PetRaceEmbattleForRegistMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return {}
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rareity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		maxStar = heroInfo:getMaxStar(),
		littleStar = heroInfo:getLittleStar(),
		awakenLevel = heroInfo:getAwakenStar(),
		identityAwakenLevel = heroInfo:getIdentityAwakenLevel()
	}
end

function PetRaceEmbattleForRegistMediator:getEmbattleHeroInfo(heroId)
	local heroData = {}
	local heroInfo = self._heroSystem:getHeroById(heroId)

	if heroInfo then
		heroData.level = heroInfo:getLevel()
		heroData.heroId = heroInfo:getId()
		heroData.star = heroInfo:getStar()
		heroData.starId = heroInfo:getStarId()
		heroData.qualityId = heroInfo:getQualityId()
		heroData.rarity = heroInfo:getRarity()
		heroData.quality = heroInfo:getQuality()
		heroData.speed = heroInfo:getSpeed()
	end

	return heroData
end

function PetRaceEmbattleForRegistMediator:initHero(node, info)
	info.id = info.roleModel

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = info.id
	})

	heroPanel:addChild(heroImg)
	heroImg:setScale(0.68)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = node:getChildByName("bg")
	local bg2 = node:getChildByName("bg1")
	local rarity = node:getChildByFullName("rarityBg.rarity")

	rarity:ignoreContentAdaptWithSize(true)
	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):center(rarity:getContentSize())
	rarityAnim:setScale(1)
	rarityAnim:offset(0, -6)
	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local level = node:getChildByName("level")

	level:setString("Lv." .. info.level)

	local starBg = node:getChildByName("starBg")
	local size = cc.size(148, 32)
	local width = size.width - (size.width / HeroStarCountMax - 2) * (HeroStarCountMax - info.maxStar)

	starBg:setContentSize(cc.size(width, size.height))

	for i = 1, HeroStarCountMax do
		local star = starBg:getChildByName("star_" .. i)

		star:setVisible(i <= info.maxStar)

		local path = i <= info.star and "img_yinghun_img_star_full.png" or i == info.star + 1 and info.littleStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

		if info.awakenLevel > 0 then
			path = "jx_img_star.png"

			if i <= info.identityAwakenLevel then
				path = "yinghun_img_awake_star.png"
			end
		end

		star:ignoreContentAdaptWithSize(true)
		star:setScale(0.4)
		star:loadTexture(path, 1)
	end

	local namePanel = node:getChildByFullName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")

	name:setString(info.name)
	qualityLevel:setString(info.qualityLevel == 0 and "" or " +" .. info.qualityLevel)
	name:setPositionX(0)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
	GameStyle:setHeroNameByQuality(name, info.quality)
	GameStyle:setHeroNameByQuality(qualityLevel, info.quality)
end

function PetRaceEmbattleForRegistMediator:checkIsRecommend(id)
	for i = 1, #self._cardsRecommend do
		if self._cardsRecommend[i] == id then
			return true
		end
	end

	return false
end

function PetRaceEmbattleForRegistMediator:createSortView()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local sortType = self._sortType

	local function callBack(data)
		local sortStr = stageSystem:getSortTypeStr(data.sortType)

		self._text_sortType:setString(sortStr)

		self._sortType = data.sortType

		self:refreshListView()
	end

	self._sortComponent = SortHeroListComponent:new({
		isHide = false,
		sortType = sortType,
		mediator = self,
		mainNode = self._sortPanel,
		callBack = callBack
	})

	self._sortPanel:setLocalZOrder(99999)

	local sortStr = stageSystem:getSortTypeStr(sortType)

	self._text_sortType:setString(sortStr)
end

function PetRaceEmbattleForRegistMediator:onClickSort()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:showNormal()
	self._sortComponent:refreshView()
end

function PetRaceEmbattleForRegistMediator:onClickSortType()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:showExtand()

	self._restHeros = self._petRaceSystem:getRestHeros()

	self:refreshListView()
end

function PetRaceEmbattleForRegistMediator:refreshViewBySort()
	self:updateData()
	self:refreshListView()
end

function PetRaceEmbattleForRegistMediator:refreshListView()
	local sortType = self._sortType

	self._heroSystem:sortHeroes(self._restHeros, sortType, self._cardsRecommend)

	local offsetX = self._tableView2:getContentOffset().x + self._myPetClone:getContentSize().width

	if offsetX > 0 then
		offsetX = 0
	end

	self._tableView2:reloadData()
	self._tableView2:setContentOffset(cc.p(offsetX, 0))
end

function PetRaceEmbattleForRegistMediator:getCD(targetTime)
	return math.floor(targetTime - self._gameServerAgent:remoteTimestamp())
end

function PetRaceEmbattleForRegistMediator:getSaveData()
	local sendData = {}

	for k1, v1 in pairs(self._embattleInfo) do
		local dataBase = {}

		sendData[k1] = dataBase

		for k2, v2 in pairs(v1) do
			dataBase[k2] = v2.heroId
		end
	end

	return sendData
end

function PetRaceEmbattleForRegistMediator:createAnim()
	local anim = cc.MovieClip:create("all_shengshizhengba")

	anim:setPlaySpeed(2)
	anim:addTo(self._node_anim)
	anim:gotoAndPlay(0)
	anim:addEndCallback(function(cid, mc)
		mc:gotoAndPlay(0)
	end)

	local jjAnim = cc.MovieClip:create("jingjirukou_jingjirukou")

	jjAnim:setPosition(cc.p(0, 0))
	self._node_anim:addChild(jjAnim)
	jjAnim:addCallbackAtFrame(12, function()
		jjAnim:stop()
	end)
end

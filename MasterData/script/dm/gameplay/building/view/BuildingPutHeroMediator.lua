-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingPutHeroMediator.lua

BuildingPutHeroMediator = class("BuildingPutHeroMediator", DmPopupViewMediator)

BuildingPutHeroMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingPutHeroMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kCellWidth, kCellHeight = 180, 231
local _putHeroNum = 4
local kBtnHandlers = {
	button_back = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	},
	sortBtn = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickSort"
	},
	["Node_AddInfo.btn_showBuffTip"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickShowBuffTip"
	},
	["Node_AddInfo.btn_showLoveTip"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickShowLoveTip"
	},
	["Node_AddInfo.Node_BuffTips.Panel_touch"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickHideTip"
	},
	["Node_AddInfo.Node_LoveTips.Panel_touch"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickHideTip"
	}
}

function BuildingPutHeroMediator:initialize()
	super.initialize(self)
end

function BuildingPutHeroMediator:dispose()
	super.dispose(self)
end

function BuildingPutHeroMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BuildingPutHeroMediator:enterWithData(data)
	self._roomId = data.roomId
	self._sortType = 1
	self._sortOrder = 2
	self._heroSystem = self._developSystem:getHeroSystem()

	self._buildingSystem:setSortExtand(0)

	if not self._buildingSystem:getRoomOpenSta(self._roomId) then
		self._roomId = self._buildingSystem:getFristRoomId()

		self:dispatch(Event:new(BUILDING_ROOM_MOVE, {
			time = 0.1,
			roomId = self._roomId
		}))
	end

	self._curTabType = -1
	self._heroList = {}
	self._viewWorldPos = self:getView():convertToWorldSpace(cc.p(0, 0))

	self:setupView()
	self:createTableView()
	self:createTabControl()
	self:refreshView()
	self:resetHeroList()
	self:registerTouchEvent()
	self:mapEventListeners()
	self:createSortView()
	self:setupClickEnvs()
	self:onClickHideTip()
end

function BuildingPutHeroMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_PUTHEROS_SUCCESS, self, self.resetHeroListByOffset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.resetHeroList)
end

function BuildingPutHeroMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabBtnClone = self:getView():getChildByFullName("button")
	self._scrollLayer = self._mainPanel:getChildByName("Panel")
	self._text_sortType = self:getView():getChildByFullName("sortBtn.text")
	self._sortPanel = self:getView():getChildByFullName("sortnode")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")

	local var_6_0 = bindWidget
	local var_6_1 = self
	local var_6_2 = self._mainPanel:getChildByFullName("node_bg")
	local var_6_3 = PopupNormalTabWidget
	local var_6_4 = {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("Building_UI_Laying")
	}

	var_6_4.title1 = getCurrentLanguage() ~= GameLanguageType.CN and "" or Strings:get("UITitle_EN_Fangzhi")
	var_6_4.fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil

	var_6_0(var_6_1, var_6_2, var_6_3, var_6_4)
end

function BuildingPutHeroMediator:onBackClicked(sender, eventType)
	self:close()
end

function BuildingPutHeroMediator:refreshView()
	self:refreshBuffShow()
end

function BuildingPutHeroMediator:createTabControl()
	local roomIdList = self._buildingSystem:getSortRoomIdList("PutSort")

	self._tabBtnControl = roomIdList

	if #roomIdList > 0 then
		local config = {
			onClickTab = function(name, tag)
				self:onClickTab(name, tag)
			end
		}
		local data = {}
		local curTabType = 1

		for i = 1, #roomIdList do
			local textdes = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomIdList[i], "Name")
			local textdes1 = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomIdList[i], "ENName")

			data[#data + 1] = {
				tabText = Strings:get(textdes),
				tabTextTranslate = Strings:get(textdes1)
			}

			if roomIdList[i] == self._roomId then
				curTabType = i
			end
		end

		config.btnDatas = data

		local injector = self:getInjector()
		local widget = TabBtnWidget:createWidgetNode()

		self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

		self._tabBtnWidget:adjustScrollViewSize(0, 470)
		self._tabBtnWidget:initTabBtn(config, {
			ignoreSound = true,
			noCenterBtn = true,
			ignoreRedSelectState = true
		})
		self._tabBtnWidget:selectTabByTag(curTabType)
		self._tabBtnWidget:removeTabBg()
		self._tabBtnWidget:scrollTabPanel(curTabType)

		local view = self._tabBtnWidget:getMainView()

		view:addTo(self._tabpanel):posite(0, 0)
		view:setLocalZOrder(1100)
	end
end

function BuildingPutHeroMediator:onClickTab(name, selectTag)
	if self._curTabType ~= selectTag then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		self._curTabType = selectTag
		self._roomId = self._tabBtnControl[selectTag]

		self:resetHeroList()

		if self._roomId ~= self._buildingSystem:getShowRoomId() then
			self:dispatch(Event:new(BUILDING_ROOM_MOVE, {
				time = 0.05,
				roomId = self._roomId
			}))
		end
	end
end

function BuildingPutHeroMediator:resetHeroList()
	self._heroList, self._roomheroList = self._buildingSystem:getPutHeroList()

	self:refreshListView()
	self._tableView:reloadData()
	self:refreshUseHero()
	self:refreshView()
end

function BuildingPutHeroMediator:resetHeroListByOffset()
	self._heroList, self._roomheroList = self._buildingSystem:getPutHeroList()

	local offsetX = self._tableView:getContentOffset().x

	if offsetX > 0 then
		offsetX = 0
	end

	self:refreshListView()
	self._tableView:reloadData()
	self._tableView:setContentOffset(cc.p(offsetX, 0))
	self:refreshUseHero()
	self:refreshView()
end

function BuildingPutHeroMediator:createTableView()
	local viewSize = self._scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._heroList + 1
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		if idx + 1 == 1 then
			return kCellWidth - 70, kCellHeight
		end

		return kCellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local realCell = self:getInjector():getInstance("BuildingPutHeroCell")

			cell.m_cellMediator = self:getInjector():instantiate("BuildingPutHeroCell", {
				view = realCell
			})

			cell.m_cellMediator:initView()
			cell:addChild(realCell)
		end

		if index == 1 then
			cell.m_cellMediator:getView():setVisible(false)
		else
			local info = {}

			info.heroId = self._heroList[index - 1]
			info.roomId = self._roomId

			cell.m_cellMediator:getView():setVisible(true)
			cell.m_cellMediator:update(info)
		end

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setPosition(self._scrollLayer:getPosition())
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._scrollLayer:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView = tableView
end

local rarityAnimOffset = {
	[15] = {
		2,
		0
	},
	[14] = {
		2,
		0
	},
	[13] = {
		-6,
		0
	},
	[12] = {
		-7,
		0
	},
	[11] = {
		-7,
		0
	}
}

function BuildingPutHeroMediator:refreshUseHero()
	local num = _putHeroNum
	local room = self._buildingSystem:getRoom(self._roomId)
	local heroList = room:getHeroList()

	self._heroSystem = self._developSystem:getHeroSystem()

	for i = 1, num do
		local panel = self._mainPanel:getChildByName("Panel_" .. i)
		local node_hero = panel:getChildByFullName("Node_hero")
		local image_1 = panel:getChildByFullName("Image_1")
		local image_2 = panel:getChildByFullName("Image_2")

		image_1:setVisible(true)
		image_2:setVisible(false)
		node_hero:setVisible(false)

		if heroList[i] then
			image_1:setVisible(false)
			image_2:setVisible(true)

			local heroNode = node_hero:getChildByFullName("Node_hero")

			heroNode:removeAllChildren()

			local heroId = heroList[i]
			local heroInfo = self._heroSystem:getHeroById(heroId)
			local isAwaken = heroInfo:getAwakenStar() > 0

			node_hero:setVisible(true)

			local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
			local hero = self._heroSystem:getHeroById(heroId)
			local hero = RoleFactory:createHeroAnimation((hero or nil) and hero:getModel(), isAwaken and "stand1" or "stand")

			hero:setAnchorPoint(cc.p(0.5, 0))
			heroNode:addChild(hero)
			hero:setScale(0.7)

			local rarity = node_hero:getChildByName("Node_rarity")

			rarity:removeAllChildren()

			local rarityAnim = IconFactory:getHeroRarityAnim(heroInfo:getRarity())

			if rarityAnim then
				rarityAnim:setScale(0.45)
				rarityAnim:addTo(rarity):center(rarity:getContentSize()):offset(rarityAnimOffset[heroInfo:getRarity()][1], rarityAnimOffset[heroInfo:getRarity()][2])
			end

			local lovelevelNum = self._heroSystem:getLoveLevelById(heroId)
			local loveLevel = node_hero:getChildByFullName("loveLevel")

			loveLevel:enableOutline(cc.c4b(60, 80, 20, 127), 2)
			loveLevel:setString(lovelevelNum)

			local loveExp = self._heroSystem:getHeroById(heroId):getLoveExp()
			local maxexp = self._heroSystem:getNextLoveExp(heroId, lovelevelNum)
			local percent = node_hero:getChildByFullName("loading")
			local text_loveNum = node_hero:getChildByFullName("loveNum")
			local per = loveExp / maxexp * 100

			percent:setPercent(per)
			text_loveNum:setString(loveExp .. "/" .. maxexp)

			if self._heroSystem:isLoveLevelMax(heroId) then
				text_loveNum:setString("Max")
			end

			local partyImg = node_hero:getChildByFullName("partyImg")
			local partyPath = IconFactory:getHeroPartyPath(heroId, "building")

			if partyPath then
				partyImg:loadTexture(partyPath)
			end

			local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroId)
			local heroConfig = heroPrototype:getConfig()
			local star = heroInfo:getStar()
			local starBg = node_hero:getChildByName("Node_star")

			for i = 1, HeroStarCountMax do
				local _star = starBg:getChildByName("star_" .. i)

				_star:setVisible(false)

				if i <= star then
					_star:setVisible(true)

					if isAwaken then
						_star:loadTexture("jx_img_star.png", ccui.TextureResType.plistType)
					else
						_star:loadTexture("img_yinghun_img_star_full.png", ccui.TextureResType.plistType)
					end
				end
			end

			local buffAddNumText = node_hero:getChildByName("buffAddNum")
			local buffAddNum, buffAddDesc = self._buildingSystem:getBuildPutHeroAddBuff(self._roomId, {
				heroId
			})

			buffAddNumText:setString("+" .. buffAddDesc)
		end
	end
end

function BuildingPutHeroMediator:registerTouchEvent()
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

function BuildingPutHeroMediator:onTouchBegan(touch, event)
	local pt = touch:getLocation()
	local view = self:getView()
	local num = _putHeroNum
	local room = self._buildingSystem:getRoom(self._roomId)
	local heroList = room:getHeroList()

	for i = 1, num do
		if heroList[i] then
			local panel = self._mainPanel:getChildByName("Panel_" .. i)
			local worlPanelPos = panel:convertToWorldSpace(cc.p(0, 0))
			local panelSize = panel:getContentSize()

			if pt.x > worlPanelPos.x and pt.y > worlPanelPos.y and pt.x < worlPanelPos.x + panelSize.width and pt.y < worlPanelPos.y + panelSize.height then
				local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroList[i])
				local hero = RoleFactory:createHeroAnimation(roleModel)

				hero:setAnchorPoint(cc.p(0.5, 0.5))
				hero:setScale(0.7)

				local localPos = cc.p(pt.x - self._viewWorldPos.x, pt.y - self._viewWorldPos.y - 30)

				hero:setPosition(localPos.x, localPos.y)
				hero:setOpacity(125)
				hero:setVisible(false)
				view:addChild(hero)

				self._touchEmbattleIcon = hero
				self._touchEmbattleIcon.id = heroList[i]

				break
			end
		end
	end

	if not self._touchEmbattleIcon then
		for i = 0, #self._heroList do
			local cell = self._tableView:cellAtIndex(i)

			if i ~= 0 and cell then
				local m_cellMediator = cell.m_cellMediator

				if m_cellMediator and m_cellMediator._heroId and m_cellMediator._heroId ~= "" then
					local heroNode = m_cellMediator:getView()
					local worldCellPos = heroNode:convertToWorldSpace(cc.p(0, 0))

					if pt.x > worldCellPos.x and pt.y > worldCellPos.y and pt.x < worldCellPos.x + kCellWidth and pt.y < worldCellPos.y + kCellHeight then
						local putRoomId = self._buildingSystem:getHeroPutRoomId(m_cellMediator._heroId)

						if putRoomId then
							do
								local textdes = Strings:get(ConfigReader:getDataByNameIdAndKey("VillageRoom", putRoomId, "Name"))

								self:dispatch(ShowTipEvent({
									duration = 0.2,
									tip = Strings:get("Building_HeroPosition", {
										room = textdes
									})
								}))
							end

							break
						end

						do
							local roleModel = IconFactory:getRoleModelByKey("HeroBase", m_cellMediator._heroId)
							local hero = RoleFactory:createHeroAnimation(roleModel)

							hero:setAnchorPoint(cc.p(0.5, 0.5))
							hero:setScale(0.7)

							local localPos = cc.p(pt.x, pt.y - 30)

							hero:setPosition(localPos.x - self._viewWorldPos.x, localPos.y - self._viewWorldPos.y)
							hero:setOpacity(125)
							hero:setVisible(false)
							view:addChild(hero)

							self._touchEmbattleIcon = hero
							self._touchEmbattleIcon.isInPut = true
							self._touchEmbattleIcon.id = m_cellMediator._heroId
						end

						break
					end
				end
			end
		end
	end

	if self._touchEmbattleIcon then
		self._touchEmbattleIcon:setLocalZOrder(99)

		return true
	end

	return false
end

function BuildingPutHeroMediator:onTouchMoved(touch, event)
	if self._touchEmbattleIcon then
		local curp = touch:getLocation()

		self._touchEmbattleIcon:setVisible(true)
		self._touchEmbattleIcon:setPosition(cc.p(curp.x - self._viewWorldPos.x, curp.y - self._viewWorldPos.y))

		if not self._touchEmbattleIcon.isInPut then
			self.listener:setSwallowTouches(true)
		end
	end
end

function BuildingPutHeroMediator:onTouchEnded(touch, event, isGuiding)
	if self._touchEmbattleIcon then
		local endPos = touch:getLocation()
		local beganPos = touch:getStartLocation()

		if not isGuiding and math.abs(beganPos.x - endPos.x) < 20 and math.abs(beganPos.y - endPos.y) < 20 then
			if self._touchEmbattleIcon.isInPut then
				self:dealForceInPut()
			else
				self:dealMoveRestHeroIcon(true)
			end
		else
			self:dealMove()
		end

		self._touchEmbattleIcon:removeFromParent()

		self._touchEmbattleIcon = nil
	end

	self.listener:setSwallowTouches(false)
end

function BuildingPutHeroMediator:onTouchCanceled(touch, event)
	if self._touchEmbattleIcon then
		if not self._touchEmbattleIcon.isInPut then
			self:refreshUseHero()
		end

		self._touchEmbattleIcon:removeFromParent()

		self._touchEmbattleIcon = nil
	end

	self.listener:setSwallowTouches(false)
end

function BuildingPutHeroMediator:dealMove()
	if self._touchEmbattleIcon.isInPut then
		self:dealMoveInPut()
	else
		self:dealMoveRestHeroIcon()
	end
end

function BuildingPutHeroMediator:dealMoveRestHeroIcon(force)
	local ptX = self._touchEmbattleIcon:getPositionX() + self._viewWorldPos.x
	local ptY = self._touchEmbattleIcon:getPositionY() + self._viewWorldPos.y
	local worlPanelPos = self._scrollLayer:convertToWorldSpace(cc.p(0, 0))
	local panelSize = self._scrollLayer:getContentSize()

	if force or ptX > worlPanelPos.x and ptY > worlPanelPos.y and ptX < worlPanelPos.x + panelSize.width and ptY < worlPanelPos.y + panelSize.height then
		local room = self._buildingSystem:getRoom(self._roomId)
		local heroList = room._heroList
		local listNow = table.deepcopy({}, heroList)

		for k, v in pairs(listNow) do
			if v == self._touchEmbattleIcon.id then
				listNow[k] = nil
			end
		end

		local list = {}

		for k, v in pairs(listNow) do
			list[#list + 1] = v
		end

		local params = {}

		params.roomId = self._roomId
		params.heroes = list

		self._buildingSystem:sendPutHeroes(params, true)
		AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)

		return
	end
end

function BuildingPutHeroMediator:dealMoveInPut()
	local index = 0
	local ptX = self._touchEmbattleIcon:getPositionX() + self._viewWorldPos.x
	local ptY = self._touchEmbattleIcon:getPositionY() + self._viewWorldPos.y
	local num = _putHeroNum

	for i = 1, num do
		local panel = self._mainPanel:getChildByName("Panel_" .. i)
		local worlPanelPos = panel:convertToWorldSpace(cc.p(0, 0))
		local panelSize = panel:getContentSize()

		if ptX > worlPanelPos.x and ptY > worlPanelPos.y and ptX < worlPanelPos.x + panelSize.width and ptY < worlPanelPos.y + panelSize.height then
			index = i

			break
		end
	end

	if index > 0 then
		local heroId = self._touchEmbattleIcon.id
		local room = self._buildingSystem:getRoom(self._roomId)
		local heroList = room._heroList
		local listNow = table.deepcopy({}, heroList)

		listNow[index] = heroId

		local list = {}

		for k, v in pairs(listNow) do
			list[#list + 1] = v
		end

		local params = {}

		params.roomId = self._roomId
		params.heroes = list

		self._buildingSystem:sendPutHeroes(params, true)

		if self._putHeroAudio then
			AudioEngine:getInstance():stopEffect(self._putHeroAudio)

			self._putHeroAudio = nil
		end

		local audioName = "Voice_" .. heroId .. "_62"

		self._putHeroAudio = AudioEngine:getInstance():playEffect(audioName, false)

		AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)
	end
end

function BuildingPutHeroMediator:dealForceInPut()
	local room = self._buildingSystem:getRoom(self._roomId)
	local heroList = room._heroList

	if table.nums(heroList) < _putHeroNum then
		local heroId = self._touchEmbattleIcon.id
		local listNow = table.deepcopy({}, heroList)

		listNow[self._touchEmbattleIcon.id] = heroId

		local list = {}

		for k, v in pairs(listNow) do
			list[#list + 1] = v
		end

		local params = {}

		params.roomId = self._roomId
		params.heroes = list

		self._buildingSystem:sendPutHeroes(params, true)

		if self._putHeroAudio then
			AudioEngine:getInstance():stopEffect(self._putHeroAudio)

			self._putHeroAudio = nil
		end

		local audioName = "Voice_" .. heroId .. "_62"

		self._putHeroAudio = AudioEngine:getInstance():playEffect(audioName, false)

		AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)
	end
end

function BuildingPutHeroMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()
		local scriptName = guideAgent:getCurrentScriptName()

		if scriptName == "guide_Village_Building_8" then
			local children = self._tableView:getContainer():getChildren()

			if children[2] and children[2].m_cellMediator then
				local card1Node = children[2].m_cellMediator:getView():getChildByName("hero")
				local panel1 = self._mainPanel:getChildByName("Panel_1")
				local node_hero = panel1:getChildByFullName("Node_hero.Node_hero")

				if card1Node and node_hero then
					storyDirector:setClickEnv("buildingPutHeroView.card1Node", card1Node, function(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							return self:onTouchBegan(sender, eventType)
						elseif eventType == ccui.TouchEventType.moved then
							self:onTouchMoved(sender, eventType)
						elseif eventType == ccui.TouchEventType.ended then
							self:onTouchEnded(sender, eventType, true)
						else
							self:onTouchCanceled(sender, eventType)
						end
					end)
					storyDirector:setClickEnv("buildingPutHeroView.node_hero", node_hero, function()
						return
					end)

					local __refreshView = self.refreshView
					local this = self

					function self.refreshView()
						__refreshView(this)

						local room = this._buildingSystem:getRoom(this._roomId)
						local heroList = room:getHeroList()

						if heroList[1] then
							this:getView():runAction(cc.CallFunc:create(function()
								storyDirector:notifyWaiting("exit_buildingPutHeroView_dragEnd")
							end))

							this.refreshView = __refreshView
						end
					end
				end
			end
		end

		storyDirector:notifyWaiting("enter_buildingPutHero_view")
	end))

	self:getView():runAction(sequence)
end

function BuildingPutHeroMediator:refreshListView()
	local sortType = self._sortType

	self._buildingSystem:sortHeroes(self._heroList, sortType, nil, self._roomId)
	self._buildingSystem:sortHeroes(self._roomheroList, sortType, nil, self._roomId)

	for __, id in ipairs(self._roomheroList) do
		self._heroList[#self._heroList + 1] = id
	end
end

function BuildingPutHeroMediator:createSortView()
	local sortType = self._sortType

	local function callBack(data)
		self._sortType = data.sortType

		local sortStr = self._buildingSystem:getSortTypeStr(self._sortType)

		self._text_sortType:setString(sortStr)
		self._sortComponent:getRootNode():setVisible(false)
		self:resetHeroList()
	end

	self._sortComponent = BuildingSortHeroListComponent:new({
		isHide = true,
		sortType = sortType,
		mediator = self,
		mainNode = self._sortPanel,
		callBack = callBack
	})

	self._sortPanel:setLocalZOrder(99999)

	local sortStr = self._buildingSystem:getSortTypeStr(self._sortType)

	self._text_sortType:setString(sortStr)
end

function BuildingPutHeroMediator:onClickSort()
	self._buildingSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:refreshView()
	self:resetHeroList()
end

function BuildingPutHeroMediator:refreshBuffTip(panel)
	local node_des = panel:getChildByFullName("Node_des")

	node_des:removeAllChildren()

	local bg = panel:getChildByFullName("bg")
	local posY = -1
	local widthMax = 0
	local numIndex = 1
	local build_Benefit_Detail = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Build_Benefit_Detail", "content")

	if build_Benefit_Detail and build_Benefit_Detail[self._roomId] then
		local desData = build_Benefit_Detail[self._roomId]

		for index, desList in pairs(desData) do
			local richTextIndex = ccui.RichText:createWithXML("<outline color='#000000' size = '1'><font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#ffffff'>" .. index .. "、</font></outline>", {})

			richTextIndex:setAnchorPoint(cc.p(0, 1))
			richTextIndex:setPosition(cc.p(0, posY))
			richTextIndex:addTo(node_des)
			richTextIndex:renderContent()

			for _, des in pairs(desList) do
				local richTextInfo = {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M
				}

				if numIndex == 1 then
					richTextInfo.num1 = _putHeroNum

					local buffNum, buffDes = self._buildingSystem:getAddBuffByBuffLv(self._roomId, self._buildingSystem:getRoomMaxBuffLv(self._roomId) * _putHeroNum)

					richTextInfo.num2 = buffDes
				elseif numIndex == 7 then
					local rarityList = {
						num1 = "14",
						num3 = "12",
						num2 = "13"
					}
					local putEffectValue = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "PutEffectValue") or {}

					if putEffectValue.party then
						for __k, __v in pairs(rarityList) do
							if putEffectValue.party[__v] then
								local buffNum, buffDes = self._buildingSystem:getAddBuffByBuffLv(self._roomId, putEffectValue.party[__v])

								richTextInfo[__k] = buffDes
							end
						end
					end
				end

				local richText = ccui.RichText:createWithXML(Strings:get(des, richTextInfo), {})

				richText:setAnchorPoint(cc.p(0, 1))
				richText:setPosition(cc.p(31, posY))
				richText:addTo(node_des)
				richText:renderContent()

				posY = posY - 30

				local size = richText:getContentSize()

				if widthMax < size.width then
					widthMax = size.width
				end

				numIndex = numIndex + 1
			end
		end
	end

	if posY < 0 and widthMax > 0 then
		bg:setContentSize(cc.size(widthMax + 65, 0 - posY + 20))
	end
end

function BuildingPutHeroMediator:refreshLoveTip(panel)
	local node_des = panel:getChildByFullName("Node_des")

	node_des:removeAllChildren()

	local bg = panel:getChildByFullName("bg")
	local posY = -1
	local widthMax = 0
	local numIndex = 1
	local desData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Impression_Increase_Detail", "content")

	for index, desList in pairs(desData) do
		local richTextIndex = ccui.RichText:createWithXML("<outline color='#000000' size = '1'><font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#ffffff'>" .. index .. "、</font></outline>", {})

		richTextIndex:setAnchorPoint(cc.p(0, 1))
		richTextIndex:setPosition(cc.p(0, posY))
		richTextIndex:addTo(node_des)
		richTextIndex:renderContent()

		for _, des in pairs(desList) do
			local richTextInfo = {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M
			}

			if numIndex == 2 then
				local allComfort = self._buildingSystem:getAllComfort()

				richTextInfo.num1 = allComfort

				local village_RoomHeroLove = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_RoomHeroLove", "content")

				village_RoomHeroLove = village_RoomHeroLove * 100
				richTextInfo.num = village_RoomHeroLove - allComfort % village_RoomHeroLove
			end

			richTextInfo.time = TimeUtil:getSystemResetDate()

			local richText = ccui.RichText:createWithXML(Strings:get(des, richTextInfo), {})

			richText:setAnchorPoint(cc.p(0, 1))
			richText:setPosition(cc.p(31, posY))
			richText:addTo(node_des)
			richText:renderContent(480, 0, true)

			local size = richText:getContentSize()

			posY = posY - size.height

			if widthMax < size.width then
				widthMax = size.width
			end

			numIndex = numIndex + 1
		end
	end

	if posY < 0 and widthMax > 0 then
		bg:setContentSize(cc.size(widthMax + 65, 0 - posY + 20))
	end
end

function BuildingPutHeroMediator:refreshBuffShow()
	local node_addLove = self:getView():getChildByFullName("Node_AddInfo.Node_addLove")
	local text_love = node_addLove:getChildByFullName("Text_num")
	local love = self._buildingSystem:getRoomAddLove(self._roomId)

	text_love:setString("+" .. love)

	local node_addBuff = self:getView():getChildByFullName("Node_AddInfo.Node_addBuff")
	local text_buff = node_addBuff:getChildByFullName("Text_num")
	local rommPartyImg = node_addBuff:getChildByFullName("roomPartyImg")
	local room = self._buildingSystem:getRoom(self._roomId)
	local heroList = room:getHeroList()
	local buffAddNum, buffAddDesc = self._buildingSystem:getBuildPutHeroAddBuff(self._roomId, heroList)

	if self._buffAddRoomId and self._buffAddNum and self._buffAddRoomId == self._roomId and tonumber(self._buffAddNum) < tonumber(buffAddNum) then
		local animBuff = cc.MovieClip:create("anim_shuzitisheng")

		animBuff:setPosition(410, 583)
		node_addBuff:addChild(animBuff, 9999)
		animBuff:addEndCallback(function()
			animBuff:stop()
			animBuff:removeFromParent()
		end)
	end

	self._buffAddRoomId = self._roomId
	self._buffAddNum = buffAddNum

	text_buff:setString("+" .. buffAddDesc)

	local roomParty = self._buildingSystem:getRoomParty(self._roomId)

	if roomParty then
		rommPartyImg:loadTexture(IconFactory:getPartyPath(roomParty, "building"))
	end

	local buff_text_1 = node_addBuff:getChildByFullName("Text_1")
	local buff_text_2 = node_addBuff:getChildByFullName("Text_2")
	local buff_image = node_addBuff:getChildByFullName("Image")
	local putFunctionDesc = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "PutFunctionDesc") or {}

	buff_text_2:setString(Strings:get(putFunctionDesc))

	local putEffect = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "PutEffect")
	local putEffectType = putEffect.type
	local putEffectId = putEffect.id
	local effectConfig = ConfigReader:getRecordById(putEffectType, putEffectId)
	local buffDes = effectConfig.Name

	buff_text_1:setString(Strings:get(buffDes))

	local parameter = effectConfig.Parameter

	buff_image:setPosition(cc.p(392, 583))
	buff_image:setScale(1)

	if putEffectType == "SkillSpecialEffect" then
		local parameterType = parameter.type

		if parameterType == "DeckCost" then
			buff_image:loadTexture("icon_bg_ka_xiyoudi_new.png", ccui.TextureResType.plistType)
			buff_image:setPosition(cc.p(392, 576))
		elseif parameterType == "GoldOreElevate" then
			buff_image:loadTexture("icon_jinbi_1.png", ccui.TextureResType.plistType)
		elseif parameterType == "CrystalOreElevate" then
			buff_image:loadTexture("icon_shuijing_1.png", ccui.TextureResType.plistType)
		elseif parameterType == "ExpOreElevate" then
			buff_image:loadTexture("icon_jingyan.png", ccui.TextureResType.plistType)
		end
	else
		buff_image:loadTexture("zhujue_bg_shuxing_3.png", ccui.TextureResType.plistType)
		buff_image:setPosition(cc.p(392, 580))
		buff_image:setScale(1.2)
	end
end

function BuildingPutHeroMediator:onClickShowBuffTip()
	local tipPanel = self:getView():getChildByFullName("Node_AddInfo.Node_BuffTips")

	self:refreshBuffTip(tipPanel)
	tipPanel:setVisible(true)
end

function BuildingPutHeroMediator:onClickShowLoveTip()
	local tipPanel = self:getView():getChildByFullName("Node_AddInfo.Node_LoveTips")

	self:refreshLoveTip(tipPanel)
	tipPanel:setVisible(true)
end

function BuildingPutHeroMediator:onClickHideTip()
	local buffTips = self:getView():getChildByFullName("Node_AddInfo.Node_BuffTips")

	buffTips:setVisible(false)

	local loveTips = self:getView():getChildByFullName("Node_AddInfo.Node_LoveTips")

	loveTips:setVisible(false)
end

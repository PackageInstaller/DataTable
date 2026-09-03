-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingSubOrcInfoMediator.lua

BuildingSubOrcInfoMediator = class("BuildingSubOrcInfoMediator", DmPopupViewMediator)

BuildingSubOrcInfoMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingSubOrcInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingSubOrcInfoMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {
	["main.Button_1"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BuildingSubOrcInfoMediator:initialize()
	super.initialize(self)
end

function BuildingSubOrcInfoMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingSubOrcInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingSubOrcInfoMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), SUBORC_LVUP_BUILDING_SUC, self, self.onRefreshViewEvent)
	self.mapEventListener(self, self:getEventDispatcher(), SUBORC_LVUP_CANEL_BUILDING_SUC, self, self.onRefreshViewEvent)
	self.mapEventListener(self, self:getEventDispatcher(), SUBORC_LVUP_FINISH_BUILDING_SUC, self, self.onRefreshViewEvent)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_FINISH_BUILDING_SUC, self, self.onOtherViewEvent)
end

function BuildingSubOrcInfoMediator:enterWithData(data)
	self._buildingId = data.buildingId
	self._roomId = data.roomId
	self._id = data.id
	self._buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	self._subOrcList = self._buildingData._subOreList

	local _ordersubOrcList = {}

	for k, v in pairs(self._subOrcList) do
		local _tabData = {}

		_tabData.id = v.id
		_tabData.level = v.level
		_ordersubOrcList[#_ordersubOrcList + 1] = _tabData
	end

	table.sort(_ordersubOrcList, function(a, b)
		return a.level > b.level
	end)

	self._ordersubOrcList = _ordersubOrcList
	self._chooseIndex = 1

	self:setupView()
	self:createTableView()
	self:refreshView()
	self:mapEventListeners()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:tick()
	end, 1, false)
end

function BuildingSubOrcInfoMediator:tick()
	local subOrcId = self._ordersubOrcList[self._chooseIndex].id
	local subOrcInfo = self._subOrcList[subOrcId]
	local status = subOrcInfo.status

	if status == KBuildingStatus.kLvUp then
		local endTime = subOrcInfo.finishTime
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local des1, des2 = self._buildingSystem:getTimeText(endTime - timeNow)

		self._text_timeNum:setString(des2)

		local cost = self:getOrcLvUpImmediate(subOrcInfo)
		local costNum = self._layout2:getChildByFullName("cost.costvalue1")

		costNum:setString(cost)
	end
end

function BuildingSubOrcInfoMediator:getOrcLvUpImmediate(orcInfo)
	local cost = 9999999
	local endTime = orcInfo.finishTime
	local timeNow = self._gameServerAgent:remoteTimestamp()
	local freeTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_FreeCompleteTime", "content")

	if freeTime >= endTime - timeNow then
		cost = 0
	else
		local nextBuilding = ConfigReader:getDataByNameIdAndKey("VillageSubOre", orcInfo.levelConfigId, "NextId")

		if nextBuilding then
			cost = ConfigReader:getDataByNameIdAndKey("VillageSubOre", nextBuilding, "UpgradeTimeDiamond") or 0
		end
	end

	return cost
end

function BuildingSubOrcInfoMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	self:bindBackBtnFlash(self._mainPanel, cc.p(915, 485))

	local config = self._buildingSystem:getBuildingConfig(self._buildingId)

	self._bgWidget = bindWidget(self, "main.tipNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Building_Expend"),
		bgSize = {
			width = 841,
			height = 485
		}
	})
	self._buildinglevel = self._mainPanel:getChildByFullName("level")
	self._buildinglevelDes = self._mainPanel:getChildByFullName("lvDes")
	self._buildinglevelDesNext = self._mainPanel:getChildByFullName("lvDes_next")
	self._buildinglevelNext = self._mainPanel:getChildByFullName("level_next")
	self._image_lv = self._mainPanel:getChildByFullName("Image_lv")
	self._layout1 = self._mainPanel:getChildByFullName("layout1")
	self._layout2 = self._mainPanel:getChildByFullName("layout2")
	self._text_lvMax = self._mainPanel:getChildByFullName("Text_lvMax")
	self._node_time = self._mainPanel:getChildByFullName("timeBg")
	self._text_timeDes = self._node_time:getChildByFullName("des")
	self._text_timeNum = self._node_time:getChildByFullName("time")

	local sourcepanel_1 = self._layout1:getChildByFullName("sourcepanel_1")
	local sourcepanel_2 = self._layout1:getChildByFullName("sourcepanel_2")

	GameStyle:runCostAnim(sourcepanel_1)
	GameStyle:runCostAnim(sourcepanel_2)
	self:bindWidget("main.layout1.btnlevelup", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelup, self)
		}
	})
	self:bindWidget("main.layout2.btncancel", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelCanel, self)
		}
	})
	self:bindWidget("main.layout2.btnfinish", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelFinish, self)
		}
	})

	self._cloneCell = self:getView():getChildByName("cloneCell")

	local maxLevelId = config.MaxLevel
	local maxLevel = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", maxLevelId, "Level")
	local nextEffectCfg = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", maxLevelId, "Factor1")
	local orcOonfig = ConfigReader:getRecordById("SkillSpecialEffect", nextEffectCfg[1])
	local defSubOrcId = orcOonfig.Parameter.ID

	self._maxSubOrcNum = SpecialEffectFormula:getAddNumByConfig(orcOonfig, 1, maxLevel)
	self._defImageName = ConfigReader:getDataByNameIdAndKey("VillageSubOre", defSubOrcId, "Img")
end

function BuildingSubOrcInfoMediator:createTableView()
	local container = self._mainPanel:getChildByName("viceOrcView")
	local tableView = cc.TableView:create(container:getContentSize())

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 300, 108
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:updateCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(self._maxSubOrcNum / 3)
	end

	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	container:addChild(tableView)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView
end

function BuildingSubOrcInfoMediator:updateCell(cell, index)
	cell:removeAllChildren()

	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(300, 108))
	layout:setAnchorPoint(0, 0)
	layout:addTo(cell):setName("main")
	layout:setSwallowTouches(false)

	local begin = 3 * index - 2
	local tail = 3 * index

	for i = begin, tail do
		if i <= self._maxSubOrcNum then
			local cell = self._cloneCell:clone()

			cell:setSwallowTouches(false)
			cell:setTag(i)

			local onGray = cell:getChildByName("onGray")
			local image = onGray:getChildByName("buildImage")

			if i <= #self._ordersubOrcList then
				local id = self._ordersubOrcList[i].id
				local info = self._subOrcList[id]

				onGray:getChildByName("Lv"):setString("Lv" .. info.level)

				local imageName = ConfigReader:getDataByNameIdAndKey("VillageSubOre", info.levelConfigId, "Img")

				image:loadTexture("asset/ui/building/" .. imageName .. ".png", ccui.TextureResType.localType)

				local function callFunc(sender)
					local oldIndex = self._chooseIndex
					local _i = sender:getTag()

					if oldIndex == _i then
						return
					end

					local line = math.ceil(oldIndex / 3)
					local layout = self._tableView:cellAtIndex(line - 1)

					if layout then
						local cell = layout:getChildByName("main"):getChildByTag(oldIndex)

						cell:getChildByName("select"):setVisible(false)
					end

					self._chooseIndex = _i

					sender:getChildByName("select"):setVisible(true)
					self:refreshView()
				end

				mapButtonHandlerClick(nil, cell, {
					ignoreClickAudio = true,
					func = callFunc
				})
			else
				onGray:setSaturation(-100)
				onGray:getChildByName("Lv"):setVisible(false)
				image:loadTexture("asset/ui/building/" .. self._defImageName .. ".png", ccui.TextureResType.localType)
			end

			cell:addTo(layout)
			cell:setPosition(cc.p(4 + (i - begin) * 100, 5))

			if self._chooseIndex == i then
				cell:getChildByName("select"):setVisible(true)
			end
		end
	end
end

function BuildingSubOrcInfoMediator:refreshView()
	local selectOrcId = self._ordersubOrcList[self._chooseIndex].id
	local _info = self._subOrcList[selectOrcId]
	local lvConfig = ConfigReader:getRecordById("VillageSubOre", _info.levelConfigId)

	if lvConfig.NextId and lvConfig.NextId ~= "" then
		self._node_time:setVisible(true)
		self._image_lv:setVisible(true)
		self._buildinglevelDesNext:setVisible(true)
		self._buildinglevelNext:setVisible(true)

		if _info.status == KBuildingStatus.kNone then
			self._layout1:setVisible(true)
			self._layout2:setVisible(false)
			self._text_lvMax:setVisible(false)

			local btnlevelup = self._layout1:getChildByFullName("btnlevelup.button")
			local levelDes = self._layout1:getChildByFullName("Text_des")
			local nextLv = ConfigReader:getDataByNameIdAndKey("VillageSubOre", lvConfig.NextId, "LevelCondition")

			if nextLv <= self._buildingData._level then
				btnlevelup:setGray(false)
				btnlevelup:setTouchEnabled(true)
				levelDes:setString("")
			else
				btnlevelup:setGray(true)
				btnlevelup:setTouchEnabled(false)
				levelDes:setString(Strings:get("Building_MainOrc_Level", {
					num = nextLv
				}))
			end

			local updateTime = ConfigReader:getDataByNameIdAndKey("VillageSubOre", lvConfig.NextId, "UpgradeTime")
			local timeD1, timeD2 = self._buildingSystem:getTimeText(updateTime)

			self._text_timeDes:setString(Strings:get("Building_UI_UpgradeTime"))
			self._text_timeNum:setString(timeD2)

			local sourcepanel_1 = self._layout1:getChildByFullName("sourcepanel_1")
			local sourcepanel_2 = self._layout1:getChildByFullName("sourcepanel_2")
			local upgradeCost = ConfigReader:getDataByNameIdAndKey("VillageSubOre", lvConfig.NextId, "UpgradeCost")

			sourcepanel_1:setVisible(false)

			if upgradeCost[1] then
				local costData = upgradeCost[1]

				sourcepanel_1:setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setString(costData.amount)

				local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costData.type, "Sicon")
				local newIcon = ccui.ImageView:create(iconPath .. ".png", 1)
				local iconpanel = sourcepanel_1:getChildByFullName("costBg.iconpanel")

				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.8)

				local count = self._developSystem:getBagSystem():getItemCount(costData.type)

				if count >= costData.amount then
					sourcepanel_1:getChildByFullName("costBg.bg.enoughImg"):setVisible(true)
				else
					sourcepanel_1:getChildByFullName("costBg.bg.enoughImg"):setVisible(false)
				end
			end

			sourcepanel_2:setVisible(false)

			if upgradeCost[2] then
				local costData = upgradeCost[2]

				sourcepanel_2:setVisible(true)
				sourcepanel_2:getChildByFullName("costBg.cost"):setVisible(true)
				sourcepanel_2:getChildByFullName("costBg.cost"):setString(costData.amount)

				local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costData.type, "Sicon")
				local newIcon = ccui.ImageView:create(iconPath .. ".png", 1)
				local iconpanel = sourcepanel_2:getChildByFullName("costBg.iconpanel")

				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.8)

				local count = self._developSystem:getBagSystem():getItemCount(costData.type)

				if count >= costData.amount then
					sourcepanel_2:getChildByFullName("costBg.bg.enoughImg"):setVisible(true)
				else
					sourcepanel_2:getChildByFullName("costBg.bg.enoughImg"):setVisible(false)
				end
			end
		else
			self._layout1:setVisible(false)
			self._layout2:setVisible(true)
			self._text_lvMax:setVisible(false)
			self._text_timeDes:setString(Strings:get("Building_UI_Upgrading"))
		end
	else
		self._layout1:setVisible(false)
		self._layout2:setVisible(false)
		self._text_lvMax:setVisible(true)
		self._buildinglevelDesNext:setVisible(false)
		self._buildinglevelNext:setVisible(false)
		self._image_lv:setVisible(false)
		self._node_time:setVisible(false)
	end

	self:enableLevelUpDesc(lvConfig)
	self._buildinglevel:setString(_info.level)
	self._buildinglevelNext:setString(_info.level + 1)
	self:tick()
end

function BuildingSubOrcInfoMediator:onRefreshViewEvent(event)
	local data = event:getData()

	if self._roomId ~= data.roomId or self._id ~= data.buildId then
		return
	else
		self._buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
		self._subOrcList = self._buildingData._subOreList

		local id = self._ordersubOrcList[self._chooseIndex].id

		self._tableView:reloadData()

		if id == data.subId then
			self:refreshView()
		end
	end
end

function BuildingSubOrcInfoMediator:onOtherViewEvent(event)
	local data = event:getData()

	if self._roomId ~= data.roomId or self._id ~= data.id then
		return
	else
		self._buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
		self._subOrcList = self._buildingData._subOreList

		self._tableView:reloadData()
		self:refreshView()
	end
end

function BuildingSubOrcInfoMediator:enableLevelUpDesc(data)
	local curLevelInfo = data
	local curEffect = curLevelInfo.Effect
	local nodes = {}

	nodes[#nodes + 1] = self._mainPanel:getChildByFullName("layout3.node1")
	nodes[#nodes + 1] = self._mainPanel:getChildByFullName("layout3.node2")

	local nextLevelId = curLevelInfo.NextId

	if nextLevelId and nextLevelId ~= "" then
		local nextLevelInfo = ConfigReader:getRecordById("VillageSubOre", nextLevelId)

		for i = 1, 2 do
			local effect = curEffect[i]

			if effect then
				local config = ConfigReader:getRecordById("SkillSpecialEffect", effect)
				local descMapId = SpecialEffectDesId[config.Parameter.type]
				local desc = Strings:get(descMapId)
				local attrNum = SpecialEffectFormula:getAddNumByConfig(config, 1, curLevelInfo.Level)
				local nextattrNum = SpecialEffectFormula:getAddNumByConfig(config, 1, nextLevelInfo.Level)
				local mulStr = tostring(nextattrNum - attrNum)

				nodes[i]:setVisible(true)

				local descNode = nodes[i]:getChildByName("desc")
				local actionNode = nodes[i]:getChildByName("action")

				descNode:setString(desc)
				actionNode:setString(attrNum .. "+" .. mulStr)
				actionNode:setPositionX(descNode:getPositionX() + descNode:getContentSize().width + 10)
				nodes[i]:removeChildByTag(1024)

				local func = SpecialEffectIconId[config.Parameter.type]

				if func then
					local icon = func()

					icon:addTo(nodes[i]):setTag(1024)
				end
			else
				nodes[i]:setVisible(false)
			end
		end
	else
		for i = 1, 2 do
			local effect = curEffect[i]

			if effect then
				local config = ConfigReader:getRecordById("SkillSpecialEffect", effect)
				local descMapId = SpecialEffectDesId[config.Parameter.type]
				local desc = Strings:get(descMapId)
				local attrNum = SpecialEffectFormula:getAddNumByConfig(config, 1, curLevelInfo.Level)

				nodes[i]:setVisible(true)

				local descNode = nodes[i]:getChildByName("desc")
				local actionNode = nodes[i]:getChildByName("action")

				descNode:setString(desc)
				actionNode:setString(attrNum)
				actionNode:setPositionX(descNode:getPositionX() + descNode:getContentSize().width + 10)

				local func = SpecialEffectIconId[config.Parameter.type]

				if func then
					local icon = func()

					icon:addTo(nodes[i]):setTag(1024)
				end
			else
				nodes[i]:setVisible(false)
			end
		end
	end
end

function BuildingSubOrcInfoMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingSubOrcInfoMediator:onClicklevelup(sender, eventType)
	local selectOrcId = self._ordersubOrcList[self._chooseIndex].id
	local _info = self._subOrcList[selectOrcId]
	local lvConfig = ConfigReader:getRecordById("VillageSubOre", _info.levelConfigId)
	local upgradeCost = lvConfig.UpgradeCost

	for k, v in pairs(upgradeCost) do
		local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount)

		if not canbuild then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end
	end

	local params = {}

	params.roomId = self._roomId
	params.buildId = self._id
	params.subId = self._ordersubOrcList[self._chooseIndex].id

	self._buildingSystem:sendSubOrcLevelUp(params, true)
	AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
end

function BuildingSubOrcInfoMediator:onClicklevelFinish(sender, eventType)
	local subOrcId = self._ordersubOrcList[self._chooseIndex].id
	local subOrcInfo = self._subOrcList[subOrcId]
	local cost = self:getOrcLvUpImmediate(subOrcInfo)

	if CurrencySystem:checkEnoughDiamond(self, cost) then
		local params = {}

		params.roomId = self._roomId
		params.buildId = self._id
		params.subId = self._ordersubOrcList[self._chooseIndex].id
		params.type = 1

		self._buildingSystem:sendSubOrcFinishLevelUp(params, true)
		AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
	end
end

function BuildingSubOrcInfoMediator:onClicklevelCanel(sender, eventType)
	local subId = self._ordersubOrcList[self._chooseIndex].id
	local data = {
		roomId = self._roomId,
		buildingId = self._buildingId,
		id = self._id,
		subId = subId
	}
	local view = self:getInjector():getInstance("BuildingCancelCheckView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data)

	self:dispatch(event)
	AudioEngine:getInstance():playEffect("Se_Click_Cancle", false)
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeSealMediator.lua

MazeSealMediator = class("MazeSealMediator", DmAreaViewMediator, _M)

MazeSealMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeSealMediator:has("_curSealType", {
	is = "rw"
})

local kBtnHandlers = {
	exitbtn = "onClickExit",
	["heroinfo.Button_1"] = "onClickExitHeroInfo"
}
local kTabBtnsNames = {
	"right_node.bg.tabbtn_1",
	"right_node.bg.tabbtn_2",
	"right_node.bg.tabbtn_3"
}
local kcellTag = 123
local kColumnNum = 6
local kHeroColNum = 5
local kHInterval = 150
local kHeroInterval = 180
local kFirstCellPos = cc.p(0, 0)

function MazeSealMediator:initialize()
	super.initialize(self)
end

function MazeSealMediator:dispose()
	super.dispose(self)
end

function MazeSealMediator:onRegister()
	super.onRegister(self)
	self:initViews()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeSealMediator:mapEventListeners()
	return
end

function MazeSealMediator:onRemove()
	super.onRemove(self)
end

function MazeSealMediator:enterWithData(data)
	self:initData()
	self:initTabBtns()
end

function MazeSealMediator:initViews()
	self._mazeEvent = self._mazeSystem:getMazeEvent()
	self._title = self:getView():getChildByFullName("titlename")
	self._panelList = {}

	for i = 1, 3 do
		self._panelList[i] = self:getView():getChildByFullName("panel_" .. i)

		self._panelList[i]:setVisible(false)
	end

	self:getView():getChildByFullName("panel_1_lock"):setVisible(self._panelList[1]:isVisible())

	self._heroInfo = self:getView():getChildByFullName("heroinfo")

	self._heroInfo:setVisible(false)

	self._main = self:getView()

	self:initHeroView()
	self:initTreasureView()
	self:initEventView()
	self:initEventClick()
end

function MazeSealMediator:initData(data)
	local var_8_0

	if data then
		if data.tabType then
			var_8_0 = data.tabType

			if not data.tabType then
				var_8_0 = 1

				goto label_8_0
			end
		end
	end

	::label_8_0::

	self._tabType = 1

	self._panelList[self._tabType]:setVisible(true)
	self:getView():getChildByFullName("panel_1_lock"):setVisible(self._panelList[1]:isVisible())
end

function MazeSealMediator:initTabBtns()
	self._tabBtns = {}

	for i, name in ipairs(kTabBtnsNames) do
		local btn = self:getView():getChildByFullName(name)

		if btn then
			btn:setTag(i)

			local unlock, tips = self:checkTabUnlock(i)

			btn.unlock = true
			btn.tips = ""
			self._tabBtns[#self._tabBtns + 1] = btn
		end
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(self._tabType)
end

function MazeSealMediator:checkTabUnlock(tab)
	local result, tip
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")

	if tab == 1 then
		result, tip = systemKeeper:isUnlock("PansLabNormal")
	end

	return result, tip
end

function MazeSealMediator:onClickTab(name, tag)
	local btn = self._tabBtns[tag]

	if btn.unlock == false then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = btn.tips
		}))

		return
	end

	self._tabType = tag

	self:changeSealType()
end

function MazeSealMediator:changeSealType()
	for i = 1, 3 do
		self._panelList[i]:setVisible(i == self._tabType)
	end

	self:getView():getChildByFullName("panel_1_lock"):setVisible(self._panelList[1]:isVisible())
end

function MazeSealMediator:initEventView()
	self._cluePanel = self:getView():getChildByFullName("panel_3.eventPanel.cluesPanel")
	self._clueCell = self:getView():getChildByFullName("panel_3.eventPanel.cluesPanel.clueCell")
	self._eventList = {}

	local keys = ConfigReader:getKeysOfTable("PansLabList")

	for k, v in pairs(keys) do
		local config = ConfigReader:getRecordById("PansLabList", v)

		table.insert(self._eventList, config)
	end

	table.sort(self._eventList, function(a, b)
		return a.Position < b.Position
	end)

	self._selectEventId = 1

	self:showSelectEvent(self._selectEventId)
	self:createClueTableView()
end

function MazeSealMediator:initTreasureView()
	self._treasureList = self._mazeSystem:getSealData():getSealTreasureList()

	dump(self._treasureList, "封印-宝物数据")

	self._itemCellClone = self._main:getChildByFullName("cellclone_bw")
	self._itemCellBg = self._main:getChildByFullName("panel_2")
	self._itemTips = self._main:getChildByFullName("panel_2.unlocktips")
	self._treasureInfo = self._main:getChildByFullName("treasurePanel")

	self._treasureInfo:setVisible(false)

	self._treasureInfoClose = self._treasureInfo:getChildByFullName("Button_1")

	self._treasureInfoClose:addTouchEventListener(function(sender, eventType)
		self._treasureInfo:setVisible(false)
	end)

	self._treasureIndexList = {}

	self:getIndexTreasure()
	self._itemTips:setVisible(table.nums(self._treasureList) > 0)
	self:refreshTreasureTableView(self._treasureIndexList)
end

function MazeSealMediator:getIndexTreasure()
	for k, v in pairs(self._treasureList) do
		table.insert(self._treasureIndexList, v)
	end
end

function MazeSealMediator:refreshTreasureTableView(data)
	for k, v in pairs(self._treasureList) do
		table.insert(self._treasureIndexList, v)
	end

	if self._treasureTableView then
		self._treasureTableView:removeFromParent(true)
	end

	local clonePanel = self._itemCellClone
	local size = clonePanel:getContentSize()

	local function numberOfCellsInTableView()
		local num = table.nums(data)

		print("宝物数量--->", num)

		return (math.ceil(num / kColumnNum))
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width + 30, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cellbar = table:dequeueCell()

		if cellbar == nil then
			cellbar = cc.TableViewCell:new()

			for k = 1, kColumnNum do
				local treasureCell = clonePanel:clone()

				treasureCell:setSwallowTouches(false)

				local posX = kFirstCellPos.x + kHInterval * (k - 1)

				treasureCell:setPosition(cc.p(posX, kFirstCellPos.y))
				cellbar:addChild(treasureCell, 0, k)
			end
		end

		for i = 1, kColumnNum do
			local treasureCell = cellbar:getChildByTag(i)
			local curIndex = idx * kColumnNum + i

			if data[curIndex] then
				treasureCell:setVisible(true)
				treasureCell:addTouchEventListener(function(sender, eventType)
					return
				end)
				self:setTreasureCellInfo(treasureCell, curIndex)
			else
				treasureCell:setVisible(false)
			end
		end

		return cellbar
	end

	local cellbgsize = self._itemCellBg:getContentSize()
	local tableView = cc.TableView:create(cellbgsize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	self._itemCellBg:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)

	self._treasureTableView = tableView

	self._treasureTableView:setBounceable(false)
	tableView:reloadData()
end

function MazeSealMediator:setTreasureCellInfo(cell, idx)
	local data = self._treasureIndexList[idx]

	if not data.taskId then
		return
	end

	local oldcell = cell:getChildByTag(kcellTag)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	cell:setTouchEnabled(true)

	local configid = ConfigReader:getDataByNameIdAndKey("PansLabOptionUnlock", data.taskId, "Key")
	local configdata = ConfigReader:getRecordById("PansLabItem", configid)
	local tname = Strings:find(configdata.Name)

	cell:getChildByFullName("name"):setString(tname)
	cell:getChildByFullName("icon"):loadTexture("asset/mazeicon/" .. configdata.Icon .. ".png")

	local desc = self:getDesc(configdata)
	local descNode = cell:getChildByFullName("desc")
	local oldtext = descNode:getChildByTag(666)

	descNode:setContentSize(212, 36)

	if oldtext then
		oldtext:removeFromParent(false)
	end

	if string.find(desc, "+") then
		local descs = string.split(desc, "+")
		local text = ccui.Text:create("+" .. descs[2], TTF_FONT_FZY3JW, 16)

		text:setColor(cc.c3b(170, 240, 20))
		text:setAnchorPoint(cc.p(0, 0))
		text:enableOutline(cc.c4b(35, 15, 5, 76.5), 2)
		descNode:setString(descs[1])

		local startPos = cc.p(descNode:getAutoRenderSize())
		local areasize = descNode:getTextAreaSize()

		descNode:setContentSize(descNode:getStringLength() * 18, math.ceil(descNode:getStringLength() / 13) * 19)
		text:setTag(666)
		text:setPosition(descNode:getStringLength() * 17, -2)
		descNode:addChild(text)
	else
		descNode:setString(self:getDesc(configdata))
	end

	cell:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:showTreasureInfo(cell, tname)
		end
	end)
	cell:getChildByFullName("use"):setVisible(configdata.IsUse == 1)
end

function MazeSealMediator:initHeroView()
	self._heroList = self._mazeSystem:getSealData():getSealHeroList()
	self._isFirstUnLock = true
	self._isFirstLock = true
	self._heroCellClone = self._main:getChildByFullName("cellclone_yh")

	self._heroCellClone:setSwallowTouches(false)

	self._herocCellBg = self._main:getChildByFullName("panel_1")
	self._herocCellLockBg = self._main:getChildByFullName("panel_1_lock")
	self._unlockList = {}
	self._lockList = {}
	self._allList = {}

	local unlockCount = 1
	local lockCount = 1
	local allcount = 1

	for k, v in pairs(self._heroList) do
		self._allList[allcount] = v
		allcount = allcount + 1

		if v.taskStatus > 0 then
			self._unlockList[unlockCount] = v
			unlockCount = unlockCount + 1
		else
			self._lockList[lockCount] = v
			lockCount = lockCount + 1
		end
	end

	for k, v in pairs(self._lockList) do
		self._unlockList[unlockCount + k] = v
	end

	self._allList = self._unlockList

	self:refreshHeroTableView(self._allList, 3)
end

function MazeSealMediator:refreshHeroTableView(data, lockstate)
	if lockstate == 1 then
		if self._heroTableView then
			self._heroTableView:removeFromParent(true)
		end
	elseif lockstate == 2 then
		if self._heroLockTableView then
			self._heroLockTableView:removeFromParent(true)
		end
	elseif lockstate == 3 and self._heroLockTableView then
		self._heroLockTableView:removeFromParent(true)
	end

	local clonePanel = self._heroCellClone
	local size = clonePanel:getContentSize()

	local function numberOfCellsInTableView(table)
		return (math.ceil(#data / kHeroColNum))
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width + 30, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cellbar = table:dequeueCell()

		if cellbar == nil then
			cellbar = cc.TableViewCell:new()

			for k = 1, kHeroColNum do
				local treasureCell = clonePanel:clone()

				treasureCell:setSwallowTouches(false)

				local posX = kFirstCellPos.x + kHeroInterval * (k - 1)

				treasureCell:setPosition(cc.p(posX, kFirstCellPos.y))
				cellbar:addChild(treasureCell, 0, k)
			end
		end

		for i = 1, kHeroColNum do
			local treasureCell = cellbar:getChildByTag(i)
			local curIndex = idx * kHeroColNum + i

			if data[curIndex] then
				treasureCell:setVisible(true)
				treasureCell:addTouchEventListener(function(sender, eventType)
					return
				end)
				self:setHeroCellInfo(treasureCell, curIndex, lockstate)
			else
				treasureCell:setVisible(false)
			end
		end

		return cellbar
	end

	local cellbgsize = self._herocCellBg:getContentSize()
	local tableView = cc.TableView:create(cellbgsize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(0, 0)
	tableView:setDelegate()

	if lockstate == 1 then
		self._herocCellBg:addChild(tableView, 10)
	elseif lockstate == 2 then
		self._herocCellLockBg:addChild(tableView, 10)
	elseif lockstate == 3 then
		self._herocCellBg:addChild(tableView, 10)
	end

	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)

	if lockstate == 1 or lockstate == 3 then
		self._heroTableView = tableView

		self._heroTableView:setBounceable(false)
	elseif lockstate == 2 then
		self._heroLockTableView = tableView

		self._heroLockTableView:setBounceable(false)
	end

	tableView:reloadData()
end

function MazeSealMediator:setHeroCellInfo(cell, idx, lockstate)
	if cell:getChildByTag(668) then
		cell:removeChildByTag(668)
	end

	local oldcell = cell:getChildByTag(idx)

	if oldcell then
		oldcell:setSwallowTouches(false)
		oldcell:removeFromParent(false)
	end

	cell:setSwallowTouches(false)
	cell:addTouchEventListener(function(sender, eventType)
		return
	end)

	local data = self._unlockList[idx]

	if lockstate == 1 then
		data = self._unlockList[idx]
	elseif lockstate == 2 then
		data = self._lockList[idx]
	elseif lockstate == 3 then
		data = self._allList[idx]
	end

	local key = ConfigReader:getDataByNameIdAndKey("PansLabOptionUnlock", data.taskId, "Key")
	local isunlock = data.taskStatus > 0

	if (self._isFirstUnLock or idx == 1) and isunlock then
		if cell:getChildByTag(668) then
			cell:removeChildByTag(668)
		end

		local _unlocktips = self:getView():getChildByFullName("panel_1.unlocktips"):clone()

		_unlocktips:setVisible(true)
		_unlocktips:setPosition(65, 170)
		cell:addChild(_unlocktips)
		_unlocktips:setTag(668)

		self._isFirstUnLock = false
	end

	if self._isFirstLock and not isunlock then
		local _locktips = self:getView():getChildByFullName("panel_1.locktips"):clone()

		_locktips:setVisible(true)
		_locktips:setPosition(65, 170)
		cell:addChild(_locktips)

		self._isFirstLock = false
	end

	local name = Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", key, "Name"))

	cell:getChildByFullName("heroname"):setString(name)

	local node = cell:getChildByFullName("heropanel")
	local aninnode = self._mazeSystem:createOneMasterAni(key, false, true)

	aninnode:setGray(false)
	aninnode:setPosition(0, 0)
	aninnode:setScale(0.7)
	node:removeAllChildren()
	node:addChild(aninnode)
	cell:getChildByFullName("except_3"):setVisible(not isunlock)

	local lockdesc = ""

	if isunlock then
		lockdesc = "已解锁"

		cell:getChildByFullName("desc"):setString("已解锁")
	else
		lockdesc = self:getShortDesc(data.taskId)

		cell:getChildByFullName("except_3.locktext"):setString(lockdesc)
	end

	local rarity = cell:getChildByFullName("rarity")

	rarity:loadTexture(GameStyle:getHeroRarityImage(ConfigReader:getDataByNameIdAndKey("HeroBase", key, "Rareity")), 1)
	rarity:ignoreContentAdaptWithSize(true)

	local touchmask = cell:getChildByFullName("touchmask")

	touchmask:setSwallowTouches(false)
	touchmask:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			print("点击了英魂--->", name)
			self:showHeroInfo(true, {
				id = key,
				hname = name,
				hlockdesc = lockdesc,
				hrarity = key
			})
		end
	end)
end

function MazeSealMediator:showHeroInfo(show, data)
	self._heroInfo:setVisible(show)

	local heroCell = self._heroInfo:getChildByFullName("cellclone")

	self._heroInfo:getChildByFullName("cellclone.heropanel"):removeAllChildren()

	if show then
		self._heroInfo:getChildByFullName("name"):setString(data.hname)
		self._heroInfo:getChildByFullName("unlock_con"):setString(data.hlockdesc)
		self._heroInfo:getChildByFullName("dw_con"):setString(Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", data.id, "Position")))

		local node = heroCell:getChildByFullName("heropanel")
		local aninnode = self._mazeSystem:createOneMasterAni(data.id, false, true)

		aninnode:setGray(false)
		aninnode:setPosition(0, 0)
		aninnode:setScale(0.7)
		node:removeAllChildren()
		node:addChild(aninnode)

		local rarity = heroCell:getChildByFullName("rarity")

		rarity:loadTexture(GameStyle:getHeroRarityImage(ConfigReader:getDataByNameIdAndKey("HeroBase", data.id, "Rareity")), 1)
		rarity:ignoreContentAdaptWithSize(true)

		local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(data.id)
		local heroConfig = heroPrototype:getConfig()
		local occupationName, occupationIcon = GameStyle:getHeroOccupation(heroConfig.Type)
		local oicon = self._heroInfo:getChildByFullName("occupationicon")

		oicon:loadTexture(occupationIcon)

		local skills = {
			"NormalSkill",
			"ProudSkill",
			"UniqueSkill",
			"PassiveSkill1",
			"PassiveSkill2",
			"BattlePassiveSkill"
		}
		local skillpanel = self._heroInfo:getChildByFullName("skillpanel")

		for k, v in pairs(skills) do
			local skillid = ConfigReader:getDataByNameIdAndKey("HeroBase", data.id, v)
			local newSkillNode = IconFactory:createHeroSkillIcon({
				isLock = false,
				id = skillid
			}, {
				hideLevel = true,
				isWidget = true
			})

			newSkillNode:setScale(0.4)
			newSkillNode:setPosition(10 + k * 75, 50)

			local skdesc = skillpanel:getChildByFullName("skilldesc"):clone()
			local sktype = Strings:get(ConfigReader:getDataByNameIdAndKey("Skill", skillid, "Type"))
			local skillTypeArr = ConfigReader:getRecordById("ConfigValue", "Hero_SkillName").content
			local typename = Strings:get(skillTypeArr[tostring(sktype)])

			skdesc:setString(typename)
			skdesc:setPosition(10 + k * 75, 10)
			skillpanel:addChild(skdesc)
			skillpanel:addChild(newSkillNode)
		end
	end
end

function MazeSealMediator:getDesc(_config)
	local effectId = _config.SkillAttrEffect
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local level = 1

	if not effectConfig then
		local specialeff = ConfigReader:getRecordById("SkillSpecialEffect", _config.SkillSpecialEffect)
		local descValue = Strings:get(_config.SpecialDesc)
		local factorMap = ConfigReader:getRecordById("PansLabItem", _config.Id)
		local t = TextTemplate:new(descValue)
		local funcMap = {
			linear = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[1] + (level - 1) * value[2]
			end,
			fixed = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[1]
			end,
			custom = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[level]
			end,
			scale = function(value, rate, base)
				return value * rate / (base or 1)
			end
		}

		return (t:stringify(factorMap, funcMap))
	end

	local effectDesc = effectConfig.EffectDesc
	local descValue = Strings:get(effectDesc)
	local factorMap = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local t = TextTemplate:new(descValue)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return (t:stringify(factorMap, funcMap))
end

function MazeSealMediator:getShortDesc(configid)
	local desc = ConfigReader:getDataByNameIdAndKey("PansLabOptionUnlock", configid, "ConditionDesc")
	local transDesc = Strings:get(desc)
	local factorMap = ConfigReader:getRecordById("PansLabOptionUnlock", configid)
	local t = TextTemplate:new(transDesc)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return t:stringify(factorMap, funcMap)
end

function MazeSealMediator:createClueTableView()
	local scrollPanel = self:getView():getChildByFullName("panel_3.eventPanel.cluesPanel")
	local cellPanel = self:getView():getChildByFullName("panel_3.eventPanel.cluesPanel.clueCell")
	local tableView = cc.TableView:create(cc.size(774, 242))

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return cellPanel:getContentSize().width, cellPanel:getContentSize().height + 5
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = cellPanel:clone()

			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(123)

			local cell_Old = cell:getChildByTag(123)

			self:createClueCell(cell_Old, idx + 1)
			cell:setTag(idx)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createClueCell(cell_Old, idx + 1)
			cell:setTag(idx)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self:getSelectEventClues(self._selectEventId)
	end

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	scrollPanel:addChild(tableView, 20)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function MazeSealMediator:createClueCell(cell, idx)
	cell:setTouchEnabled(false)

	local clues = self:getSelectEventClues(self._selectEventId)
	local cluesName, cluesDesc = self._mazeEvent:getClueNameById(self._eventList[self._selectEventId].Id, idx)
	local cluedesc = cell:getChildByName("clueInfo")

	if not self:haveGetClue(clues[idx]) then
		cluedesc:setString(cluesName .. " 未解锁")
		cluedesc:getVirtualRenderer():disableEffect()
		cluedesc:setColor(cc.c3b(147, 137, 135))
	else
		cluedesc:setString(cluesName .. " " .. cluesDesc)
		cluedesc:setColor(cc.c3b(255, 255, 255))
		cluedesc:getVirtualRenderer():enableUnderline(1)
	end
end

function MazeSealMediator:initEventClick()
	for i = 1, 6 do
		self:resetOtherSelect(1)

		local eventBtn = self:getView():getChildByFullName("panel_3.eventBtn_" .. i)

		eventBtn:getChildByFullName("select"):setVisible(false)

		local title = self:getView():getChildByFullName("panel_3.eventPanel.title")
		local pro = eventBtn:getChildByFullName("pro")
		local nameid = self._eventList[self._selectEventId].StoryName
		local name = Strings:get(nameid)

		eventBtn:getChildByFullName("text"):setString(name)
		title:setString(name)
		pro:setString(self:getGetClueNum(i) .. "/" .. #self:getSelectEventClues(i))
		eventBtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				self._selectEventId = i

				self:resetOtherSelect(i)
				self:showSelectEvent(i)
			end
		end)
	end
end

function MazeSealMediator:resetOtherSelect(selectid)
	for i = 1, 6 do
		local eventBtn = self:getView():getChildByFullName("panel_3.eventBtn_" .. i)

		eventBtn:getChildByFullName("select"):setVisible(selectid == i)
	end
end

function MazeSealMediator:haveGetClue(clueid)
	local getclues = self._mazeSystem:getCluesByEventId(self._eventList[self._selectEventId].Id)

	if getclues then
		for k, v in pairs(getclues) do
			if v == clueid then
				return true
			end
		end

		return false
	else
		return false
	end
end

function MazeSealMediator:getGetClueNum(eid)
	local getclues = self._mazeSystem:getCluesByEventId(self._eventList[eid].Id)

	if getclues then
		return table.nums(getclues) or 0
	else
		return 0
	end
end

function MazeSealMediator:getSelectEventClues(index)
	return self._eventList[index].ClueList
end

function MazeSealMediator:showSelectEvent(index)
	local title = self:getView():getChildByFullName("panel_3.eventPanel.title")
	local pro = self:getView():getChildByFullName("panel_3.eventPanel.pro")
	local nameid = self._eventList[self._selectEventId].StoryName
	local name = Strings:get(nameid)

	title:setString(name)
	pro:setString(self:getGetClueNum(self._selectEventId) .. "/" .. #self:getSelectEventClues(self._selectEventId))
end

function MazeSealMediator:showTreasureInfo(cell, name)
	self._treasureInfo:setVisible(true)

	local tpanel = self._treasureInfo:getChildByFullName("Panel_30")
	local tcell = cell:clone()

	tcell:setPosition(0, 0)
	self._treasureInfo:getChildByFullName("tname"):setString(name)
	tpanel:removeAllChildren()
	tpanel:addChild(tcell)
end

function MazeSealMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dismiss()
	end
end

function MazeSealMediator:onClickExitHeroInfo(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._heroInfo:setVisible(false)
	end
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTreasureOwnMediator.lua

MazeTreasureOwnMediator = class("MazeTreasureOwnMediator", DmPopupViewMediator, _M)

MazeTreasureOwnMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeTreasureOwnMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}
local kcellTag = 123
local kColumnNum = 3
local kHInterval = 258
local kFirstCellPos = cc.p(0, 0)

function MazeTreasureOwnMediator:initialize()
	super.initialize(self)
end

function MazeTreasureOwnMediator:dispose()
	super.dispose(self)
end

function MazeTreasureOwnMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeTreasureOwnMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TREASURE_USE_SUC, self, self.updateViews)
end

function MazeTreasureOwnMediator:dispose()
	super.dispose(self)
end

function MazeTreasureOwnMediator:enterWithData(data)
	self:initData()
	self:initViews()
end

function MazeTreasureOwnMediator:initData()
	self._curUseTreasure = nil
end

function MazeTreasureOwnMediator:initViews()
	self._main = self:getView()

	local skills = self._mazeSystem:getMasterSkill()

	self._cellclone = self._main:getChildByFullName("cellclone")
	self._cellbg = self._main:getChildByFullName("cellbg")

	local masterid = self._mazeSystem:getSelectMasterId()

	masterid = ConfigReader:getDataByNameIdAndKey("RoleModel", masterid, "Model")

	self:initTreasureList()
	self:refreshTableView()
end

function MazeTreasureOwnMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickExit, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeTreasureOwnMediator:updateViews()
	self:initTreasureList()
	self._tableView:reloadData()

	local view = self:getInjector():getInstance("MazeTreasureUseSucView")
	local data = {
		name = self._curUseTreasure:getName(),
		effect = self._curUseTreasure:getDesc()
	}

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	self:close()
end

function MazeTreasureOwnMediator:initTreasureList()
	local count = 1
	local treasure = self._mazeSystem:getMasterTreasure()

	self._treasureList = {}

	for k, v in pairs(treasure) do
		self._treasureList[count] = v
		count = count + 1
	end

	if GameConfigs.mazeDebugMode then
		dump(self._treasureList, "宝物数据")
	end
end

function MazeTreasureOwnMediator:refreshTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local clonePanel = self._cellclone
	local size = clonePanel:getContentSize()

	local function numberOfCellsInTableView(table)
		return (math.ceil(#self._treasureList / kColumnNum))
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

			if self._treasureList[curIndex] then
				treasureCell:setVisible(true)
				treasureCell:addTouchEventListener(function(sender, eventType)
					self:onCellClicked(sender, eventType, curIndex)
				end)
				self:setCellInfo(treasureCell, curIndex)
			else
				treasureCell:setVisible(false)
			end
		end

		return cellbar
	end

	local cellbgsize = self._cellbg:getContentSize()
	local tableView = cc.TableView:create(cellbgsize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	self._cellbg:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	self._tableView:setBounceable(false)
	tableView:reloadData()
end

function MazeTreasureOwnMediator:setCellInfo(cell, idx)
	local oldcell = cell:getChildByTag(kcellTag)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	cell:setTouchEnabled(true)
	cell:addTouchEventListener(function(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end)

	local data = self._treasureList[idx]

	cell:getChildByFullName("name"):setString(data:getName())
	cell:getChildByFullName("icon"):loadTexture(data:getIconPath())

	local desc = data:getDesc()
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
		descNode:setString(data:getDesc())
	end

	cell:getChildByFullName("use"):setVisible(data:getIsUse())
end

function MazeTreasureOwnMediator:onCellClicked(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended then
		local treasure = self._treasureList[index]

		print("使用的宝物id--->", treasure:getId())

		if treasure:getIsUse() then
			self._curUseTreasure = treasure

			self._mazeSystem:requestMazestUseTreasure(self._mazeSystem._mazeEvent:getConfigId(), treasure:getId())
		end
	end
end

function MazeTreasureOwnMediator:getDesc(_config)
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

function MazeTreasureOwnMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeHeroUpMediator.lua

MazeHeroUpMediator = class("MazeHeroUpMediator", DmPopupViewMediator, _M)

MazeHeroUpMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeHeroUpMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	upPanel = "onTouchUpPanel",
	["upPanel.Button_12"] = "onClickUpHero"
}
local kcellTag = 123
local kColumnNum = 5
local kHInterval = 170
local kVInterval = 90
local kFirstCellPos = cc.p(0, 40)

function MazeHeroUpMediator:initialize()
	super.initialize(self)
end

function MazeHeroUpMediator:dispose()
	super.dispose(self)
end

function MazeHeroUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeHeroUpMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_HERO_UP_SUC, self, self.updateViews)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_EVENT_SKILL_SUC, self, self.updateViews)
end

function MazeHeroUpMediator:dispose()
	super.dispose(self)
end

function MazeHeroUpMediator:enterWithData(data)
	self._model = data._model

	if data._index == 4 then
		print("---事件技能---")

		self._index = 4
	else
		self._index = data._index
	end

	self:initData()
	self:initViews()
end

function MazeHeroUpMediator:initData()
	self._targetHeroId = ""
	self._targetHero = nil
	self._state = 1
end

function MazeHeroUpMediator:initViews()
	self._main = self:getView()

	local skills = self._mazeSystem:getMasterSkill()

	self._cellclone = self._main:getChildByFullName("cellclone")
	self._cellbg = self._main:getChildByFullName("cellbg")
	self._heroPanel = self._main:getChildByFullName("upPanel")

	self._heroPanel:setVisible(false)

	self._selectName = self._main:getChildByFullName("name")

	if self._index ~= 4 then
		self._main:getChildByFullName("cellbg.Text_50"):setString(self._model:getUpCost())
	end

	self:initHeroList()
	self:refreshTableView()
	self:setupTopInfoWidget()
end

function MazeHeroUpMediator:updateViews(newdatas)
	self:initHeroList()
	self._tableView:reloadData()

	local datapoints = newdatas._data.d.player.pansLab.points

	for k, v in pairs(datapoints) do
		local difdata = v.team.heroes

		if self._index ~= 4 then
			self._main:getChildByFullName("cellbg.Text_50"):setString(self._model:getUpCost())
		end

		local name = Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", self._targetHeroId, "Name"))
		local data = {
			olddata = self._targetConfigId,
			newdata = difdata,
			heroid = self._targetHeroId,
			heroname = name
		}
		local view = self:getInjector():getInstance("MazeHeroUpSucView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end
end

function MazeHeroUpMediator:initHeroList()
	local count = 1
	local heros = self._mazeSystem:getHeros()

	self._heroList = {}

	for k, v in pairs(heros) do
		self._heroList[count] = v
		count = count + 1
	end
end

function MazeHeroUpMediator:refreshTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local clonePanel = self._cellclone
	local size = clonePanel:getContentSize()

	local function numberOfCellsInTableView(table)
		return (math.ceil(#self._heroList / kColumnNum))
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

			if self._heroList[curIndex] then
				treasureCell:setVisible(true)
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

function MazeHeroUpMediator:setCellInfo(cell, idx)
	local oldcell = cell:getChildByTag(kcellTag)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	cell:setTouchEnabled(true)
	cell:addTouchEventListener(function(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end)

	local data = self._heroList[idx]

	cell:getChildByFullName("bg2"):setVisible(false)

	local name = Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", data.id, "Name"))

	cell:getChildByFullName("name"):setString(name)

	local level = ConfigReader:getDataByNameIdAndKey("PansLabAttr", data.attrId, "Level")

	cell:getChildByFullName("lv"):setString("Lv." .. level)

	local node = cell:getChildByFullName("Panel_1")
	local rarity = cell:getChildByFullName("rarity")

	node:removeAllChildren()
	rarity:loadTexture(GameStyle:getHeroRarityImage(ConfigReader:getDataByNameIdAndKey("HeroBase", data.id, "Rareity")), 1)
	rarity:ignoreContentAdaptWithSize(true)

	local aninnode = self._mazeSystem:createOneMasterAni(data.id, false, true)

	aninnode:setGray(false)
	aninnode:setPosition(0, 0)
	aninnode:setScale(0.8)
	node:addChild(aninnode)
end

function MazeHeroUpMediator:onCellClicked(sender, eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		print("行数-->", math.ceil(#self._heroList / kColumnNum))

		for i = 1, math.ceil(#self._heroList / kColumnNum) do
			local cellbar = self._tableView:cellAtIndex(i - 1)

			if cellbar then
				for j = 1, 3 do
					if cellbar:getChildByTag(j) then
						cellbar:getChildByTag(j):getChildByFullName("bg2"):setVisible(false)
					end
				end
			end
		end

		sender:getChildByFullName("bg2"):setVisible(true)
		self:showUpHero(self._heroList[idx])
	end
end

function MazeHeroUpMediator:showHeroSelect()
	self._selectName:setVisible(true)
end

function MazeHeroUpMediator:showUpHero(herodata)
	self._targetHeroId = herodata.id
	self._targetConfigId = herodata.attrId
	self._targetUUID = herodata.uuid
	self._targetHero = herodata

	self._heroPanel:setVisible(true)

	local aniparent = self._heroPanel:getChildByFullName("aninode")

	aniparent:removeAllChildren()

	local aninnode = self._mazeSystem:createOneMasterAni(herodata.id, false, true)

	aninnode:setGray(false)
	aninnode:setPosition(0, 0)
	aniparent:addChild(aninnode)

	local level = ConfigReader:getDataByNameIdAndKey("PansLabAttr", herodata.attrId, "Level")

	self._heroPanel:getChildByFullName("uplv"):setString("Lv." .. level)

	local name = Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", herodata.id, "Name"))

	self._heroPanel:getChildByFullName("upname"):setString(name)
end

function MazeHeroUpMediator:onClickUpHero(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local level = ConfigReader:getDataByNameIdAndKey("PansLabAttr", self._targetHero.attrId, "Level")

		print("英魂等级-->", level, "主角等级-->", self._mazeSystem:getSelectMasterLv())

		if level < self._mazeSystem:getSelectMasterLv() then
			self._heroPanel:setVisible(false)

			if self._index == 4 then
				print("------使用事件主动技能------")

				local data = {
					heroId = self._targetUUID
				}
				local cjson = require("cjson.safe")
				local paramsData = cjson.encode(data)

				self._mazeSystem:setOptionEventName(EVT_MAZE_EVENT_SKILL_SUC)
				self._mazeSystem:requestMazeEventSkillId(self._mazeSystem._mazeEvent:getConfigId(), paramsData)
			else
				print("-------=======------", self._index)

				local data = {
					heroId = self._targetUUID
				}
				local cjson = require("cjson.safe")
				local paramsData = cjson.encode(data)

				self._mazeSystem:setOptionEventName(EVT_MAZE_HERO_UP_SUC)
				self._mazeSystem:requestMazestStartOption(self._index, paramsData)
			end
		else
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("MAZE_HEROUP_TIPS")
			}))
		end
	end
end

function MazeHeroUpMediator:onTouchUpPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._heroPanel:setVisible(false)
	end
end

function MazeHeroUpMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		style = 1,
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

function MazeHeroUpMediator:onClickExit()
	self:close()
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/SetBoardHeroPopMediator.lua

SetBoardHeroPopMediator = class("SetBoardHeroPopMediator", DmPopupViewMediator, _M)

SetBoardHeroPopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
SetBoardHeroPopMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["main.checkBox"] = {
		ignoreClickAudio = true,
		func = "onClickCheckBox"
	},
	["main.randomBox.Panel_5"] = {
		ignoreClickAudio = true,
		func = "onClickRandom"
	},
	["main.screenBtn"] = {
		ignoreClickAudio = true,
		func = "onClickScreen"
	}
}
local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_TypeOrder", "content")
local partyList = {
	GalleryPartyType.kWNSXJ,
	GalleryPartyType.kXD,
	GalleryPartyType.kBSNCT,
	GalleryPartyType.kDWH,
	GalleryPartyType.kMNJH,
	GalleryPartyType.kSSZS,
	GalleryPartyType.kUNKNOWN
}
local screenFunc = {
	{
		func = function(screenType, hero)
			return hero:getRarity() == 16 - screenType
		end
	},
	{
		func = function(screenType, hero)
			return hero:getType() == TargetOccupation[screenType]
		end
	},
	{
		func = function(screenType, hero)
			return hero:getParty() == partyList[screenType]
		end
	}
}

function SetBoardHeroPopMediator:initialize()
	super.initialize(self)
end

function SetBoardHeroPopMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initWidget()
end

function SetBoardHeroPopMediator:dispose()
	super.dispose(self)
end

function SetBoardHeroPopMediator:enterWithData(data)
	self._doubleClickTag = false
	self._doubleClickRandom = false
	self._setBoardHeroId = data.heroId
	self._parentMediator = data.mediator
	self._chooseIndex = 1
	self._herosList = self._heroSystem:getOwnHeroIds()

	self:sortHeroList()

	self._cloneCell = self:getView():getChildByName("cellClone")

	self:createTableView()
end

function SetBoardHeroPopMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._checkBox = self._main:getChildByName("checkBox")
	self._randomBox = self._main:getChildByName("randomBox")

	local isDynamic = self._settingModel:getRoleDynamic()

	self:onCheckBoxChange(isDynamic)

	if CommonUtils.GetSwitch("fn_board_random") == true then
		local isRandom = self._settingModel:getRoleAndBgRandom()

		self:onRandomBoxChange(isRandom)
	else
		self._randomBox:setVisible(false)
	end
end

function SetBoardHeroPopMediator:sortHeroList()
	for _, v in ipairs(self._herosList) do
		v.sortTag = self._setBoardHeroId == v.id and 999 or 1
	end

	table.sort(self._herosList, function(a, b)
		return a.sortTag > b.sortTag or a.sortTag == b.sortTag and a.loveLevel > b.loveLevel or a.sortTag == b.sortTag and a.loveLevel == b.loveLevel and a.rareity == b.rareity and a.id > b.id
	end)
end

function SetBoardHeroPopMediator:createTableView()
	local container = self._main:getChildByName("container")
	local tableView = cc.TableView:create(container:getContentSize())

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 477, 176
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
		return math.ceil(#self._herosList / 3)
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

function SetBoardHeroPopMediator:updateCell(cell, index)
	cell:removeAllChildren()

	local layout = ccui.Layout:create()

	layout:setTouchEnabled(false)
	layout:setContentSize(cc.size(477, 186))
	layout:setAnchorPoint(0, 0)
	layout:addTo(cell):setName("main")

	local begin = 3 * index - 2
	local tail = 3 * index

	for i = begin, tail do
		if self._herosList[i] then
			local posTag = i - begin + 1
			local _heroCell = self._cloneCell:clone()
			local heroImg = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe7_1",
				id = self._herosList[i].roleModel
			})

			heroImg:setScale(0.44642857142857145)

			local heroPanel = _heroCell:getChildByName("hero")

			heroPanel:addChild(heroImg)
			heroImg:setAnchorPoint(cc.p(0.5, 0.5))
			heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)
			_heroCell:addTo(layout)
			_heroCell:setSwallowTouches(false)
			_heroCell:setPosition(cc.p(5 + (posTag - 1) * 135, 0))
			_heroCell:setTag(i)

			local function callFunc(sender)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					if self._herosList[i].id == self._setBoardHeroId then
						return
					end

					self._setBoardHeroId = self._herosList[i].id

					sender:getChildByName("selectImage"):setVisible(true)

					local offsetY = self._tableView:getContentOffset().y

					self._tableView:reloadData()
					self._tableView:setContentOffset(cc.p(0, offsetY))
					self:dispatch(Event:new(EVT_AFKGIFT_SET_SHOWHERO, {
						heroId = self._setBoardHeroId
					}))
				end
			end

			mapButtonHandlerClick(nil, _heroCell, {
				ignoreClickAudio = true,
				func = callFunc
			})

			if self._herosList[i].id == self._setBoardHeroId then
				_heroCell:getChildByName("selectImage"):setVisible(true)
			end
		end
	end
end

function SetBoardHeroPopMediator:onClickCheckBox()
	if self._doubleClickTag then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("HeroDynamic_Setting_Tips")
		}))
	else
		local isDynamic = self._settingModel:getRoleDynamic()

		self._settingModel:setRoleDynamic(not isDynamic)
		self:onCheckBoxChange(not isDynamic)
		self:dispatch(Event:new(EVT_AFKGIFT_SET_SHOWHERO, {
			heroId = self._setBoardHeroId
		}))

		self._doubleClickTag = true

		performWithDelay(self:getView(), function()
			self._doubleClickTag = false
		end, 1)
	end
end

function SetBoardHeroPopMediator:onClickRandom()
	if self._doubleClickRandom then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("MainScene_BoardHero_Random_2")
		}))
	else
		local isRandom = self._settingModel:getRoleAndBgRandom()

		self._settingModel:setRoleAndBgRandom(not isRandom)
		self:onRandomBoxChange(not isRandom)
		self:dispatch(Event:new(EVT_AFKGIFT_SET_SHOWHERO, {
			heroId = self._setBoardHeroId
		}))

		self._doubleClickRandom = true

		performWithDelay(self:getView(), function()
			self._doubleClickRandom = false
		end, 1)
	end
end

function SetBoardHeroPopMediator:onCheckBoxChange(isDynamic)
	local slider = self._checkBox:getChildByName("slide")
	local text1 = self._checkBox:getChildByName("test1")
	local text2 = self._checkBox:getChildByName("test2")

	if isDynamic then
		slider:setPositionX(58.7)
		text2:setTextColor(cc.c3b(202, 245, 53))
		text1:setTextColor(cc.c3b(193, 193, 193))
	else
		slider:setPositionX(18.41)
		text1:setTextColor(cc.c3b(202, 245, 53))
		text2:setTextColor(cc.c3b(193, 193, 193))
	end
end

function SetBoardHeroPopMediator:onRandomBoxChange(isRandom)
	local darkImage = self._randomBox:getChildByName("Image_Dark")
	local lightImage = self._randomBox:getChildByName("Image_Light")

	darkImage:setVisible(not isRandom)
	lightImage:setVisible(isRandom)
end

function SetBoardHeroPopMediator:onClickScreen()
	self:createScreenView()
	self._screenWidget:getView():setVisible(true)
	self._screenWidget:refreshView(self._screenType)
end

function SetBoardHeroPopMediator:createScreenView()
	if self._screenWidget then
		return
	end

	local function callBack(data)
		self._screenType = data.screenType

		self:updateHeroList()
		self:sortHeroList()
		self._tableView:reloadData()
	end

	self._screenWidget = BoardHeroScreenWidget:new({
		mediator = self,
		callBack = callBack
	})

	local pos = self._main:convertToWorldSpace(cc.p(-625, 0))
	local pos1 = self._parentMediator:getView():convertToNodeSpace(pos)

	self._screenWidget:getView():addTo(self._parentMediator:getView(), 100):setPosition(pos1)
end

function SetBoardHeroPopMediator:updateHeroList()
	local heroList = self._heroSystem:getOwnHeroIds()

	self._herosList = {}

	for i, v in pairs(heroList) do
		if self:chooseHero(v) then
			self._herosList[#self._herosList + 1] = v
		end
	end
end

function SetBoardHeroPopMediator:chooseHero(hero)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local markCount = 0

	for k, v in pairs(self._screenType) do
		if screenFunc[k].func(v, heroSystem:getHeroById(hero.id)) then
			markCount = markCount + 1
		end
	end

	if markCount == table.nums(self._screenType) then
		return true
	end

	return false
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/FightStatisticPopMediator.lua

FightStatisticPopMediator = class("FightStatisticPopMediator", DmPopupViewMediator)

local kBtnHandlers = {
	tips = {
		func = "onClickTips"
	}
}
local enumSortType = {
	"dmage",
	"againstDmg",
	"cure",
	"liveTime"
}
local sortType = {
	againstDmg = 3,
	dmage = 2,
	liveTime = 5,
	cure = 4
}

local function helpReverse(array)
	array[#array + 1] = -1

	table.reverse(array)

	array[1] = array[#array]
	array[#array] = nil

	return array
end

function FightStatisticPopMediator:initialize()
	super.initialize(self)
end

function FightStatisticPopMediator:dispose()
	super.dispose(self)
end

function FightStatisticPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mainBg", PopupNormalWidget, {
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Fight_Statistic_Title"),
		title1 = Strings:get("UITitle_EN_Shujutongji"),
		bgSize = {
			width = 837,
			height = 444
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 50 or nil
	})

	self._playerId = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
end

function FightStatisticPopMediator:enterWithData(data)
	self._data = data
	self._playData = data.players[self._playerId]

	self:initWidget()
	self:processData()
	self:createTableView()
end

function FightStatisticPopMediator:initWidget()
	local text = self:getView():getChildByName("text1")

	text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	for i = 2, 5 do
		local text = self:getView():getChildByName("text" .. i)

		if text then
			text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		end

		local touchPanel = self:getView():getChildByName("textTouch" .. i)

		local function callFunc()
			local _sortType = sortType[enumSortType[i - 1]]
			local sortTag = text:getChildByName("sortTag")

			if self._sortType == _sortType then
				helpReverse(self._statistic)
				sortTag:setFlippedY(not sortTag:isFlippedY())
			else
				local oldText = self:getView():getChildByName("text" .. self._sortType)

				oldText:getChildByName("sortTag"):loadTexture("btn_sjxu_old.png", ccui.TextureResType.plistType)

				self._sortType = _sortType

				sortTag:loadTexture("btn_sjxu_1.png", ccui.TextureResType.plistType)
				self:sortDataByType(self._sortType)
			end

			self._tableView:reloadData()
		end

		mapButtonHandlerClick(nil, touchPanel, {
			ignoreClickAudio = true,
			func = callFunc
		})
	end

	self._cloneCell = self:getView():getChildByName("cell")

	local dmgText = self._cloneCell:getChildByName("dmg")
	local againstText = self._cloneCell:getChildByName("against")
	local cureText = self._cloneCell:getChildByName("cure")

	dmgText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	againstText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	cureText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function FightStatisticPopMediator:processData()
	self._statistic = {}
	self._statistic_map = {}

	local summonId = {}

	self._allDmg = 0
	self._allReceiveDamage = 0
	self._allCure = 0

	dump(self._playData.unitSummary, "self._playData.unitSummary", 4)

	for k, v in pairs(self._playData.unitSummary) do
		for _, id in ipairs(v.summoned) do
			summonId[#summonId + 1] = id
		end
	end

	for k, v in pairs(self._playData.unitSummary) do
		if not table.indexof(summonId, k) then
			local uniqKey = v.cid .. v.model
			local _tab = {}

			_tab.id = k
			_tab.dmg = v.damage or 0
			_tab.receiveDamage = v.receiveDamage or 0
			_tab.cure = v.cure or 0
			_tab.isMaster = v.type == "master"
			_tab.liveTime = math.ceil((v.endTime - v.startTime) / 1000)

			for _, sumId in ipairs(v.summoned) do
				local _data = self._playData.unitSummary[sumId]

				if _data then
					if not _data.damage then
						if not _data.receiveDamage then
							local receiveDamage = 0

							if not _data.cure then
								local cure = 0

								_tab.dmg = _tab.dmg + _data.damage
								_tab.receiveDamage = _tab.receiveDamage + receiveDamage
								_tab.cure = _tab.cure + cure
							end
						end
					end
				end
			end

			_tab.dmg = math.ceil(_tab.dmg)
			_tab.receiveDamage = math.ceil(_tab.receiveDamage)
			_tab.cure = math.ceil(_tab.cure)

			if self._statistic_map[uniqKey] then
				self._statistic_map[uniqKey].liveTime = self._statistic_map[uniqKey].liveTime + _tab.liveTime
				self._statistic_map[uniqKey].dmg = self._statistic_map[uniqKey].dmg + _tab.dmg
				self._statistic_map[uniqKey].receiveDamage = self._statistic_map[uniqKey].receiveDamage + _tab.receiveDamage
				self._statistic_map[uniqKey].cure = self._statistic_map[uniqKey].cure + _tab.cure
			else
				self._statistic_map[uniqKey] = _tab
			end

			self._statistic_map[uniqKey] = _tab
		end
	end

	for k, v in pairs(self._statistic_map) do
		self._statistic[#self._statistic + 1] = v
	end

	for k, v in ipairs(self._statistic) do
		self._allDmg = self._allDmg + v.dmg
		self._allReceiveDamage = self._allReceiveDamage + v.receiveDamage
		self._allCure = self._allCure + v.cure
	end

	dump(self._statistic, "self._statistic", 4)

	self._sortType = sortType.dmage

	self:sortDataByType(self._sortType)
end

function FightStatisticPopMediator:sortDataByType(type)
	local sortFunc

	if type == sortType.dmage then
		function sortFunc(a, b)
			if a.isMaster then
				return true
			elseif b.isMaster then
				return false
			else
				return a.dmg > b.dmg
			end
		end
	elseif type == sortType.againstDmg then
		function sortFunc(a, b)
			if a.isMaster then
				return true
			elseif b.isMaster then
				return false
			else
				return a.receiveDamage > b.receiveDamage
			end
		end
	elseif type == sortType.cure then
		function sortFunc(a, b)
			if a.isMaster then
				return true
			elseif b.isMaster then
				return false
			else
				return a.cure > b.cure
			end
		end
	elseif type == sortType.liveTime then
		function sortFunc(a, b)
			if a.isMaster then
				return true
			elseif b.isMaster then
				return false
			else
				return a.liveTime > b.liveTime
			end
		end
	end

	table.sort(self._statistic, sortFunc)
end

function FightStatisticPopMediator:createTableView()
	local parent = self:getView():getChildByName("tableView")
	local tableView = cc.TableView:create(parent:getContentSize())

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		local cellSize = self._cloneCell:getContentSize()

		return cellSize.width, cellSize.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local mainView = self._cloneCell:clone()

			mainView:addTo(cell):setName("main")
			mainView:setPosition(cc.p(0, 0))
		end

		self:updateCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._statistic
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:addTo(parent)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:setBounceable(false)
	tableView:reloadData()

	self._tableView = tableView
end

function FightStatisticPopMediator:updateCell(cell, index)
	local mainView = cell:getChildByName("main")
	local _data = self._statistic[index]
	local dmgText = mainView:getChildByName("dmg")

	dmgText:setString(_data.dmg)

	local receiveDamageText = mainView:getChildByName("against")

	receiveDamageText:setString(_data.receiveDamage)

	local cureText = mainView:getChildByName("cure")

	cureText:setString(_data.cure)

	local dmgBar = mainView:getChildByFullName("dmgBar.loadingBar")
	local receiveDamageBar = mainView:getChildByFullName("againstBar.loadingBar")
	local cureBar = mainView:getChildByFullName("cureBar.loadingBar")

	dmgBar:setPercent(_data.dmg * 100 / self._allDmg)
	receiveDamageBar:setPercent(_data.receiveDamage * 100 / self._allReceiveDamage)
	cureBar:setPercent(_data.cure * 100 / self._allCure)

	local contTime = mainView:getChildByName("liveTime")

	contTime:setString(_data.liveTime)

	local precessText1 = mainView:getChildByFullName("dmgBar.precess")
	local dmgDate

	precessText1:setString((self._allDmg == 0 and 0 or string.format("%0.2f", _data.dmg * 100 / self._allDmg)) .. "%")
	precessText1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local precessText2 = mainView:getChildByFullName("againstBar.precess")
	local againstDate

	precessText2:setString((self._allReceiveDamage == 0 and 0 or string.format("%0.2f", _data.receiveDamage * 100 / self._allReceiveDamage)) .. "%")
	precessText2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local precessText3 = mainView:getChildByFullName("cureBar.precess")
	local cureDate

	precessText3:setString((self._allCure == 0 and 0 or string.format("%0.2f", _data.cure * 100 / self._allCure)) .. "%")
	precessText3:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local heroIcon = mainView:getChildByName("heroIcon")

	heroIcon:removeAllChildren()

	local heroNode = self:createSmallIcon(_data.id)

	heroNode:addTo(heroIcon):center(heroIcon:getContentSize())
	heroNode:setScale(0.52)
end

function FightStatisticPopMediator:createSmallIcon(heroId)
	local _rawData = self._playData.unitSummary[heroId]
	local rootPanel = ccui.Layout:create()

	rootPanel:setAnchorPoint(cc.p(0.5, 0.5))
	rootPanel:setContentSize(127, 129)
	rootPanel:setTouchEnabled(false)
	rootPanel:setSwallowTouches(false)

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = _rawData.model
	})

	heroImg:setScale(0.5)

	heroImg = IconFactory:addStencilForIcon(heroImg, 4, cc.size(104, 104), {
		0,
		0
	})

	heroImg:setPosition(cc.p(63, 68))
	heroImg:setName("HeroIcon")
	heroImg:addTo(rootPanel)

	local rarity = _rawData.rarity

	if rarity > 11 and rarity < 15 then
		local quality
		local bgName = GameStyle:getItemQuaRectFile((not _rawData.quality or _rawData.quality == 0) and 1 or math.ceil(_rawData.quality / 10), 1)
		local qualityBg = ccui.ImageView:create(bgName)

		qualityBg:addTo(rootPanel, -1)
		qualityBg:setPosition(cc.p(63, 69))
	else
		local qualityBg = ccui.ImageView:create("asset/itemRect/common_pz_huang.png")

		qualityBg:addTo(rootPanel, -1)
		qualityBg:setPosition(cc.p(63, 69))
	end

	return rootPanel
end

function FightStatisticPopMediator:onClickTips()
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		title1 = Strings:get("Statistical_Notes"),
		title2 = Strings:get("UITitle_EN_Tongjishuoming"),
		rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Battle_StatisticalText", "content")
	}, nil)

	self:dispatch(event)
end

function FightStatisticPopMediator:onClickClose()
	self:close()
end

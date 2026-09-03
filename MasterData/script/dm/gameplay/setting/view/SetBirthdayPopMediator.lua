-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SetBirthdayPopMediator.lua

SetBirthdayPopMediator = class("SetBirthdayPopMediator", DmPopupViewMediator)

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickChoose"
	}
}
local leapMonth = {
	1,
	3,
	5,
	7,
	8,
	10,
	12
}

function SetBirthdayPopMediator:initialize()
	super.initialize(self)
end

function SetBirthdayPopMediator:dispose()
	super.dispose(self)

	if self._yearTimer then
		self._yearTimer:stop()

		self._yearTimer = nil
	end

	if self._monthTimer then
		self._monthTimer:stop()

		self._monthTimer = nil
	end

	if self._dayTimer then
		self._dayTimer:stop()

		self._dayTimer = nil
	end
end

function SetBirthdayPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Tip_SetBirthday"),
		title1 = Strings:get("UITitle_EN_Xiugaishengri"),
		bgSize = {
			width = 690,
			height = 408
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})

	self._main = self:getView():getChildByName("main")
	self._btnOk = self._main:getChildByFullName("btn_ok.button")
end

function SetBirthdayPopMediator:enterWithData(data)
	self._playerBirthday = data.birthday

	local _tab = self:parseTimeStr(self._playerBirthday)

	self._isFirstSetBirthday = self:getInjector():getInstance("DevelopSystem"):getPlayer():getFirstUpdateBirthDay()

	self._main:getChildByFullName("btn_ok.name1"):setVisible(false)

	local text = self._main:getChildByFullName("btn_ok.name")
	local payIcon = self._main:getChildByFullName("node")

	if self._isFirstSetBirthday then
		self._main:getChildByName("tips"):setVisible(true)
		text:setString(Strings:get("Common_button1"))
		payIcon:setVisible(false)
	else
		self._main:getChildByName("tips"):setVisible(false)
		text:setVisible(false)
		payIcon:setVisible(true)
	end

	self._year = _tab.year or 2000
	self._month = _tab.month or 1
	self._day = _tab.day or 1

	self:initCalendar()
end

function SetBirthdayPopMediator:initCalendar()
	self:initYearTableView()
	self:initMonthTableView()
	self:initDayTableView()
end

function SetBirthdayPopMediator:initYearTableView()
	local year_tableView = cc.TableView:create(cc.size(100, 132))

	local function cellSize(table, idx)
		return 100, 44
	end

	local function onScroll(table)
		if self._yearTimer ~= nil then
			return
		end

		local function autoCenterCell()
			if not table:isDragging() and not table:isTouchMoved() then
				table:stopScroll()

				local offX = table:getContentOffset().y
				local a, b = math.modf(-offX / 44)
				local entity = a

				if b > 0.5 and a < 118 or a == -1 then
					entity = a + 1
				end

				local entityPosY = entity * -44

				self._year = 1901 + entity

				table:setContentOffsetInDuration(cc.p(0, entityPosY), 0.1)
				performWithDelay(self:getView(), function()
					local offX = table:getContentOffset().y

					table:reloadData()
					table:setContentOffset(cc.p(0, offX), false)
					self._yearTimer:stop()

					self._yearTimer = nil

					if self._month == 2 and self._day > 27 then
						if self._year % 4 ~= 0 and self._day == 29 then
							self._day = 28
						end

						self._dayTableView:stopScroll()
						self._dayTableView:reloadData()

						local initPosY = (self._day - 1) * -44

						self._dayTableView:setContentOffset(cc.p(0, initPosY), false)
					end

					self._btnOk:setGray(false)
					self._btnOk:setTouchEnabled(true)
				end, 0.3)
			else
				self._btnOk:setGray(true)
				self._btnOk:setTouchEnabled(false)
			end
		end

		self._yearTimer = LuaScheduler:getInstance():schedule(autoCenterCell, 1, false)
	end

	local function cellTouched(table, cell)
		return
	end

	local function numberOfYears(view)
		local years = 119

		return years + 2
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		if not cell:getChildByName("yearText") then
			local yearText = ccui.Text:create(tostring(1900 + idx), TTF_FONT_FZYH_M, 20)

			yearText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			yearText:addTo(cell):setName("yearText")
			yearText:center(cc.size(100, 44))
		end

		if self._year == 1900 + idx then
			cell:getChildByName("yearText"):setTextColor(cc.c4b(255, 255, 255, 255))
		else
			cell:getChildByName("yearText"):setTextColor(cc.c4b(127, 127, 127, 255))
		end

		if index == 1 or index == numberOfYears() then
			cell:getChildByName("yearText"):setString("")
		else
			cell:getChildByName("yearText"):setString(tostring(1900 + idx) .. Strings:get("Setting_UI_Year"))
		end

		return cell
	end

	year_tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	year_tableView:setDelegate()
	year_tableView:registerScriptHandler(numberOfYears, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	year_tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	year_tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	year_tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	year_tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	year_tableView:addTo(self._main)
	year_tableView:setPosition(cc.p(335, 273))
	year_tableView:setBounceable(false)
	year_tableView:reloadData()

	self._yearTableView = year_tableView

	local initPosY = (self._year - 1901) * -44

	self._yearTableView:setContentOffset(cc.p(0, initPosY), false)
end

function SetBirthdayPopMediator:initMonthTableView()
	local month_tableView = cc.TableView:create(cc.size(100, 132))

	local function cellSize(table, idx)
		return 100, 44
	end

	local function onScroll(table)
		if self._monthTimer ~= nil then
			return
		end

		local function autoCenterCell()
			if not table:isDragging() and not table:isTouchMoved() then
				table:stopScroll()

				local offX = table:getContentOffset().y
				local a, b = math.modf(-offX / 44)
				local entity = a

				if b > 0.5 and a < 11 or a == -1 then
					entity = a + 1
				end

				local entityPosY = entity * -44

				self._month = 1 + entity

				table:setContentOffsetInDuration(cc.p(0, entityPosY), 0.1)
				performWithDelay(self:getView(), function()
					local offX = table:getContentOffset().y

					table:reloadData()
					table:setContentOffset(cc.p(0, offX), false)
					self._monthTimer:stop()

					self._monthTimer = nil

					local day = self._day

					self._dayTableView:stopScroll()
					self._dayTableView:reloadData()

					if self._month == 2 and day > 28 then
						self._day = 28
					elseif not _G.table.indexof(leapMonth, self._month) and day == 31 then
						self._day = 30
					end

					local initPosY = (self._day - 1) * -44

					self._dayTableView:setContentOffset(cc.p(0, initPosY), false)
					self._btnOk:setGray(false)
					self._btnOk:setTouchEnabled(true)
				end, 0.3)
			else
				self._btnOk:setGray(true)
				self._btnOk:setTouchEnabled(false)
			end
		end

		self._monthTimer = LuaScheduler:getInstance():schedule(autoCenterCell, 1, false)
	end

	local function cellTouched(table, cell)
		return
	end

	local function numberOfMonth(view)
		local month = 12

		return month + 2
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		if not cell:getChildByName("monthText") then
			local yearText = ccui.Text:create(tostring(0 + idx), TTF_FONT_FZYH_M, 20)

			yearText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			yearText:addTo(cell):setName("monthText")
			yearText:center(cc.size(100, 44))
		end

		if self._month == idx then
			cell:getChildByName("monthText"):setTextColor(cc.c4b(255, 255, 255, 255))
		else
			cell:getChildByName("monthText"):setTextColor(cc.c4b(127, 127, 127, 255))
		end

		if index == 1 or index == numberOfMonth() then
			cell:getChildByName("monthText"):setString("")
		else
			cell:getChildByName("monthText"):setString(tostring(0 + idx) .. Strings:get("Setting_UI_Month"))
		end

		return cell
	end

	month_tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	month_tableView:setDelegate()
	month_tableView:registerScriptHandler(numberOfMonth, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	month_tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	month_tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	month_tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	month_tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	month_tableView:addTo(self._main)
	month_tableView:setPosition(cc.p(500, 273))
	month_tableView:setBounceable(false)
	month_tableView:reloadData()

	self._monthTableView = month_tableView

	local initPosY = (self._month - 1) * -44

	self._monthTableView:setContentOffset(cc.p(0, initPosY), false)
end

function SetBirthdayPopMediator:initDayTableView()
	local day_tableView = cc.TableView:create(cc.size(100, 132))

	local function cellSize(table, idx)
		return 100, 44
	end

	local function numberOfDay(view)
		return (self._month == 2 and (self._year % 4 == 0 and 29 or 28) or table.indexof(leapMonth, self._month) and 31 or 30) + 2
	end

	local function onScroll(table)
		if self._dayTimer ~= nil then
			return
		end

		local function autoCenterCell()
			if not table:isDragging() and not table:isTouchMoved() then
				table:stopScroll()

				local maxDays = numberOfDay()
				local offX = table:getContentOffset().y
				local a, b = math.modf(-offX / 44)
				local entity = a

				if b > 0.5 and a < maxDays - 3 or a == -1 then
					entity = a + 1
				end

				local entityPosY = entity * -44

				self._day = 1 + entity

				table:setContentOffsetInDuration(cc.p(0, entityPosY), 0.1)
				performWithDelay(self:getView(), function()
					local offX = table:getContentOffset().y

					table:reloadData()
					table:setContentOffset(cc.p(0, offX), false)
					self._dayTimer:stop()

					self._dayTimer = nil

					self._btnOk:setGray(false)
					self._btnOk:setTouchEnabled(true)
				end, 0.3)
			else
				self._btnOk:setGray(true)
				self._btnOk:setTouchEnabled(false)
			end
		end

		self._dayTimer = LuaScheduler:getInstance():schedule(autoCenterCell, 1, false)
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		if not cell:getChildByName("dayText") then
			local yearText = ccui.Text:create(tostring(0 + idx), TTF_FONT_FZYH_M, 20)

			yearText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			yearText:addTo(cell):setName("dayText")
			yearText:center(cc.size(100, 44))
		end

		if self._day == idx then
			cell:getChildByName("dayText"):setTextColor(cc.c4b(255, 255, 255, 255))
		else
			cell:getChildByName("dayText"):setTextColor(cc.c4b(127, 127, 127, 255))
		end

		local maxDays = numberOfDay()

		if index == 1 or index == maxDays then
			cell:getChildByName("dayText"):setString("")
		else
			cell:getChildByName("dayText"):setString(tostring(0 + idx) .. Strings:get("Setting_UI_Day"))
		end

		return cell
	end

	day_tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	day_tableView:setDelegate()
	day_tableView:registerScriptHandler(numberOfDay, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	day_tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	day_tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	day_tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	day_tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	day_tableView:addTo(self._main)
	day_tableView:setPosition(cc.p(665, 273))
	day_tableView:setBounceable(false)
	day_tableView:reloadData()

	self._dayTableView = day_tableView

	local initPosY = (self._day - 1) * -44

	self._dayTableView:setContentOffset(cc.p(0, initPosY), false)
end

function SetBirthdayPopMediator:onClickClose(sender, eventType)
	self:close()
end

function SetBirthdayPopMediator:onClickChoose()
	local str, isLegal = self:toTimeStr()

	if not isLegal then
		return
	end

	local view = self:getInjector():getInstance("AlertView")
	local viewData = {}

	viewData.cancelBtn = {}
	viewData.sureBtn = {}
	viewData.title = Strings:get("Tip_Remind")
	viewData.content = self._isFirstSetBirthday and Strings:get("Tip_First_SetBirthDay") or Strings:get("Tip_RE_SetBirthDay")

	local delegate, outSelf = {}, self

	function delegate:willClose(_, data)
		if data.response == AlertResponse.kOK then
			local bagSystem = outSelf:getInjector():getInstance(DevelopSystem):getBagSystem()

			if outSelf._isFirstSetBirthday or bagSystem:getDiamond() >= 100 then
				if str ~= outSelf._playerBirthday then
					outSelf:close({
						birthday = str
					})
				else
					outSelf:close()
				end
			else
				outSelf:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("Common_Tip4")
				}))
			end
		end
	end

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, viewData, delegate))
end

function SetBirthdayPopMediator:parseTimeStr(timeStr)
	local _tab = {}
	local strTab = string.split(timeStr, "-")

	_tab.year = tonumber(strTab[1])
	_tab.month = tonumber(strTab[2])
	_tab.day = tonumber(strTab[3])

	return _tab
end

function SetBirthdayPopMediator:toTimeStr()
	local monthStr
	local isLegal = true

	monthStr = self._month < 10 and "0" .. tostring(self._month) or tostring(self._month)

	local dayStr = self._day < 10 and "0" .. tostring(self._day) or tostring(self._day)

	if self._day > 0 and self._day < 32 then
		if self._day < 29 then
			isLegal = true
		else
			if self._day == 29 then
				isLegal = self._month == 2 and self._year % 4 == 0 or true
			end

			if self._day == 31 then
				isLegal = table.indexof(leapMonth, self._month)
			end

			if self._day == 30 then
				isLegal = self._month ~= 2
			end
		end
	else
		isLegal = false
	end

	local strconTab = {}

	strconTab[#strconTab + 1] = tostring(self._year)
	strconTab[#strconTab + 1] = "-"
	strconTab[#strconTab + 1] = monthStr
	strconTab[#strconTab + 1] = "-"
	strconTab[#strconTab + 1] = dayStr

	return table.concat(strconTab), isLegal
end

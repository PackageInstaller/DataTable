-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SetAreaPopMediator.lua

SetAreaPopMediator = class("SetAreaPopMediator", DmPopupViewMediator)

SetAreaPopMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickChoose"
	}
}
local regionData
local orderTab = {}
local orderTabSize = 0

function SetAreaPopMediator:initialize()
	super.initialize(self)
end

function SetAreaPopMediator:dispose()
	super.dispose(self)

	if self._regionTimer then
		self._regionTimer:stop()

		self._regionTimer = nil
	end

	if self._areaTimer then
		self._areaTimer:stop()

		self._areaTimer = nil
	end
end

function SetAreaPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Tip_SetArea"),
		title1 = Strings:get("UITitle_EN_Xiugaidiqu"),
		bgSize = {
			width = 690,
			height = 408
		}
	})
	self:bindWidget("main.btn_ok", OneLevelViceButton, {})

	self._main = self:getView():getChildByName("main")
	self._btnOk = self._main:getChildByFullName("btn_ok.button")
	orderTab = self._settingSystem:getOrderTab()
	regionData = self._settingSystem:getRegionData()
	orderTabSize = #orderTab
	self._isFirstEnter = true
end

function SetAreaPopMediator:enterWithData(data)
	self._playerAreaInfo = data.playerArea

	if self._playerAreaInfo == nil or self._playerAreaInfo == "" then
		self._playerAreaInfo = tostring(orderTab[1].Id) .. "-1"
	end

	local _tab = self:parseAreaInfo(self._playerAreaInfo)

	self._regionId = _tab.regionId
	self._regionIndex = _tab.regionIndex
	self._areaIndex = _tab.areaIndex
	self._citys = regionData[self._regionId].City

	self:initAreaTableView()
end

function SetAreaPopMediator:initAreaTableView()
	self:initRegionTab()
	self:initAreaTab()
end

function SetAreaPopMediator:initRegionTab()
	local regionTableView = cc.TableView:create(cc.size(160, 132))

	local function cellSize(table, idx)
		return 100, 44
	end

	local function cellTouched(table, cell)
		return
	end

	local function numberOfRegions(view)
		return orderTabSize + 2
	end

	local function onScroll(table)
		if self._regionTimer ~= nil then
			return
		end

		local function autoCenterCell()
			if not table:isDragging() and not table:isTouchMoved() then
				table:stopScroll()

				local offX = table:getContentOffset().y
				local a, b = math.modf(-offX / 44)
				local entity = a

				if b > 0.5 and a < orderTabSize - 1 or a == -1 then
					entity = a + 1
				end

				local entityPosY = entity * -44

				self._regionIndex = orderTabSize - entity
				self._regionId = orderTab[self._regionIndex].Id
				self._citys = regionData[self._regionId].City

				if not self._isFirstEnter then
					self._areaIndex = 1

					self._areaTableView:stopScroll()
					self._areaTableView:reloadData()
					table:setContentOffsetInDuration(cc.p(0, entityPosY), 0.1)
				end

				self._isFirstEnter = false

				performWithDelay(self:getView(), function()
					local offX = table:getContentOffset().y

					table:reloadData()
					table:setContentOffset(cc.p(0, offX), false)
					self._regionTimer:stop()

					self._regionTimer = nil

					self._btnOk:setGray(false)
					self._btnOk:setTouchEnabled(true)
				end, 0.3)
			else
				self._btnOk:setGray(true)
				self._btnOk:setTouchEnabled(false)
			end
		end

		self._regionTimer = LuaScheduler:getInstance():schedule(autoCenterCell, 1, false)
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		if not cell:getChildByName("regionText") then
			local regionText = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

			regionText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			regionText:ignoreContentAdaptWithSize(false)
			regionText:setContentSize(cc.size(150, 30))
			regionText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			regionText:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
			regionText:addTo(cell):setName("regionText")
			regionText:center(cc.size(160, 44))
		end

		if self._regionIndex == idx then
			cell:getChildByName("regionText"):setTextColor(cc.c4b(255, 255, 255, 255))
		else
			cell:getChildByName("regionText"):setTextColor(cc.c4b(127, 127, 127, 255))
		end

		if index == 1 or index == numberOfRegions() then
			cell:getChildByName("regionText"):setString("")
		else
			local regionId = orderTab[idx].Id
			local regionStrId = regionData[regionId].Provinces

			cell:getChildByName("regionText"):setString(Strings:get(regionStrId))
		end

		return cell
	end

	regionTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	regionTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	regionTableView:setDelegate()
	regionTableView:registerScriptHandler(numberOfRegions, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	regionTableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	regionTableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	regionTableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	regionTableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	regionTableView:addTo(self._main)
	regionTableView:setPosition(cc.p(380, 273))
	regionTableView:setBounceable(false)
	regionTableView:reloadData()

	self._regionTableView = regionTableView

	local initPosY = (orderTabSize - self._regionIndex) * -44

	self._regionTableView:setContentOffset(cc.p(0, initPosY), false)
end

function SetAreaPopMediator:initAreaTab()
	local areaTableView = cc.TableView:create(cc.size(176, 132))

	local function cellSize(table, idx)
		return 176, 44
	end

	local function cellTouched(table, cell)
		return
	end

	local function numberOfCitys(view)
		return #self._citys + 2
	end

	local function onScroll(table)
		if self._areaTimer ~= nil then
			return
		end

		local function autoCenterCell()
			if not table:isDragging() and not table:isTouchMoved() then
				table:stopScroll()

				local amountOfCitys = numberOfCitys()
				local offX = table:getContentOffset().y
				local a, b = math.modf(-offX / 44)
				local entity = a

				if b > 0.5 and a < amountOfCitys - 3 or a == -1 then
					entity = a + 1
				end

				local entityPosY = entity * -44

				self._areaIndex = amountOfCitys - entity - 2

				table:setContentOffsetInDuration(cc.p(0, entityPosY), 0.1)
				performWithDelay(self:getView(), function()
					local offX = table:getContentOffset().y

					table:reloadData()
					table:setContentOffset(cc.p(0, offX), false)
					self._areaTimer:stop()

					self._areaTimer = nil

					self._btnOk:setGray(false)
					self._btnOk:setTouchEnabled(true)
				end, 0.3)
			else
				self._btnOk:setGray(true)
				self._btnOk:setTouchEnabled(false)
			end
		end

		self._areaTimer = LuaScheduler:getInstance():schedule(autoCenterCell, 1, false)
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		if not cell:getChildByName("areaText") then
			local regionText = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

			regionText:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			regionText:ignoreContentAdaptWithSize(false)
			regionText:setContentSize(cc.size(150, 30))
			regionText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			regionText:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
			regionText:addTo(cell):setName("areaText")
			regionText:center(cc.size(176, 44))
		end

		if self._areaIndex == idx then
			cell:getChildByName("areaText"):setTextColor(cc.c4b(255, 255, 255, 255))
		else
			cell:getChildByName("areaText"):setTextColor(cc.c4b(127, 127, 127, 255))
		end

		if index == 1 or index == numberOfCitys() then
			cell:getChildByName("areaText"):setString("")
		else
			cell:getChildByName("areaText"):setString(Strings:get(self._citys[idx]))
		end

		return cell
	end

	areaTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	areaTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	areaTableView:setDelegate()
	areaTableView:registerScriptHandler(numberOfCitys, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	areaTableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	areaTableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	areaTableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	areaTableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	areaTableView:addTo(self._main)
	areaTableView:setPosition(cc.p(580, 273))
	areaTableView:setBounceable(false)
	areaTableView:reloadData()

	self._areaTableView = areaTableView

	local initPosY = (#self._citys - self._areaIndex) * -44

	self._areaTableView:setContentOffset(cc.p(0, initPosY), false)
end

function SetAreaPopMediator:onClickClose(sender, eventType)
	self:close()
end

function SetAreaPopMediator:parseAreaInfo(areaStr)
	local parts = string.split(areaStr, "-", nil, true)
	local _tab = {}

	_tab.regionId = parts[1]

	for k, v in ipairs(orderTab) do
		if v.Id == parts[1] then
			_tab.regionIndex = k

			break
		end
	end

	_tab.areaIndex = tonumber(parts[2])

	return _tab
end

function SetAreaPopMediator:onClickChoose()
	if self:checkLegalArea({
		regionId = self._regionId,
		areaIndex = self._areaIndex
	}) then
		local str = tostring(self._regionId) .. "-" .. tostring(self._areaIndex)

		self:close({
			areaStr = str
		})
	end
end

function SetAreaPopMediator:checkLegalArea(areaTab)
	local _regionId = areaTab.regionId
	local _areaIndex = areaTab.areaIndex
	local areaInfo = regionData[_regionId]

	if not areaInfo then
		return false
	end

	if not areaInfo.City[_areaIndex] then
		return false
	end

	return true
end

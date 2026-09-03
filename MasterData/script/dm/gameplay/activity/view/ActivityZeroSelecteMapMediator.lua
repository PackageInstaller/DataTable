-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityZeroSelecteMapMediator.lua

ActivityZeroSelectMapMediator = class("ActivityZeroSelectMapMediator", DmPopupViewMediator, _M)

ActivityZeroSelectMapMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.closeBack"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBack"
	}
}
local cellTag = "666"

function ActivityZeroSelectMapMediator:initialize()
	super.initialize(self)
end

function ActivityZeroSelectMapMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivityZeroSelectMapMediator:dispose()
	super.dispose(self)
end

function ActivityZeroSelectMapMediator:enterWithData(data)
	self._activityId = data.activityId

	self:initData()
	self:setupView()
	self:createTableView()
end

function ActivityZeroSelectMapMediator:initData()
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._map = self._activity:getMap()
	self._mapList = self._activity:getMapList()
end

function ActivityZeroSelectMapMediator:resumeWithData()
	self:initData()
	self._tableView:reloadData()
end

function ActivityZeroSelectMapMediator:createTableView()
	local size = self._cellPanel:getContentSize()

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height + 0
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local itemCell = self._cellPanel:clone()

			itemCell:setVisible(true)
			itemCell:setTag(cellTag)
			itemCell:setPosition(cc.p(0, 0))
			cell:setTag(idx + 1)
			cell:addChild(itemCell)
		end

		self:updateCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._mapList
	end

	local tableView = cc.TableView:create(self._scrollPanel:getContentSize())

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	self._scrollPanel:addChild(tableView, 100)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function ActivityZeroSelectMapMediator:updateCell(tableViewCell, index)
	local cellPanel = tableViewCell:getChildByTag(cellTag)
	local cell = cellPanel:getChildByFullName("cell")
	local mapBg = cell:getChildByFullName("mapBg")
	local lockBg = cell:getChildByFullName("lock_bg")
	local unlockDesc = lockBg:getChildByFullName("unlockDesc")
	local rightLine = cell:getChildByFullName("right_line")
	local progress = cell:getChildByFullName("progress")
	local chapter = cell:getChildByFullName("chapter")
	local chapterNum = cell:getChildByFullName("chapter_num")
	local mapName = cell:getChildByFullName("mapName")
	local button = cell:getChildByFullName("button")

	button:setSwallowTouches(false)

	local curData = self._map[self._mapList[index]]
	local curMapId = curData:getId()
	local isOpen = curData:getIsOpen()
	local mapBgName = curData:getMapBgName()
	local mapNameStr = curData:getMapName()
	local getMapConditionTime = curData:getMapConditionTime()
	local explorePoint = curData:getExplorePoint()
	local descStr, progressStr = "", ""

	if getMapConditionTime and getMapConditionTime ~= "" then
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local curTime = gameServerAgent:remoteTimestamp()
		local time = TimeUtil:formatStrToTImestamp(getMapConditionTime)

		if curTime < time then
			descStr = getMapConditionTime .. Strings:get("Activity_Zero_title_8")
			isOpen = false
			progressStr = Strings:get("Activity_Zero_title_10")
		end
	end

	if not isOpen and descStr == "" then
		descStr = Strings:get("Activity_Zero_title_9")
	end

	mapBg:setVisible(true)

	if mapBgName then
		mapBg:loadTexture("asset/ui/activity/" .. mapBgName, ccui.TextureResType.localType)
	end

	lockBg:setVisible(not isOpen)
	chapter:setString(Strings:get("Activity_Zero_title_2"))
	chapterNum:setString(index)
	mapName:setString(mapNameStr)
	unlockDesc:setString(descStr)
	progress:setString(progressStr ~= "" and progressStr or Strings:get("Activity_Zero_title_3", {
		value = explorePoint
	}))
	rightLine:setVisible(index ~= 1)

	local function callFunc()
		if not isOpen then
			self:dispatch(ShowTipEvent({
				tip = descStr
			}))

			return
		end

		self._activity:setCurMapId(curMapId)
		self._activitySystem:enterBlockMap(self._activityId)
		self:onClickBack()
	end

	mapButtonHandlerClick(nil, button, {
		func = callFunc
	})
end

function ActivityZeroSelectMapMediator:removeTableView()
	return
end

function ActivityZeroSelectMapMediator:setupView()
	self._main = self:getView():getChildByFullName("main")
	self._scrollPanel = self._main:getChildByFullName("scroll")
	self._cellPanel = self._main:getChildByFullName("cell")

	self._cellPanel:setVisible(false)
end

function ActivityZeroSelectMapMediator:refreshData()
	return
end

function ActivityZeroSelectMapMediator:refreshView(hasAnim)
	return
end

function ActivityZeroSelectMapMediator:updateView()
	self:refreshData()
end

function ActivityZeroSelectMapMediator:onClickBack(sender, eventType)
	self:close()
end

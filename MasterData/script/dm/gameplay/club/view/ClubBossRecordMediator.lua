-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossRecordMediator.lua

ClubBossRecordMediator = class("ClubBossRecordMediator", DmPopupViewMediator)

ClubBossRecordMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossRecordMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		ignoreClickAudio = true,
		func = "onCloseClicked"
	}
}

function ClubBossRecordMediator:initialize()
	super.initialize(self)
end

function ClubBossRecordMediator:dispose()
	super.dispose(self)
end

function ClubBossRecordMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function ClubBossRecordMediator:mapEventListeners()
	return
end

function ClubBossRecordMediator:enterWithData(data)
	self:initDate(data)
	self:initNodes()
	self:createTableView()
end

function ClubBossRecordMediator:initDate(data)
	self._allData = data

	table.sort(self._allData, function(a, b)
		return a.hurt > b.hurt
	end)
end

function ClubBossRecordMediator:initNodes()
	self._main = self:getView():getChildByName("main")
	self._viewPanel = self._main:getChildByFullName("viewPanel")
	self._cellPanel = self:getView():getChildByFullName("clonePanel")

	self._cellPanel:setVisible(false)

	self._titleNode = self._main:getChildByFullName("title_node")

	local config = {
		title = Strings:get("clubBoss_57"),
		title1 = Strings:get("clubBoss_58")
	}

	self._titleNode:setVisible(true)
	self._titleNode:setLocalZOrder(3)

	local injector = self:getInjector()
	local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

	titleWidget:updateView(config)
end

function ClubBossRecordMediator:createTableView()
	local function cellSizeForTable(table, idx)
		return 694, 47
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)
		end

		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, self._allData[idx + 1], idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._allData
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	self._viewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
	tableView:setBounceable(false)
end

function ClubBossRecordMediator:createCell(cell, data, rankID)
	cell:removeAllChildren()

	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local rank = panel:getChildByName("rank")

	rank:setVisible(false)

	local rankBg1 = panel:getChildByName("rankBg1")

	rankBg1:setVisible(false)

	local rankBg2 = panel:getChildByName("rankBg2")

	rankBg2:setVisible(false)

	local rankBg3 = panel:getChildByName("rankBg3")

	rankBg3:setVisible(false)

	local Image_3 = panel:getChildByName("Image_3")

	Image_3:setVisible(rankID % 2 == 0)

	local Image_4 = panel:getChildByName("Image_4")

	Image_4:setVisible(false)

	if rankID == 1 then
		rankBg1:setVisible(true)
	elseif rankID == 2 then
		rankBg2:setVisible(true)
	elseif rankID == 3 then
		rankBg3:setVisible(true)
	else
		rank:setVisible(true)
		rank:setString(tostring(rankID))
	end

	local nameText = panel:getChildByName("nameText")

	nameText:setString(data.name)

	local scoreText = panel:getChildByName("scoreText")

	scoreText:setString(data.hurt)

	local battleTime = panel:getChildByName("battleTime")

	battleTime:setString(data.times)

	if data.rid == self._developSystem:getPlayer():getRid() then
		Image_4:setVisible(true)
	end
end

function ClubBossRecordMediator:onCloseClicked(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end

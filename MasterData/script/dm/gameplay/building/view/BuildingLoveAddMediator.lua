-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingLoveAddMediator.lua

BuildingLoveAddMediator = class("BuildingLoveAddMediator", DmPopupViewMediator)

BuildingLoveAddMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingLoveAddMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local clickEventMap = {
	["main.Button_know"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}
local kCellWidth, kCellHeight, kCellGap = 700, 55, 0

function BuildingLoveAddMediator:initialize()
	super.initialize(self)
end

function BuildingLoveAddMediator:dispose()
	super.dispose(self)
end

function BuildingLoveAddMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingLoveAddMediator:mapEventListeners()
	return
end

function BuildingLoveAddMediator:enterWithData(data)
	self._roomList = data.roomList

	self:setupView()
	self:createTableView()
	self:refreshView()
	self:mapEventListeners()
end

function BuildingLoveAddMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._panel_list = self._mainPanel:getChildByFullName("Panel_list")
	self._cell = self._mainPanel:getChildByFullName("cell")
	self._text_know = self._mainPanel:getChildByFullName("Text_know")

	self._text_know:enableUnderline()
end

function BuildingLoveAddMediator:refreshView()
	self._tableView:reloadData()
end

function BuildingLoveAddMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingLoveAddMediator:createTableView()
	local viewSize = self._panel_list:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._roomList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, index)
		return kCellWidth, kCellHeight + kCellGap
	end

	local function cellAtIndex(tableView, index)
		local cell = tableView:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local roomCell = self._cell:clone()

			cell:addChild(roomCell)
			roomCell:setPosition(0, 0)
			roomCell:setName("CellItem")
			roomCell:setVisible(true)
		end

		self:updateTableCell(cell, index + 1)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(self._panel_list:getPosition())
	tableView:setDelegate()
	self._panel_list:getParent():addChild(tableView, 99)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView = tableView
end

function BuildingLoveAddMediator:updateTableCell(cell, index)
	local cellItem = cell:getChildByFullName("CellItem")
	local text_name = cellItem:getChildByFullName("Text_name")
	local image_line_1 = cellItem:getChildByFullName("Image_line_1")

	if index == 1 then
		image_line_1:setVisible(true)
	else
		image_line_1:setVisible(false)
	end

	local roomData = self._roomList[index]
	local roomId = roomData.roomId
	local heroList = roomData.heroList
	local textRoomDes = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Name")

	text_name:setString(Strings:get(textRoomDes))

	for i = 1, 4 do
		local node_head = cellItem:getChildByFullName("Node_head_" .. i)

		if node_head:getChildByFullName("headImg") then
			node_head:removeChildByName("headImg")
		end

		if node_head:getChildByFullName("numAdd") then
			node_head:removeChildByName("numAdd")
		end

		node_head:setVisible(false)
	end

	local index = 0
	local heroSystem = self._developSystem:getHeroSystem()

	for k, v in pairs(heroList) do
		if index >= 4 then
			return
		end

		local node_head = cellItem:getChildByFullName("Node_head_" .. index + 1)

		node_head:setVisible(true)

		local roleModel = IconFactory:getRoleModelByKey("HeroBase", k)
		local icon = IconFactory:createRoleIconSpriteNew({
			id = roleModel
		})

		icon:setScale(0.5)

		local stencilForIcon = IconFactory:addStencilForIcon(icon, 2, cc.size(100, 100), {
			0,
			0
		})

		stencilForIcon:addTo(node_head):posite(5, 5)
		stencilForIcon:setScale(0.4)
		stencilForIcon:setName("headImg")

		local numNode = self:createNumLabel(v)

		numNode:addTo(node_head):posite(23, -6)
		numNode:setScale(0.5)
		numNode:setName("numAdd")

		index = index + 1
	end
end

function BuildingLoveAddMediator:createNumLabel(value)
	local node = cc.Node:create()
	local imageAdd = ccui.ImageView:create("jq_word_add.png", 1)

	node:addChild(imageAdd)

	local width = 20

	for i = 1, utf8.len(value) do
		local num = string.sub(tostring(value), i, i)
		local child = ccui.ImageView:create("jq_word_" .. num .. ".png", 1)

		child:setAnchorPoint(cc.p(0.5, 0.5))
		child:setPosition(width, 0)
		node:addChild(child)

		width = width + child:getContentSize().width - 20
	end

	return node
end

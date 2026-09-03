-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/DebugBoxTool.lua

DebugBoxTool = {}

function DebugBoxTool:getResPath(resName)
	return "debug/" .. resName
end

function DebugBoxTool:createTableView(rootNode, scollViewRect, delegate)
	assert(delegate ~= nil, "can not be nil")

	local panel = rootNode
	local scollerCell

	if delegate and delegate.createCellTemplate then
		scollerCell = delegate:createCellTemplate()
	end

	assert(scollerCell ~= nil, "function delegate.createCellTemplate can not be nil")
	scollerCell:setVisible(false)
	rootNode:addChild(scollerCell)

	local selectCell
	local kCellRoundTag = 110

	local function scrollViewDidScroll(view)
		return
	end

	local function scrollViewDidZoom(view)
		return
	end

	local function tableCellTouched(table, cell)
		if delegate and delegate.tableCellTouched then
			delegate:tableCellTouched(table, cell)
		end
	end

	local roundRowSize = scollerCell:getContentSize()

	local function cellSizeForTable(table, idx)
		if delegate and delegate.cellSizeForTable then
			local width, height = delegate:cellSizeForTable(table, idx)

			if width ~= nil then
				return width, height
			end
		end

		return roundRowSize.width, roundRowSize.height
	end

	local function createCell(cell, idx, table)
		if delegate and delegate.createCell then
			delegate:createCell(cell, idx, table)
		end
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCellByTag(idx)

		if cell == nil then
			cell = cc.TableViewCell:new()

			local _, height = cellSizeForTable(table, idx)
			local roundCell = scollerCell:clone()

			roundCell:setPosition(cc.p(0, height))
			roundCell:setAnchorPoint(cc.p(0, 1))
			roundCell:setVisible(true)
			cell:addChild(roundCell, 11, kCellRoundTag)
			cell:setTag(idx)
			createCell(roundCell, idx + 1, table)
		else
			local _, height = cellSizeForTable(table, idx)
			local roundCell = cell:getChildByTag(kCellRoundTag)

			roundCell:setPosition(cc.p(0, height))
			createCell(roundCell, idx + 1, table)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		if delegate and delegate.cellNum then
			return delegate:cellNum(cell, idx)
		end

		return 0
	end

	local size = scollViewRect:getContentSize()

	size.height = size.height - 6
	size.width = size.width - 6

	local scollerView = cc.TableView:create(size)

	scollerView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	scollerView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	scollerView:setPosition(scollViewRect:getPosition())
	scollerView:setPositionX(scollerView:getPositionX() + 2)
	scollerView:setDelegate()
	panel:addChild(scollerView, 9999)
	scollerView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	scollerView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	scollerView:registerScriptHandler(scrollViewDidZoom, cc.SCROLLVIEW_SCRIPT_ZOOM)
	scollerView:registerScriptHandler(tableCellTouched, cc.TABLECELL_TOUCHED)
	scollerView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	scollerView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	scollerView:setTouchEnabled(true)
	scollerView:reloadData()
	scollerView:setTag(999991)
	scollerView:setName("scollerView")

	return scollerView
end

function DebugBoxTool:centerAddNode(parentNode, node, zorder, tag, offset)
	if parentNode and node then
		local ps = parentNode:getContentSize()
		local cs = node:getContentSize()
		local cax, cay = node:getAnchorPoint().x, node:getAnchorPoint().y
		local x, y = ps.width * 0.5 - (0.5 - cax) * cs.width, ps.height * 0.5 - (0.5 - cay) * cs.height

		if offset then
			x = x + offset.x
			y = y + offset.y
		end

		node:setPosition(x, y)
		parentNode:addChild(node, zorder or 0, tag or 0)
	else
		pclog("warning", "parentNode or node is nil!!!")
	end
end

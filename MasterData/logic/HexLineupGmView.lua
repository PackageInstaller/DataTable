-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupGmView.lua

module("logic.extensions.hexlineup.view.HexLineupGmView", package.seeall)

local function hexToPixel(q, r, cellW, cellH)
	local px = (q + r * 0.5) * cellW
	local py = -r * cellH * 0.75

	return px, py
end

local function hexKey(q, r)
	return q .. "_" .. r
end

local function cubeRoundFromFloat(qf, rf, sf)
	local rq = math.floor(qf + 0.5)
	local rr = math.floor(rf + 0.5)
	local rs = math.floor(sf + 0.5)
	local dq = math.abs(rq - qf)
	local dr = math.abs(rr - rf)
	local ds = math.abs(rs - sf)

	if dr < dq and ds < dq then
		rq = -rr - rs
	elseif ds < dr then
		rr = -rq - rs
	else
		rs = -rq - rr
	end

	return rq, rr, rs
end

local function inBoardRange(q, r, R)
	local s = -q - r

	return R >= math.max(math.abs(q), math.abs(r), math.abs(s))
end

local function parseOffsetsStr(offsetStr)
	local list = {}

	for part in string.gmatch(offsetStr or "", "[^#]+") do
		local qStr, rStr = string.match(part, "(-?%d+):(-?%d+)")

		if qStr and rStr then
			local q = tonumber(qStr)
			local r = tonumber(rStr)
			local s = -q - r

			table.insert(list, {
				q = q,
				r = r,
				s = s
			})
		end
	end

	return list
end

local HexLineupGmView = class("HexLineupGmView", ViewComponent)
local BOARD_RADIUS = 5
local GM_PIECE_COLOR_IDX = 2

function HexLineupGmView:ctor()
	HexLineupGmView.super.ctor(self)

	self._selected = {}
	self._gridCellMap = {}
	self._pieceRowPreviewByRowGo = {}
end

function HexLineupGmView:buildUI()
	HexLineupGmView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnCopy = self:getGo("btnCopy")
	self._txtOutput = self:getTxt("output/txt")
	self._gridView = self:getGo("gridView")
	self._gridCell = self:getGo("gridCell")

	local cellRt = self._gridCell:GetComponent(ComponentType.RectTransform)

	self._cellWidth = cellRt.sizeDelta.x
	self._cellHeight = cellRt.sizeDelta.y
	self._pieceScrView = self:getGo("pieceScrView")
	self._pieceScrCell = self:getGo("pieceScrCell")
	self._pieceChild = self:getGo("pieceChild")
	self._pieceCellTemplate = self:getGo("pieceScrCell/pieceCell")
	self._pieceScrollerList = ScrollerList.create(self._pieceScrView, self._pieceScrCell, GameUtil.handler(self._updatePieceScrCell, self), GameUtil.handler(self._clearPieceScrCell, self))
end

function HexLineupGmView:bindEvents()
	HexLineupGmView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickBtnCopy, self)
end

function HexLineupGmView:unbindEvents()
	HexLineupGmView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCopy)

	if self._gridCellMap then
		for _, cell in pairs(self._gridCellMap) do
			if cell and cell.mainGo then
				GameUtil.rmClickHandler(cell.mainGo)
			end
		end
	end
end

function HexLineupGmView:onEnter()
	HexLineupGmView.super.onEnter(self)

	self._selected = {}
	self._R = BOARD_RADIUS - 1
	self._pieceRowPreviewByRowGo = {}

	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._pieceScrCell, false)
	GameUtil.SetActive(self._pieceChild, false)
	self:_createGridCellPool()
	self:_createPieceChildPool()
	self:_generateBoard()

	local pieceDataList = HexLineupConfig.instance:getPieceDataList() or {}

	self._pieceScrollerList:reloadData(pieceDataList)
	self:_refreshOutputTxt()
end

function HexLineupGmView:onExit()
	HexLineupGmView.super.onExit(self)

	if self._pieceScrollerList then
		self._pieceScrollerList:dispose()
	end

	self._selected = {}

	if self._gridCellMap then
		for _, cell in pairs(self._gridCellMap) do
			if self._gridCellPool then
				self._gridCellPool:returnObject(cell)
			end
		end
	end

	self._gridCellMap = {}

	if self._gridCellPool then
		self._gridCellPool:clear()

		self._gridCellPool = nil
	end

	if self._pieceChildPool then
		self._pieceChildPool:clear()

		self._pieceChildPool = nil
	end

	self._pieceRowPreviewByRowGo = {}
end

function HexLineupGmView:_getSelectedCoordList()
	local list = {}

	for key, on in pairs(self._selected) do
		if on then
			local q, r = string.match(key, "(-?%d+)_(-?%d+)")

			if q and r then
				table.insert(list, {
					q = tonumber(q),
					r = tonumber(r)
				})
			end
		end
	end

	return list
end

function HexLineupGmView:_buildExportString()
	local coords = self:_getSelectedCoordList()

	if #coords <= 0 then
		return ""
	end

	local q0, r0

	for _, c in ipairs(coords) do
		if q0 ~= nil and q0 <= c.q then
			if c.q == q0 and r0 > c.r then
				r0 = c.r
				q0 = c.q
			end
		end
	end

	local norm = {}

	for _, c in ipairs(coords) do
		table.insert(norm, {
			q = c.q - q0,
			r = c.r - r0
		})
	end

	table.sort(norm, function(a, b)
		if a.q ~= b.q then
			return a.q < b.q
		end

		return a.r < b.r
	end)

	local parts = {}

	for _, c in ipairs(norm) do
		table.insert(parts, c.q .. ":" .. c.r)
	end

	return table.concat(parts, "#")
end

function HexLineupGmView:_refreshOutputTxt()
	if self._txtOutput then
		self._txtOutput.text = self:_buildExportString()
	end
end

function HexLineupGmView:_createGridCellPool()
	if self._gridCellPool then
		return
	end

	local templateGo = self._gridCell

	local function createFunc()
		local mainGo = goutil.clone(templateGo)
		local iconGo = goutil.findChild(mainGo, "icon")

		GameUtil.SetActive(iconGo, false)

		return {
			mainGo = mainGo,
			icon = iconGo
		}
	end

	local function disposeFunc(cell)
		if cell.mainGo then
			goutil.destroy(cell.mainGo)

			cell.mainGo = nil
		end
	end

	local function resetFunc(cell)
		GameUtil.SetActive(cell.mainGo, false)
		GameUtil.SetActive(cell.icon, false)
	end

	self._gridCellPool = ObjectPool.New(120, createFunc, disposeFunc, resetFunc)
end

function HexLineupGmView:_generateBoard()
	local R = self._R

	self._gridCellMap = {}

	for q = -R, R do
		local r1 = math.max(-R, -q - R)
		local r2 = math.min(R, -q + R)

		for r = r1, r2 do
			local key = hexKey(q, r)
			local cell = self._gridCellPool:fetchObject()

			goutil.addChildToParent(cell.mainGo, self._gridView)

			local px, py = hexToPixel(q, r, self._cellWidth, self._cellHeight)

			GameUtil.setLocalPos(cell.mainGo, px, py)
			GameUtil.SetActive(cell.mainGo, true)
			GameUtil.SetActive(cell.icon, false)

			self._gridCellMap[key] = cell

			local cq, cr = q, r

			GameUtil.addClickHandler(cell.mainGo, function()
				self:_onClickGridCell(cq, cr)
			end)
		end
	end
end

function HexLineupGmView:_onClickGridCell(q, r)
	local key = hexKey(q, r)

	self._selected[key] = not self._selected[key]

	self:_refreshCellVisual(key)
	self:_refreshOutputTxt()
end

function HexLineupGmView:_refreshCellVisual(key)
	local cell = self._gridCellMap[key]

	if not cell then
		return
	end

	local on = self._selected[key]

	GameUtil.SetActive(cell.icon, on)

	if on then
		GameUtil.setUIImageColorIdx(cell.icon, GM_PIECE_COLOR_IDX)
	end
end

function HexLineupGmView:_syncAllCellVisual()
	for key, _ in pairs(self._gridCellMap) do
		self:_refreshCellVisual(key)
	end
end

function HexLineupGmView:_findFitTranslation(localizedList)
	local R = self._R
	local bestTq, bestTr, bestDist

	for tq = -8, 8 do
		for tr = -8, 8 do
			local ok = true

			for _, c in ipairs(localizedList) do
				local bq = c.q + tq
				local br = c.r + tr

				if not inBoardRange(bq, br, R) then
					ok = false

					break
				end
			end

			if ok then
				local dist = math.abs(tq) + math.abs(tr)

				if bestDist == nil or dist < bestDist then
					bestDist = dist
					bestTr = tr
					bestTq = tq
				end
			end
		end
	end

	if bestDist == nil then
		printError("[HexLineupGmView] 形状无法完全放入棋盘，请缩小 offsets")

		return 0, 0
	end

	return bestTq, bestTr
end

function HexLineupGmView:_loadOffsetsOntoBoard(offsetStr)
	local raw = parseOffsetsStr(offsetStr)

	if #raw <= 0 then
		for k, _ in pairs(self._gridCellMap) do
			self._selected[k] = false
		end

		self:_syncAllCellVisual()
		self:_refreshOutputTxt()

		return
	end

	local n = #raw
	local sq, sr, ss = 0, 0, 0

	for _, o in ipairs(raw) do
		sq = sq + o.q
		sr = sr + o.r
		ss = ss + o.s
	end

	local cq, cr, cs = cubeRoundFromFloat(sq / n, sr / n, ss / n)
	local localized = {}

	for _, o in ipairs(raw) do
		table.insert(localized, {
			q = o.q - cq,
			r = o.r - cr,
			s = o.s - cs
		})
	end

	local tq, tr = self:_findFitTranslation(localized)

	for k, _ in pairs(self._gridCellMap) do
		self._selected[k] = false
	end

	for _, c in ipairs(localized) do
		local bq = c.q + tq
		local br = c.r + tr
		local key = hexKey(bq, br)

		if self._gridCellMap[key] then
			self._selected[key] = true
		end
	end

	self:_syncAllCellVisual()
	self:_refreshOutputTxt()
end

function HexLineupGmView:_takeDownPiecePreviewForRowGo(rowGo)
	if not rowGo or not self._pieceRowPreviewByRowGo then
		return
	end

	local pieceChildren = self._pieceRowPreviewByRowGo[rowGo]

	if pieceChildren then
		self:_returnPieceChildren(pieceChildren)

		self._pieceRowPreviewByRowGo[rowGo] = nil
	end
end

function HexLineupGmView:_updatePieceScrCell(view, cell, pieceData, tag)
	if not pieceData then
		return
	end

	local mainGo = cell.gameObject

	self:_takeDownPiecePreviewForRowGo(mainGo)
	GameUtil.rmClickHandler(mainGo)

	local txtPieceId = goutil.findChildTextComponent(mainGo, "txtPieceId")

	if txtPieceId then
		txtPieceId.text = tostring(pieceData.pieceId)
	end

	local pieceCellGo = goutil.findChild(mainGo, "pieceCell")
	local pieceX = Framework.TransformUtil.GetLocalScale(self._pieceCellTemplate.transform, 0, 0, 0)
	local rowScale = pieceX > 0 and pieceX or 0.45

	if pieceCellGo then
		pieceCellGo.transform.localScale = Vector3(rowScale, rowScale, 1)
	end

	local offsets = parseOffsetsStr(pieceData.offsets)

	self._pieceRowPreviewByRowGo[mainGo] = self:_buildPiecePreview(pieceCellGo, offsets)

	local pieceId = pieceData.pieceId

	GameUtil.addClickHandler(mainGo, function()
		self:_onClickPieceRow(pieceId)
	end)
end

function HexLineupGmView:_clearPieceScrCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
	self:_takeDownPiecePreviewForRowGo(mainGo)
end

function HexLineupGmView:_createPieceChildPool()
	if self._pieceChildPool then
		return
	end

	local templateGo = self._pieceChild

	local function createFunc()
		local mainGo = goutil.clone(templateGo)

		return {
			mainGo = mainGo
		}
	end

	local function disposeFunc(child)
		if child.mainGo then
			goutil.destroy(child.mainGo)

			child.mainGo = nil
		end
	end

	local function resetFunc(child)
		GameUtil.SetActive(child.mainGo, false)
	end

	self._pieceChildPool = ObjectPool.New(40, createFunc, disposeFunc, resetFunc)
end

function HexLineupGmView:_returnPieceChildren(pieceChildren)
	if pieceChildren == nil then
		return
	end

	for _, child in ipairs(pieceChildren) do
		if self._pieceChildPool and child.mainGo then
			goutil.addChildToParent(child.mainGo, self._pieceScrView)
			self._pieceChildPool:returnObject(child)
		end
	end
end

function HexLineupGmView:_layoutPreviewChildren(offsets, pieceChildren, extraX, extraY)
	extraX = extraX or 0
	extraY = extraY or 0

	for i, child in ipairs(pieceChildren) do
		local offset = offsets[i]

		if offset then
			local px, py = hexToPixel(offset.q, offset.r, self._cellWidth, self._cellHeight)

			GameUtil.setLocalPos(child.mainGo, px + extraX, py + extraY)
		end
	end
end

function HexLineupGmView:_buildPiecePreview(pieceCellGo, offsets)
	if not pieceCellGo or #offsets <= 0 then
		return {}
	end

	local centerX, centerY = 0, 0

	for _, offset in ipairs(offsets) do
		local px, py = hexToPixel(offset.q, offset.r, self._cellWidth, self._cellHeight)

		centerX = centerX + px
		centerY = centerY + py
	end

	centerX = centerX / #offsets
	centerY = centerY / #offsets

	local pieceChildren = {}

	for _ = 1, #offsets do
		local child = self._pieceChildPool:fetchObject()

		goutil.addChildToParent(child.mainGo, pieceCellGo)
		GameUtil.setUIImageColorIdx(child.mainGo, GM_PIECE_COLOR_IDX)
		GameUtil.SetActive(child.mainGo, true)
		table.insert(pieceChildren, child)
	end

	self:_layoutPreviewChildren(offsets, pieceChildren, -centerX, -centerY)

	return pieceChildren
end

function HexLineupGmView:_onClickPieceRow(pieceId)
	local pdata = HexLineupConfig.instance:getPieceData(pieceId)

	if not pdata then
		return
	end

	self:_loadOffsetsOntoBoard(pdata.offsets or "")
end

function HexLineupGmView:_onClickBtnCopy()
	Clipboard.copy(self:_buildExportString())
end

return HexLineupGmView

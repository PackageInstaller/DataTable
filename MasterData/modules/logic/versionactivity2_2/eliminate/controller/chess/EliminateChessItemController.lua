-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/EliminateChessItemController.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessItemController", package.seeall)

local EliminateChessItemController = class("EliminateChessItemController")

function EliminateChessItemController:ctor()
	self._chess = {}
	self._chessboard = {}
	self._chessboardMaxWidth = 0
	self._chessboardMaxHeight = 0
	self._chessboardMaxRowValue = 0
	self._chessboardMaxLineValue = 0
end

function EliminateChessItemController:InitCloneGo(chessGo, chessBoardGo, chessParent, chessBoardParent)
	if gohelper.isNil(chessGo) or gohelper.isNil(chessBoardGo) or gohelper.isNil(chessParent) or gohelper.isNil(chessBoardParent) then
		return false
	end

	self._gochess = chessGo
	self._gochessBoard = chessBoardGo
	self._gochessBg = chessParent
	self._gochessBoardBg = chessBoardParent

	return true
end

function EliminateChessItemController:InitChess()
	local chessList = EliminateChessModel.instance:getChessMoList()

	for i = 1, #chessList do
		if self._chess[i] == nil then
			self._chess[i] = {}
		end

		local row = chessList[i]

		for j = 1, #row do
			local chessMo = row[j]
			local chessItem = self:createChess(i, j)

			chessItem:initData(chessMo)

			self._chess[i][j] = chessItem
		end
	end
end

function EliminateChessItemController:refreshChess()
	for i = 1, #self._chess do
		local row = self._chess[i]

		for j = 1, #row do
			local chess = row[j]

			chess:updateInfo()
		end
	end
end

function EliminateChessItemController:InitChessBoard()
	local chessList = EliminateChessModel.instance:getChessMoList()

	for i = 1, #chessList do
		if self._chessboard[i] == nil then
			self._chessboard[i] = {}
		end

		local row = chessList[i]

		for j = 1, #row do
			local chessMo = row[j]
			local cloneGo = gohelper.clone(self._gochessBoard, self._gochessBoardBg, string.format("chessBoard_%d_%d", i, j))

			gohelper.setActiveCanvasGroup(cloneGo, false)

			local chessBoardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EliminateChessBoardItem, self)

			chessBoardItem:initData(chessMo)

			self._chessboard[i][j] = chessBoardItem
		end
	end

	if chessList and #chessList > 0 then
		self._chessboardMaxWidth = #chessList * EliminateEnum.ChessWidth
		self._chessboardMaxHeight = #chessList[1] * EliminateEnum.ChessHeight
		self._chessboardMaxRowValue = #chessList
		self._chessboardMaxLineValue = #chessList[1]
	end
end

function EliminateChessItemController:createChess(x, y)
	local cloneGo = self:getChessItemGo(string.format("chess_%d_%d", x, y), x, y)
	local resItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EliminateChessItem, self)

	resItem:init(cloneGo)

	return resItem
end

function EliminateChessItemController:getMaxWidthAndHeight()
	return self._chessboardMaxWidth, self._chessboardMaxHeight
end

function EliminateChessItemController:getMaxLineAndRow()
	return self._chessboardMaxLineValue, self._chessboardMaxRowValue
end

function EliminateChessItemController:getChessItem(x, y)
	local chess

	if self._chess[x] ~= nil then
		chess = self._chess[x][y]
	end

	if chess == nil then
		logNormal("EliminateChessItemController:getChessItem chess is nil x = " .. x .. " y = " .. y)
	end

	return chess
end

function EliminateChessItemController:getChess()
	return self._chess
end

function EliminateChessItemController:updateChessItem(x, y, chessItem)
	self._chess[x][y] = chessItem

	if chessItem ~= nil then
		chessItem._go.name = string.format("chess_%d_%d", x, y)
	end
end

function EliminateChessItemController:getChessBoardItem(x, y)
	return self._chessboard[x][y]
end

function EliminateChessItemController:getChessItemByModel(model)
	for _, row in ipairs(self._chess) do
		for _, item in ipairs(row) do
			if item._data == model then
				return item
			end
		end
	end

	return nil
end

function EliminateChessItemController:getChessItemGo(name, x, y)
	if self.chessItemPool == nil then
		local maxCount = 62

		self.chessItemPool = LuaObjPool.New(maxCount, function()
			if gohelper.isNil(self._gochess) or gohelper.isNil(self._gochessBg) then
				logError("EliminateChessItemController:getChessItemGo self._gochess or self._gochessBg is nil")
			end

			local itemGo = gohelper.clone(self._gochess, self._gochessBg)

			if isDebugBuild and gohelper.isNil(itemGo) then
				logNormal("chessItemPool get go is nil")
			end

			gohelper.setActiveCanvasGroup(itemGo, false)

			return itemGo
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActiveCanvasGroup(itemGo, false)
			end
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				if isDebugBuild then
					itemGo.name = "cache"
				end

				gohelper.setActiveCanvasGroup(itemGo, false)
			end
		end)
	end

	local go = self.chessItemPool:getObject()

	if gohelper.isNil(go) then
		go = gohelper.clone(self._gochess, self._gochessBg)
	end

	if not string.nilorempty(name) then
		go.name = name
	end

	return go
end

function EliminateChessItemController:getDebugIndex(x, y)
	if self.debug == nil then
		self.debug = {}
	end

	if self.debug[x] == nil then
		self.debug[x] = {}
	end

	self.debug[x][y] = ((self.debug[x][y] or nil) and (self.debug[x][y] or 0)) + 1

	return self.debug[x][y]
end

function EliminateChessItemController:putChessItemGo(luaGo)
	if self.chessItemPool ~= nil then
		self.chessItemPool:putObject(luaGo)
	else
		gohelper.destroy(luaGo)
	end
end

function EliminateChessItemController:clear()
	for _, chessRow in pairs(self._chess) do
		for _, chess in pairs(chessRow) do
			chess:onDestroy()
		end
	end

	for _, chessboardRow in pairs(self._chessboard) do
		for _, chessboard in pairs(chessboardRow) do
			chessboard:onDestroy()
		end
	end

	if self.chessItemPool then
		self.chessItemPool:dispose()

		self.chessItemPool = nil
	end

	self._gochess = nil
	self._gochessBoard = nil
	self._gochessBg = nil
	self._gochessBoardBg = nil

	tabletool.clear(self._chess)
	tabletool.clear(self._chessboard)
end

EliminateChessItemController.instance = EliminateChessItemController.New()

return EliminateChessItemController

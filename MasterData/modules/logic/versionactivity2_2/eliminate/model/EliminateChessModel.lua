-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateChessModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateChessModel", package.seeall)

local EliminateChessModel = class("EliminateChessModel", BaseModel)

function EliminateChessModel:onInit()
	self._chessMo = {}
	self._chessConfig = {}
	self._chessBoardConfig = {}
	self._maxRow = 0
	self._maxCol = 0
	self._tips = nil
end

function EliminateChessModel:reInit()
	self._chessMo = {}
	self._chessConfig = {}
	self._chessBoardConfig = {}
	self._maxRow = 0
	self._maxCol = 0
	self._tips = nil
end

function EliminateChessModel:mockData()
	local data = T_lua_eliminate_level[1]
	local chess = data.chess
	local chessBoard = data.chessBoard

	self._maxRow = #chess

	for i = 1, #chess do
		if self._chessMo then
			self._chessMo[i] = {}
		end

		local row = chess[i]

		self._maxCol = #row

		for j = 1, #row do
			local id = row[j]
			local chessMo = EliminateChessMO.New()

			chessMo:setXY(i, j)
			chessMo:setStartXY(i, j)
			chessMo:setChessId(id)
			chessMo:setChessBoardType(chessBoard[i][j])

			self._chessMo[i][j] = chessMo
		end
	end
end

function EliminateChessModel:initChessInfo(info)
	local rowList = info.row

	if rowList == nil or #rowList <= 0 then
		return
	end

	self._maxRow = #rowList

	for i = 1, #rowList do
		if self._chessMo[i] == nil then
			self._chessMo[i] = {}
		end

		local row = rowList[i].chess

		for j = 1, #row do
			self._maxCol = #row

			local chess = row[j]
			local chessMo = self._chessMo[i][j]

			if chessMo == nil then
				chessMo = EliminateChessMO.New()
				self._chessMo[i][j] = chessMo
			end

			chessMo:setXY(i, j)
			chessMo:setStartXY(i, j)
			chessMo:setChessId(chess.id)
			chessMo:setChessBoardType(chess.type)
		end
	end

	self:createInitMoveState()
end

function EliminateChessModel:createInitMoveState()
	for i = 1, #self._chessMo do
		local row = self._chessMo[i]

		for j = 1, #row do
			local chessMo = row[j]

			chessMo:setStartXY(i, self._maxCol + 1)
		end
	end
end

function EliminateChessModel:getMaxRowAndCol()
	return self._maxRow, self._maxCol
end

function EliminateChessModel:posIsValid(x, y)
	return x >= 1 and x <= self._maxRow and y >= 1 and y <= self._maxCol
end

function EliminateChessModel:updateMatch3Tips(tips)
	self._tips = self._tips or EliminateTipMO.New()

	self._tips:updateInfoByServer(tips)
end

function EliminateChessModel:getTipEliminateCount()
	return self._tips and self._tips:getEliminateCount() or 0
end

function EliminateChessModel:updateMovePoint(movePoint)
	self._movePoint = movePoint or 0
end

function EliminateChessModel:getTipInfo()
	return self._tips
end

function EliminateChessModel:getChessMo(x, y)
	return self._chessMo[x][y]
end

function EliminateChessModel:updateChessMo(x, y, chessMo)
	self._chessMo[x][y] = chessMo
end

function EliminateChessModel:getChessMoList()
	return self._chessMo
end

function EliminateChessModel:getMovePoint()
	return self._movePoint
end

function EliminateChessModel:setRecordCurNeedShowEffectAndXY(x, y, effectType)
	self._recordShowEffectX = x
	self._recordShowEffectY = y
	self._recordShowEffectType = effectType
end

function EliminateChessModel:getRecordCurNeedShowEffectAndXYAndClear()
	local effectType = self._recordShowEffectType
	local x = self._recordShowEffectX
	local y = self._recordShowEffectY

	self._recordShowEffectType = nil
	self._recordShowEffectX = nil
	self._recordShowEffectY = nil

	return x, y, effectType
end

function EliminateChessModel:addCurPlayAudioCount()
	if self._playAudioCount then
		self._playAudioCount = self._playAudioCount + 1 or 1
	end
end

function EliminateChessModel:clearCurPlayAudioCount()
	self._playAudioCount = nil
end

function EliminateChessModel:getCurPlayAudioCount()
	if self._playAudioCount == nil then
		self._playAudioCount = 1
	end

	return self._playAudioCount
end

function EliminateChessModel:calEvaluateLevel()
	if self._eliminateTotalCount == nil then
		return nil
	end

	local gear = EliminateConfig.instance:getEvaluateGear()
	local gearLevel

	if gear and #gear == 3 then
		gearLevel = self._eliminateTotalCount < gear[2] and (self._eliminateTotalCount >= gear[1] and 1 or nil) or self._eliminateTotalCount < gear[3] and 2 or 3
	end

	return gearLevel
end

function EliminateChessModel:addTotalEliminateCount(count)
	if self._eliminateTotalCount == nil then
		self._eliminateTotalCount = 0
	end

	self._eliminateTotalCount = self._eliminateTotalCount + count
end

function EliminateChessModel:clearTotalCount()
	self._eliminateTotalCount = nil
end

function EliminateChessModel:getNeedResetData()
	return self._cacheData
end

function EliminateChessModel:setNeedResetData(data)
	self._cacheData = data
end

function EliminateChessModel:clear()
	self._chessMo = {}
	self._cacheData = nil
end

EliminateChessModel.instance = EliminateChessModel.New()

return EliminateChessModel

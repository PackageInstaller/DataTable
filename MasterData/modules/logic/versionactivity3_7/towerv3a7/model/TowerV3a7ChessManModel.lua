-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/model/TowerV3a7ChessManModel.lua

module("modules.logic.versionactivity3_7.towerv3a7.model.TowerV3a7ChessManModel", package.seeall)

local TowerV3a7ChessManModel = class("TowerV3a7ChessManModel", BaseModel)

function TowerV3a7ChessManModel:onInit()
	self:reInit()
end

function TowerV3a7ChessManModel:reInit()
	self._chessList = nil
	self._chessDelayList = nil
	self._chessAfterDieList = nil
	self._selectedChess = nil
	self._camp1ChessList = nil
	self._camp2ChessList = nil
end

function TowerV3a7ChessManModel:update()
	local time = TowerV3a7Model.instance:getTime()

	for i, v in pairs(self._chessDelayList) do
		if time >= v.appearValue then
			self._chessDelayList[i] = nil

			self:_addChess(v.chessConfig)
		end
	end
end

function TowerV3a7ChessManModel:initChess(chessList)
	self._chessList = {}
	self._chessDelayList = {}
	self._chessAfterDieList = {}
	self._camp1ChessList = {}
	self._camp2ChessList = {}

	for i, chessConfig in ipairs(chessList) do
		if chessConfig then
			local appearParams = string.splitToNumber(chessConfig.appear, "#")
			local type = appearParams[1]
			local value = appearParams[2]

			if type == TowerV3a7Enum.ChessAppearType.Init then
				self:_addChess(chessConfig)
			elseif type == TowerV3a7Enum.ChessAppearType.Delay then
				table.insert(self._chessDelayList, {
					appearValue = value,
					chessConfig = chessConfig
				})
			elseif type == TowerV3a7Enum.ChessAppearType.AfterDie then
				table.insert(self._chessAfterDieList, {
					appearValue = value,
					chessConfig = chessConfig
				})
			else
				logError("TowerV3a7ChessManModel:initChess error appear:" .. tostring(type), " id:" .. chessConfig.id)
			end

			if chessConfig.belong == TowerV3a7Enum.Camp.Own then
				table.insert(self._camp1ChessList, chessConfig)
			elseif chessConfig.belong == TowerV3a7Enum.Camp.Enemy then
				table.insert(self._camp2ChessList, chessConfig)
			end
		end
	end
end

function TowerV3a7ChessManModel:chessDie(mo)
	for k, v in ipairs(self._chessAfterDieList) do
		if v.appearValue == mo.id then
			self:_addChess(v.chessConfig)
		end
	end

	self:_checkAllEmenyChessDie()
end

function TowerV3a7ChessManModel:_checkAllEmenyChessDie()
	for i, v in ipairs(self._camp2ChessList) do
		local mo = self._chessList[v.id]

		if not mo or not mo:isDead() then
			return
		end
	end

	local params = {
		type = TowerV3a7Enum.StoryFinishTarget.KillAllEnemy
	}

	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryFinishTarget, params)
end

function TowerV3a7ChessManModel:_addChess(chessConfig)
	if self._chessList[chessConfig.id] then
		logError("TowerV3a7ChessManModel:_addChess error id:" .. chessConfig.id)

		return
	end

	local mo = TowerV3a7ChessMO.New()

	mo:init(chessConfig)

	self._chessList[chessConfig.id] = mo

	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryAddChessMan, mo)
	TowerV3a7RoomModel.instance:addChess(mo)
end

function TowerV3a7ChessManModel:getChess(id)
	return self._chessList[id]
end

function TowerV3a7ChessManModel:chessIsSelected(mo)
	return self._selectedChess == mo
end

function TowerV3a7ChessManModel:selectedChess(mo)
	if mo and mo:getState() ~= TowerV3a7Enum.ChessState.Normal then
		logError("TowerV3a7ChessManModel:selectedChess error state:" .. mo:getState(), " id:" .. mo.id)

		return
	end

	if self._selectedChess then
		self._selectedChess:setState(TowerV3a7Enum.ChessState.Normal)
	elseif not mo then
		return
	end

	if mo then
		mo:setState(TowerV3a7Enum.ChessState.Select)
	end

	self._selectedChess = mo

	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.SelectChessMan, mo)
end

function TowerV3a7ChessManModel:moveChess(roomMo)
	local mo = self._selectedChess

	if not mo then
		logError("TowerV3a7ChessManModel:moveChess error mo is nil")

		return
	end

	if roomMo:getChessNum() >= TowerV3a7Enum.MaxChessNum then
		logError("TowerV3a7ChessManModel:moveChess error room is full")

		return
	end

	self:selectedChess()
	mo:setTempLocation(roomMo.id)
	roomMo:addTempChess(mo)
	mo:setState(TowerV3a7Enum.ChessState.Moving)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.SrcMoveChessMan, mo)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.DstMoveChessMan, mo)
end

function TowerV3a7ChessManModel:autoMoveChess(mo, roomMo)
	if roomMo:getChessNum() >= TowerV3a7Enum.MaxChessNum then
		logError("TowerV3a7ChessManModel:autoMoveChess error room is full")

		return
	end

	mo:setTempLocation(roomMo.id)
	roomMo:addTempChess(mo)
	mo:setState(TowerV3a7Enum.ChessState.Moving)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.SrcMoveChessMan, mo)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.DstMoveChessMan, mo)
end

TowerV3a7ChessManModel.instance = TowerV3a7ChessManModel.New()

return TowerV3a7ChessManModel

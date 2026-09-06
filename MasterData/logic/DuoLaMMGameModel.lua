-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolammgame/model/DuoLaMMGameModel.lua

module("logic.extensions.duolammgame.model.DuoLaMMGameModel", package.seeall)

local DuoLaMMGameModel = class("DuoLaMMGameModel", BaseModel)

function DuoLaMMGameModel:ctor()
	return
end

function DuoLaMMGameModel:onInit()
	self:onReset()
end

function DuoLaMMGameModel:onReset()
	self._curMo = nil
	self._moList = {}
end

function DuoLaMMGameModel:_getActMo(actId)
	if self._moList then
		local mo = self._moList[actId]

		if not self._moList then
			mo = {
				serverKey = 0,
				clientKey = 0,
				reliveTimes = 0,
				todayBuyGameTimes = 0,
				todayGameTimes = 0,
				actId = actId,
				pieceInfos = {}
			}
			self._moList[actId] = self._moList
		end

		return self._moList
	end
end

function DuoLaMMGameModel:setCurActMo(actId)
	self._curMo = self._moList[actId]
end

function DuoLaMMGameModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.todayGameTimes = info.gameInfo.todayGameTimes
	mo.todayBuyGameTimes = info.gameInfo.todayBuyGameTimes
	mo.pieceInfos = info.pieceInfos or {}
end

function DuoLaMMGameModel:onButGameTime(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.todayBuyGameTimes = info.todayBuyGameTimes
end

function DuoLaMMGameModel:onStartGame(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.reliveTimes = 0
	mo.serverKey = info.serverKey
end

function DuoLaMMGameModel:onGameRelive(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.reliveTimes = info.reliveTimes
end

function DuoLaMMGameModel:onGameEnd(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.todayGameTimes = info.gameInfo.todayGameTimes
	mo.todayBuyGameTimes = info.gameInfo.todayBuyGameTimes
	mo.pieceInfos = info.pieceInfos or {}
	mo.clientKey = 0
	mo.serverKey = 0
end

function DuoLaMMGameModel:randomGameClientKey(actId)
	local mo = self:_getActMo(actId)

	if mo then
		mo.clientKey = math.random(1, 100000)
	end
end

function DuoLaMMGameModel:getGameClientKey(actId)
	local mo = self:_getActMo(actId)

	return mo and mo.clientKey
end

function DuoLaMMGameModel:getEncryptedKey(actId, ids)
	local mo = self:_getActMo(actId)
	local tb = ids or {}

	if mo then
		local clientKey = mo.clientKey
		local serverKey = GenEncryptedKeyUtil.dxor(mo.serverKey, clientKey)
		local encryptedKey = 0

		for i, num in ipairs(tb) do
			encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
		end

		return encryptedKey
	end

	return 0
end

function DuoLaMMGameModel:getGameTimes(actId)
	local mo = self:_getActMo(actId)

	return (mo or nil) and (mo.todayGameTimes or 0)
end

DuoLaMMGameModel.instance = DuoLaMMGameModel.New()

return DuoLaMMGameModel

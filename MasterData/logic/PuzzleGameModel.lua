-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/model/PuzzleGameModel.lua

module("logic.extensions.puzzlegame.model.PuzzleGameModel", package.seeall)

local PuzzleGameModel = class("PuzzleGameModel", BaseModel)

function PuzzleGameModel:onInit()
	self:onReset()
end

function PuzzleGameModel:onReset()
	self._actId = 0
	self._hasLoginDay = 0
	self._gainPrizeIds = {}
	self._hasFinishPuzzleIds = {}
	self._hasGainProgressIds = {}
	self._curClientKey = 0
	self._curServerKey = 0
end

function PuzzleGameModel:onGetInfo(msg)
	self._hasLoginDay = checkint(msg.hasPuzzleNum)
	self._gainPrizeIds = msg.gainJigsawPrizeIds
	self._hasFinishPuzzleIds = {}

	for k, v in ipairs(msg.accomplishIds) do
		local key = checkint(v)

		if key > 0 then
			self._hasFinishPuzzleIds[key] = key
		end
	end

	self._hasGainProgressIds = msg.gainJigsawProgressPrizeIds
end

function PuzzleGameModel:onStartGame(msg)
	self._curServerKey = msg.encryptedKey
end

function PuzzleGameModel:onEndGame(msg)
	self._hasFinishPuzzleIds = self._hasFinishPuzzleIds or {}

	if msg.isPass > 0 then
		self._hasFinishPuzzleIds[msg.isPass] = msg.isPass
	end
end

function PuzzleGameModel:onGainProgressPrize(msg)
	table.insert(self._hasGainProgressIds, msg.progressId)
end

function PuzzleGameModel:setActId(actId)
	self._actId = actId
end

function PuzzleGameModel:getActId()
	return self._actId
end

function PuzzleGameModel:getCurLoginDay()
	return self._hasLoginDay
end

function PuzzleGameModel:getHasFinishPuzzleIds()
	return self._hasFinishPuzzleIds
end

function PuzzleGameModel:isPassPuzzle(puzzleId)
	return table.indexof(self._hasFinishPuzzleIds, puzzleId)
end

function PuzzleGameModel:getHagGainPrizes()
	return self._hasGainProgressIds
end

function PuzzleGameModel:getEncryptedKey(...)
	local clientKey = self._curClientKey
	local serverKey = self._curServerKey
	local nums = {
		...
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, nums)

	return tostring(encryptedKey)
end

function PuzzleGameModel:setClientKey(key)
	self._curClientKey = key
end

PuzzleGameModel.instance = PuzzleGameModel.New()

return PuzzleGameModel

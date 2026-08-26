-- chunkname: @modules/logic/versionactivity2_7/coopergarland/model/CooperGarlandGameModel.lua

module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandGameModel", package.seeall)

local CooperGarlandGameModel = class("CooperGarlandGameModel", BaseModel)

function CooperGarlandGameModel:onInit()
	self:clearAllData()
end

function CooperGarlandGameModel:reInit()
	self:clearAllData()
end

function CooperGarlandGameModel:clearAllData()
	self:setEpisodeId()
	self:setGameId()
	self:setGameRound()
	self:setMapId()
	self:setRemoveCount()
	self:setRemoveMode()
	self:setBallHasKey(false)
	self:setIsStopGame(false)
	self:setSceneOpenAnimShowBall(false)
end

function CooperGarlandGameModel:enterGameInitData(episodeId)
	self:setEpisodeId(episodeId)

	local actId = CooperGarlandModel.instance:getAct192Id()
	local gameId = CooperGarlandConfig.instance:getGameId(actId, episodeId)

	self:setGameId(gameId)

	local saveRound = CooperGarlandModel.instance:getEpisodeProgress(actId, episodeId)

	self:changeRound(saveRound)
	self:setSceneOpenAnimShowBall(false)
end

function CooperGarlandGameModel:changeRound(round)
	local gameId = self:getGameId()

	if not gameId then
		return
	end

	self:setGameRound(round)

	local mapId = CooperGarlandConfig.instance:getMapId(gameId, round)

	self:setMapId(mapId)

	local removeCount = CooperGarlandConfig.instance:getRemoveCount(gameId, round)

	self:setRemoveCount(removeCount)
	self:setBallHasKey(false)
	self:setRemoveMode(false)
	self:setIsStopGame(false)
end

function CooperGarlandGameModel:resetGameData()
	local curRound = self:getGameRound()

	self:changeRound(curRound)
end

function CooperGarlandGameModel:setEpisodeId(episodeId)
	self._episodeId = episodeId
end

function CooperGarlandGameModel:setGameId(gameId)
	self._gameId = gameId
end

function CooperGarlandGameModel:setGameRound(round)
	self._gameRound = round
end

function CooperGarlandGameModel:setMapId(mapId)
	self._mapId = mapId
end

function CooperGarlandGameModel:setRemoveCount(count)
	self._removeCount = count
end

function CooperGarlandGameModel:setRemoveMode(isRemoveMode)
	self._isRemoveMode = isRemoveMode
end

function CooperGarlandGameModel:setBallHasKey(isHas)
	self._hasKey = isHas
end

function CooperGarlandGameModel:setControlMode(controlMode)
	self._controlMode = controlMode

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, controlMode)
end

function CooperGarlandGameModel:setIsStopGame(isStop)
	self._isStopGame = isStop
end

function CooperGarlandGameModel:setSceneOpenAnimShowBall(isShowBall)
	self._openAnimShowBall = isShowBall
end

function CooperGarlandGameModel:getEpisodeId()
	return self._episodeId
end

function CooperGarlandGameModel:getGameId()
	return self._gameId
end

function CooperGarlandGameModel:getGameRound()
	return self._gameRound
end

function CooperGarlandGameModel:getMapId()
	return self._mapId
end

function CooperGarlandGameModel:getRemoveCount()
	return self._removeCount or 0
end

function CooperGarlandGameModel:getIsRemoveMode()
	return self._isRemoveMode
end

function CooperGarlandGameModel:getBallHasKey()
	return self._hasKey
end

function CooperGarlandGameModel:getControlMode()
	self._controlMode = self._controlMode or GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, CooperGarlandEnum.Const.JoystickModeRight)

	return self._controlMode
end

function CooperGarlandGameModel:getIsJoystick()
	local controlMode = self:getControlMode()

	return controlMode == CooperGarlandEnum.Const.JoystickModeRight or controlMode == CooperGarlandEnum.Const.JoystickModeLeft
end

function CooperGarlandGameModel:isFinishedStoryComponent(mapId, componentId)
	local componentType = CooperGarlandConfig.instance:getMapComponentType(mapId, componentId)
	local strParam = CooperGarlandConfig.instance:getMapComponentExtraParams(mapId, componentId)
	local guideId = strParam and tonumber(strParam)

	return (componentType == CooperGarlandEnum.ComponentType.Story and guideId or nil) and GuideModel.instance:isGuideFinish(guideId)
end

function CooperGarlandGameModel:getIsStopGame()
	return self._isStopGame
end

function CooperGarlandGameModel:getSceneOpenAnimShowBall()
	return self._openAnimShowBall
end

CooperGarlandGameModel.instance = CooperGarlandGameModel.New()

return CooperGarlandGameModel

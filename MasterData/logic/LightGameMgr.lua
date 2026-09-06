-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameMgr.lua

module("logic.extensions.duolalight.view.LightGameMgr", package.seeall)

local LightGameMgr = class("LightGameMgr")

LightGameMgr.State = {
	Stoping = 3,
	Runing = 2,
	Ended = 5,
	Readying = 1
}

function LightGameMgr:ctor()
	self._lightGameMapMo = LightGameMapMo.New()
end

function LightGameMgr:onEnter(params)
	params = params or {}
	self._mapId = 0

	self._lightGameMapMo:onEnter()
end

function LightGameMgr:onResetGame(mapId)
	self._mapId = mapId
	self._curGameTime = 0
	self._mapData = DuoLaLightConfig.instance:getDlMapData(mapId)

	self._lightGameMapMo:onReset(self._mapId)
	self:setMaxStep(self._mapData.baseStep or 5)
	self:setCurStep(0)
	self:setBuyTimes(0)
	self:_setIsPass(false)
	self:setEditorMode(false)
end

function LightGameMgr:onExit()
	self._mapId = 0

	self._lightGameMapMo:onExit()
end

function LightGameMgr:onDestroy()
	self._lightGameMapMo:onDestroy()
end

function LightGameMgr:onTicking(deltaTime)
	self._deltaTime = deltaTime

	if self._state == LightGameMgr.State.Readying then
		-- block empty
	elseif self._state == LightGameMgr.State.Runing then
		if not self:isPass() then
			self._curGameTime = self._curGameTime + deltaTime
		end
	elseif self._state == LightGameMgr.State.Stoping then
		-- block empty
	elseif self._state == LightGameMgr.State.Ended then
		-- block empty
	end

	if self._isNeedDispatch then
		self._isNeedDispatch = false

		self:dispatchUpdateGameUI()
	end
end

function LightGameMgr:_changeState(state)
	self._state = state
end

function LightGameMgr:getCurState()
	return self._state
end

function LightGameMgr:resetGame(mapId)
	self:onResetGame(mapId)
	self:_changeState(LightGameMgr.State.Readying)
end

function LightGameMgr:stopGame()
	self:_changeState(LightGameMgr.State.Stoping)
end

function LightGameMgr:continueGame()
	self:_changeState(LightGameMgr.State.Runing)
end

function LightGameMgr:endGame()
	self:_changeState(LightGameMgr.State.Ended)
end

function LightGameMgr:getMapId()
	return self._mapId
end

function LightGameMgr:getCurGameTime()
	return self._curGameTime
end

function LightGameMgr:readyToDispatchUpdateGameUI()
	self._isNeedDispatch = true
end

function LightGameMgr:dispatchUpdateGameUI()
	GlobalDispatcher:dispatch(GlobalNotify.LightGameUpdateGameUI)
end

function LightGameMgr:isEditorMode()
	return self._isEditorMode
end

function LightGameMgr:setEditorMode(isEditorMode)
	self._isEditorMode = isEditorMode
end

function LightGameMgr:getLeftStep()
	return self:getMaxStep() - self:getCurStep()
end

function LightGameMgr:getCurStep()
	return self._curStep
end

function LightGameMgr:setCurStep(step)
	self._curStep = step

	self:readyToDispatchUpdateGameUI()
end

function LightGameMgr:getMaxStep()
	return self._maxStep
end

function LightGameMgr:setMaxStep(step)
	self._maxStep = step

	self:readyToDispatchUpdateGameUI()
end

function LightGameMgr:getBuyTimes()
	return self._curBuyTimes
end

function LightGameMgr:setBuyTimes(times)
	self._curBuyTimes = times

	self:readyToDispatchUpdateGameUI()
end

function LightGameMgr:getGridType(x, y)
	return self._lightGameMapMo:getGridType(x, y)
end

function LightGameMgr:setGridType(x, y, gridType)
	self._lightGameMapMo:setGridType(x, y, gridType)
end

function LightGameMgr:getGridCount()
	return self._lightGameMapMo:getGridCount()
end

function LightGameMgr:getRowCount()
	return self._lightGameMapMo:getRowCount()
end

function LightGameMgr:getColCount()
	return self._lightGameMapMo:getColCount()
end

function LightGameMgr:finfishPath(x, y)
	if self:isEditorMode() then
		return self:finfishPathOfEditor(x, y)
	else
		return self:finfishPathOfNormal(x, y)
	end
end

function LightGameMgr:finfishPathOfNormal(x, y)
	local gridVecList

	if self._lightGameMapMo:isCanMove(x, y) then
		self:setCurStep(self:getCurStep() + 1)

		gridVecList = self._lightGameMapMo:getGridVecListByPoint(x, y)

		for _, vec in ipairs(gridVecList) do
			self:setGridType(vec.x, vec.y, LightGameMapMo.GridType.Black - self:getGridType(vec.x, vec.y))
		end
	end

	self:_setIsPass(self._lightGameMapMo:checkIsPass())

	return gridVecList or {}
end

function LightGameMgr:finfishPathOfEditor(x, y)
	local vec = Vector2.New(x, y)
	local curGridType = self:getGridType(vec.x, vec.y)

	self:setGridType(vec.x, vec.y, (curGridType + 1 + 1) % 3 - 1)

	return {
		vec
	}
end

function LightGameMgr:isPass()
	return self._isPass
end

function LightGameMgr:_setIsPass(isPass)
	self._isPass = isPass
end

return LightGameMgr

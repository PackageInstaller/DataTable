-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/model/JumpGameModel.lua

module("logic.extensions.jumpgame.model.JumpGameModel", package.seeall)

local JumpGameModel = class("JumpGameModel")

function JumpGameModel:ctor()
	self._width = 1240
	self._height = 680
	self._platformInited = 1
	self._cameraPosX = 0
	self._initEdPillars = Array.New()
	self._willPillars = Array.New()
	self._platFormLen = 100
	self._plateFormInitLen = 100
	self._playerPos = 0
	self._initPlayerPos = 0
	self._totalCollect = 0
	self._recentCollect = 0
	self._levelId = 1
	self._over = false
	self._gameType = 0
	self._initCollectParams = {}
end

function JumpGameModel:setInitCollectParams(params)
	self._initCollectParams = params
end

function JumpGameModel:getInitCollectParams()
	return self._initCollectParams
end

function JumpGameModel:getWidthAndHeight()
	return self._width, self._height
end

function JumpGameModel:onReset()
	self._platformInited = 1
	self._cameraPosX = 0

	self._initEdPillars:Clear()
	self._willPillars:Clear()

	self._platFormLen = 100
	self._plateFormInitLen = 100
	self._playerPos = 0
	self._initPlayerPos = 0
	self._totalCollect = 0
	self._recentCollect = 0
	self._over = false
	self._gameType = 0
end

function JumpGameModel:generateRoad(pos)
	self._willPillars:Clear()

	local stages = JumpGameConfig.instance:getStageCfg()
	local n = 0

	while self._platFormLen - self._cameraPosX < self._width and n < 5 do
		n = n + 1

		for i, v in ipairs(stages) do
			if i >= (self._levelId - 1) * 8 + 1 and i <= self._levelId * 8 and v.road[1] <= self._platformInited and self._platformInited <= v.road[2] then
				local pillarModel = JumpPillarMo.New()

				pillarModel:initPillar(v, self._platformInited)
				self._willPillars:PushBack(pillarModel)

				self._platFormLen = self._platFormLen + pillarModel:getPillarLen()
				self._platformInited = self._platformInited + 1
			end
		end
	end
end

function JumpGameModel:getWillPillars()
	return self._willPillars
end

function JumpGameModel:getInitLen()
	return self._plateFormInitLen
end

function JumpGameModel:AddPlateFormLen(len)
	self._plateFormInitLen = self._plateFormInitLen + len
end

function JumpGameModel:updateCameraPosX(value)
	self._cameraPosX = self._cameraPosX + value
end

function JumpGameModel:getPlayerPos()
	return self._playerPos
end

function JumpGameModel:setPlayerPos(pos)
	self._playerPos = pos
end

function JumpGameModel:setInitPlayerPos(pos)
	self._initPlayerPos = pos
end

function JumpGameModel:getInitPlayerPos()
	return self._initPlayerPos
end

function JumpGameModel:addCollect(value)
	self._recentCollect = value
	self._totalCollect = self._totalCollect + value
end

function JumpGameModel:returnCollect()
	return self._totalCollect
end

function JumpGameModel:returnRecentCollect()
	return self._recentCollect
end

function JumpGameModel:gameOver()
	self._over = true
end

function JumpGameModel:isOver()
	return self._over
end

function JumpGameModel:setInitCollectParams(paramsTable)
	self._initCollectParams = paramsTable
end

function JumpGameModel:setGameType(gameType)
	self._gameType = gameType
end

function JumpGameModel:getGameType()
	return self._gameType
end

JumpGameModel.instance = JumpGameModel.New()

return JumpGameModel

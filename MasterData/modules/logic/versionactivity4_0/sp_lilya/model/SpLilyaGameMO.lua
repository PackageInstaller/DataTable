-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaGameMO.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaGameMO", package.seeall)

local SpLilyaGameMO = class("SpLilyaGameMO")

function SpLilyaGameMO:ctor()
	self:reset()
end

function SpLilyaGameMO:reset()
	self.gameConfig = nil
	self.enemyEndPosX = 0
	self.time = 0
	self.remainTime = 0
	self.killCount = 0
	self.shotCount = 0
	self.curWave = 0
	self.maxWave = 0
	self.waveTime = 0
	self.sceneMo = nil
	self.playerMo = nil
	self.isEnergy = nil
	self.isGravity = nil
	self.gameResult = nil
end

function SpLilyaGameMO:init(gameConfig)
	self:reset()

	self.gameConfig = gameConfig
	self.time = gameConfig.time
	self.monsterTeam = gameConfig.monsterTeam
	self.winType = gameConfig.winType
	self.winParam = gameConfig.winParam
	self.remainTime = gameConfig.time
	self.waveTime = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.WaveTime, true) * 0.001
	self.isEnergy = gameConfig.isEnergy
	self.isGravity = gameConfig.isGravity

	self:_initSceneData(gameConfig)
	self:_initPlayerMO(gameConfig)
end

function SpLilyaGameMO:_initSceneData(gameCo)
	self.sceneMo = self.sceneMo or SpLilyaSceneMo.New()

	local sceneMo = self.sceneMo

	sceneMo:init(gameCo)

	self.enemyEndPosX = -sceneMo.groundPosX
end

function SpLilyaGameMO:_initPlayerMO(gameCo)
	self.playerMo = self.playerMo or SpLilyaPlayerMO.New()

	local playerMo = self.playerMo

	playerMo:init(gameCo, self.sceneMo:getHalfWidth(), self.sceneMo:getHalfHeight())
end

return SpLilyaGameMO

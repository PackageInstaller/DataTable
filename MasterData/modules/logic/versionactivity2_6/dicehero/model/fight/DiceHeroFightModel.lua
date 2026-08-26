-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightModel.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightModel", package.seeall)

local DiceHeroFightModel = class("DiceHeroFightModel", BaseModel)

function DiceHeroFightModel:onInit()
	self.finishResult = DiceHeroEnum.GameStatu.None
	self.tempRoundEnd = false
end

function DiceHeroFightModel:reInit()
	self:onInit()
end

function DiceHeroFightModel:setGameData(data)
	if not self._gameData then
		self._gameData = DiceHeroFightData.New(data)
	else
		self._gameData:init(data)
	end

	if self._gameData.allyHero then
		self._gameData.initHp = self._gameData.allyHero.hp or 0
	end
end

function DiceHeroFightModel:getGameData()
	return self._gameData
end

DiceHeroFightModel.instance = DiceHeroFightModel.New()

return DiceHeroFightModel

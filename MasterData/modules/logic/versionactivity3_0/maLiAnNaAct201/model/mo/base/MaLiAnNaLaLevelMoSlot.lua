-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/base/MaLiAnNaLaLevelMoSlot.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMoSlot", package.seeall)

local MaLiAnNaLaLevelMoSlot = class("MaLiAnNaLaLevelMoSlot")

function MaLiAnNaLaLevelMoSlot.create(slotConfigId, id)
	local instance = MaLiAnNaLaLevelMoSlot.New()

	instance.id = id
	instance.configId = slotConfigId

	return instance
end

function MaLiAnNaLaLevelMoSlot:ctor()
	self.id = 0
	self.configId = 0
	self.heroId = 0
	self.posX = 0
	self.posY = 0
end

function MaLiAnNaLaLevelMoSlot:updateHeroId(heroId)
	self.heroId = heroId
end

function MaLiAnNaLaLevelMoSlot:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function MaLiAnNaLaLevelMoSlot:getPosXY()
	return self.posX, self.posY
end

function MaLiAnNaLaLevelMoSlot:getStr()
	return string.format("id = %d, configId = %d, heroId = %d, posX = %d, posY = %d", self.id, self.configId, self.heroId or 0, self.posX, self.posY)
end

return MaLiAnNaLaLevelMoSlot

-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorModel.lua

module("modules.logic.versionactivity3_3.igor.model.IgorModel", package.seeall)

local IgorModel = class("IgorModel", BaseModel)

function IgorModel:onInit()
	self:reInit()
end

function IgorModel:reInit()
	self.activityId = nil
	self.gameId = nil
end

function IgorModel:initGame(episodeCo)
	self.activityId = episodeCo.activityId
	self.gameId = episodeCo.gameId
	self.episodeCo = episodeCo

	local mo = self:getGameMo(self.gameId)

	mo:setEpisodeCo(episodeCo)
	mo:initGame()
end

function IgorModel:resetGame()
	local mo = self:getCurGameMo()

	if mo then
		mo:resetGame()
	end
end

function IgorModel:getGameMo(id)
	local mo = self:getById(id)

	if not mo then
		mo = IgorGameMO.New(id)

		self:addAtLast(mo)
	end

	return mo
end

function IgorModel:getCurGameMo()
	return self:getGameMo(self.gameId)
end

function IgorModel:getActivityId()
	return self.activityId
end

function IgorModel:setPause(isPause)
	local mo = self:getCurGameMo()

	if mo then
		mo:setPaused(isPause)
	end
end

IgorModel.instance = IgorModel.New()

return IgorModel

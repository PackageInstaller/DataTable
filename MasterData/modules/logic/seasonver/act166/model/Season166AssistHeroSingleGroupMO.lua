-- chunkname: @modules/logic/seasonver/act166/model/Season166AssistHeroSingleGroupMO.lua

module("modules.logic.seasonver.act166.model.Season166AssistHeroSingleGroupMO", package.seeall)

local Season166AssistHeroSingleGroupMO = class("Season166AssistHeroSingleGroupMO", Season166HeroSingleGroupMO)

function Season166AssistHeroSingleGroupMO:ctor()
	self.id = nil
	self.heroUid = nil
	self.heroId = nil
	self._heroMo = nil
end

function Season166AssistHeroSingleGroupMO:init(id, pickAssistHeroMO)
	self.id = id
	self.heroUid = 0
	self._heroMo = pickAssistHeroMO.heroMO

	if pickAssistHeroMO then
		self.heroId = pickAssistHeroMO.heroId or 0
	end

	if pickAssistHeroMO then
		self.userId = pickAssistHeroMO.userId or 0
	end

	self.pickAssistHeroMO = pickAssistHeroMO
	self.isAssist = true
end

function Season166AssistHeroSingleGroupMO:getHeroMO()
	return self._heroMo
end

function Season166AssistHeroSingleGroupMO:isTrial()
	return true
end

return Season166AssistHeroSingleGroupMO

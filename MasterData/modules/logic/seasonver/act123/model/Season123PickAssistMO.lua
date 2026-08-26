-- chunkname: @modules/logic/seasonver/act123/model/Season123PickAssistMO.lua

module("modules.logic.seasonver.act123.model.Season123PickAssistMO", package.seeall)

local Season123PickAssistMO = pureTable("Season123PickAssistMO")

function Season123PickAssistMO:init(info)
	self.id = info.heroUid
	self.assistMO = Season123AssistHeroMO.New()

	self.assistMO:init(info)

	self.heroMO = Season123HeroUtils.createHeroMOByAssistMO(self.assistMO, true)
end

function Season123PickAssistMO:getId()
	return self.id
end

function Season123PickAssistMO:isSameHero(targetPickAssistMO)
	local result = false

	if targetPickAssistMO then
		local curHeroUid = self:getId()
		local targetHeroUid = targetPickAssistMO:getId()

		result = curHeroUid == targetHeroUid
	end

	return result
end

function Season123PickAssistMO:getPlayerInfo()
	return {
		userId = self.assistMO.userId,
		name = self.assistMO.name,
		level = self.assistMO.userLevel,
		portrait = self.assistMO.portrait,
		bg = self.assistMO.bg
	}
end

return Season123PickAssistMO

-- chunkname: @modules/logic/seasonver/act166/model/Season166TalentMO.lua

module("modules.logic.seasonver.act166.model.Season166TalentMO", package.seeall)

local Season166TalentMO = pureTable("Season166TalentMO")

function Season166TalentMO:ctor()
	self.id = 0
	self.level = 1
	self.skillIds = {}
end

function Season166TalentMO:setData(info)
	self.id = info.id
	self.level = info.level

	self:updateSkillIds(info.skillIds)

	self.config = lua_activity166_talent_style.configDict[info.id][info.level]
end

function Season166TalentMO:updateSkillIds(skillIds)
	tabletool.clear(self.skillIds)

	for k, id in ipairs(skillIds) do
		self.skillIds[k] = id
	end
end

return Season166TalentMO

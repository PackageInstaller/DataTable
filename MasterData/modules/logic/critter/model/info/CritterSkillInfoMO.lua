-- chunkname: @modules/logic/critter/model/info/CritterSkillInfoMO.lua

module("modules.logic.critter.model.info.CritterSkillInfoMO", package.seeall)

local CritterSkillInfoMO = pureTable("CritterSkillInfoMO")

function CritterSkillInfoMO:init(info)
	if not self.tags or #self.tags > 0 then
		self.tags = {}
	end

	if info and info.tags then
		tabletool.addValues(self.tags, info.tags)
	end
end

function CritterSkillInfoMO:getTags()
	return self.tags
end

return CritterSkillInfoMO

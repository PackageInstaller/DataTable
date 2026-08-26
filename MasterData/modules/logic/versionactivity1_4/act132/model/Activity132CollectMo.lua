-- chunkname: @modules/logic/versionactivity1_4/act132/model/Activity132CollectMo.lua

module("modules.logic.versionactivity1_4.act132.model.Activity132CollectMo", package.seeall)

local Activity132CollectMo = class("Activity132CollectMo")

function Activity132CollectMo:ctor(cfg)
	self.activityId = cfg.activityId
	self.collectId = cfg.collectId
	self.name = cfg.name
	self.bg = cfg.bg
	self.nameEn = cfg.nameEn
	self.clueDict = {}

	local list = string.splitToNumber(cfg.clues, "#")

	for i, clueId in ipairs(list) do
		local clueMo = self.clueDict[clueId]
		local clueCfg = Activity132Config.instance:getClueConfig(self.activityId, clueId)

		if not clueMo and clueCfg then
			clueMo = Activity132ClueMo.New(clueCfg)
			self.clueDict[clueId] = clueMo
		end
	end
end

function Activity132CollectMo:getClueList()
	local list = {}

	for k, v in pairs(self.clueDict) do
		table.insert(list, v)
	end

	if #list > 1 then
		table.sort(list, SortUtil.keyLower("clueId"))
	end

	return list
end

function Activity132CollectMo:getClueMo(clueId)
	return self.clueDict[clueId]
end

return Activity132CollectMo

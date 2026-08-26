-- chunkname: @modules/logic/versionactivity1_4/act132/model/Activity132ClueMo.lua

module("modules.logic.versionactivity1_4.act132.model.Activity132ClueMo", package.seeall)

local Activity132ClueMo = class("Activity132ClueMo")

function Activity132ClueMo:ctor(cfg)
	self.activityId = cfg.activityId
	self.clueId = cfg.clueId
	self.name = cfg.name
	self.contentDict = {}

	local posList = string.splitToNumber(cfg.pos, "#")

	self.posX = posList[1] or 0
	self.posY = posList[2] or 0

	local list = string.splitToNumber(cfg.contents, "#")

	for i, contentId in ipairs(list) do
		local contentCfg = Activity132Config.instance:getContentConfig(self.activityId, contentId)

		if contentCfg then
			self.contentDict[contentId] = Activity132ContentMo.New(contentCfg)
		end
	end
end

function Activity132ClueMo:getContentList()
	local list = {}

	for k, v in pairs(self.contentDict) do
		table.insert(list, v)
	end

	if #list > 1 then
		table.sort(list, SortUtil.keyLower("contentId"))
	end

	return list
end

function Activity132ClueMo:getPos()
	return self.posX, self.posY
end

return Activity132ClueMo

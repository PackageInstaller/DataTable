-- chunkname: @modules/logic/versionactivity1_4/act132/model/Activity132Mo.lua

module("modules.logic.versionactivity1_4.act132.model.Activity132Mo", package.seeall)

local Activity132Mo = class("Activity132Mo")

function Activity132Mo:ctor(activityId)
	self.id = activityId
	self.selectCollectId = nil
	self.contentStateDict = {}

	self:initCfg()
end

function Activity132Mo:initCfg()
	self.collectDict = {}

	local dict = Activity132Config.instance:getCollectDict(self.id)

	if dict then
		for k, v in pairs(dict) do
			self.collectDict[v.collectId] = Activity132CollectMo.New(v)
		end
	end
end

function Activity132Mo:init(info)
	if not info then
		return
	end

	for i = 1, #info.contents do
		local data = info.contents[i]

		self.contentStateDict[data.Id] = data.state
	end
end

function Activity132Mo:getCollectList()
	local list = {}

	for k, v in pairs(self.collectDict) do
		table.insert(list, v)
	end

	if #list > 1 then
		table.sort(list, SortUtil.keyLower("collectId"))
	end

	return list
end

function Activity132Mo:getCollectMo(collectId)
	return self.collectDict[collectId]
end

function Activity132Mo:getContentState(contentId)
	return self.contentStateDict[contentId] or Activity132Enum.ContentState.Lock
end

function Activity132Mo:getSelectCollectId()
	return self.selectCollectId
end

function Activity132Mo:setSelectCollectId(collectId)
	self.selectCollectId = collectId
end

function Activity132Mo:setContentUnlock(contents)
	for i = 1, #contents do
		self.contentStateDict[contents[i]] = Activity132Enum.ContentState.Unlock
	end
end

function Activity132Mo:checkClueRed(clueId)
	local clueCo = Activity132Config.instance:getClueConfig(self.id, clueId)
	local list = string.splitToNumber(clueCo.contents, "#")

	if list then
		for i, v in ipairs(list) do
			if self:getContentState(v) == Activity132Enum.ContentState.CanUnlock then
				return true
			end
		end
	end
end

return Activity132Mo

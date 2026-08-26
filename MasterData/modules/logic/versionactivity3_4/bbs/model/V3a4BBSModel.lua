-- chunkname: @modules/logic/versionactivity3_4/bbs/model/V3a4BBSModel.lua

module("modules.logic.versionactivity3_4.bbs.model.V3a4BBSModel", package.seeall)

local V3a4BBSModel = class("V3a4BBSModel", BaseModel)

function V3a4BBSModel:onInit()
	self._actId = VersionActivity3_4Enum.ActivityId.Dungeon
end

function V3a4BBSModel:reInit()
	return
end

function V3a4BBSModel:getPostMo(postId)
	self._postMos = self._postMos or {}
	self._postMos[self._actId] = self._postMos[self._actId] or {}

	local mo = self._postMos[self._actId][postId]

	if not mo then
		mo = V3a4BBSPostMO.New(self._actId, postId)
		self._postMos[self._actId][postId] = mo
	end

	return mo
end

function V3a4BBSModel:getPostStepMo(postId, stepId)
	local mo = self:getPostMo(postId)

	return mo and mo:getStepMo(stepId)
end

function V3a4BBSModel:_initElementCoList()
	self._elementCoList = {}

	for _, elementCo in pairs(lua_chapter_map_element.configDict) do
		if elementCo.type == DungeonEnum.ElementType.V3a4BBS and not string.nilorempty(elementCo.param) then
			local postId = tonumber(elementCo.param)

			if postId then
				self._elementCoList[postId] = elementCo
			end
		end
	end
end

function V3a4BBSModel:getUnlockElements()
	if not self._elementCoList then
		self:_initElementCoList()
	end

	local coList = {}

	for _, co in pairs(self._elementCoList) do
		local episodeId = DungeonConfig.instance:getEpisodeByElement(co.id)
		local isUnlock = DungeonModel.instance:hasPassLevel(episodeId)

		if isUnlock then
			table.insert(coList, co)
		end
	end

	table.sort(coList, function(a, b)
		return a.id < b.id
	end)

	return coList
end

function V3a4BBSModel:getElementCoByPostId(postId)
	if not self._elementCoList then
		self:_initElementCoList()
	end

	return self._elementCoList[postId]
end

function V3a4BBSModel:clearSavePrefs(postId)
	local post = self:getPostMo(postId)

	if post then
		post:clearTriggerStep()
	end
end

V3a4BBSModel.instance = V3a4BBSModel.New()

return V3a4BBSModel

-- chunkname: @modules/logic/story/model/StoryBgEffectTransModel.lua

module("modules.logic.story.model.StoryBgEffectTransModel", package.seeall)

local StoryBgEffectTransModel = class("StoryBgEffectTransModel", BaseModel)

function StoryBgEffectTransModel:onInit()
	self._transList = {}
end

function StoryBgEffectTransModel:setStoryBgEffectTransList(infos)
	self._transList = {}

	for k, info in ipairs(infos) do
		local mo = StoryBgEffectTransMo.New()

		mo:init(info, k)
		table.insert(self._transList, mo)
	end
end

function StoryBgEffectTransModel:getStoryBgEffectTransList()
	return self._transList
end

function StoryBgEffectTransModel:getStoryBgEffectTransByType(type)
	for _, v in pairs(self._transList) do
		if v.type == type then
			return v
		end
	end

	return nil
end

StoryBgEffectTransModel.instance = StoryBgEffectTransModel.New()

return StoryBgEffectTransModel

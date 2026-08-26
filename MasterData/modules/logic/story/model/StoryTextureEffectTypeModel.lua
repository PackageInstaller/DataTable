-- chunkname: @modules/logic/story/model/StoryTextureEffectTypeModel.lua

module("modules.logic.story.model.StoryTextureEffectTypeModel", package.seeall)

local StoryTextureEffectTypeModel = class("StoryTextureEffectTypeModel", BaseModel)

function StoryTextureEffectTypeModel:onInit()
	self._typeList = {}
end

function StoryTextureEffectTypeModel:setStoryTextureEffectTypeList(infos)
	self._typeList = {}

	for _, info in ipairs(infos) do
		local mo = StoryTextureEffectTypeMO.New()

		mo:init(info)
		table.insert(self._typeList, mo)
	end
end

function StoryTextureEffectTypeModel:getStoryTextureEffectTypeList()
	return self._typeList
end

function StoryTextureEffectTypeModel:getStoryTextureEffectByType(type)
	for _, v in pairs(self._typeList) do
		if v.type == type then
			return v
		end
	end

	return nil
end

StoryTextureEffectTypeModel.instance = StoryTextureEffectTypeModel.New()

return StoryTextureEffectTypeModel

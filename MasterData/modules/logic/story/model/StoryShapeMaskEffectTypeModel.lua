-- chunkname: @modules/logic/story/model/StoryShapeMaskEffectTypeModel.lua

module("modules.logic.story.model.StoryShapeMaskEffectTypeModel", package.seeall)

local StoryShapeMaskEffectTypeModel = class("StoryShapeMaskEffectTypeModel", BaseModel)

function StoryShapeMaskEffectTypeModel:onInit()
	self._typeList = {}
end

function StoryShapeMaskEffectTypeModel:setStoryShapeMaskEffectTypeList(infos)
	self._typeList = {}

	for _, info in ipairs(infos or {}) do
		local mo = StoryShapeMaskEffectTypeMO.New()

		mo:init(info)
		table.insert(self._typeList, mo)
	end
end

function StoryShapeMaskEffectTypeModel:getStoryShapeMaskEffectTypeList()
	return self._typeList
end

function StoryShapeMaskEffectTypeModel:getStoryShapeMaskEffectByType(type)
	for _, v in pairs(self._typeList) do
		if v.type == type then
			return v
		end
	end

	return nil
end

StoryShapeMaskEffectTypeModel.instance = StoryShapeMaskEffectTypeModel.New()

return StoryShapeMaskEffectTypeModel

-- chunkname: @modules/logic/story/model/StoryBlurTypeModel.lua

module("modules.logic.story.model.StoryBlurTypeModel", package.seeall)

local StoryBlurTypeModel = class("StoryBlurTypeModel", BaseModel)

function StoryBlurTypeModel:onInit()
	self._typeList = {}
end

function StoryBlurTypeModel:setStoryBlurTypeList(infos)
	self._typeList = {}

	for k, info in ipairs(infos) do
		local mo = StoryBlurTypeMO.New()

		mo:init(info, k)
		table.insert(self._typeList, mo)
	end
end

function StoryBlurTypeModel:getStoryBlurTypeList()
	return self._typeList
end

function StoryBlurTypeModel:getStoryBlurByType(type)
	for _, v in pairs(self._typeList) do
		if v.type == type then
			return v
		end
	end

	return nil
end

StoryBlurTypeModel.instance = StoryBlurTypeModel.New()

return StoryBlurTypeModel

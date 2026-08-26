-- chunkname: @modules/logic/story/model/StoryCameraEffectModel.lua

module("modules.logic.story.model.StoryCameraEffectModel", package.seeall)

local StoryCameraEffectModel = class("StoryCameraEffectModel", BaseModel)

function StoryCameraEffectModel:onInit()
	self._typeList = {}
end

function StoryCameraEffectModel:setStoryCameraEffectList(infos)
	self._typeList = {}

	for k, info in ipairs(infos) do
		local mo = StoryCameraEffectMO.New()

		mo:init(info, k)
		table.insert(self._typeList, mo)
	end
end

function StoryCameraEffectModel:getStoryCameraEffectList()
	return self._typeList
end

function StoryCameraEffectModel:getStoryCameraEffectByType(type)
	for _, v in pairs(self._typeList) do
		if v.type == type then
			return v
		end
	end

	return nil
end

StoryCameraEffectModel.instance = StoryCameraEffectModel.New()

return StoryCameraEffectModel

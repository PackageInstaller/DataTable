-- chunkname: @modules/logic/story/model/StoryMo.lua

module("modules.logic.story.model.StoryMo", package.seeall)

local StoryMo = pureTable("StoryMo")

function StoryMo:ctor()
	self.finishList = nil
	self.processList = nil
end

function StoryMo:init(co)
	self.finishList = {}

	if co.finishList then
		for i, v in ipairs(co.finishList) do
			self.finishList[v] = true
		end
	end

	self.processList = co.processingList and self:_getListInfo(co.processingList, StoryProcessInfoMo) or {}
end

function StoryMo:update(info)
	local isProcessing = false

	for _, v in pairs(self.processList) do
		if v.storyId == info.storyId then
			v.stepId = info.stepId
			v.favor = info.favor
			isProcessing = true
		end
	end

	if not isProcessing then
		local mo = StoryProcessInfoMo.New()

		mo.storyId = info.storyId
		mo.stepId = info.stepId
		mo.favor = info.favor

		table.insert(self.processList, mo)
	end
end

function StoryMo:_getListInfo(originList, cls)
	if not originList then
		return {}
	end

	local list = {}

	for _, v in ipairs(originList) do
		local mo = v

		if cls then
			mo = cls.New()

			mo:init(v)
		end

		table.insert(list, mo)
	end

	return list
end

return StoryMo

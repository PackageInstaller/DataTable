-- chunkname: @modules/logic/story/model/StoryBgZoneModel.lua

module("modules.logic.story.model.StoryBgZoneModel", package.seeall)

local StoryBgZoneModel = class("StoryBgZoneModel", BaseModel)

function StoryBgZoneModel:onInit()
	self._zoneList = {}
end

function StoryBgZoneModel:setZoneList(infos)
	self._zoneList = {}

	if infos then
		for _, info in ipairs(infos) do
			local zoneMo = StoryBgZoneMo.New()

			zoneMo:init(info)
			table.insert(self._zoneList, zoneMo)
		end
	end

	self:setList(self._zoneList)
end

function StoryBgZoneModel:getZoneList()
	return self._zoneList
end

function StoryBgZoneModel:getBgZoneByPath(path)
	local resultName = string.gsub(path, "_zone", "")

	resultName = string.gsub(resultName, ".png", "")
	resultName = string.gsub(resultName, ".jpg", "")
	resultName = resultName .. "_zone.png"

	for _, v in pairs(self._zoneList) do
		if v.path == resultName then
			return v
		end
	end

	return nil
end

function StoryBgZoneModel:getRightBgZonePath(path)
	local mo = self:getBgZoneByPath(path)

	if mo then
		return mo.path
	end

	return path
end

StoryBgZoneModel.instance = StoryBgZoneModel.New()

return StoryBgZoneModel

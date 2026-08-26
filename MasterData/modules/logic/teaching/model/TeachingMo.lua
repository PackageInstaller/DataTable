-- chunkname: @modules/logic/teaching/model/TeachingMo.lua

module("modules.logic.teaching.model.TeachingMo", package.seeall)

local TeachingMo = class("TeachingMo")

function TeachingMo:ctor()
	self._teachingStatusMap = {}
	self._passEpisodes = {}
end

function TeachingMo:update(info)
	tabletool.clear(self._passEpisodes)
	tabletool.clear(self._teachingStatusMap)

	for _, episodeId in ipairs(info.passEpisodes) do
		self._passEpisodes[episodeId] = true
	end

	if info.teachinges then
		for _, teachingInfo in ipairs(info.teachinges) do
			self._teachingStatusMap[teachingInfo.teachingId] = teachingInfo.status
		end
	end
end

function TeachingMo:updateByTeachings(teachinges)
	if teachinges then
		for _, teachingInfo in ipairs(teachinges) do
			self._teachingStatusMap[teachingInfo.teachingId] = teachingInfo.status
		end
	end
end

function TeachingMo:getTeachingStatus(teachingId)
	if self._teachingStatusMap[teachingId] then
		return self._teachingStatusMap[teachingId]
	end

	return TeachingEnum.TeachingStatus.NotFinish
end

return TeachingMo

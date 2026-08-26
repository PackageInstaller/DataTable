-- chunkname: @modules/logic/seasonver/act166/model/Season166TeachModel.lua

module("modules.logic.seasonver.act166.model.Season166TeachModel", package.seeall)

local Season166TeachModel = class("Season166TeachModel", BaseModel)

function Season166TeachModel:onInit()
	self:reInit()
end

function Season166TeachModel:reInit()
	self:cleanData()
end

function Season166TeachModel:cleanData()
	self.curTeachId = 0
	self.curTeachConfig = nil
	self.curEpisodeId = nil
end

function Season166TeachModel:initTeachData(actId, teachId)
	self.actId = actId
	self.curTeachId = teachId
	self.curTeachConfig = Season166Config.instance:getSeasonTeachCos(teachId)
	self.curEpisodeId = self.curBaseSpotConfig and self.curBaseSpotConfig.episodeId
end

function Season166TeachModel:checkIsAllTeachFinish(actId)
	local Season166MO = Season166Model.instance:getActInfo(actId)
	local teachCoList = Season166Config.instance:getAllSeasonTeachCos()
	local isAllFinish = true

	for index, teachCo in ipairs(teachCoList) do
		local teachMO = Season166MO.teachInfoMap[teachCo.teachId]

		if not teachMO or teachMO.passCount == 0 then
			isAllFinish = false

			break
		end
	end

	return isAllFinish
end

Season166TeachModel.instance = Season166TeachModel.New()

return Season166TeachModel

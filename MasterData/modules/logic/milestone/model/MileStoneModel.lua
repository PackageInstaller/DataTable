-- chunkname: @modules/logic/milestone/model/MileStoneModel.lua

module("modules.logic.milestone.model.MileStoneModel", package.seeall)

local MileStoneModel = class("MileStoneModel", BaseModel)

function MileStoneModel:onInit()
	self:_clear()
end

function MileStoneModel:reInit()
	self:_clear()
end

function MileStoneModel:_clear()
	return
end

function MileStoneModel:updateInfos(infos)
	self:clear()

	for i = 1, #infos do
		self:updateInfo(infos[i])
	end
end

function MileStoneModel:updateInfo(info)
	local data = self:getDataById(info.milestoneId)

	data:updateInfo(info)
end

function MileStoneModel:updateBonusInfo(info)
	local data = self:getDataById(info.milestoneId)

	data:updateBonusInfo(info.getBonusId)
end

function MileStoneModel:getDataById(id)
	local data = self:getById(id)

	if not data then
		data = MileStoneMO.New()

		data:init(id)
		self:addAtLast(data)
	end

	return data
end

MileStoneModel.instance = MileStoneModel.New()

return MileStoneModel

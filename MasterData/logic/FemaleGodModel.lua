-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/model/FemaleGodModel.lua

module("logic.extensions.femalegod.model.FemaleGodModel", package.seeall)

local FemaleGodModel = class("FemaleGodModel", BaseModel)

function FemaleGodModel:onInit()
	self:onReset()
end

function FemaleGodModel:onReset()
	self._infos = {}
end

function FemaleGodModel:getInfo(activityId)
	if self._infos[activityId] == nil then
		self._infos[activityId] = {}
	end

	return self._infos[activityId]
end

function FemaleGodModel:handlePM_InflationMoneyGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._infos[msg.activityId].gainedPrizeId = msg.gainedPrizeId or {}
end

function FemaleGodModel:handlePM_InflationMoneyGainProgressPrizeRes(msg)
	local info = self:getInfo(msg.activityId)

	info.gainedPrizeId = info.gainedPrizeId or {}

	table.insert(info.gainedPrizeId, msg.prizeId)
end

FemaleGodModel.instance = FemaleGodModel.New()

return FemaleGodModel

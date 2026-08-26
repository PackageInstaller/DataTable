-- chunkname: @modules/logic/investigate/model/InvestigateOpinionModel.lua

module("modules.logic.investigate.model.InvestigateOpinionModel", package.seeall)

local InvestigateOpinionModel = class("InvestigateOpinionModel", BaseModel)

function InvestigateOpinionModel:onInit()
	self._isInitOpinionInfo = false
	self._connectedId = {}
	self._unLockedId = {}
end

function InvestigateOpinionModel:reInit()
	self:onInit()
end

function InvestigateOpinionModel:getIsInitOpinionInfo()
	return self._isInitOpinionInfo
end

function InvestigateOpinionModel:initOpinionInfo(info)
	self._isInitOpinionInfo = true

	for i, v in ipairs(info.intelBox) do
		for _, clueId in ipairs(v.clueIds) do
			self._connectedId[clueId] = clueId
		end
	end

	for _, clueId in ipairs(info.clueIds) do
		self._unLockedId[clueId] = clueId
	end
end

function InvestigateOpinionModel:isUnlocked(id)
	return self._unLockedId[id] ~= nil
end

function InvestigateOpinionModel:setInfo(mo, moList)
	self._mo = mo
	self._moList = moList
end

function InvestigateOpinionModel:getInfo()
	return self._mo, self._moList
end

function InvestigateOpinionModel:getLinkedStatus(id)
	return self._connectedId[id] ~= nil
end

function InvestigateOpinionModel:setLinkedStatus(id, value)
	self._connectedId[id] = value
end

function InvestigateOpinionModel:allOpinionLinked(infoId)
	local opinionList = InvestigateConfig.instance:getInvestigateAllClueInfos(infoId)

	for i, v in ipairs(opinionList) do
		if not self:getLinkedStatus(v.id) then
			return false
		end
	end

	return true
end

InvestigateOpinionModel.instance = InvestigateOpinionModel.New()

return InvestigateOpinionModel

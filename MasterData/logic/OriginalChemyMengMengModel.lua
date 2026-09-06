-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/model/OriginalChemyMengMengModel.lua

module("logic.extensions.originalchemymengmeng.model.OriginalChemyMengMengModel", package.seeall)

local OriginalChemyMengMengModel = class("OriginalChemyMengMengModel", BaseModel)

function OriginalChemyMengMengModel:onInit()
	self:onReset()
end

function OriginalChemyMengMengModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._selectedReagentIdMap = {}
	self._compoundMap = {}
	self._selectStageMap = {}
end

function OriginalChemyMengMengModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginalChemyMengMengModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginalChemyMengMengFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginalChemyMengMengModel:getCompoundMap(activityId)
	return self._compoundMap[activityId]
end

function OriginalChemyMengMengModel:setSelectStageMap(activityId, selectStageId)
	self._selectStageMap[activityId] = selectStageId
end

function OriginalChemyMengMengModel:getSelectStageMap(activityId)
	return self._selectStageMap[activityId]
end

function OriginalChemyMengMengModel:setCompoundNum(activityId, compoundNumMap)
	local curCompoundMap = self._compoundMap[activityId]

	for compoundId, num in pairs(compoundNumMap) do
		curCompoundMap[compoundId] = checknumber(curCompoundMap[compoundId]) + num
	end
end

function OriginalChemyMengMengModel:setSelectedReagentId(activityId, reagentId)
	self._selectedReagentIdMap[activityId] = checknumber(reagentId)
end

function OriginalChemyMengMengModel:getSelectedReagentId(activityId)
	return checknumber(self._selectedReagentIdMap[activityId])
end

function OriginalChemyMengMengModel:hasGainReagent(activityId, reagentId)
	local info = self:getInfo(activityId)

	if info then
		if not info.gainReagent then
			local reagentIds = {}

			return table.indexof(reagentIds, reagentId) ~= false
		end
	end
end

function OriginalChemyMengMengModel:hasUsedReagent(activityId, reagentId)
	local info = self:getInfo(activityId)

	if info then
		if not info.hasUsedReagent then
			local reagentIds = {}

			return table.indexof(reagentIds, reagentId) ~= false
		end
	end
end

function OriginalChemyMengMengModel:isStagePass(activityId, stageId)
	return table.indexof(self:getPassStageIds(activityId), stageId) ~= false
end

function OriginalChemyMengMengModel:handlePM_OriginAlchemyMengMengGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.gainCompound = info.gainCompound or {}
	info.gainReagent = info.gainReagent or {}
	info.hasUsedReagent = info.hasUsedReagent or {}
	info.passStageId = info.passStageId or {}
	self._compoundMap[msg.activityId] = {}

	local compoundMap = self._compoundMap[msg.activityId]

	for i, v in ipairs(msg.gainCompound) do
		compoundMap[v.left] = v.right
	end
end

function OriginalChemyMengMengModel:handlePM_OriginAlchemyMengMengResetRes(msg)
	local info = self._infos[msg.activityId]

	if not info then
		return
	end

	info.hasGainPrize = false
	info.gainCompound = {}
	info.gainReagent = {}
	info.hasUsedReagent = {}
	info.passStageId = {}
	self._compoundMap[msg.activityId] = {}
end

function OriginalChemyMengMengModel:handlePM_OriginAlchemyMengMengChallengeRes(msg)
	return
end

function OriginalChemyMengMengModel:handlePM_OriginAlchemyMengMengSmeltReagentRes(msg)
	local info = self._infos[msg.activityId]

	if not info then
		return
	end

	info.gainReagent = info.gainReagent or {}

	if not self:hasGainReagent(msg.activityId, msg.reagentId) then
		table.insert(info.gainReagent, msg.reagentId)
	end
end

function OriginalChemyMengMengModel:handlePM_OriginAlchemyMengMengNotifyClgRes(msg)
	local info = self._infos[msg.activityId]

	if info and msg.isPass then
		self:setSelectStageMap(msg.activityId, 0)
		table.insert(info.passStageId, msg.stageId)

		if checknumber(msg.useReagentId) > 0 then
			table.insert(info.hasUsedReagent, msg.useReagentId)
		end
	end
end

OriginalChemyMengMengModel.instance = OriginalChemyMengMengModel.New()

return OriginalChemyMengMengModel

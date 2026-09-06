-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswSimplePillarInfoCtrl.lua

module("logic.extensions.godstatueswar.data.GswSimplePillarInfoCtrl", package.seeall)

local GswSimplePillarInfoCtrl = class("GswSimplePillarInfoCtrl")

function GswSimplePillarInfoCtrl:ctor(seasonId)
	self._seasonId = seasonId
	self._fmtInfoMoPoolOfPlayer = {}
	self._fmtInfoMoPoolOfSystem = {}
	self._onlyIdsInTier = {}
	self._onlyIdList = {}
	self._tierIdMap = {}
	self._seatIdxMap = {}
	self._emptyFmtInfoMo = GswSimpleTierFmtInfoMo.New()
end

function GswSimplePillarInfoCtrl:onReset()
	table.clear(self._fmtInfoMoPoolOfPlayer)
	self:_resetAllTierFmtInfoMoOfSystem()
	table.clear(self._onlyIdsInTier)
	table.clear(self._onlyIdList)
	table.clear(self._tierIdMap)
	table.clear(self._seatIdxMap)
end

function GswSimplePillarInfoCtrl:updateData(msg)
	self:onReset()

	local seasonId = self._seasonId
	local step = GodStatuesWarController.instance:getCurStepOfGsw(seasonId)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)

	for _, v in ipairs(msg) do
		local tierId = v.tier
		local formId = v.formId
		local playerId = v.playerId
		local playerFormId = v.playerFormId
		local mo = GswSimpleTierFmtInfoMo.New()

		mo:initMsgData(v)

		local onlyId = GodStatuesWarController.instance:getOnlyIdByFmtInfoMo(playerId, playerFormId)

		self._fmtInfoMoPoolOfPlayer[onlyId] = mo
		self._tierIdMap[onlyId] = tierId
		self._seatIdxMap[onlyId] = formId

		self:setOnlyIdToTier(onlyId, tierId, formId)
		table.insert(self._onlyIdList, onlyId)
	end

	local tierCount = GodStatuesWarController.instance:getTierCount(seasonId)

	for tierId = 1, tierCount do
		local seatCount = GodStatuesWarController.instance:getSeatCountInTier(seasonId, tierId)

		for seatIdx = 1, seatCount do
			local mo = self:_addTierFmtInfoMoOfSystem(tierId, seatIdx)
			local data = GodStatuesWarConfig.instance:getNfbDivinePillarData(stepData.divinePillarPlanId, tierId)

			mo:initLocalData((data.creepsMasterIds or nil) and checknumber(data.creepsMasterIds[seatIdx]))
		end
	end
end

function GswSimplePillarInfoCtrl:_addTierFmtInfoMoOfSystem(tierId, seatIdx)
	local mo

	if self._fmtInfoMoPoolOfSystem[tierId] then
		mo = self._fmtInfoMoPoolOfSystem[tierId][seatIdx]
	else
		self._fmtInfoMoPoolOfSystem[tierId] = {}
	end

	if mo == nil then
		mo = GswSimpleTierFmtInfoMo.New()
		self._fmtInfoMoPoolOfSystem[tierId][seatIdx] = mo
	end

	return mo
end

function GswSimplePillarInfoCtrl:_resetAllTierFmtInfoMoOfSystem()
	if self._fmtInfoMoPoolOfSystem then
		for tierId, v in pairs(self._fmtInfoMoPoolOfSystem) do
			for seatIdx, mo in pairs(v) do
				mo:onReset()
			end
		end
	end
end

function GswSimplePillarInfoCtrl:getTierFmtInfoMo(tierId, seatIdx)
	local fmtInfoMo
	local onlyId = self:getOnlyIdInTier(tierId, seatIdx)

	if onlyId then
		fmtInfoMo = self:getTierFmtInfoMoByOnlyId(onlyId)
	elseif self._fmtInfoMoPoolOfSystem[tierId] then
		fmtInfoMo = self._fmtInfoMoPoolOfSystem[tierId][seatIdx]
	end

	return fmtInfoMo or self._emptyFmtInfoMo
end

function GswSimplePillarInfoCtrl:setOnlyIdToTier(onlyId, tierId, seatIdx)
	if not string.nilorempty(onlyId) then
		self._tierIdMap[onlyId] = tierId
		self._seatIdxMap[onlyId] = seatIdx
	end

	self._onlyIdsInTier[tierId] = self._onlyIdsInTier[tierId] or {}

	if self._onlyIdsInTier[tierId] == nil then
		self._onlyIdsInTier[tierId] = {}
	end

	self._onlyIdsInTier[tierId][seatIdx] = onlyId
end

function GswSimplePillarInfoCtrl:getOnlyIdList()
	return self._onlyIdList
end

function GswSimplePillarInfoCtrl:getOnlyIdListInTier(tierId)
	return self._onlyIdsInTier[tierId] or {}
end

function GswSimplePillarInfoCtrl:getOnlyIdInTier(tierId, seatIdx)
	if self._onlyIdsInTier[tierId] then
		return self._onlyIdsInTier[tierId][seatIdx]
	end
end

function GswSimplePillarInfoCtrl:getTierFmtInfoMoByOnlyId(onlyId)
	return self._fmtInfoMoPoolOfPlayer[onlyId] or self._emptyFmtInfoMo
end

function GswSimplePillarInfoCtrl:getTierId(onlyId)
	return self._tierIdMap[onlyId] or 0
end

function GswSimplePillarInfoCtrl:getSeatIdx(onlyId)
	return self._seatIdxMap[onlyId] or 0
end

return GswSimplePillarInfoCtrl

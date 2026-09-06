-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingEggsMachineMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingEggsMachineMO", package.seeall)

local ZooBuildingEggsMachineMO = class("ZooBuildingEggsMachineMO", ZooBuildingMO)

function ZooBuildingEggsMachineMO:ctor()
	ZooBuildingEggsMachineMO.super.ctor(self)
end

function ZooBuildingEggsMachineMO:setHatchInfos(hatchInfo)
	self._hatchInfo = {}

	for i, hatch in ipairs(hatchInfo) do
		local tag = hatch.id

		self._hatchInfo[tag] = self:_returnHatchInfoByMsgSlotInfo(hatch)
	end

	for i = 1, 3 do
		if self._hatchInfo[i] == nil then
			self._hatchInfo[i] = self:_returnHatchInfoByMsgSlotInfo({})
		end
	end
end

function ZooBuildingEggsMachineMO:setHatchInfoByIndex(index, slotInfo)
	self._hatchInfo[index] = self:_returnHatchInfoByMsgSlotInfo(slotInfo or {})
end

function ZooBuildingEggsMachineMO:getHatchInfoByIndex(index)
	return (self._hatchInfo or nil) and (self._hatchInfo[index] or nil)
end

function ZooBuildingEggsMachineMO:clearHatchInfoByIndex(index)
	self._hatchInfo[index] = self._hatchInfo[index] or self:_returnHatchInfoByMsgSlotInfo({})

	self._hatchInfo[index]:reset()
end

function ZooBuildingEggsMachineMO:resetAbsorbStates()
	if self._hatchInfo then
		for k, v in pairs(self._hatchInfo) do
			v.absorbBuddyId = 0
			v.absorbBuddyName = nil
			v.absorbStartTime = 0
			v.maxCanAbsorbTime = 0
			v.absorbMaxEndTime = 0
		end
	end
end

function ZooBuildingEggsMachineMO:getHatchInfos()
	return self._hatchInfo
end

function ZooBuildingEggsMachineMO:getBuildingOpTypes()
	return
end

function ZooBuildingEggsMachineMO:onSelected()
	UIStateManager.instance:push(ViewName.ZoohatchView)
end

function ZooBuildingEggsMachineMO:_onClickHatchEgg()
	UIStateManager.instance:push(ViewName.ZoohatchView)
end

function ZooBuildingEggsMachineMO:_returnHatchInfoByMsgSlotInfo(slotInfo)
	local hatchInfo = EggHatchInfoMO.New()

	hatchInfo.animalRace = slotInfo.animalRace or 0
	hatchInfo.geneInfo = slotInfo.gene
	hatchInfo.hatchEndTime = (slotInfo.hatchEndTime or 0) / 1000
	hatchInfo.absorbBuddyId = slotInfo.absorbBuddyId
	hatchInfo.absorbBuddyName = slotInfo.absorbBuddyName or ""
	hatchInfo.absorbStartTime = (slotInfo.absorbStartTime or 0) / 1000
	hatchInfo.maxCanAbsorbTime = checknumber(slotInfo.maxCanAbsorbTime or 0) / 1000
	hatchInfo.absorbMaxEndTime = hatchInfo.absorbStartTime + hatchInfo.maxCanAbsorbTime

	if hatchInfo.animalRace > 0 then
		local hatchCD = 0
		local cfg
		local animalCfg = ZooConfig.instance:getAnimalById(slotInfo.animalRace)
		local effectiveGene = ZooController.instance:getEffectiveGeneByGeneInfo(slotInfo.gene)

		for index, geneId in ipairs(effectiveGene) do
			cfg = ZooConfig.instance:getGene(geneId)

			if cfg then
				hatchCD = hatchCD + cfg.hatchCD
			end
		end

		hatchInfo.hatchCD = hatchCD
	end

	return hatchInfo
end

return ZooBuildingEggsMachineMO

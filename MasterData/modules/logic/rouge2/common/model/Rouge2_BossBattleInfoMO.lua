-- chunkname: @modules/logic/rouge2/common/model/Rouge2_BossBattleInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_BossBattleInfoMO", package.seeall)

local Rouge2_BossBattleInfoMO = pureTable("Rouge2_BossBattleInfoMO")

function Rouge2_BossBattleInfoMO:init(info)
	self._bossInfoList, self._bossInfoMap = GameUtil.rpcInfosToListAndMap(info.bossInfo, Rouge2_BossInfoMO, "bossId")
	self._saveInfoList, self._saveInfoMap = GameUtil.rpcInfosToListAndMap(info.saveInfo, Rouge2_SaveInfoMO, "index")
	self._useSaveIndex = info.useSaveIndex

	if self._saveInfoList then
		self._saveInfoNum = #self._saveInfoList or 0
	end
end

function Rouge2_BossBattleInfoMO:getBossInfoList()
	return self._bossInfoList
end

function Rouge2_BossBattleInfoMO:getBossInfoById(bossId)
	return self._bossInfoMap and self._bossInfoMap[bossId]
end

function Rouge2_BossBattleInfoMO:getSaveInfoList()
	return self._saveInfoList
end

function Rouge2_BossBattleInfoMO:getSaveInfoByIndex(index)
	return self._saveInfoMap and self._saveInfoMap[index]
end

function Rouge2_BossBattleInfoMO:getUseSaveIndex()
	return self._useSaveIndex
end

function Rouge2_BossBattleInfoMO:getUseSaveInfo()
	local index = self:getUseSaveIndex()

	return self:getSaveInfoByIndex(index)
end

function Rouge2_BossBattleInfoMO:hasUseSaveIndex()
	return self._useSaveIndex and self._useSaveIndex ~= 0
end

function Rouge2_BossBattleInfoMO:getNextSaveInfo(isNext)
	if self._saveInfoNum <= 0 then
		return
	end

	local checkDir = isNext and 1 or -1

	if not self._useSaveIndex then
		local tempUseSaveIndex = 0
		local maxSaveInfoNum = Rouge2_FightRecordController.instance:getMaxRecordNum()

		for i = 1, maxSaveInfoNum do
			local findIndex = (tempUseSaveIndex + i * checkDir) % (maxSaveInfoNum + 1)

			if findIndex == 0 then
				findIndex = checkDir == 1 and 1 or maxSaveInfoNum
			end

			local saveInfo = self:getSaveInfoByIndex(findIndex)

			if saveInfo then
				return saveInfo
			end
		end
	end
end

function Rouge2_BossBattleInfoMO:getSaveInfoNum()
	return self._saveInfoNum
end

return Rouge2_BossBattleInfoMO

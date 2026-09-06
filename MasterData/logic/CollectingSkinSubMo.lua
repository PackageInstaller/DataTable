-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/data/CollectingSkinSubMo.lua

module("logic.extensions.collectingskin.data.CollectingSkinSubMo", package.seeall)

local CollectingSkinSubMo = class("CollectingSkinSubMo")

function CollectingSkinSubMo:ctor(activityId)
	self._activityId = activityId
	self._itemMats = {}

	local cfg = CollectingSkinConfig.instance:getItemCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		local itemType = data.type
		local matStr

		if itemType == CollectingSkinEnum.ItemType_MOUNT then
			local mountId = checknumber(data.materialKey)
			local mountData = MountConfig.instance:getMountCo(mountId)

			if mountData == nil then
				printError(string.format("皮肤收集好礼，缺失坐骑配置 ( activityId:%s, type:%s, materialKey:%s )", self._activityId, itemType, data.materialKey))
			end

			matStr = mountData and mountData.activationItem
		else
			matStr = data.materialKey
		end

		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		self._itemMats[data.id] = {
			matStr = matStr,
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName,
			itemType = itemType
		}
	end

	self:_resetData()
end

function CollectingSkinSubMo:_resetData()
	self._gainPrizeIds = {}
	self._gainedSkinPrizeIds = {}
	self._itemDataBitIds = {}
end

function CollectingSkinSubMo:dispose()
	self._activityId = nil

	self:_resetData()
end

function CollectingSkinSubMo:handlePM_CollectingSkinGetInfoRes(msg)
	MmUtil.fillTableByValues(self._gainPrizeIds, msg.dataBitId, true)
	MmUtil.fillTableByValues(self._gainedSkinPrizeIds, msg.gainedSkinPrizeIds, true)
	MmUtil.fillTableByValues(self._itemDataBitIds, msg.itemDataBitId, true)
end

function CollectingSkinSubMo:handlePM_CollectingSkinGainProgressPrizeRes(msg)
	self._gainPrizeIds[msg.dataBitId] = msg.dataBitId
end

function CollectingSkinSubMo:handlePM_CollectingSkinGainSkinPrizeRes(msg)
	self._gainedSkinPrizeIds[msg.skinId] = msg.skinId
end

function CollectingSkinSubMo:handlePM_CollectingSkinGainItemPrizeRes(msg)
	self._itemDataBitIds[msg.dataBitId] = msg.dataBitId
end

function CollectingSkinSubMo:handlePM_CollectingSkinItemRankInfoRes(msg)
	return
end

function CollectingSkinSubMo:getPrizeIsGain(progressId)
	if self._gainPrizeIds and progressId then
		return self._gainPrizeIds[checkint(progressId)] ~= nil
	end

	return false
end

function CollectingSkinSubMo:isHasGainPrizeInSkin(skinId)
	return self._gainedSkinPrizeIds[skinId] ~= nil
end

function CollectingSkinSubMo:isEnoughGetPrizeInSkin(skinId)
	return MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, skinId) > 0
end

function CollectingSkinSubMo:isCanGetPrizeInSkin(skinId)
	return not self:isHasGainPrizeInSkin(skinId) and self:isEnoughGetPrizeInSkin(skinId)
end

function CollectingSkinSubMo:getCurItemProgress()
	local progress = 0
	local cfg = CollectingSkinConfig.instance:getItemCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		if self:isHasCollectItem(data.id) then
			progress = progress + 1
		end
	end

	return progress
end

function CollectingSkinSubMo:isHasCollectItem(id)
	local mat = self:getItemMatMo(id)

	if mat.itemType == CollectingSkinEnum.ItemType_MOUNT then
		local mountId = MountConfig.instance:getMountInMap(mat.matType, mat.matId)
		local value = MountModel.instance:getLockmountsById(mountId) ~= false

		return value ~= false
	else
		return MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId) > 0
	end
end

function CollectingSkinSubMo:getItemMatMo(id)
	return self._itemMats[id]
end

function CollectingSkinSubMo:isHasGainPrizeInItem(dataBitId)
	return self._itemDataBitIds[dataBitId] ~= nil
end

function CollectingSkinSubMo:isEnoughGetPrizeInItem(dataBitId)
	local data = CollectingSkinConfig.instance:getItemProgressData(self._activityId, dataBitId)
	local need = data and data.progress
	local cur = self:getCurItemProgress()

	return need <= cur
end

function CollectingSkinSubMo:isCanGetPrizeInItem(dataBitId)
	return not self:isHasGainPrizeInItem(dataBitId) and self:isEnoughGetPrizeInItem(dataBitId)
end

return CollectingSkinSubMo

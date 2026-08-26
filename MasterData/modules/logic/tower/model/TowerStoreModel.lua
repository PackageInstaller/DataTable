-- chunkname: @modules/logic/tower/model/TowerStoreModel.lua

module("modules.logic.tower.model.TowerStoreModel", package.seeall)

local TowerStoreModel = class("TowerStoreModel", BaseModel)

function TowerStoreModel:onInit()
	self.goodsInfosDict = nil
end

function TowerStoreModel:reInit()
	self:onInit()
end

function TowerStoreModel:getCurrencyIcon(activityId)
	local currenyId = CurrencyEnum.CurrencyType.TowerStore

	if currenyId then
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(currenyId)

		if currencyCO then
			return currencyCO.icon .. "_1"
		end
	end
end

function TowerStoreModel:getCurrencyCount(activityId)
	local currenyId = CurrencyEnum.CurrencyType.TowerStore

	if currenyId then
		local curreny = CurrencyModel.instance:getCurrency(currenyId)

		if curreny then
			return curreny.quantity
		end
	end

	return 0
end

function TowerStoreModel:getStoreGroupMO()
	local storeMoList = {}

	for _, storeId in pairs(StoreEnum.TowerStore) do
		storeMoList[storeId] = StoreModel.instance:getStoreMO(storeId)
	end

	return storeMoList
end

function TowerStoreModel:getStoreGroupName(storeId)
	local storeGroupCo = StoreConfig.instance:getTabConfig(storeId)

	if storeGroupCo then
		return storeGroupCo.name, storeGroupCo.nameEn
	end
end

function TowerStoreModel:getUpdateStoreRemainTime(useEn)
	local actInfoMo, actStatues = self:getUpdateStoreActivityMo()

	if actInfoMo and actStatues ~= ActivityEnum.ActivityStatus.Expired then
		return (actInfoMo:getRemainTimeStr2ByEndTime(useEn))
	end

	return ""
end

function TowerStoreModel:getUpdateStoreActivityMo()
	local storeId = self:getMinRemainTimeStoreId()
	local actId = self:checkUpdateStoreActivity(storeId)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local actStatues = actInfoMo and ActivityHelper.getActivityStatus(actId)

	return actInfoMo, actStatues
end

function TowerStoreModel:checkUpdateStoreActivity(storeId)
	local storeMoList = self:getStoreGroupMO()
	local actId

	if storeMoList then
		local updateStoreMo = storeMoList[storeId]

		if updateStoreMo then
			for _, mo in pairs(updateStoreMo:getGoodsList()) do
				if not actId then
					if mo.config.activityId ~= 0 then
						actId = mo.config.activityId
					end
				elseif actId ~= mo.config.activityId then
					logError("回声港湾的红帆陈列馆绑定活动id不一致：" .. "  " .. mo.config.id)

					return mo.config.activityId
				end
			end
		end
	end

	return actId
end

function TowerStoreModel:getMinRemainTimeStoreId()
	local minRemainTimeStoreId = 0
	local minOffsetSecond
	local storeType = self:getStore()

	for _, storeId in pairs(storeType) do
		local actId = self:checkUpdateStoreActivity(storeId)
		local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

		if actInfoMo then
			local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

			if not minOffsetSecond or offsetSecond < minOffsetSecond then
				minOffsetSecond = offsetSecond
				minRemainTimeStoreId = storeId
			end
		end
	end

	return minRemainTimeStoreId
end

function TowerStoreModel:checkStoreNewGoods()
	local storeId = self:getMinRemainTimeStoreId()
	local actId = self:checkUpdateStoreActivity(storeId) or 0

	if self:isHasNewGoods() then
		self._isHasNewGoods = true
	elseif actId and actId > 0 then
		local key = self:getStoreNewGoodsPrefKey()

		self._isHasNewGoods = not ActivityEnterMgr.instance:isEnteredActivity(actId) or PlayerPrefsHelper.getNumber(key, 0) == 0
	else
		self._isHasNewGoods = false
	end

	return self._isHasNewGoods
end

function TowerStoreModel:setNotNewStoreGoods()
	local key = self:getStoreNewGoodsPrefKey()

	PlayerPrefsHelper.setNumber(key, 1)

	self._isHasNewGoods = false
end

function TowerStoreModel:isHasNewGoodsInStore()
	return self._isHasNewGoods
end

function TowerStoreModel:getStoreNewGoodsPrefKey()
	local storeId = self:getMinRemainTimeStoreId()
	local actId = self:checkUpdateStoreActivity(storeId) or 0
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo then
		if not playerInfo.userId then
			local playerId = 1999

			return "TowerStoreModel_StoreNewGoods_" .. playerId .. "|" .. actId
		end
	end
end

function TowerStoreModel:getStore()
	return {
		StoreEnum.TowerStore.ComposeUpdateStore,
		StoreEnum.TowerStore.UpdateStore,
		StoreEnum.TowerStore.NormalStore
	}
end

function TowerStoreModel:saveAllStoreGroupNewData()
	local normalStoreId = StoreEnum.TowerStore.NormalStore

	self:clearStoreGroupMo(normalStoreId)
	self:saveStoreGroupNewMo(normalStoreId)
end

function TowerStoreModel:readAllStoreGroupNewData()
	local normalStoreId = StoreEnum.TowerStore.NormalStore

	self:readStoreGroupNewMo(normalStoreId)
end

function TowerStoreModel:saveStoreGroupNewMo(storeId)
	local key = self:getStoreGoodsNewDataPrefKey(storeId)
	local dataStr = ""

	if not self._storeGroupGoodsMo then
		PlayerPrefsHelper.setString(key, dataStr)

		return
	end

	local groupMo = self._storeGroupGoodsMo[storeId]

	if groupMo then
		for _, mo in pairs(groupMo) do
			dataStr = dataStr .. string.format("%s#%s#%s|", mo.goodsId, mo.limitCount, mo.isNew and 0 or 1)
		end
	end

	PlayerPrefsHelper.setString(key, dataStr)
end

function TowerStoreModel:readStoreGroupNewMo(storeId)
	local key = self:getStoreGoodsNewDataPrefKey(storeId)
	local saveStoreGroupMo = PlayerPrefsHelper.getString(key, "")

	self._storeGroupGoodsMo = self._storeGroupGoodsMo or {}
	self._storeGroupGoodsMo[storeId] = {}

	local stroreGroupMo = self:getStoreGroupMO()

	if not stroreGroupMo then
		return
	end

	local nowStoreGroupMo = stroreGroupMo[storeId]

	if not nowStoreGroupMo then
		return
	end

	local nowStoreGoodsList = nowStoreGroupMo:getGoodsList()

	for _, mo in pairs(nowStoreGoodsList) do
		local goodsId = mo.goodsId
		local limitCount = mo.config.maxBuyCount - mo.buyCount
		local _mo = {
			goodsId = goodsId,
			limitCount = limitCount
		}

		if not string.nilorempty(saveStoreGroupMo) then
			local groupMoList = GameUtil.splitString2(saveStoreGroupMo, true, "|", "#")
			local hasMo

			for _, goodsMo in pairs(groupMoList) do
				if goodsMo and goodsMo[1] == goodsId then
					if goodsMo[2] ~= limitCount then
						_mo.isNew = true
					else
						_mo.isNew = goodsMo[3] == 0
						hasMo = true
					end
				end
			end

			if not hasMo then
				_mo.isNew = true
			end
		else
			_mo.isNew = true
		end

		self._storeGroupGoodsMo[storeId][goodsId] = _mo
	end
end

function TowerStoreModel:clearStoreGroupMo(storeId)
	if self._storeGroupGoodsMo then
		if self._storeGroupGoodsMo then
			for _, mo in pairs(self._storeGroupGoodsMo) do
				mo.isNew = false
			end
		end
	end
end

function TowerStoreModel:getStoreGoodsNewData(storeId, goodsId)
	if self._storeGroupGoodsMo then
		local groupGoodsMo = self._storeGroupGoodsMo[storeId]

		return groupGoodsMo and groupGoodsMo[goodsId]
	end
end

function TowerStoreModel:isHasNewGoods()
	if self._storeGroupGoodsMo then
		if self._storeGroupGoodsMo then
			for _, mo in pairs(self._storeGroupGoodsMo) do
				if mo.isNew then
					return true
				end
			end
		end
	end
end

function TowerStoreModel:onClickGoodsItem(storeId, goodsId)
	local goodsMo = self:getStoreGoodsNewData(storeId, goodsId)

	if goodsMo then
		goodsMo.isNew = false
	end
end

function TowerStoreModel:getStoreGoodsNewDataPrefKey(storeId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo then
		if not playerInfo.userId then
			local playerId = 1999

			return "TowerStoreModel_StoreGoodsNewData_" .. storeId .. "_" .. playerId
		end
	end
end

function TowerStoreModel:isUpdateStoreEmpty()
	local storeMoList = self:getStoreGroupMO()

	if storeMoList then
		if not storeMoList[StoreEnum.TowerStore.UpdateStore] then
			local updateStoreMo = storeMoList[StoreEnum.TowerStore.ComposeUpdateStore]

			return not updateStoreMo or next(updateStoreMo:getGoodsList()) == nil
		end
	end
end

TowerStoreModel.instance = TowerStoreModel.New()

return TowerStoreModel

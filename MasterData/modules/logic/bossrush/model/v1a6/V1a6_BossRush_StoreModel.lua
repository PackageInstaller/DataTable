-- chunkname: @modules/logic/bossrush/model/v1a6/V1a6_BossRush_StoreModel.lua

module("modules.logic.bossrush.model.v1a6.V1a6_BossRush_StoreModel", package.seeall)

local V1a6_BossRush_StoreModel = class("V1a6_BossRush_StoreModel", BaseModel)

function V1a6_BossRush_StoreModel:onInit()
	self.goodsInfosDict = nil
end

function V1a6_BossRush_StoreModel:reInit()
	self:onInit()
end

function V1a6_BossRush_StoreModel:getCurrencyIcon(activityId)
	local currenyId = CurrencyEnum.CurrencyType.BossRushStore

	if currenyId then
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(currenyId)

		if currencyCO then
			return currencyCO.icon .. "_1"
		end
	end
end

function V1a6_BossRush_StoreModel:getCurrencyCount(activityId)
	local currenyId = CurrencyEnum.CurrencyType.BossRushStore

	if currenyId then
		local curreny = CurrencyModel.instance:getCurrency(currenyId)

		if curreny then
			return curreny.quantity
		end
	end

	return 0
end

function V1a6_BossRush_StoreModel:getStoreGroupMO()
	local storeMoList = {}

	for _, storeId in pairs(StoreEnum.BossRushStore) do
		storeMoList[storeId] = StoreModel.instance:getStoreMO(storeId)
	end

	return storeMoList
end

function V1a6_BossRush_StoreModel:getStoreGroupName(storeId)
	local storeGroupCo = StoreConfig.instance:getTabConfig(storeId)

	if storeGroupCo then
		return storeGroupCo.name, storeGroupCo.nameEn
	end
end

function V1a6_BossRush_StoreModel:getUpdateStoreRemainTime()
	local actInfoMo = self:getUpdateStoreActivityMo()

	if actInfoMo then
		return (actInfoMo:getRemainTimeStr2ByEndTime())
	end

	return ""
end

function V1a6_BossRush_StoreModel:getUpdateStoreActivityMo()
	local actId = self:checkUpdateStoreActivity()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isNormal = actInfoMo and ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal

	if isNormal then
		return actInfoMo
	end
end

function V1a6_BossRush_StoreModel:checkUpdateStoreActivity()
	local storeMoList = self:getStoreGroupMO()
	local actId

	if storeMoList then
		local updateStoreMo = storeMoList[StoreEnum.BossRushStore.UpdateStore]

		if updateStoreMo then
			for _, mo in pairs(updateStoreMo:getGoodsList()) do
				if not actId then
					if mo.config.activityId ~= 0 then
						actId = mo.config.activityId
					end
				elseif actId ~= mo.config.activityId then
					logError("鬃毛信托特约期汇绑定活动id不一致：" .. "  " .. mo.config.id .. "  活动1：" .. mo.config.activityId .. "  活动2：" .. actId)

					return
				end
			end
		end
	end

	return actId
end

function V1a6_BossRush_StoreModel:checkStoreNewGoods()
	local actId = self:checkUpdateStoreActivity()

	if self:isHasNewGoods() then
		self._isHasNewGoods = true
	elseif actId then
		local key = self:getStoreNewGoodsPrefKey()

		self._isHasNewGoods = not ActivityEnterMgr.instance:isEnteredActivity(actId) or PlayerPrefsHelper.getNumber(key, 0) == 0
	else
		self._isHasNewGoods = false
	end

	return self._isHasNewGoods
end

function V1a6_BossRush_StoreModel:setNotNewStoreGoods()
	local key = self:getStoreNewGoodsPrefKey()

	PlayerPrefsHelper.setNumber(key, 1)

	self._isHasNewGoods = false
end

function V1a6_BossRush_StoreModel:isHasNewGoodsInStore()
	return self._isHasNewGoods
end

function V1a6_BossRush_StoreModel:getStoreNewGoodsPrefKey()
	local actId = self:checkUpdateStoreActivity() or BossRushConfig.instance:getActivityId()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo then
		if not playerInfo.userId then
			local playerId = 1999

			return "V1a6_BossRush_StoreModel_StoreNewGoods_" .. playerId .. "|" .. actId
		end
	end
end

function V1a6_BossRush_StoreModel:getStore()
	return {
		StoreEnum.BossRushStore.NormalStore,
		StoreEnum.BossRushStore.UpdateStore
	}
end

function V1a6_BossRush_StoreModel:saveAllStoreGroupNewData()
	local normalStoreId = StoreEnum.BossRushStore.NormalStore

	self:clearStoreGroupMo(normalStoreId)
	self:saveStoreGroupNewMo(normalStoreId)
end

function V1a6_BossRush_StoreModel:readAllStoreGroupNewData()
	local normalStoreId = StoreEnum.BossRushStore.NormalStore

	self:readStoreGroupNewMo(normalStoreId)
end

function V1a6_BossRush_StoreModel:saveStoreGroupNewMo(storeId)
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

function V1a6_BossRush_StoreModel:readStoreGroupNewMo(storeId)
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

		if mo:isSoldOut() or limitCount <= 0 and mo.config.maxBuyCount > 0 then
			_mo.isNew = false
		elseif not string.nilorempty(saveStoreGroupMo) then
			local saveGroupMoList = GameUtil.splitString2(saveStoreGroupMo, true, "|", "#")
			local hasMo

			for _, saveGoodsMo in pairs(saveGroupMoList) do
				local saveGoodsId = saveGoodsMo[1]
				local saveGoodsLimitCount = saveGoodsMo[2]
				local saveGoodsIsNew = saveGoodsMo[3]

				if saveGoodsMo and saveGoodsId == goodsId then
					if saveGoodsLimitCount < limitCount then
						_mo.isNew = true
					else
						_mo.isNew = saveGoodsIsNew == 0
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

function V1a6_BossRush_StoreModel:clearStoreGroupMo(storeId)
	if self._storeGroupGoodsMo then
		if self._storeGroupGoodsMo then
			for _, mo in pairs(self._storeGroupGoodsMo) do
				mo.isNew = false
			end
		end
	end
end

function V1a6_BossRush_StoreModel:getStoreGoodsNewData(storeId, goodsId)
	if self._storeGroupGoodsMo then
		local groupGoodsMo = self._storeGroupGoodsMo[storeId]

		return groupGoodsMo and groupGoodsMo[goodsId]
	end
end

function V1a6_BossRush_StoreModel:isHasNewGoods()
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

function V1a6_BossRush_StoreModel:onClickGoodsItem(storeId, goodsId)
	local goodsMo = self:getStoreGoodsNewData(storeId, goodsId)

	if goodsMo then
		goodsMo.isNew = false
	end
end

function V1a6_BossRush_StoreModel:getStoreGoodsNewDataPrefKey(storeId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo then
		if not playerInfo.userId then
			local playerId = 1999

			return "V1a6_BossRush_StoreModel_StoreGoodsNewData_" .. storeId .. "_" .. playerId
		end
	end
end

V1a6_BossRush_StoreModel.instance = V1a6_BossRush_StoreModel.New()

return V1a6_BossRush_StoreModel

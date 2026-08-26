-- chunkname: @modules/logic/versionactivity3_1/nationalgift/model/NationalGiftModel.lua

module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftModel", package.seeall)

local NationalGiftModel = class("NationalGiftModel", BaseModel)

function NationalGiftModel:onInit()
	self:reInit()
end

function NationalGiftModel:reInit()
	self._actInfoDict = {}
end

function NationalGiftModel:setActInfo(info)
	if info then
		if not info.activityId then
			local actId = self:getCurVersionActId()

			self._actInfoDict[actId] = self._actInfoDict[actId] or NationalGiftMO.New()

			if not info then
				return
			end

			self._actInfoDict[actId]:init(info)
		end
	end
end

function NationalGiftModel:setActActive(active, actId)
	actId = actId or self:getCurVersionActId()

	if self._actInfoDict[actId] then
		self._actInfoDict[actId]:updateActActive(active)
	end
end

function NationalGiftModel:updateBonusStatus(bonusId, status, actId)
	actId = actId or self:getCurVersionActId()

	if self._actInfoDict[actId] then
		self._actInfoDict[actId]:updateBonusStatus(bonusId, status)
	end
end

function NationalGiftModel:updateBonuses(bonuses, actId)
	actId = actId or self:getCurVersionActId()

	if self._actInfoDict[actId] then
		self._actInfoDict[actId]:updateBonuses(bonuses)
	end
end

function NationalGiftModel:isBonusActive(actId)
	actId = actId or self:getCurVersionActId()

	return self._actInfoDict[actId] and self._actInfoDict[actId].isActive
end

function NationalGiftModel:getBonusList(actId)
	actId = actId or self:getCurVersionActId()

	return self._actInfoDict[actId] and self._actInfoDict[actId].bonuses
end

function NationalGiftModel:getBonusEndTime(actId)
	actId = actId or self:getCurVersionActId()

	if not self._actInfoDict[actId] then
		return 0
	end

	return tonumber(self._actInfoDict[actId].endTime) / 1000
end

function NationalGiftModel:getBuyEndTime()
	local packageStoreId = self:getNationalGiftStoreId()
	local chargeCo = StoreConfig.instance:getChargeGoodsConfig(packageStoreId)

	if not chargeCo then
		return 0
	end

	if type(chargeCo.offlineTime) == "number" then
		return chargeCo.offlineTime / 1000
	else
		if string.nilorempty(chargeCo.offlineTime) then
			return 0
		end

		return (TimeUtil.stringToTimestamp(chargeCo.offlineTime))
	end

	return 0
end

function NationalGiftModel:isBonusGet(bonusId, actId)
	actId = actId or self:getCurVersionActId()

	return self._actInfoDict[actId] and self._actInfoDict[actId]:isBonusGet(bonusId)
end

function NationalGiftModel:isBonusCouldGet(bonusId, actId)
	actId = actId or self:getCurVersionActId()

	return self._actInfoDict[actId] and self._actInfoDict[actId]:isBonusCouldGet(bonusId)
end

function NationalGiftModel:isGiftHasBuy(actId)
	actId = actId or self:getCurVersionActId()

	return self._actInfoDict[actId] and self._actInfoDict[actId].isActive
end

function NationalGiftModel:getCurRewardDay()
	local day = 1
	local bonusList = self:getBonusList()

	for index, bonus in ipairs(bonusList) do
		if bonus.status ~= NationalGiftEnum.Status.NoGet then
			day = index
		end
	end

	return day
end

function NationalGiftModel:isNeedShowReddot()
	local lv = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0)

	return lv > 0
end

function NationalGiftModel:getNationalGiftStoreId(actId)
	actId = actId or self:getCurVersionActId()

	local bonusCo = NationalGiftConfig.instance:getBonusCo(1, actId)

	return bonusCo.packsId
end

function NationalGiftModel:getCurVersionActId()
	return ActivityConfig.instance:getConstAsNum(9, VersionActivity3_3Enum.ActivityId.NationalGift)
end

NationalGiftModel.instance = NationalGiftModel.New()

return NationalGiftModel

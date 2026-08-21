-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/model/RetrieveActivityData.lua

module("logic.extensions.retrieve.model.RetrieveActivityData", package.seeall)

local M = class("RetrieveActivityData", ActivityData)

function M:ctor(ActivityNO)
	M.super.ctor(self, ActivityNO)

	self._desc = false
	self._descriptionHash = false
	self._dailyRemain = false
	self._rate = false
	self._previewRate = false
	self._picked = 0
	self._stableNum = 0
	self._nextGuaranteeA = false
	self._isNew = false
end

function M:initConfig()
	self._configCO = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryPool, self._configId)

	if not self._configCO then
		return
	end

	self._poolId = self._configCO.code
	self._lotteryName = self._configCO.name
	self._lotteryType = RetrieveEnum.LotteryType.CommonCard
	self._systemOpen = self._configCO.systemOpen
	self._lotteryCost = {}
	self._lotteryCost[RetrieveEnum.LotteryNum.One] = {
		item = self._configCO.cost[1],
		num = self._configCO.cost[2]
	}
	self._lotteryCost[RetrieveEnum.LotteryNum.Ten] = {
		item = self._configCO.cost[1],
		num = self._configCO.cost[3]
	}
	self._sortOrder = self._configCO.sortOrder
	self._characterCode = self._configCO.characterCode
	self._pictureName = self._configCO.pictureName
	self._hint = self._configCO.hint
	self._poolType = self._configCO.running
	self._absoluteMax = self._configCO.absoluteMax
	self._campType = self._configCO.campType
	self._poolTitleName = self._configCO.titleName
	self._subtitleName = self._configCO.subtitle
	self._bannerName = self._configCO.bannerName
	self._wishMax = self._configCO.wishMax or 0
	self._pickShowList = self._configCO.pickableItems or {}
	self._feature = self._configCO.feature
	self._sceneBg = self._configCO.sceneBg
	self._enterVideo = self._configCO.enterVideo
	self._leftPos = self:_toVector3(self._configCO.leftPos)
	self._midPos = self:_toVector3(self._configCO.midPos)
	self._rightPos = self:_toVector3(self._configCO.rightPos)
	self._showMidRoleInfo = self._configCO.showMidRoleInfo == 1
	self._isNew = true
end

function M:_toVector3(value)
	if not value then
		return Vector3.New(0, 0, 0)
	end

	return Vector3.New(value[1] or 0, value[2] or 0, value[3] or 0)
end

function M:getConditionOpen()
	if not self._systemOpen then
		return false
	end

	if self._systemOpen > 0 then
		return SystemOpenFacade.instance:isOpen(self._systemOpen, false)
	end

	return true
end

function M:refreshLotteryData(params)
	self._desc = params.description
	self._descriptionHash = params.descriptionHash

	if params:HasField("dailyRemain") then
		self._dailyRemain = params.dailyRemain
	end

	self._rate = params.sRate / 10 or 0
	self._commonRate = params.basicRates
	self._upRate = params.upRates
	self._syntheticalRates = params.syntheticalRates
	self._picked = params.picked or 0
	self._stableNum = params.guaranteeWish or 0
	self._nextGuaranteeA = params.nextGuaranteeA or 10
	self._guaranteeAbsolute = params.guaranteeAbsolute
	self._nextGuaranteeS = params.nextGuaranteeS
end

function M:getCommonRateByQuality(quality)
	local index = quality - 1

	return self._commonRate and self._commonRate[index] or 0
end

function M:getUpRateByQuality(quality)
	local index = quality - 1

	return self._upRate and self._upRate[index] or 0
end

function M:getComplexRateByQuality(quality)
	local index = quality - 1

	return self._syntheticalRates and self._syntheticalRates[index] or 0
end

function M:getPicked()
	return self._picked or 0
end

function M:setPicked(pickItemId)
	if pickItemId ~= self._picked then
		self._stableNum = 0
	end

	self._picked = pickItemId
end

function M:_refreshCenterPos()
	if self._picked > 0 and self._characterCode and #self._characterCode > 1 then
		local curPicedIndex = 1

		for i = 1, #self._characterCode do
			if self._characterCode[i] == self._picked then
				curPicedIndex = i

				break
			end
		end

		if curPicedIndex ~= 2 then
			local tmpHeroId = self._characterCode[2]

			self._characterCode[2] = self._picked
			self._characterCode[curPicedIndex] = tmpHeroId
		end
	end
end

function M:nextGuaranteeA()
	return self._nextGuaranteeA or 10
end

function M:getAbsoluteCout()
	return self._guaranteeAbsolute or 0
end

function M:getNextGuaranteeS()
	return self._nextGuaranteeS or 0
end

function M:isPicked()
	return self._picked > 0
end

function M:isRandomPick()
	return self._picked == RetrieveEnum.RandomPick
end

function M:isPickNothing()
	return self._picked == 0
end

function M:getWishMax()
	return self._wishMax or 0
end

function M:getPickableItems()
	return self._pickShowList or {}
end

function M:getFeature()
	return self._feature or 0
end

function M:getPoolType()
	return self._poolType or 0
end

function M:getAbsoluteMax()
	return self._absoluteMax or 0
end

function M:getStableNum()
	return self._stableNum or 0
end

function M:getRate()
	return self._rate
end

function M:getRateStr()
	return string.format("%.2f", self:getRate())
end

function M:getLotteryId()
	return self._id
end

function M:getLotteryName()
	return self._lotteryName
end

function M:getPoolId()
	return self._poolId
end

function M:getLotteryType()
	return self._lotteryType
end

function M:getLotteryCost(lotteryNum)
	return self._lotteryCost[lotteryNum]
end

function M:getSortOrder()
	return self._sortOrder
end

function M:getDesc()
	return self._desc
end

function M:getDescriptionHash()
	return self._descriptionHash
end

function M:getDailyRemain()
	return self._dailyRemain
end

function M:getPoolTitileName()
	return self._poolTitleName
end

function M:getSubtitle()
	return self._subtitleName
end

function M:getWishDesc()
	if not self._wishDesc and not self._simpleWishDesc then
		self._simpleWishDesc, self._wishDesc = StringUtil.splitSummaryInfo(self._configCO.wishDesc)
	end

	return self._wishDesc or ""
end

function M:getSimpleWishDesc()
	if not self._wishDesc and not self._simpleWishDesc then
		self._simpleWishDesc, self._wishDesc = StringUtil.splitSummaryInfo(self._configCO.wishDesc)
	end

	return self._simpleWishDesc or ""
end

function M:_getSimpleText()
	return
end

function M:getCharacterCode()
	return self._characterCode
end

function M:getPictureName()
	return self._pictureName
end

function M:getBannerName()
	return self._bannerName
end

function M:getSceneBg()
	return self._sceneBg
end

function M:getEneterVideo()
	return self._enterVideo
end

function M:getLeftPos()
	return self._leftPos
end

function M:getMidPos()
	return self._midPos
end

function M:getRightPos()
	return self._rightPos
end

function M:getShowMidRoleInfo()
	return self._showMidRoleInfo
end

function M:setNewFlag(isNew)
	self._isNew = isNew
end

function M:getIsNew()
	return self._isNew or false
end

function M:getHint()
	return self._hint
end

function M:setIsNew(isNew)
	self._isNew = isNew
end

function M:getIsNew()
	return self._isNew
end

function M:getCampType()
	return self._campType
end

function M:getLotterySimpleType()
	if self:isEcho() then
		return RetrieveEnum.LotterySimpleType.Echo
	end

	return RetrieveEnum.LotterySimpleType.Card
end

function M:isCard()
	return self._lotteryType == RetrieveEnum.LotteryType.CommonCard or self._lotteryType == RetrieveEnum.LotteryType.OptionalCard
end

function M:isEcho()
	return self._lotteryType == RetrieveEnum.LotteryType.CommonEcho or self._lotteryType == RetrieveEnum.LotteryType.OptionalEcho
end

function M:getPreviewItemList()
	local itemRawList = {}
	local upRawItemList = {}
	local poolRawList = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryPoolDetail, self._configId)

	for i, poolData in pairs(poolRawList) do
		if self:getLotterySimpleType() == RetrieveEnum.LotterySimpleType.Card then
			local groupList = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryHeroGroup, poolData.groupCode)

			for k, group in pairs(groupList) do
				if LotteryUtil.isProbabilityUp(group) then
					local characterCO = CharacterConfig.instance:getCfgInfoByID(group.itemCode)
					local quality = characterCO.quality

					upRawItemList[quality] = upRawItemList[quality] or {}

					table.insert(upRawItemList[quality], group)
				else
					local characterCO = CharacterConfig.instance:getCfgInfoByID(group.itemCode)
					local quality = characterCO.quality

					itemRawList[quality] = itemRawList[quality] or {}

					table.insert(itemRawList[quality], group)
				end
			end
		else
			local groupList = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryEquipGroup, poolData.groupCode)

			for k, group in pairs(groupList) do
				if LotteryUtil.isProbabilityUp(group) then
					local itemCO = BackpackConfig.instance:getItemInfoByItemId(group.itemCode)
					local quality = itemCO.quality

					upRawItemList[quality] = upRawItemList[quality] or {}

					table.insert(upRawItemList[quality], group)
				else
					local itemCO = BackpackConfig.instance:getItemInfoByItemId(group.itemCode)

					if itemCO then
						local quality = itemCO.quality

						itemRawList[quality] = itemRawList[quality] or {}

						table.insert(itemRawList[quality], group)
					else
						printError("cloud not found id==>", group.itemCode)
					end
				end
			end
		end
	end

	return upRawItemList, itemRawList
end

function M:isNewhandLottery()
	return self._feature == 1
end

return M

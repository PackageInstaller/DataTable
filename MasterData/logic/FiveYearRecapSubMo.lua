-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/data/FiveYearRecapSubMo.lua

module("logic.extensions.fiveyearrecap.data.FiveYearRecapSubMo", package.seeall)

local FiveYearRecapSubMo = class("FiveYearRecapSubMo")

function FiveYearRecapSubMo:ctor(activityId)
	self._activityId = activityId

	local pageDatass = FiveYearRecapConfig.instance:getReportPageDatass(self._activityId)

	if pageDatass then
		self._maxPageId = #pageDatass or 0
	end

	self:_resetData()
end

function FiveYearRecapSubMo:_resetData()
	self._loginDays = 0
	self._hasGainedLoginPrizeIds = {}
	self._onlineMinute = 0
	self._unLockPieceIds = {}
	self._hasGainedUnlockPrize = false
	self._hasShared = false
	self._recapDatas = {}
end

function FiveYearRecapSubMo:dispose()
	self:_resetData()
end

function FiveYearRecapSubMo:handlePM_FiveYearRecapGetInfoRes(msg)
	self._loginDays = msg.loginDays
	self._onlineMinute = msg.onlineMinute
	self._hasGainedUnlockPrize = msg.hasGainedUnlockPrize
	self._hasShared = msg.hasShared

	for i, v in ipairs(msg.hasGainedLoginPrizeIds) do
		self._hasGainedLoginPrizeIds[v] = true
	end

	for i, v in ipairs(msg.unLockPieceIds) do
		self._unLockPieceIds[v] = true
	end

	local recapMap = {}

	for _, no in ipairs(msg.datas) do
		recapMap[no.dataId] = no.data
	end

	MmUtil.coverDictionary(self._recapDatas, recapMap)
end

function FiveYearRecapSubMo:handlePM_FiveYearRecapGainLoginPrizeRes(msg)
	for _, v in ipairs(msg.prizeIds) do
		self._hasGainedLoginPrizeIds[v] = true
	end
end

function FiveYearRecapSubMo:handlePM_FiveYearRecapUnlockRes(msg)
	self._unLockPieceIds[msg.pieceId] = true
end

function FiveYearRecapSubMo:handlePM_FiveYearRecapShareRes(msg)
	self._hasShared = true
end

function FiveYearRecapSubMo:getLoginDays()
	return self._loginDays
end

function FiveYearRecapSubMo:isHasGainedLoginPrize(prizeId)
	return self._hasGainedLoginPrizeIds[prizeId] or false
end

function FiveYearRecapSubMo:isEnoughToGainLoginPrize(prizeId)
	local data = FiveYearRecapConfig.instance:getLoginDaysPrizeData(self._activityId, prizeId)

	if data then
		if not data.loginDays then
			local need = 0
			local cur = self:getLoginDays()

			return need <= cur
		end
	end
end

function FiveYearRecapSubMo:isCanGainLoginPrize(prizeId)
	return not self:isHasGainedLoginPrize(prizeId) and self:isEnoughToGainLoginPrize(prizeId)
end

function FiveYearRecapSubMo:getOnlineMinute()
	return self._onlineMinute
end

function FiveYearRecapSubMo:isEnoughUnlockPiece()
	return self:getWithPieceCount() > 0
end

function FiveYearRecapSubMo:getWithPieceCount()
	local data = FiveYearRecapConfig.instance:getOnlineUnlockDataByMinute(self._activityId, self._onlineMinute)

	if data then
		if not data.unlockCount then
			local withCount = 0
			local usedCount = self:getUsedPieceCount()

			return Mathf.Max(0, withCount - usedCount)
		end
	end
end

function FiveYearRecapSubMo:isActivatedOnline(onlineMinute)
	return onlineMinute <= self._onlineMinute
end

function FiveYearRecapSubMo:isPieceUnlocked(pieceId)
	return self._unLockPieceIds[pieceId] or false
end

function FiveYearRecapSubMo:getUsedPieceCount()
	local count = 0

	for _, isUnlock in pairs(self._unLockPieceIds) do
		if isUnlock then
			count = count + 1
		end
	end

	return count
end

function FiveYearRecapSubMo:getHasGainedUnlockPrize()
	return self._hasGainedUnlockPrize
end

function FiveYearRecapSubMo:getRecapData(dataId)
	local result
	local data = FiveYearRecapConfig.instance:getDataIdsData(dataId)
	local handleType = data.handleType

	if string.nilorempty(handleType) then
		result = self._recapDatas[dataId]
	elseif handleType == FiveYearRecapEnum.HandleTypes_Client then
		if dataId == FiveYearRecapEnum.DataIds_RegisterTime then
			result = self:_getRecapDataOfRegisterTime()
		elseif dataId == FiveYearRecapEnum.DataIds_NowMount then
			result = self:_getRecapDataOfNowMount()
		elseif dataId == FiveYearRecapEnum.DataIds_NowMaxZdl then
			result = self:_getRecapDataOfNowMaxZdl()
		elseif dataId == FiveYearRecapEnum.DataIds_NowMaxZdlRaceId then
			result = self:_getRecapDataOfNowMaxZdlRaceId()
		elseif dataId == FiveYearRecapEnum.DataIds_NowCollectPetCount then
			result = self:_getRecapDataOfNowCollectPetCount()
		else
			printError(string.format("配置错误，handleType为Client的dataId未作处理，请联系前端。( yw运营-五周年回顾.xlsx | dataId:%s, handleType:%s )", dataId, handleType))
		end
	elseif handleType == FiveYearRecapEnum.HandleTypes_Mat then
		local matType, matId = MaterialMgr.getMatParams(data.params)

		result = MaterialModel.instance:getMaterialsNumber(matType, matId)
	elseif handleType == FiveYearRecapEnum.HandleTypes_MatType then
		local matType = checknumber(data.params)
		local count = 0

		if matType == MatType.Bubble then
			local tmp = ChatConfig.instance:getChatBubbleCfgs()
			local vipLv = RoleModel.instance:getVipLvl()

			for i, v in ipairs(tmp) do
				if v.notOnline ~= 1 then
					if v.bubbleId > 1 then
						local num = MaterialModel.instance:getMaterialsNumber(MatType.Bubble, v.bubbleId)

						if v.defaultByVip then
							if vipLv < v.vipLevel then
								-- block empty
							else
								count = count + 1
							end
						elseif num > 0 then
							count = count + 1
						end
					else
						count = count + 1
					end
				end
			end
		elseif matType == MatType.NameFrame then
			local tmp = BattleStartAnimConfig.instance:getNameFrameCfgList() or {}

			for i, v in ipairs(tmp) do
				if v.notOnline ~= 1 then
					local state = BattleStartAnimModel.instance:getState(matType, v.id)

					if state ~= BattleStartAnimModel.Lock then
						count = count + 1
					end
				end
			end
		elseif matType == MatType.HomePageBg then
			local cfgs = BattleStartAnimConfig.instance:getHomePageBgCfgList() or {}

			count = self:_getMatCount(cfgs, matType)
		elseif matType == MatType.OpeningEffect then
			local cfgs = BattleStartAnimConfig.instance:getOpeningEffectCfgList()

			count = self:_getMatCount(cfgs, matType)
		elseif matType == MatType.PlayerMessageSkin then
			local cfgs = BattleStartAnimConfig.instance:getPlayerMessageSkinCfg() or {}

			count = self:_getMatCount(cfgs, matType)
		elseif matType == MatType.BattleUserInterfaceSkin then
			local cfgs = BattleStartAnimConfig.instance:getBattleUISkinCfgs()

			count = self:_getMatCount(cfgs, matType)
		elseif matType == MatType.BattleBackgroundSkin then
			local cfgs = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfgs()

			count = self:_getMatCount(cfgs, matType)
		else
			local list = MaterialMgr.getModelList(matType)

			if list then
				for _, mo in ipairs(list) do
					count = mo.GetCount and count + mo:GetCount() or count + 1
				end
			end
		end

		result = count
	elseif handleType == FiveYearRecapEnum.HandleTypes_Dress then
		local belogTabs = string.split(data.params, "#")

		result = self:_getRecapDataOfCollectDressCount(belogTabs)
	end

	return result and result > 0 and result or nil
end

function FiveYearRecapSubMo:_getMatCount(cfgs, matType)
	local count = 0

	for i, v in ipairs(cfgs) do
		local state = BattleStartAnimModel.instance:getState(matType, v.id)

		if state ~= BattleStartAnimModel.Lock then
			count = count + 1
		end
	end

	return count
end

function FiveYearRecapSubMo:_getRecapDataOfRegisterTime()
	return RoleModel.instance:getActiveTimeSec()
end

function FiveYearRecapSubMo:_getRecapDataOfNowMount()
	return MountModel.instance:getActiveMountNum()
end

function FiveYearRecapSubMo:_getRecapDataOfNowMaxZdl()
	return GlobalModel.instance:getCurrStrength()
end

function FiveYearRecapSubMo:_getRecapDataOfNowMaxZdlRaceId()
	local petId = BagPetsController.instance:getMaxPowerPetId()
	local petMo = BagPetsController.instance:getPet(petId)

	return petMo and petMo:getDefineId() or 0
end

function FiveYearRecapSubMo:_getRecapDataOfNowCollectPetCount()
	local ownedNum, totalNum = PetbookModel.instance:getPetNum()

	return ownedNum
end

function FiveYearRecapSubMo:_getRecapDataOfCollectDressCount(belogTabs)
	local neutralCount = 0
	local genderCount = 0
	local tabMap = {}

	for _, belogTab in pairs(belogTabs) do
		tabMap[checknumber(belogTab)] = true
	end

	local dataList = DressConfig.instance:getAllConfig().dataList or {}

	for _, data in ipairs(dataList) do
		if tabMap[data.belogTab] then
			if data.clothesGender == GameEnum.Gender.Neutral then
				neutralCount = neutralCount + 1
			else
				genderCount = genderCount + 1
			end
		end
	end

	return neutralCount + Mathf.Ceil(genderCount / 2)
end

function FiveYearRecapSubMo:isHasShared()
	return self._hasShared
end

function FiveYearRecapSubMo:getMaxPageId()
	return self._maxPageId
end

function FiveYearRecapSubMo:getAdapterContent(content)
	local isHaveEmptyData = false
	local result = string.gsub(content, "{([^}]+)}", function(adapterTag)
		local adapterResult = self:getAdapterResult(adapterTag)

		isHaveEmptyData = isHaveEmptyData or adapterResult == nil

		return tostring(adapterResult)
	end)

	return result, isHaveEmptyData
end

local AdapterFuncs = {
	[FiveYearRecapEnum.AdapterTypes.DataId] = "_handleAdapterWithDataId",
	[FiveYearRecapEnum.AdapterTypes.RankRatio] = "_handleAdapterWithRankRatio",
	[FiveYearRecapEnum.AdapterTypes.PetName] = "_handleAdapterWithPetName",
	[FiveYearRecapEnum.AdapterTypes.DateTime] = "_handleAdapterWithDateTime"
}

function FiveYearRecapSubMo:getAdapterResult(adapterTag)
	if string.nilorempty(adapterTag) then
		return nil
	end

	local array = string.split(adapterTag, "$")
	local adapterType = array[1]
	local params = array[2]

	if FiveYearRecapEnum.AdapterTypes[adapterType] == nil then
		printError(string.format("配置错误，adapterFormat字段内出现不存在的adapterType。( yw运营-五周年回顾.xlsx | adapterType:%s, adapterTag:%s )", adapterType, adapterTag))
	elseif AdapterFuncs[adapterType] == nil then
		printError(string.format("错误，不存在对应adapterType的回调函数。( yw运营-五周年回顾.xlsx | adapterType:%s, adapterTag:%s )", adapterType, adapterTag))
	end

	local funcName = AdapterFuncs[adapterType]
	local func = self[funcName]

	return (GameUtil.callBack(func, self, params))
end

function FiveYearRecapSubMo:_handleAdapterWithDataId(params)
	local dataId = checknumber(params)

	return self:getRecapData(dataId)
end

function FiveYearRecapSubMo:_handleAdapterWithRankRatio(params)
	local array = string.split(params, "#")
	local rankPlanId = checknumber(array[1])
	local dataId = checknumber(array[2])
	local dataValue = self:getRecapData(dataId) or 0

	return (FiveYearRecapConfig.instance:getAdapterRankplanValueByRank(rankPlanId, dataValue))
end

function FiveYearRecapSubMo:_handleAdapterWithPetName(params)
	local dataId = checknumber(params)
	local dataValue = self:getRecapData(dataId)
	local raceId = dataValue or 0

	return (CharacterConfig.instance:getPetName(raceId))
end

function FiveYearRecapSubMo:_handleAdapterWithDateTime(params)
	local dataId = checknumber(params)
	local dataValue = self:getRecapData(dataId)

	dataValue = checknumber(dataValue)

	local ss = dataValue % 100
	local mm = math.floor(dataValue / 100) % 100
	local hh = math.floor(dataValue / 10000)

	return string.format("%d点%02d分%02d秒", hh, mm, ss)
end

function FiveYearRecapSubMo:isFitCondition(cond)
	local result = false
	local array = string.split(cond, "$")
	local condType = array[1]
	local params = string.split(array[2], ",")

	if condType == "dataId" then
		local dataId = checknumber(params[1])
		local valueA = self:getRecapData(dataId) or 0
		local compareTag = params[2]
		local valueB = checknumber(params[3])

		result = self:_compareByParam(compareTag, valueA, valueB)
	end

	return result
end

function FiveYearRecapSubMo:_compareByParam(compareTag, valueA, valueB)
	if compareTag == GameEnum.GREATER_THAN then
		return valueB < valueA
	elseif compareTag == GameEnum.GREATER_THAN_OR_EQUAL_TO then
		return valueB <= valueA
	elseif compareTag == GameEnum.LESS_THAN then
		return valueA < valueB
	elseif compareTag == GameEnum.LESS_THAN_OR_EQUAL_TO then
		return valueA <= valueB
	elseif compareTag == GameEnum.EQUAL_TO then
		return valueA == valueB
	elseif compareTag == GameEnum.NOT_EQUAL_TO then
		return valueA ~= valueB
	end

	return false
end

function FiveYearRecapSubMo:filterFitTagList(tagIdList)
	local result = {}

	for _, tagId in ipairs(tagIdList) do
		if self:isFitTag(tagId) then
			table.insert(result, tagId)
		end
	end

	return result
end

function FiveYearRecapSubMo:isFitTag(tagId)
	local data = FiveYearRecapConfig.instance:getPersonTagData(self._activityId, tagId)

	return self:isFitCondition(data.judgeCond)
end

return FiveYearRecapSubMo

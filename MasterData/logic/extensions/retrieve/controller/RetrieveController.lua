-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/controller/RetrieveController.lua

module("logic.extensions.retrieve.controller.RetrieveController", package.seeall)

local M = class("RetrieveController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._cacheItemMOList = {}
	self._clickLotteryTen = false
end

function M:enterScene(isTest)
	RetrieveModel.instance:setTestModel(isTest)
	SceneFace.instance:enterRetrieveScene()
end

function M:removeAllHero()
	if enableLog then
		printInfo("retrieve .. remove all hero")
	end

	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()

		if curSceneFlow then
			curSceneFlow.performMgr:clearCacheUnitList()
			curSceneFlow.unitFactory:removeUnitByTag(UnitTag.Player)
		end
	end
end

function M:setAllHeroState(active)
	if enableLog then
		printInfo("retrieve .. set all state", active)
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		for pointId, tempHeroId in ipairs(heroCodes) do
			local curSceneFlow = SceneFace.instance:getCurSceneFlow()

			if curSceneFlow then
				local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, tempHeroId)

				if retrieveUnit then
					retrieveUnit.meshModel:setModelActive(active, MainPerformEnum.AnimPrefix.ChouKa)
				end
			end
		end
	end
end

function M:clearCacheUnitList()
	if enableLog then
		printInfo("retrieve .. clear cache unit list")
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow and curSceneFlow.performMgr then
		curSceneFlow.performMgr:clearCacheUnitList()
	end
end

function M:hideOtherHero(heroId)
	if enableLog then
		printInfo("retrieve .. hide other hero", heroId)
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		for pointId, tempHeroId in ipairs(heroCodes) do
			local curSceneFlow = SceneFace.instance:getCurSceneFlow()

			if curSceneFlow then
				local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, tempHeroId)

				retrieveUnit.meshModel:setModelActive(tempHeroId ~= heroId, MainPerformEnum.AnimPrefix.ChouKa)
			end
		end
	end
end

function M:showHeroByHeroId(heroId)
	if enableLog then
		printInfo("retrieve .. show hero by hero id", heroId)
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		for pointId, tempHeroId in ipairs(heroCodes) do
			local curSceneFlow = SceneFace.instance:getCurSceneFlow()

			if curSceneFlow then
				local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, tempHeroId)

				if retrieveUnit then
					local show = heroId == tempHeroId

					retrieveUnit.meshModel:setModelActive(show, MainPerformEnum.AnimPrefix.ChouKa)
				end
			end
		end
	end
end

function M:forceEnterWish(pickedHero)
	if enableLog then
		printInfo("retrieve .. force enter wish", pickedHero)
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		if heroCodes then
			local curSceneFlow = SceneFace.instance:getCurSceneFlow()

			for index, heroId in ipairs(heroCodes) do
				if pickedHero == heroId then
					self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa)
				elseif curSceneFlow then
					local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, heroId)

					if retrieveUnit then
						retrieveUnit.meshModel:setModelActive(false, MainPerformEnum.AnimPrefix.ChouKa)
					else
						self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa, nil, nil, true)
					end
				end
			end
		end
	end
end

function M:forceEnterHeroPreview()
	if enableLog then
		printInfo("retrieve .. force enter hero preview")
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		if heroCodes then
			local curSceneFlow = SceneFace.instance:getCurSceneFlow()

			for index, heroId in ipairs(heroCodes) do
				if curSceneFlow then
					local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, heroId)

					if retrieveUnit then
						retrieveUnit.meshModel:setModelActive(false, MainPerformEnum.AnimPrefix.ChouKa)
					else
						self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa, nil, nil, true)
					end
				end
			end
		end
	end
end

function M:forceShowIdle()
	if enableLog then
		printInfo("retrieve .. force show idle")
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		if heroCodes then
			for index, heroId in ipairs(heroCodes) do
				local curSceneFlow = SceneFace.instance:getCurSceneFlow()

				if curSceneFlow then
					local retrieveUnit = curSceneFlow.unitFactory:getUnitHero(UnitTag.Player, heroId)

					if retrieveUnit and retrieveUnit.meshModel:getCurAnimState() == MainPerformEnum.AnimFullName.ChangeShow then
						MainScenePerformUtil.heroAnimSeqPlay(heroId, MainPerformEnum.AnimPrefix.ChouKa)
					else
						self:changeHeroReq(index, heroId)
					end
				end
			end
		end
	end
end

function M:loadAndSetDefault()
	if enableLog then
		printInfo("retrieve .. load and set default")
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		if heroCodes then
			for index, heroId in ipairs(heroCodes) do
				self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa)
			end
		end
	end
end

function M:changeHeroByLotteryId(pointId, needShowEnter)
	if enableLog then
		printInfo("retrieve .. change hero by point id", pointId, needShowEnter)
	end

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData then
		local heroCodes = lotteryData:getCharacterCode()

		if heroCodes then
			local isChange = false

			for index, heroId in ipairs(heroCodes) do
				if not pointId then
					local cPointId = 1

					if #heroCodes == 1 then
						isChange = true
						cPointId = 2
					elseif #heroCodes >= 2 then
						isChange = index == 2
						cPointId = 2
					end

					if isChange then
						self:changeHeroReq(cPointId, heroId, 0, true, MainPerformEnum.AnimPrefix.XiangQing, nil, isChange and needShowEnter)
					else
						self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa, nil, false, needShowEnter)
					end
				elseif index ~= pointId then
					self:changeHeroReq(index, heroId, nil, true, MainPerformEnum.AnimPrefix.ChouKa)
				end
			end
		end
	end
end

function M:changeHeroReq(pointId, heroId, skinId, forceSet, prefix, mixDuration, isChange, defaultHide)
	local info = {
		pointId = pointId,
		heroId = heroId,
		skinId = skinId,
		forceSet = forceSet,
		prefix = prefix,
		mixDuration = mixDuration,
		isChange = isChange,
		defaultHide = defaultHide,
		posInfo = posInfo
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_CHANGE_REQ, info)
end

function M:refreshLotteryData(pools)
	local lotteryDataList = ActivityController.instance:getActivitiesByLogicType(ActivityEnum.LogicType.LOTTERY)
	local lotteryActivityLen = #lotteryDataList

	if lotteryActivityLen ~= #pools then
		for _, activityData in ipairs(lotteryDataList) do
			local hasFind = false
			local tmpFindPoolId = activityData:getLotteryId()

			for i, pool in ipairs(pools) do
				if pool.code == activityData:getPoolId() then
					hasFind = true
				end
			end

			if not hasFind then
				activityData:setIsOpen(false)

				local jumpInfo = RetrieveModel.instance:getJumpInfo()

				if jumpInfo and jumpInfo.lotteryId == tmpFindPoolId then
					RetrieveModel.instance:clearJumpInfo()
				end
			end
		end
	end

	for i, pool in ipairs(pools) do
		local code = pool.code
		local lotteryData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.LOTTERY, code)

		if lotteryData then
			lotteryData:refreshLotteryData(pool)
			lotteryData:setIsNew(PlayerLocalStorageModel.instance:getPoolNewFlag(code))
		else
			printWarn(string.format("活动中找不到对应code为%s的卡池，或者是该活动尚未开启", code))
		end
	end

	RetrieveDispatcher:dispatchEvent(RetrieveEventType.DATA_REFRESH)
end

function M:_setPoolIsNew(poolcode)
	local isNew = not PlayerLocalStorageModel.getPoolNewFlag(poolcode)

	return isNew
end

function M:cacheLotteryResult(items)
	self._lotteryResultCache = {}
	self._heroResMap = {}

	local canAiLiSi = false

	for i, item in ipairs(items) do
		local code = item.itemCode
		local extraItems = item.extra or {}
		local conversionItem = {}

		for extraIndex, extraItem in ipairs(extraItems) do
			local hasSame = false

			for coverIndex = 1, #conversionItem do
				if conversionItem[coverIndex].code == extraItem.code then
					conversionItem[coverIndex].num = conversionItem[coverIndex].num + extraItem.num
					hasSame = true

					break
				end
			end

			if not hasSame then
				table.insert(conversionItem, {
					code = extraItem.code,
					num = extraItem.num
				})
			end
		end

		if ItemUtil.isCharacterById(code) then
			local characterCO = CharacterConfig.instance:getCfgInfoByID(code)

			canAiLiSi = characterCO.quality == GameEnum.QualityEnum.S and true or false

			local idleAnimClip = false
			local mainModelRes = false
			local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

			if modelCO then
				mainModelRes = GameUrl.getMainSceneMeshModelUrl(modelCO.mainSceneResName)
				idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(modelCO.mainSceneResName, MainPerformEnum.AnimFullName.ChoukaIdle)
			end

			local setting = IconType.getSetting(IconType.RoleHeadIcon)
			local url = setting.url
			local headRes = string.format(url, modelCO.headIconName)
			local timelineRes = MainScenePerformUtil.getHeroEnterShowTimelinePath(characterCO.modelId)
			local modelInfo = {
				isModel = true,
				heroId = code,
				modelUrl = mainModelRes,
				clipUrl = mainModelRes,
				timelineUrl = timelineRes,
				headUrl = headRes,
				index = i
			}

			table.insert(self._heroResMap, modelInfo)
		end

		local lotteryResult = {
			characterCode = code,
			isAiLiSi = canAiLiSi,
			index = i,
			isNew = item.newly,
			conversion = conversionItem
		}

		table.insert(self._lotteryResultCache, lotteryResult)
	end

	if enableLog then
		local tempRest = ""
		local nameStr = ""

		for i = 1, #self._lotteryResultCache do
			local code = self._lotteryResultCache[i].characterCode
			local characterCO = CharacterConfig.instance:getCfgInfoByID(code)
			local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(code)

			nameStr = nameStr .. heroInfoCO.name .. " "

			if characterCO.quality == GameEnum.QualityEnum.S then
				tempRest = tempRest .. "S" .. " "
			elseif characterCO.quality == GameEnum.QualityEnum.A then
				tempRest = tempRest .. "A" .. " "
			elseif characterCO.quality == GameEnum.QualityEnum.B then
				tempRest = tempRest .. "B" .. " "
			elseif characterCO.quality == GameEnum.QualityEnum.C then
				tempRest = tempRest .. "C" .. " "
			end
		end

		printInfo("retrieve .. 抽卡出货开始.当前卡的序列:", nameStr)
	end

	if not RetrieveModel.instance:getIsTest() then
		self:preLoadShowRes()
	end
end

function M:preLoadShowRes()
	ViewBlackFadeController.instance:showGadget(false, 0.3, self._onFade2Black, self, "预加载抽卡模型动画资源")
end

function M:_onFade2Black()
	local lotteryFlow = SceneFace.instance:getCurSceneFlow()

	if lotteryFlow then
		lotteryFlow.resMgr:preloadHeroList(self._heroResMap)
	end
end

function M:getCacheLotteryResult()
	return self._lotteryResultCache
end

function M:sendRequest()
	local lotteryInfoList = {}
	local lotteryDataList = ActivityController.instance:getActivitiesByLogicType(ActivityEnum.LogicType.LOTTERY)

	for i, lotteryData in ipairs(lotteryDataList) do
		if lotteryData:getDescriptionHash() then
			local lotteryInfo = {}

			lotteryInfo.code = lotteryData:getLotteryId()
			lotteryInfo.descriptionHash = lotteryData:getDescriptionHash()

			table.insert(lotteryInfoList, lotteryInfo)
		end
	end

	RetrieveAgent.instance:sendGetPoolInfoRequest(lotteryInfoList)
end

function M:sendLotteryRequest(lotteryNumType, lotteryId)
	if self:checkCanLottery(lotteryId, lotteryNumType) then
		local lotteryData = ActivityController.instance:getActivityById(lotteryId)

		if lotteryData then
			local jumpInfo = {
				needShowEnter = false,
				lotteryId = lotteryId
			}

			RetrieveModel.instance:setJumpInfo(jumpInfo)
			RetrieveAgent.instance:sendLotteryRequest(lotteryData:getConfigId(), lotteryNumType, lotteryData)
		end

		return true
	end

	return false
end

function M:setCacheItemMOList(itemMoList)
	for i, item in ipairs(itemMoList) do
		if item:getType() ~= GameEnum.ItemTypeEnum.EchoItemType and item:getType() ~= GameEnum.ItemTypeEnum.HeroType then
			local cacheItem = self:_isItemCache(item:getItemId())

			if cacheItem then
				local count = cacheItem:getCount() + item:getCount()

				cacheItem:setCount(count)
			else
				table.insert(self._cacheItemMOList, item)
			end
		end
	end
end

function M:_isItemCache(code)
	for i, cacheItem in ipairs(self._cacheItemMOList) do
		if cacheItem:getItemId() == code then
			return cacheItem
		end
	end

	return false
end

function M:getCacheItemMOList()
	return self._cacheItemMOList
end

function M:clearCacheItemMOList()
	self._cacheItemMOList = {}
end

function M:popCacheItemMoList(lotteryType)
	if self._cacheItemMOList and #self._cacheItemMOList ~= 0 then
		table.sort(self._cacheItemMOList, GainItemModel.sortItemCompare)
		GainItemController.instance:openView(self._cacheItemMOList)
	else
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	end
end

function M:checkCanLottery(lotteryId, lotteryNumType)
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if not lotteryData then
		FloatWordMgr.instance:show(lang("tip_close_card_pool"))

		return false
	end

	if not lotteryData:getIsOpen() then
		FloatWordMgr.instance:show(lang("tip_close_card_pool"))

		return false
	end

	local lotteryType = lotteryData:getLotterySimpleType()
	local isReachUpperLimit = MainBackpackModel.instance:isReachUpperLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")

	if isReachUpperLimit and lotteryType == RetrieveEnum.LotterySimpleType.Echo then
		FloatWordMgr.instance:show(lang("tip_backpack_upper_limit_echo"))

		return false
	end

	if lotteryData:getDailyRemain() and lotteryNumType > lotteryData:getDailyRemain() then
		local cardOrEcho = lotteryType == RetrieveEnum.LotterySimpleType.Card and "card" or "echo"
		local oneOrTen = lotteryNumType == RetrieveEnum.LotteryNum.One and "one" or "ten"
		local langKey = string.format("tip_lottery_%s_%s_num_max", cardOrEcho, oneOrTen)
		local content = string.format(lang(langKey), lotteryData:getLotteryName())

		FloatWordMgr.instance:show(content)

		return false
	end

	local costItem = lotteryData:getLotteryCost(lotteryNumType)
	local itemCode = costItem.item
	local num = costItem.num
	local itemCount = ItemModel.instance:getItemCountByItemId(itemCode)

	if num <= itemCount then
		return true
	end

	local offsetNum = num - itemCount
	local targetId = lotteryType == RetrieveEnum.LotterySimpleType.Card and 1102 or 1103
	local alwaysShowTips = true
	local forceShowWhenJumpOpen, titleStr

	CurrencyExchangeController.instance:showTipsNormal(targetId, offsetNum, alwaysShowTips, forceShowWhenJumpOpen, titleStr)

	return false
end

function M:activeWishCamera(pointId)
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow then
		local wishCameras = curSceneFlow.resMgr:getWishCamera()

		for i = 1, #wishCameras do
			goutil.setActive(wishCameras[i], pointId == i)
		end
	end
end

function M:jumpToMainRetrieve()
	ViewMgr.instance:close(ViewName.RetrieveJumpViewViewPresentor)
	self:activeSceneByName(RetrieveEnum.SceneNameMap.Main)
	ViewMgr.instance:open(ViewName.RetrieveMainViewViewPresentor)
end

function M:switch2ShowScene()
	self:activeSceneByName(RetrieveEnum.SceneNameMap.Show)
end

function M:swtich2Result()
	ViewMgr.instance:close(ViewName.RetrieveRoleShowViewViewPresentor)
	ViewMgr.instance:close(ViewName.RetrieveJumpViewViewPresentor)
	self:activeSceneByName(RetrieveEnum.SceneNameMap.Result)
	ViewMgr.instance:open(ViewName.RetrieveTenCardShowViewViewPresentor)
end

function M:activeSceneByName(name)
	local scene = SceneMgr.instance:getScene(SceneType.Retrieve)

	if scene then
		scene.stage:activeSceneByName(name)
	end
end

function M:doRetrieveTen()
	local lotteryId = RetrieveModel.instance:getLotteryId()

	if not lotteryId then
		printError("卡池ID", lotteryId)

		return
	end

	self:clearClickState()

	self._lotteryId = lotteryId
	self._clickLotteryTen = true

	if not self:checkCanLottery(lotteryId, RetrieveEnum.LotteryNum.Ten) then
		return false
	end

	self._lotteryData = ActivityController.instance:getActivityById(self._lotteryId)

	if not self._lotteryData then
		printError("无法获取抽卡数据")

		return
	end

	if self:checkHasPicked(self._lotteryData) then
		if self._lotteryData:isCard() and self._lotteryData:isNewhandLottery() then
			if self._lotteryData:isRandomPick() then
				local dialog = Dialog.showMessage(lang("tip_title"), lang("lottery_random_tips"))

				dialog:setConfirmListener(self._oncConfirmTen, self)

				return
			elseif not self._lotteryData:isPicked() then
				FloatWordMgr.instance:show(lang("lottery_no_select_pray_target"))
				ViewMgr.instance:open(ViewName.LotterySelectUpTips, self._lotteryData)

				return
			end
		end

		local titleStr = ""
		local lotterySimpleType = self._lotteryData:getLotterySimpleType()

		if lotterySimpleType == RetrieveEnum.LotterySimpleType.Card then
			titleStr = lang("tip_wish_lottery_card")
		elseif lotterySimpleType == RetrieveEnum.LotterySimpleType.Echo then
			titleStr = lang("tip_wish_lottery_echo")
		end

		local luaTable = {}

		luaTable.ensureCallBack = self._oncConfirmTen
		luaTable.ensureHandler = self
		luaTable.title = lang("tip_title")
		luaTable.content = langF("tip_wish_lottery_tips", titleStr)

		local dialog = Dialog.showDialogDaily(luaTable, "__key_send_lottery_request__")

		if dialog then
			dialog:setConfirmListener(self._oncConfirmTen, self)
		end
	else
		self:_oncConfirmTen()
	end
end

function M:checkHasPicked(lotteryData)
	local pickedShowList = lotteryData:getPickableItems()

	if #pickedShowList > 0 then
		local pickedItemId = lotteryData:getPicked()
		local lotteryFeature = lotteryData:getFeature()
		local hasPicked = pickedItemId > 0

		if not hasPicked and lotteryFeature == 1 then
			return true
		end
	end

	return false
end

function M:_oncConfirmTen()
	self:sendLotteryRequest(RetrieveEnum.LotteryNum.Ten, self._lotteryId)
end

function M:_handleGainItemViewClose(evt, targetId, isDailyRefres)
	if self._clickLotteryTen then
		self._clickLotteryTen = false

		self:doRetrieveTen()
	end
end

function M:tryForceLottery()
	if self._clickLotteryTen then
		self._clickLotteryTen = false

		self:doRetrieveTen()
	end
end

function M:clearClickState()
	self._clickLotteryTen = false

	RetrieveFacade.instance:clearLotteryFlag()
end

function M:changeSceneBg(sceneBgName)
	local scene = SceneMgr.instance:getScene(SceneType.Retrieve)

	if scene then
		scene.stage:changeBgScene(sceneBgName)
	end
end

function M:updateHeroPosMap(leftPos, midPos, rightPos)
	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()

		if curSceneFlow then
			curSceneFlow.performMgr:updateHeroPosMap(leftPos, midPos, rightPos)
		end
	end
end

M.instance = M.New()

return M

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/exchange/ExchangeWorkshopView.lua

module("logic.extensions.firstannualwelfare.exchange.view.ExchangeWorkshopView", package.seeall)

local ExchangeWorkshopView = class("ExchangeWorkshopView", ViewComponent)
local QTSH_MAT_ID = 401
local EXCHANGE_POOL_TYPE = {
	RPool = 2,
	CCostPool = 3,
	CPool = 1
}

function ExchangeWorkshopView:ctor()
	ExchangeWorkshopView.super.ctor(self)
end

function ExchangeWorkshopView:buildUI()
	ExchangeWorkshopView.super.buildUI(self)

	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._pageScrollerview = goutil.findChild(self.mainGO, "pageCol/pageScrollerview")
	self._pageScrollercell = goutil.findChild(self.mainGO, "pageCol/pageScrollercell")
	self._costPos = goutil.findChild(self.mainGO, "costCol/costPos")
	self._costGo = goutil.findChild(self.mainGO, "costCol/costGo")
	self._targetItem = goutil.findChild(self.mainGO, "targetCol/targetItem")
	self._imgRandom = goutil.findChild(self.mainGO, "targetCol/targetItem/imgRandom")
	self._btnTargetChoice = goutil.findChild(self.mainGO, "targetCol/btnTargetChoice")
	self._txtTarget = goutil.findChildTextComponent(self.mainGO, "targetCol/txtTarget")
	self._targetItemSpriteChange = self:getGo("targetCol/targetItem"):GetComponent("UIImageSpriteChange")
	self._btnShowAll = goutil.findChild(self.mainGO, "showCol/btnShowAll")
	self._btnSifter = goutil.findChild(self.mainGO, "showCol/btnSifter")
	self._btnOneKey = goutil.findChild(self.mainGO, "showCol/btnOneKey")
	self._imgNoMat = goutil.findChild(self.mainGO, "showCol/imgNoMat")
	self._sifterCol = goutil.findChild(self.mainGO, "showCol/sifterCol")
	self._typeCol = goutil.findChild(self.mainGO, "showCol/sifterCol/typeCol")
	self._typeCell = goutil.findChild(self.mainGO, "showCol/sifterCol/typeCol/typeCell")
	self._matScrollerview = goutil.findChild(self.mainGO, "showCol/matCol/matScrollerview")
	self._matScrollercell = goutil.findChild(self.mainGO, "showCol/matCol/matScrollercell")
	self._txtExchangeTimes = goutil.findChildTextComponent(self.mainGO, "exchangeTipsCol/txtExchangeTimes")
	self._txtPageTips = goutil.findChildTextComponent(self.mainGO, "exchangeTipsCol/txtPageTips")
	self._hideMask = self:getGo("showCol/hideMask")
	self._pageScrollList = ScrollerList.create(self._pageScrollerview, self._pageScrollercell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))
	self._matScrollList = ScrollerList.create(self._matScrollerview, self._matScrollercell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))

	GameUtil.SetActive(self._costGo, false)
	GameUtil.SetActive(self._sifterCol, false)
	GameUtil.SetActive(self._hideMask, false)

	self._costExt = self:getGo("exchangeTipsCol/cost")
	self._txtNumCostExt = self:getTxt("exchangeTipsCol/cost/txtNum")
	self._iconCostExt = self:getGo("exchangeTipsCol/cost/txtNum/icon")
	self._txtResettips = self:getTxt("txtResettips")
	self._costEffs = {}
	self._effCostIdxs = {}
end

function ExchangeWorkshopView:bindEvents()
	ExchangeWorkshopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnSifter, self._onClickSifter, self)
	GameUtil.addClickHandler(self._btnShowAll, self._onClickShowAll, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._hideMask, self._onClickHideMask, self)
end

function ExchangeWorkshopView:unbindEvents()
	ExchangeWorkshopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnSifter)
	GameUtil.rmClickHandler(self._btnShowAll)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._hideMask)
end

function ExchangeWorkshopView:destroyUI()
	ExchangeWorkshopView.super.destroyUI(self)
end

function ExchangeWorkshopView:onEnter()
	ExchangeWorkshopView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstAnnualWelfare)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._fawCfg = FirstAnnualWelfareConfig.instance:getFawCfg(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.FirstAnnualWelfareGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FirstAnnualWelfareExchangeRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FirstAnnualWelfareExchangeTargetMat, self._changeTargetMat, self)
	FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGetInfoReq(self._activityId)
end

function ExchangeWorkshopView:onExit()
	ExchangeWorkshopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FirstAnnualWelfareGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FirstAnnualWelfareExchangeRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FirstAnnualWelfareExchangeTargetMat, self._changeTargetMat, self)
	self._matScrollList:dispose()
	self._pageScrollList:dispose()
	self:_clearCostCol()
end

function ExchangeWorkshopView:_onSetUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FirstAnnualWelfare, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function ExchangeWorkshopView:_onUpdate()
	self:_onUpdatePageData()
	self:_onUpdateMatData()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ExchangeWorkshopView:_onUpdateData()
	self:_onUpdateCostData()
	self:_updateTargetMatData()
	self:_onUpdateSifterCondData()
end

function ExchangeWorkshopView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePageScrollerList()
	self:_onUpdateMatShowCol()
	self:_onUpdateCostCol()
	self:_onUpdateTargetCol()
end

function ExchangeWorkshopView:_onUpdatePageData()
	local exchangeCfgs = FirstAnnualWelfareConfig.instance:getExchangeCfgs()
	local exchangeIds = self._fawCfg.exchangeIds

	self._pageCfg = {}
	self._pageId = self._pageId or 1

	for _, exchangeId in ipairs(exchangeIds) do
		local data = exchangeCfgs[exchangeId]

		table.insert(self._pageCfg, data)
	end
end

function ExchangeWorkshopView:_getCurPageData()
	return self._pageCfg[self._pageId]
end

function ExchangeWorkshopView:_getCurExchangeIndex()
	local pageData = self:_getCurPageData()
	local exchangeIndex = 0

	for index, id in ipairs(self._fawCfg.exchangeIds) do
		if pageData.exchangeId == id then
			exchangeIndex = index
		end
	end

	return exchangeIndex
end

function ExchangeWorkshopView:_getCurMatType()
	local pageData = self:_getCurPageData()

	return pageData.matType
end

function ExchangeWorkshopView:_getCurMatTypeName()
	local name = ""
	local matType = self:_getCurMatType()

	if matType == MatType.Equipment then
		name = "装备"
	elseif matType == MatType.StarGodPlus then
		name = "星神"
	end

	return name
end

function ExchangeWorkshopView:_getCurMatQualityDesc()
	local desc = ""
	local matData = self:_getCurPageData()
	local matType = matData.matType
	local matQuality = matData.costQuality

	if matType == MatType.Equipment then
		desc = ConstString.EquipmentQualityDesc[matQuality]
	elseif matType == MatType.StarGodPlus then
		desc = ConstString.StarGodPlusQualityDesc[matQuality]
	end

	return desc
end

function ExchangeWorkshopView:_isCurExchangeTimesFull()
	local pageData = self:_getCurPageData()
	local limitTimes = pageData.limitTimes
	local exchangeTimes = FirstAnnualWelfareModel.instance:getExchangeTimesByIdx(self._pageId)

	return limitTimes <= exchangeTimes
end

function ExchangeWorkshopView:_onUpdateMatData()
	self._matDataList = {}
	self._matIdxList = {}

	local pageData = self:_getCurPageData()
	local costMatType = pageData.matType
	local moList = MaterialMgr.getModelList(costMatType)

	if costMatType == MatType.Equipment then
		for idx, mo in ipairs(moList) do
			local var_19_0 = {
				index = idx,
				matType = costMatType,
				matId = mo.baseId,
				onlyId = mo.onlyId,
				isWear = mo:isWearEquip(),
				quality = mo.quality,
				qualityDesc = mo.qualityDes,
				petId = mo.equipPetId,
				lv = mo.starCount
			}

			var_19_0.jobTypeList = mo.jobTypeList or {}
			var_19_0.attrType = mo.attrType
			var_19_0.isEquipArtifact = mo:isEquipArtifact()
			var_19_0.mo = mo

			local data = var_19_0
			local petInfo = BagPetsController.instance:getPet(mo.equipPetId)

			if petInfo then
				data.raceId = petInfo.raceId or 1
			end

			table.insert(self._matDataList, data)
		end

		ArraySort.sortOn(self._matDataList, {
			function(a)
				if a.isWear then
					return a.petId
				else
					return -1
				end
			end,
			function(a)
				if a.attrType == "无" or string.nilorempty(a.attrType) then
					return 0
				else
					return checknumber(GameEnum.Races[a.attrType])
				end
			end,
			function(a)
				return a.onlyId
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	elseif costMatType == MatType.StarGodPlus then
		for idx, mo in ipairs(moList) do
			local data = {
				index = idx,
				matType = costMatType,
				matId = mo:getDefineId(),
				onlyId = mo:getId(),
				isWear = mo:isWear(),
				quality = mo:getQuality(),
				qualityDesc = ConstString.StarGodPlusQualityDesc[mo:getQuality()],
				petId = mo:getUsePetId(),
				raceId = mo:getUseRaceId(),
				sgType = mo:getEquipType(),
				mo = mo
			}

			table.insert(self._matDataList, data)
		end

		ArraySort.sortOn(self._matDataList, {
			function(a)
				if a.isWear then
					return a.petId
				else
					return -1
				end
			end,
			function(a)
				if a.matId == QTSH_MAT_ID then
					return -1
				else
					return 0
				end
			end,
			function(a)
				return a.onlyId
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	end

	for idx, matData in ipairs(self._matDataList) do
		matData.index = idx
	end

	for _, matData in ipairs(self._matDataList) do
		table.insert(self._matIdxList, matData.index)
	end
end

function ExchangeWorkshopView:_getMatData(matIdx)
	return self._matDataList[matIdx]
end

function ExchangeWorkshopView:_getMatMatId(matIdx)
	return self._matDataList[matIdx].matId
end

function ExchangeWorkshopView:_getMatOnlyId(matIdx)
	return self._matDataList[matIdx].onlyId
end

function ExchangeWorkshopView:_getMatRaceId(matIdx)
	return self._matDataList[matIdx].raceId
end

function ExchangeWorkshopView:_getMatStr(matIdx)
	local data = self:_getMatData(matIdx)

	return string.format("%s:%s:%s", data.matType, data.matId, 0)
end

function ExchangeWorkshopView:_isMatWearing(matIdx)
	return self._matDataList[matIdx].isWear == true
end

function ExchangeWorkshopView:_onUpdateCostData()
	self._matCostIdxList = {}

	local pageData = self:_getCurPageData()

	self._costNum = pageData.costNum

	for i = 1, self._costNum do
		self._matCostIdxList[i] = nil
	end
end

function ExchangeWorkshopView:_getCostIdx(targetMatIdx)
	for costIdx, matIdx in pairs(self._matCostIdxList) do
		if matIdx == targetMatIdx then
			return costIdx
		end
	end

	return nil
end

function ExchangeWorkshopView:_getMatIdx(cosIdx)
	return self._matCostIdxList[cosIdx]
end

function ExchangeWorkshopView:_getCostMatIds()
	local matIds = {}

	for i = 1, self._costNum do
		local matIdx = self._matCostIdxList[i]
		local matId = self:_getMatMatId(matIdx)

		table.insert(matIds, matId)
	end

	return matIds
end

function ExchangeWorkshopView:_getCostOnlyIds()
	local onlyIds = {}

	for costIdx = 1, self._costNum do
		local matIdx = self:_getMatIdx(costIdx)
		local onlyId = self:_getMatOnlyId(matIdx)

		table.insert(onlyIds, onlyId)
	end

	return onlyIds
end

function ExchangeWorkshopView:_getNilGridCostIdxs()
	local costIdxs = {}

	for costIdx = 1, self._costNum do
		if self._matCostIdxList[costIdx] == nil then
			table.insert(costIdxs, costIdx)
		end
	end

	return costIdxs
end

function ExchangeWorkshopView:_setMatSelect(matIdx, isSetSelect)
	local costIdx = self:_getCostIdx(matIdx)
	local isHaveMat = self:_isCostHaveMat(costIdx)

	if isSetSelect then
		if isHaveMat then
			printError(string.format("消耗栏上已存在物品，请检查是否存在重复上架同一消耗位置。( cosIdx=%d, matIdx=%d )", cosIdx, matIdx))

			return
		end

		for i = 1, self._costNum do
			if self._matCostIdxList[i] == nil then
				self._matCostIdxList[i] = matIdx

				break
			end
		end
	else
		if not isHaveMat then
			printError(string.format("消耗栏上对应位置不存在消耗物品，请检查是否试图下架未上架的物品。( matIdx=%d )", matIdx))

			return
		end

		self._matCostIdxList[costIdx] = nil
	end
end

function ExchangeWorkshopView:_isMatSelected(matIdx)
	local costIdx = self:_getCostIdx(matIdx)

	return costIdx ~= nil
end

function ExchangeWorkshopView:_isCostHaveMat(costIdx)
	local matIdx = self:_getMatIdx(costIdx)

	return matIdx ~= nil
end

function ExchangeWorkshopView:_isCostHaveFull()
	local isFull = true

	for i = 1, self._costNum do
		if self._matCostIdxList[i] == nil then
			isFull = false

			break
		end
	end

	return isFull
end

function ExchangeWorkshopView:_isCostHaveWearing()
	local isHaveWear = false

	for costIdx = 1, self._costNum do
		local matIdx = self:_getMatIdx(costIdx)

		if matIdx and self:_isMatWearing(matIdx) then
			isHaveWear = true
		end
	end

	return isHaveWear
end

function ExchangeWorkshopView:_updateTargetMatData(poolId, index)
	local defineId

	index = checknumber(index)
	poolId = checknumber(poolId)

	if poolId ~= 0 and index ~= 0 then
		local pageData = self:_getCurPageData()
		local cPoolData

		if pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
			cPoolData = FirstAnnualWelfareConfig.instance:getCCostPoolData(poolId, index)
			defineId = cPoolData.defineId
		elseif pageData.poolType == EXCHANGE_POOL_TYPE.RPool then
			printError("错误, 随机池不应该传入指定兑换物的池子id和索引")

			return
		else
			cPoolData = FirstAnnualWelfareConfig.instance:getCPoolData(poolId, index)
			defineId = cPoolData.defineId
		end
	end

	self._targetMatData = nil
	self._cPoolIndex = index

	if defineId == nil then
		local pageData = self:_getCurPageData()

		if pageData.poolType == EXCHANGE_POOL_TYPE.CPool then
			local isOnlyOneMat = self:_isOnlyOneTargetMat()

			if isOnlyOneMat then
				local cPoolCfg = FirstAnnualWelfareConfig.instance:getCPoolCfg(pageData.poolId)

				defineId = cPoolCfg[1].defineId
			end
		elseif pageData.poolType == EXCHANGE_POOL_TYPE.RPool then
			defineId = -1
		elseif pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
			local isOnlyOneMat = self:_isOnlyOneTargetMat()

			if isOnlyOneMat then
				local cCostPoolCfg = FirstAnnualWelfareConfig.instance:getCCostPoolCfg(pageData.poolId)

				defineId = cCostPoolCfg[1].defineId
			end
		end
	end

	if defineId then
		self._targetMatData = self:_setTargetMatData(defineId)
	end
end

function ExchangeWorkshopView:_setTargetMatData(defineId)
	if defineId == nil then
		printError("错误, 传入空的物品id")

		return
	end

	local targetMatData = {}

	if defineId == -1 then
		local pageData = self:_getCurPageData()

		targetMatData.matType = pageData.matType
		targetMatData.defineId = defineId
		targetMatData.matName = "随机" .. self:_getCurMatTypeName()

		goutil.setActive(self._costExt, false)
	else
		local pageData = self:_getCurPageData()
		local targetMatType = pageData.matType
		local matCfg = MaterialMgr.getMatCfg(targetMatType, defineId)

		targetMatData.matType = targetMatType
		targetMatData.defineId = defineId
		targetMatData.matName = MaterialMgr.getMaterialsName(targetMatType, defineId)

		if pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
			local cCostPoolData = FirstAnnualWelfareConfig.instance:getCCostPoolData(pageData.poolId, self._cPoolIndex)
			local extCost = cCostPoolData.cost

			if GameUtil.isEmptyString(extCost) then
				goutil.setActive(self._costExt, false)
			else
				goutil.setActive(self._costExt, true)

				local costType, costId, costNum = MaterialMgr.getMatParams(extCost)

				MaterialMgr.resetAll(self._iconCostExt)
				MaterialMgr.setIcon(self._iconCostExt, costType, costId)

				self._txtNumCostExt.text = string.format("x%s", costNum)
			end
		end
	end

	return targetMatData
end

function ExchangeWorkshopView:_getTargetMatStr()
	return string.format("%s:%s:%s", self._targetMatData.matType, self._targetMatData.defineId, 0)
end

function ExchangeWorkshopView:_getTargetMatType()
	if self._targetMatData then
		return self._targetMatData.matType
	end
end

function ExchangeWorkshopView:_getTargetMatName()
	if self._targetMatData then
		return self._targetMatData.matName
	end
end

function ExchangeWorkshopView:_getTargetDefineId()
	if self._targetMatData then
		return self._targetMatData.defineId
	end
end

function ExchangeWorkshopView:_isHasChoiceTarget()
	return self._targetMatData ~= nil
end

function ExchangeWorkshopView:_isOnlyOneTargetMat()
	local pageData = self:_getCurPageData()
	local isOnlyOneMat = false

	if pageData.poolType == EXCHANGE_POOL_TYPE.CPool then
		local cPoolCfg = FirstAnnualWelfareConfig.instance:getCPoolCfg(pageData.poolId)

		isOnlyOneMat = #cPoolCfg == 1
	elseif pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
		local cCostPoolCfg = FirstAnnualWelfareConfig.instance:getCCostPoolCfg(pageData.poolId)

		isOnlyOneMat = #cCostPoolCfg == 1
	end

	return isOnlyOneMat
end

function ExchangeWorkshopView:_sifter()
	local pageData = self:_getCurPageData()
	local costMatType = pageData.matType

	if costMatType == MatType.Equipment then
		self:_sifterEquipment()
	elseif costMatType == MatType.StarGodPlus then
		self:_sifterStarGod()
	end
end

function ExchangeWorkshopView:_sifterEquipment()
	self._matIdxList = {}

	local eqQualityConds, eqJobTypeConds, eqAttrTypeConds = self:_getEquipmentConds()

	for _, matData in ipairs(self._matDataList) do
		local matIdx = matData.index
		local isNeedShowAll = self:_isNeedShowAll()
		local isFitQuality = false
		local isFitJobType = false
		local isFitAdditionRaceType = false

		if string.nilorempty(matData.quality) then
			printError("错误,装备品质不能为空")
		end

		for _, eqQualityCond in ipairs(eqQualityConds) do
			if eqQualityCond == matData.quality then
				isFitQuality = true

				break
			end
		end

		if #eqJobTypeConds == 0 then
			isFitJobType = true
		end

		for _, eqJobTypeCond in ipairs(eqJobTypeConds) do
			if table.indexof(matData.jobTypeList, eqJobTypeCond) ~= false then
				isFitJobType = true
			end
		end

		if #eqAttrTypeConds == 0 then
			isFitAdditionRaceType = true
		end

		for _, eqAttrType in ipairs(eqAttrTypeConds) do
			if eqAttrType == matData.attrType then
				isFitAdditionRaceType = true
			end
		end

		if isFitQuality and not matData.isEquipArtifact and (isNeedShowAll or isFitJobType and isFitAdditionRaceType) then
			table.insert(self._matIdxList, matIdx)
		end
	end
end

function ExchangeWorkshopView:_sifterStarGod()
	self._matIdxList = {}

	local sgQualityConds, sgTypeConds = self:_getStarGodConds()
	local onlyOneTargetMatId

	for _, matData in ipairs(self._matDataList) do
		local matIdx = matData.index
		local isNeedShowAll = self:_isNeedShowAll()
		local isFitQuality = false
		local isFitType = false
		local isSameTargetMat = false

		if string.nilorempty(matData.quality) then
			printError("错误,星神品质不能为空")
		end

		for _, sgQualityCond in ipairs(sgQualityConds) do
			if sgQualityCond == matData.quality then
				isFitQuality = true
			end
		end

		if string.nilorempty(matData.sgType) then
			printError("错误,星神类型不能为空")
		end

		if #sgTypeConds == 0 then
			isFitType = true
		end

		for _, sgTypeCond in ipairs(sgTypeConds) do
			if sgTypeCond == GameEnum.StarGodPlusEquipTypeName[matData.sgType] then
				isFitType = true
			end
		end

		isSameTargetMat = isSameTargetMat or matData.matId == ((self:_isOnlyOneTargetMat() or nil) and self:_getTargetDefineId())

		if isFitQuality and not isSameTargetMat and (isNeedShowAll or isFitType) then
			table.insert(self._matIdxList, matIdx)
		end
	end
end

function ExchangeWorkshopView:_onUpdateSifterCondData()
	self._condNum = 0
	self._condMap = {
		eqQualityConds = {},
		eqJobTypeConds = {},
		eqAttrTypeConds = {},
		sgQualityConds = {},
		sgTypeConds = {}
	}

	local pageData = self:_getCurPageData()
	local costMatType = pageData.matType

	self._condDataList = {}

	if costMatType == MatType.Equipment then
		self._condDataList = {
			{
				sifterName = "属性",
				sifterKey = "eqAttrTypeConds",
				iconType = "Atla",
				tabNames = {
					"火",
					"草",
					"水",
					"光",
					"暗",
					"空",
					"创",
					"无属性"
				},
				sifterConds = {
					"火",
					"草",
					"水",
					"光",
					"暗",
					"空",
					"创",
					"无"
				},
				iconStateKeys = {
					"火",
					"草",
					"水",
					"光",
					"暗",
					"空",
					"创",
					""
				}
			},
			{
				sifterName = "职业",
				sifterKey = "eqJobTypeConds",
				iconType = "Job",
				tabNames = {
					"魔法",
					"肉盾",
					"疾速",
					"治疗",
					"平衡",
					"利爪"
				},
				sifterConds = {
					"魔法",
					"肉盾",
					"疾速",
					"治疗",
					"平衡",
					"利爪"
				},
				iconStateKeys = {
					GameEnum.JobZhDefine.Mofa,
					GameEnum.JobZhDefine.Dun,
					GameEnum.JobZhDefine.JiSu,
					GameEnum.JobZhDefine.ZhiLiao,
					GameEnum.JobZhDefine.Pingheng,
					GameEnum.JobZhDefine.LiZhua
				}
			}
		}
	elseif costMatType == MatType.StarGodPlus then
		self._condDataList = {
			{
				sifterName = "星神类型",
				sifterKey = "sgTypeConds",
				iconType = "Attr",
				tabNames = {
					"攻击",
					"防御",
					"生命",
					"暴击",
					"防暴",
					"命中",
					"闪避",
					"破击",
					"格挡",
					"气势"
				},
				sifterConds = {
					"攻击",
					"防御",
					"生命",
					"暴击",
					"防暴",
					"命中",
					"闪避",
					"破击",
					"格挡",
					"气势"
				},
				iconStateKeys = {
					GameEnum.AttrType.AttackPhysical,
					GameEnum.AttrType.DefensePhysical,
					GameEnum.AttrType.Hp,
					GameEnum.AttrType.CriticalRate,
					GameEnum.AttrType.AntiCriticalRate,
					GameEnum.AttrType.HitRate,
					GameEnum.AttrType.DodgeRate,
					GameEnum.AttrType.StrikeRate,
					GameEnum.AttrType.BlockRate,
					GameEnum.AttrType.OriginalVigour
				}
			}
		}
	end

	if costMatType == MatType.Equipment then
		table.insert(self._condMap.eqQualityConds, pageData.costQuality)
	elseif costMatType == MatType.StarGodPlus then
		table.insert(self._condMap.sgQualityConds, pageData.costQuality)
	end

	self:_sifter()
end

function ExchangeWorkshopView:_setSifterCond(sifterKey, value, isAdd)
	local isHaveAdd = self:_isSifterCondHaveAdd(sifterKey, value)

	if isAdd then
		if isHaveAdd then
			printError("对应值已添加，不要重复添加")

			return
		end

		self._condNum = self._condNum + 1

		table.insert(self._condMap[sifterKey], value)
	else
		if not isHaveAdd then
			printError("对应值不存在，不要试图删减不存在的值")

			return
		end

		self._condNum = self._condNum - 1

		table.removebyvalue(self._condMap[sifterKey], value, true)
	end
end

function ExchangeWorkshopView:_getEquipmentConds()
	local eqQualityConds = self._condMap.eqQualityConds
	local eqJobTypeConds = self._condMap.eqJobTypeConds
	local eqAttrTypeConds = self._condMap.eqAttrTypeConds

	return eqQualityConds, eqJobTypeConds, eqAttrTypeConds
end

function ExchangeWorkshopView:_getStarGodConds()
	local sgQualityConds = self._condMap.sgQualityConds
	local sgTypeConds = self._condMap.sgTypeConds

	return sgQualityConds, sgTypeConds
end

function ExchangeWorkshopView:_getCondDataList()
	return self._condDataList
end

function ExchangeWorkshopView:_isSifterCondHaveAdd(sifterKey, value)
	local isHaveAdd = false
	local condData = self._condMap[sifterKey]

	for _, v in ipairs(condData) do
		if v == value then
			isHaveAdd = true

			break
		end
	end

	return isHaveAdd
end

function ExchangeWorkshopView:_isNeedShowAll()
	return self._condNum == 0
end

function ExchangeWorkshopView:_onUpdatePlaneUI()
	local pageData = self:_getCurPageData()
	local limitTimes = pageData.limitTimes
	local exchangeTimes = FirstAnnualWelfareModel.instance:getExchangeTimesByIdx(self._pageId)

	self._txtExchangeTimes.text = string.format("%s/%s", limitTimes - exchangeTimes, limitTimes)
	self._txtPageTips.text = pageData.pageTips

	self._targetItemSpriteChange:SetState(pageData.showState or 0)
	goutil.setActive(self._txtResettips.gameObject, pageData.weeklyRefresh)
end

function ExchangeWorkshopView:_onUpdatePageScrollerList()
	self._pageScrollList:reloadData(self._pageCfg)
end

function ExchangeWorkshopView:_updatePageCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

	if not string.nilorempty(data.pageName) and txtName then
		txtName.text = data.pageName
	end

	local isSelected = self._pageId == index

	UIChangeGroup:SetState(isSelected and 1 or 0)

	local function handler()
		self._pageId = index

		self:_onUpdate()
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function ExchangeWorkshopView:_clearPageCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function ExchangeWorkshopView:_onUpdateMatShowCol()
	self:_updateSifterCol()
	self:_updateMatScrollerList()
end

function ExchangeWorkshopView:_updateSifterCol()
	local condDataList = self:_getCondDataList()
	local typeChildList = GameUtil.getChildren(self._typeCol)

	for _, go in ipairs(typeChildList) do
		GameUtil.SetActive(go, false)
	end

	self._typeCellList = {}

	for typeIdx, condData in ipairs(condDataList) do
		local typeCell = {}

		typeCell._mainGo = typeChildList[typeIdx] or goutil.cloneAndSetParent(self._typeCell, self._typeCol.transform)
		typeCell._txtTitle = goutil.findChildTextComponent(typeCell._mainGo, "txtTitle/txt")
		typeCell._tabCol = goutil.findChild(typeCell._mainGo, "tabCol")
		typeCell._tabCell = goutil.findChild(typeCell._mainGo, "tabCol/tabCell")
		typeCell._tabCellList = {}

		table.insert(self._typeCellList, typeCell)
		GameUtil.SetActive(typeCell._mainGo, true)

		typeCell._mainGo.name = string.format("typeCell_%d", typeIdx)

		if typeCell._txtTitle and not string.nilorempty(condData.sifterName) then
			typeCell._txtTitle.text = condData.sifterName
		end

		local tabChildList = GameUtil.getChildren(typeCell._tabCol)

		for _, go in ipairs(tabChildList) do
			GameUtil.SetActive(go, false)
		end

		for tabIdx, tabName in ipairs(condData.tabNames) do
			local tabCell = {}

			tabCell._mainGo = tabChildList[tabIdx] or goutil.cloneAndSetParent(typeCell._tabCell, typeCell._tabCol.transform)
			tabCell._txtTab = goutil.findChildTextComponent(tabCell._mainGo, "txtTab")
			tabCell._UIChangeGroup = tabCell._mainGo:GetComponent(ComponentType.UIChangeGroup)
			tabCell._iconAttrs = goutil.findChild(tabCell._mainGo, "iconAttrs")
			tabCell._iconAtlas = goutil.findChild(tabCell._mainGo, "iconAtlas")
			tabCell._iconJob = goutil.findChild(tabCell._mainGo, "iconJob")

			table.insert(typeCell._tabCellList, tabCell)
			GameUtil.SetActive(tabCell._mainGo, true)

			local sifterCond = condData.sifterConds[tabIdx]
			local iconStateKey = condData.iconStateKeys[tabIdx]

			tabCell._mainGo.name = string.format("tabCell_%d", tabIdx)
			tabCell._txtTab.text = tabName

			local isSelected = self:_isSifterCondHaveAdd(condData.sifterKey, sifterCond)

			tabCell._UIChangeGroup:SetState(isSelected and 1 or 0)
			GameUtil.SetActive(tabCell._iconAttrs, condData.iconType == "Attr")
			GameUtil.SetActive(tabCell._iconAtlas, condData.iconType == "Atla")
			GameUtil.SetActive(tabCell._iconJob, condData.iconType == "Job")

			if condData.iconType == "Attr" then
				local state = iconStateKey - 1
				local imageChange = tabCell._iconAttrs:GetComponent(ComponentType.UIImageSpriteChange)
				local imageColorChange = tabCell._iconAttrs:GetComponent(ComponentType.UIImageColorChange)

				imageChange:SetState(state)
				imageColorChange:SetState(isSelected and 1 or 0)
			elseif condData.iconType == "Atla" then
				GameUtil.SetActive(tabCell._iconAtlas, false)

				if not string.nilorempty(iconStateKey) then
					GameUtil.SetActive(tabCell._iconAtlas, true)

					local state = (GameEnum.Races[iconStateKey] or 1) - 1
					local imageChange = tabCell._iconAtlas:GetComponent(ComponentType.UIImageSpriteChange)

					imageChange:SetState(state)
				end
			elseif condData.iconType == "Job" then
				local state = (GameEnum.JobZh[iconStateKey] or 1) - 1
				local imageChange = tabCell._iconJob:GetComponent(ComponentType.UIImageSpriteChange)
				local imageColorChange = tabCell._iconJob:GetComponent(ComponentType.UIImageColorChange)

				imageChange:SetState(state)
				imageColorChange:SetState(isSelected and 1 or 0)
			end

			local function handler()
				local istabSelected = self:_isSifterCondHaveAdd(condData.sifterKey, sifterCond)
				local isAdd = not istabSelected

				self:_setSifterCond(condData.sifterKey, sifterCond, isAdd)
				self:_sifter()
				self:_onUpdateMatShowCol()
			end

			GameUtil.addClickHandler(tabCell._mainGo, handler)
		end
	end
end

function ExchangeWorkshopView:_clearSifterCol()
	local typeChildList = GameUtil.getChildren(self._typeCol)

	for _, typeCell in ipairs(typeChildList) do
		local tabChildList = GameUtil.getChildren(typeCell._tabCol)

		for _, tabCell in ipairs(tabChildList) do
			-- block empty
		end
	end
end

function ExchangeWorkshopView:_onClickSifter()
	self._isInShow = not self._isInShow

	GameUtil.SetActive(self._sifterCol, self._isInShow)
	goutil.setActive(self._hideMask, self._isInShow)
end

function ExchangeWorkshopView:_onClickShowAll()
	self:_onUpdateSifterCondData()
	self:_onUpdateMatShowCol()
end

function ExchangeWorkshopView:_onClickHideMask()
	self._isInShow = false

	GameUtil.SetActive(self._sifterCol, self._isInShow)
	goutil.setActive(self._hideMask, self._isInShow)
end

function ExchangeWorkshopView:_updateMatScrollerList()
	local isNoMat = #self._matIdxList == 0

	GameUtil.SetActive(self._imgNoMat, isNoMat)
	self._matScrollList:reloadData(self._matIdxList)
	self._matScrollList:MoveCellInView(0, false)
end

function ExchangeWorkshopView:_updateMatCell(view, cell, matIdx, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")
	local wearIconGo = goutil.findChild(mainGo, "wearIconGo")
	local wearIcon = goutil.findChild(mainGo, "wearIconGo/icon")
	local nameText = goutil.findChildTextComponent(mainGo, "nameText")
	local nameChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
	local matData = self:_getMatData(matIdx)
	local isSelected = self:_isMatSelected(matIdx)
	local isWear = self:_isMatWearing(matIdx)
	local matStr = self:_getMatStr(matIdx)
	local proxy = MaterialMgr.setCellByMo(matData.mo, item)

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelected)
	proxy.binder:setLvl(matData.lv or 0)
	proxy.binder:setNum(0)

	nameText.text = MaterialMgr.getMaterialsNameByCfg(matStr)

	nameChange:SetState(matData.quality)
	GameUtil.SetActive(imgReduce, isSelected)
	GameUtil.SetActive(wearIconGo, isWear)

	if isWear then
		local raceId = self:_getMatRaceId(matIdx)

		MaterialMgr.setIcon(wearIcon, MatType.Pet, raceId)
	end

	local function handler()
		local isFull = self:_isCostHaveFull()
		local isMatSelected = self:_isMatSelected(matIdx)
		local isNeedAdd = not isMatSelected

		if isFull and not isMatSelected then
			return
		end

		self:_setMatSelect(matIdx, isNeedAdd)

		if isNeedAdd then
			local costIdx = self:_getCostIdx(matIdx)

			table.insert(self._effCostIdxs, costIdx)
		end

		GameUtil.SetActive(imgReduce, isNeedAdd)
		proxy.binder:setSelected(isNeedAdd)
		self:_onUpdateCostCol()
	end

	GameUtil.addClickHandler(btnSelect, handler)
end

function ExchangeWorkshopView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local wearIcon = goutil.findChild(mainGo, "wearIconGo/icon")

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(wearIcon)
	GameUtil.rmClickHandler(btnSelect)
end

function ExchangeWorkshopView:_onClickOneKey()
	if self:_isCostHaveFull() then
		local costMatTypeName = self:_getCurMatTypeName()

		FloatWordMgr.instance:show(string.format("放入的%s已满哦", costMatTypeName))

		return
	end

	local costIdxs = self:_getNilGridCostIdxs()
	local fitMatIdxList = {}
	local notSelectMatList = {}
	local matNum = 0
	local needCostNum = #costIdxs

	for _, matIdx in ipairs(self._matIdxList) do
		local isMatSelected = self:_isMatSelected(matIdx)

		if not isMatSelected then
			table.insert(notSelectMatList, matIdx)
		end
	end

	for _, matIdx in ipairs(notSelectMatList) do
		local isWear = self:_isMatWearing(matIdx)

		if not isWear then
			table.insert(fitMatIdxList, matIdx)

			matNum = matNum + 1

			if needCostNum <= matNum then
				break
			end
		end
	end

	if needCostNum <= matNum then
		for i, costIdx in ipairs(costIdxs) do
			self._matCostIdxList[costIdx] = fitMatIdxList[i]

			table.insert(self._effCostIdxs, costIdx)
		end

		self:_onUpdateMatShowCol()
		self:_onUpdateCostCol()

		return
	end

	for _, matIdx in ipairs(notSelectMatList) do
		local isWear = self:_isMatWearing(matIdx)

		if isWear then
			table.insert(fitMatIdxList, matIdx)

			matNum = matNum + 1

			if needCostNum <= matNum then
				break
			end
		end
	end

	if needCostNum <= matNum then
		local costMatTypeName = self:_getCurMatTypeName()
		local tipsContent = string.format("可以放入的物品中，含有穿戴的%s，是否继续放入？", costMatTypeName)

		local function okFunc()
			for i, costIdx in ipairs(costIdxs) do
				self._matCostIdxList[costIdx] = fitMatIdxList[i]

				table.insert(self._effCostIdxs, costIdx)
			end

			self:_onUpdateMatShowCol()
			self:_onUpdateCostCol()
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		local costMatTypeName = self:_getCurMatTypeName()

		FloatWordMgr.instance:show(string.format("拥有%s数量不足", costMatTypeName))

		return
	end
end

function ExchangeWorkshopView:_onUpdateCostCol()
	self:_setCostCells()
end

function ExchangeWorkshopView:_setCostCells()
	local childList = GameUtil.getChildren(self._costPos)

	for idx, go in ipairs(childList) do
		if idx > self._costNum then
			GameUtil.SetActive(go, false)
		end
	end

	self._costCellList = {}

	for costIdx = 1, self._costNum do
		local cell = {}

		cell._mainGo = childList[costIdx] or goutil.cloneAndSetParent(self._costGo, self._costPos.transform)
		cell._item = goutil.findChild(cell._mainGo, "item")
		cell._imgAdd = goutil.findChild(cell._mainGo, "imgAdd")
		cell._btnSelect = goutil.findChild(cell._mainGo, "btnSelect")
		cell._wearIconGo = goutil.findChild(cell._mainGo, "wearIconGo")
		cell._wearIcon = goutil.findChild(cell._mainGo, "wearIconGo/icon")
		cell._costIdx = costIdx

		table.insert(self._costCellList, cell)
		GameUtil.SetActive(cell._mainGo, true)

		local matIdx = self:_getMatIdx(costIdx)
		local isHaveMat = self:_isCostHaveMat(costIdx)
		local pageData = self:_getCurPageData()

		cell._mainGo.name = string.format("costGo_%d", costIdx)

		local posArr = string.split(pageData.costPos, "#")
		local pos = string.split(posArr[costIdx], ":")

		GameUtil.setLocalPos(cell._mainGo, pos[1], pos[2], 0)
		GameUtil.SetActive(cell._imgAdd, not isHaveMat)
		GameUtil.SetActive(cell._wearIconGo, false)

		if isHaveMat then
			local matData = self:_getMatData(matIdx)
			local matStr = self:_getMatStr(matIdx)
			local proxy = MaterialMgr.setCellByMo(matData.mo, cell._item)

			proxy.binder:setAutoTips(false)
			proxy.binder:setLvl(matData.lv or 0)
			proxy.binder:setNum(0)

			local isWear = self:_isMatWearing(matIdx)

			if isWear then
				local raceId = self:_getMatRaceId(matIdx)

				MaterialMgr.setIcon(cell._wearIcon, MatType.Pet, raceId)
				GameUtil.SetActive(cell._wearIconGo, true)
			end
		else
			MaterialMgr.resetAll(cell._item)
		end

		if table.indexof(self._effCostIdxs, costIdx) ~= false then
			self:_showCostEffAdd(costIdx)
			table.removebyvalue(self._effCostIdxs, costIdx)
		end

		local function handler()
			local costMatIdx = self:_getMatIdx(costIdx)
			local isCostHaveMat = self:_isCostHaveMat(costIdx)

			if isCostHaveMat then
				self:_setMatSelect(costMatIdx, false)
				self:_onUpdateCostCol()
				self:_onUpdateMatShowCol()
			end
		end

		GameUtil.addClickHandler(cell._btnSelect, handler)
	end
end

function ExchangeWorkshopView:_clearCostCol()
	local childList = GameUtil.getChildren(self._costPos)

	for _, go in ipairs(childList) do
		local item = goutil.findChild(go, "item")
		local btnSelect = goutil.findChild(go, "btnSelect")
		local wearIcon = goutil.findChild(go, "wearIconGo/icon")

		MaterialMgr.resetAll(item)
		MaterialMgr.clearIcon(wearIcon)
		GameUtil.rmClickHandler(btnSelect)
		UIEffectManager.instance:stopEffect(self._costEffs[go])
	end

	self._costEffs = {}

	MaterialMgr.resetAll(self._iconCostExt)
end

function ExchangeWorkshopView:_showCostEffAdd(costIdx)
	local cell = self._costCellList[costIdx]
	local effGo = cell._mainGo
	local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"

	UIEffectManager.instance:stopEffect(self._costEffs[effGo])

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._costEffs[effGo] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
	end
end

function ExchangeWorkshopView:_onUpdateTargetCol()
	local pageData = self:_getCurPageData()
	local isNeedShowItem = false

	if pageData.poolType == EXCHANGE_POOL_TYPE.CPool then
		local isOnlyOneMat = self:_isOnlyOneTargetMat()

		isNeedShowItem = isOnlyOneMat and true or self:_isHasChoiceTarget()
	elseif pageData.poolType == EXCHANGE_POOL_TYPE.RPool then
		isNeedShowItem = false
	elseif pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
		local isOnlyOneMat = self:_isOnlyOneTargetMat()

		isNeedShowItem = isOnlyOneMat and true or self:_isHasChoiceTarget()
	end

	GameUtil.SetActive(self._imgRandom, not isNeedShowItem)

	if isNeedShowItem then
		local matStr = self:_getTargetMatStr()
		local proxy = MaterialMgr.setCellByCfg(matStr, self._targetItem)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setLvl(0)
		end

		self._txtTarget.text = self:_getTargetMatName()
	else
		MaterialMgr.resetAll(self._targetItem)

		self._txtTarget.text = pageData.cosTips

		GameUtil.SetActive(self._costExt, false)
	end

	local function handler()
		local isChoicePool = pageData.poolType == EXCHANGE_POOL_TYPE.CPool or pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool
		local isOnlyOneMat = self:_isOnlyOneTargetMat()

		if isChoicePool and not isOnlyOneMat then
			UIStateManager.instance:push(ViewName.ExchangeSelectView, pageData.exchangeId, self._cPoolIndex, pageData.poolType)
		end
	end

	GameUtil.addClickHandler(self._btnTargetChoice, handler)
end

function ExchangeWorkshopView:_changeTargetMat(poolId, index)
	self:_updateTargetMatData(poolId, index)
	self:_onUpdateTargetCol()
end

function ExchangeWorkshopView:_onClickTip()
	TipsFacade.instance:openRulesView("exchangeworkshopview_rule")
end

function ExchangeWorkshopView:_getCurExchangeTimesFullTips()
	local pageData = self:_getCurPageData()

	return (pageData.weeklyRefresh or nil) and "本周活动次数已达上限"
end

function ExchangeWorkshopView:_onClickSure()
	local costMatTypeName = self:_getCurMatTypeName()

	if not self:_isCostHaveFull() then
		FloatWordMgr.instance:show(string.format("请先放入%s哦", costMatTypeName))

		return
	end

	if not self:_isHasChoiceTarget() then
		FloatWordMgr.instance:show(string.format("请选择要兑换的%s", costMatTypeName))

		return
	end

	if self:_isCurExchangeTimesFull() then
		FloatWordMgr.instance:show(self:_getCurExchangeTimesFullTips())

		return
	end

	local tipsContent = self:_getCurtipsContent()
	local pageData = self:_getCurPageData()

	local function okFunc()
		FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareExchangeReq(self._activityId, self._pageId, self:_getTargetDefineId(), self:_getCostOnlyIds())
	end

	if pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
		local cCostPoolData = FirstAnnualWelfareConfig.instance:getCCostPoolData(pageData.poolId, self._cPoolIndex)
		local extCost = cCostPoolData.cost
		local costExtType, costExtId, costExtNum = MaterialMgr.getMatParams(extCost)

		TipsFacade.instance:openPopupCostMatViewNew(costExtType, costExtId, costExtNum, tipsContent, okFunc)
	else
		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end
end

function ExchangeWorkshopView:_getCurtipsContent()
	local pageData = self:_getCurPageData()
	local costMatTypeName = self:_getCurMatTypeName()
	local isHaveWear = self:_isCostHaveWearing()
	local qualityDesc = self:_getCurMatQualityDesc()
	local targetMatName = self:_getTargetMatName()
	local costStr = qualityDesc .. costMatTypeName
	local extCostTips = ""
	local highlightColor = GameEnum.ColorConst.Red

	if pageData.poolType == EXCHANGE_POOL_TYPE.CCostPool then
		local cCostPoolData = FirstAnnualWelfareConfig.instance:getCCostPoolData(pageData.poolId, self._cPoolIndex)
		local extCost = cCostPoolData.cost
		local costExtType, costExtId, costExtNum = MaterialMgr.getMatParams(extCost)

		extCostTips = string.format("<color=%s>%s%s</color>和", highlightColor, costExtNum, MaterialMgr.getMaterialsName(costExtType, costExtId))
	end

	local costMatNameStr = ""
	local cnt = 0

	for i = 1, self._costNum do
		if self._matCostIdxList[i] then
			cnt = cnt + 1

			local nameStr = MaterialMgr.getMaterialsNameByCfg(self:_getMatStr(self._matCostIdxList[i]))

			costMatNameStr = cnt == 1 and string.format("【%s】", nameStr) or string.format("%s、【%s】", costMatNameStr, nameStr)
		end
	end

	return isHaveWear and string.format("选中的材料中有穿戴中的%s，确认卸下并消耗%s<color=%s>%s%s</color>兑换<color=%s>【%s】</color>吗？", costMatTypeName, extCostTips, highlightColor, costStr, costMatNameStr, highlightColor, targetMatName) or string.format("确认消耗%s<color=%s>%s%s</color>兑换<color=%s>【%s】</color>吗？", extCostTips, highlightColor, costStr, costMatNameStr, highlightColor, targetMatName)
end

return ExchangeWorkshopView

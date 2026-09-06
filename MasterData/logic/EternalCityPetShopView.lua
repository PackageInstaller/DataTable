-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityPetShopView.lua

module("logic.extensions.eternalcity.view.EternalCityPetShopView", package.seeall)

local EternalCityPetShopView = class("EternalCityPetShopView", ViewComponent)

function EternalCityPetShopView:buildUI()
	EternalCityPetShopView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._goldBarCon = self:getGo("shopPet/goldBarCon")
	self._txtTips = self:getTxt("shopPet/tips/txt")
	self._strTxtTips = self._txtTips.text
	self._txtRecruitTimes = self:getTxt("shopPet/txtRecruitTimes")
	self._btnRefresh = self:getGo("shopPet/btnRefresh")
	self._txtCostRefresh = self:getTxt("shopPet/txtCostRefresh")
	self._iconCostRefresh = self:getGo("shopPet/txtCostRefresh/icon")
	self._txtDiscount = self:getTxt("shopPet/txtCostRefresh/txtDiscount")
	self._btnTask = self:getGo("shopPet/btnTask")
	self._redBtnTask = self:getGo("shopPet/btnTask/redPoint")

	local shopPetScrView = self:getGo("shopPet/scrView")
	local shopPetScrCell = self:getGo("shopPet/scrCell")

	self._shopPetScrollerList = ScrollerList.create(shopPetScrView, shopPetScrCell, GameUtil.handler(self._updateShopPetScrCell, self), GameUtil.handler(self._clearShopPetScrCell, self))
	self._btnFilter = self:getGo("bagPet/btnFilter")

	local bagPetScrView = self:getGo("bagPet/scrView")
	local bagPetScrCell = self:getGo("bagPet/scrCell")

	self._bagPetScrollerList = ScrollerList.create(bagPetScrView, bagPetScrCell, GameUtil.handler(self._updateBagPetScrCell, self), GameUtil.handler(self._clearBagPetScrCell, self))
end

function EternalCityPetShopView:bindEvents()
	EternalCityPetShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickBtnFilter, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function EternalCityPetShopView:unbindEvents()
	EternalCityPetShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnTask)
end

function EternalCityPetShopView:onEnter()
	EternalCityPetShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityRecruitRes, self._handlePM_EternalCityRecruitRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityRefreshPoolRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityOperaPoolRes, self._handlePM_EternalCityOperaPoolRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMaterialItemChange, self)
	self:_onUpdate()

	local goldMats = {}
	local datass = EternalCityConfig.instance:getPetPoolDatass(self._activityId) or {}

	for poolId, datas in ipairs(datass) do
		for _, data in ipairs(datas) do
			local mat = self._subMo:getPetRecruitCostMat(poolId, data.creepsId)

			goldMats[mat.matType] = goldMats[mat.matType] or {}
			goldMats[mat.matType][mat.matId] = mat.matType .. ":" .. mat.matId
		end
	end

	local refreshMat = self._subMo:getRefreshPoolCostMat()

	goldMats[refreshMat.matType] = goldMats[refreshMat.matType] or {}
	goldMats[refreshMat.matType][refreshMat.matId] = refreshMat.matType .. ":" .. refreshMat.matId
	self._goldMats = goldMats

	local list = {}

	for matType, map in pairs(goldMats) do
		for matId, matStr in pairs(map) do
			local tab = {
				showAdd = true,
				id = matStr
			}

			table.insert(list, tab)
		end
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end
end

function EternalCityPetShopView:onExit()
	EternalCityPetShopView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	MaterialMgr.clearIcon(self._iconCostRefresh)
	self:_onClearShopPetCol()
	self:_onClearBagPetCol()
end

function EternalCityPetShopView:_handlePM_EternalCityOperaPoolRes(msg)
	local poolId = msg.poolId
	local index = -1
	local dataList = self._shopPetScrollerList:getData()

	for i, id in ipairs(dataList) do
		if id == poolId then
			index = i - 1

			break
		end
	end

	if index >= 0 then
		self._shopPetScrollerList:updateCellInViewByIndex(index)
	end

	self:_onUpdatePlaneUI()
end

function EternalCityPetShopView:_handlePM_EternalCityRecruitRes()
	FloatWordMgr.instance:show("招募成功！")
	self:_onUpdate()
end

function EternalCityPetShopView:_onMaterialItemChange(changeItemsList)
	local isNeedUpdate = false

	for _, mo in pairs(changeItemsList) do
		local matType = mo:GetMatType()
		local matId = mo:getDefineId()

		if self._goldMats[matType] and self._goldMats[matType][matId] then
			isNeedUpdate = true

			break
		end
	end

	if isNeedUpdate then
		self:_onUpdate()
	end
end

function EternalCityPetShopView:_onUpdate()
	self:_onUpdateShopPetCol()
	self:_onUpdateBagPetCol()
	self:_onUpdatePlaneUI()
end

function EternalCityPetShopView:_onUpdatePlaneUI()
	local todayRecruitTimes = self._subMo:getTodayRecruitTimes()
	local maxRecruitTimes = self._subMo:getMaxRecruitTimes()

	self._txtRecruitTimes.text = string.format("今日招募次数：%s/%s", Mathf.Max(maxRecruitTimes - todayRecruitTimes, 0), maxRecruitTimes)

	local refreshMat = self._subMo:getRefreshPoolCostMat()
	local refreshResult = self:_getTryRefreshPoolResultAndTips(false)
	local refreshCost = self._subMo:getRefreshPoolCost()

	GameUtil.SetGray(self._btnRefresh, refreshResult ~= GameEnum.ResultCode.Success)
	MaterialMgr.setIcon(self._iconCostRefresh, refreshMat.matType, refreshMat.matId, nil, nil)

	self._txtCostRefresh.text = refreshMat.matNum
	self._txtDiscount.text = refreshCost

	GameUtil.SetActive(self._txtDiscount.gameObject, refreshCost ~= refreshMat.matNum)

	local guaranteedNums = {}
	local datass = EternalCityConfig.instance:getPetPoolDatass(self._activityId) or {}

	for poolId, datas in ipairs(datass) do
		for _, data in ipairs(datas) do
			if data.guaranteedNum > 0 and table.indexof(guaranteedNums, data.guaranteedNum) == false then
				table.insert(guaranteedNums, data.guaranteedNum)
			end
		end
	end

	table.sort(guaranteedNums, function(a, b)
		return a < b
	end)

	local content = ""

	for i, v in ipairs(guaranteedNums) do
		content = i > 1 and content .. "/" .. v or content .. v
	end

	self._txtTips.text = string.format(self._strTxtTips, content)
end

function EternalCityPetShopView:_onUpdateShopPetCol()
	local poolIdList = {}
	local datass = EternalCityConfig.instance:getPetPoolDatass(self._activityId) or {}

	for poolId, datas in ipairs(datass) do
		table.insert(poolIdList, poolId)
	end

	self._shopPetScrollerList:reloadData(poolIdList)
end

function EternalCityPetShopView:_onClearShopPetCol()
	self._shopPetScrollerList:dispose()
end

function EternalCityPetShopView:_updateShopPetScrCell(view, cell, poolId, tag)
	local creepsId = self._subMo:getPoolPetId(poolId)
	local creepsData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
	local skinId = checknumber(creepsData and creepsData.faceId)

	if skinId <= 0 then
		skinId = checknumber(creepsData and creepsData.raceId)
	end

	if creepsData then
		if not creepsData.productionRate then
			local productionRate = 0
			local isLocked = self._subMo:isPoolLocked(poolId)
			local recruitMat = self._subMo:getPetRecruitCostMat(poolId, creepsId)
			local recruitResult = self:_getTryRecruitPetResultAndTips(false, poolId, creepsId, 1)
			local mainGo = cell.gameObject
			local maskGo = goutil.findChild(mainGo, "mask")
			local icon = goutil.findChild(mainGo, "mask/icon")
			local txtSpeed = goutil.findChildTextComponent(mainGo, "speed/txt")
			local btnRecruit = goutil.findChild(mainGo, "btnRecruit")
			local btnLock = goutil.findChild(mainGo, "btnLock")
			local btnUnlock = goutil.findChild(mainGo, "btnUnlock")
			local tagLock = goutil.findChild(mainGo, "tagLock")
			local txtCostRecruit = goutil.findChildTextComponent(mainGo, "txtCostRecruit")
			local iconCostRecruit = goutil.findChild(mainGo, "txtCostRecruit/icon")

			MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

			txtSpeed.text = string.format("%s%%", productionRate)

			MaterialMgr.setIcon(iconCostRecruit, recruitMat.matType, recruitMat.matId, nil, nil)

			txtCostRecruit.text = recruitMat.matNum

			GameUtil.SetGray(btnRecruit, recruitResult ~= GameEnum.ResultCode.Success)
			GameUtil.SetActive(tagLock, isLocked)
			GameUtil.SetActive(btnUnlock, isLocked)
			GameUtil.SetActive(btnLock, not isLocked)
			GameUtil.addClickHandler(btnRecruit, function()
				local result = self:_getTryRecruitPetResultAndTips(true, poolId, creepsId, 1)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				local matMo = self._subMo:getPetRecruitCostMat(poolId, creepsId)
				local content = string.format("是否消耗%sx%s，招募精灵？", matMo.matName, matMo.matNum)
				local toggleFunc, togTxt
				local alignment = UnityEngine.TextAnchor.MiddleCenter
				local otherCallBack, autoOpenSource

				local function successCallBack()
					EternalCityController.instance:sendPM_EternalCityRecruitReq(self._activityId, poolId)
				end

				TipsFacade.instance:openPopupCostMatViewNew(matMo.matType, matMo.matId, matMo.matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
			end, self)
			GameUtil.addClickHandler(btnLock, function()
				EternalCityController.instance:sendPM_EternalCityOperaPoolReq(self._activityId, poolId, EternalCityEnum.PoolOperationType_Lock)
			end, self)
			GameUtil.addClickHandler(btnUnlock, function()
				EternalCityController.instance:sendPM_EternalCityOperaPoolReq(self._activityId, poolId, EternalCityEnum.PoolOperationType_Unlock)
			end, self)
			GameUtil.addClickHandler(maskGo, function()
				local petMo = self._subMo:getSupportPetMo(creepsId)

				CommonTipsMgr.instance:showPetTips(petMo, false)
			end)
		end
	end
end

function EternalCityPetShopView:_clearShopPetScrCell(cell)
	local mainGo = cell.gameObject
	local maskGo = goutil.findChild(mainGo, "mask")
	local icon = goutil.findChild(mainGo, "mask/icon")
	local iconCostRecruit = goutil.findChild(mainGo, "txtCostRecruit/icon")
	local btnRecruit = goutil.findChild(mainGo, "btnRecruit")
	local btnLock = goutil.findChild(mainGo, "btnLock")

	MaterialMgr.clearIcon(icon)
	MaterialMgr.clearIcon(iconCostRecruit)
	GameUtil.SetGray(btnRecruit, false)
	GameUtil.rmClickHandler(btnRecruit)
	GameUtil.rmClickHandler(maskGo)
	GameUtil.rmClickHandler(btnLock)
end

function EternalCityPetShopView:_onUpdateBagPetCol()
	local creepsInfoList = {}
	local creepsInfos = self._subMo:getCreepsInfos()

	for creepsId, info in pairs(creepsInfos) do
		local creepsData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
		local petMo = self._subMo:getSupportPetMo(creepsId)
		local petCo = CharacterConfig.instance:getPetCo(creepsData.raceId)
		local isFit = self:_onFilter(petCo, petMo.rare, petMo.curFaceId)

		if isFit then
			local placeNum = self._subMo:getCreepsNumInPlace(creepsId)
			local leftPlaceNum = info.num - placeNum

			for i = 1, info.num do
				local info = {}

				info.creepsId = creepsId
				info.isPlaced = false

				if leftPlaceNum < i then
					info.isPlaced = true
				end

				table.insert(creepsInfoList, info)
			end
		end
	end

	self._bagPetScrollerList:reloadData(creepsInfoList)
end

function EternalCityPetShopView:_onClearBagPetCol()
	self._bagPetScrollerList:dispose()
end

function EternalCityPetShopView:_updateBagPetScrCell(view, cell, info, tag)
	local creepsId = info.creepsId
	local isPlaced = info.isPlaced
	local creepsData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
	local skinId = checknumber(creepsData and creepsData.faceId)

	if skinId <= 0 then
		skinId = checknumber(creepsData and creepsData.raceId)
	end

	if creepsData then
		if not creepsData.productionRate then
			local productionRate = 0
			local mainGo = cell.gameObject
			local icon = goutil.findChild(mainGo, "icon")
			local txtSpeed = goutil.findChildTextComponent(mainGo, "speed/txt")
			local tagActive = goutil.findChild(mainGo, "tagActive")

			MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

			txtSpeed.text = string.format("%s%%", productionRate)

			GameUtil.SetActive(tagActive, isPlaced)
			GameUtil.addClickHandler(mainGo, function()
				local petMo = self._subMo:getSupportPetMo(creepsId)

				CommonTipsMgr.instance:showPetTips(petMo, false)
			end)
		end
	end
end

function EternalCityPetShopView:_clearBagPetScrCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function EternalCityPetShopView:_onClickBtnRefresh()
	local result = self:_getTryRefreshPoolResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local isHasGuaranteed = false
	local datass = EternalCityConfig.instance:getPetPoolDatass(self._activityId) or {}

	for poolId, datas in ipairs(datass) do
		local refreshTimes = self._subMo:getPoolRefreshTimes(poolId)
		local isLocked = self._subMo:isPoolLocked(poolId)

		if not isLocked then
			for _, data in pairs(datas) do
				if data.guaranteedNum > 0 and refreshTimes >= data.guaranteedNum then
					isHasGuaranteed = true

					break
				end
			end
		end

		if isHasGuaranteed then
			break
		end
	end

	if isHasGuaranteed then
		local matMo = self._subMo:getRefreshPoolCostMat()
		local refreshCost = self._subMo:getRefreshPoolCost()
		local content = "当前精灵为高产率精灵，是否确认继续刷新？"
		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter
		local otherCallBack, autoOpenSource

		local function successCallBack()
			EternalCityController.instance:sendPM_EternalCityRefreshPoolReq(self._activityId)
		end

		TipsFacade.instance:openPopupCostMatViewNew(matMo.matType, matMo.matId, refreshCost, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	else
		local matMo = self._subMo:getRefreshPoolCostMat()
		local refreshCost = self._subMo:getRefreshPoolCost()
		local content = string.format("是否消耗%sx%s，刷新一次招募精灵？", matMo.matName, refreshCost)
		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter
		local otherCallBack, autoOpenSource

		local function successCallBack()
			EternalCityController.instance:sendPM_EternalCityRefreshPoolReq(self._activityId)
		end

		self:openPopupCostMatViewWithToggleKey(matMo.matType, matMo.matId, refreshCost, content, successCallBack, togTxt, alignment, otherCallBack, autoOpenSource)
	end
end

function EternalCityPetShopView:openPopupCostMatViewWithToggleKey(matType, matId, matNum, content, successCallBack, togTxt, alignment, otherCallBack, autoOpenSource)
	if matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId) then
		togTxt = lang("本次登录不提示")

		local isNotShowTipsWin = EternalCityModel.instance:isNotShowTipsWin()

		if isNotShowTipsWin then
			if successCallBack then
				successCallBack()
			end
		else
			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				if successCallBack then
					successCallBack()
				end
			end, function(isOn)
				EternalCityModel.instance:setIsNotShowTipsWin(not isOn)
			end, togTxt, alignment, function(key)
				if key == TipsFacade.STATE_CANCEL then
					EternalCityModel.instance:setIsNotShowTipsWin(false)
				end

				if otherCallBack then
					otherCallBack(key)
				end
			end, autoOpenSource)
		end
	else
		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, nil, nil, alignment, otherCallBack, autoOpenSource)
	end
end

function EternalCityPetShopView:_getTryRefreshPoolResultAndTips(isNeedTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local isAllLocked = true
		local datass = EternalCityConfig.instance:getPetPoolDatass(self._activityId) or {}

		for poolId, datas in ipairs(datass) do
			local isLocked = self._subMo:isPoolLocked(poolId)

			if not isLocked then
				isAllLocked = false

				break
			end
		end

		if isAllLocked then
			result = GameEnum.ResultCode.Error
			tips = "所有池子都已锁定，无法刷新招募精灵"
		end
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughRefreshPoolWithCost() then
		result = GameEnum.ResultCode.Error

		local mat = self._subMo:getRefreshPoolCostMat()

		tips = string.format("%s不足", mat.matName)
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function EternalCityPetShopView:_getTryRecruitPetResultAndTips(isNeedTips, poolId, creepsId, count)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and count <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "招募数量不能为0"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughRecruitTimes() then
		result = GameEnum.ResultCode.Error
		tips = "今日招募次数已用完"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughPetRecruitWithCost(poolId, creepsId, count) then
		result = GameEnum.ResultCode.Error

		local mat = self._subMo:getPetRecruitCostMat(poolId, creepsId)

		tips = string.format("%s不足", mat.matName)
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function EternalCityPetShopView:_onClickBtnTip()
	local key = self._actData.ruleKeyPetShop

	TipsFacade.instance:openRulesView(key)
end

function EternalCityPetShopView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function EternalCityPetShopView:_onClickBtnFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_ETERNAL_CITY, pos, sizeDelta, GameUtil.handler(self._onUpdateBagPetCol, self))
end

function EternalCityPetShopView:_onFilter(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_ETERNAL_CITY, cfg, rare, skinId)
end

return EternalCityPetShopView

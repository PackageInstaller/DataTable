-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodFoodDisView.lua

module("logic.extensions.seekfood.view.SeekFoodFoodDisView", package.seeall)

local SeekFoodFoodDisView = class("SeekFoodFoodDisView", ViewComponent)

SeekFoodFoodDisView.ViewType = {
	Dis = 1,
	Boss = 2
}

function SeekFoodFoodDisView:buildUI()
	SeekFoodFoodDisView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._foodIcon = goutil.findChild(self.mainGO, "food/foodIcon")
	self._txtFoodIcon = goutil.findChildTextComponent(self.mainGO, "food/txtName")
	self._imgPet = goutil.findChild(self.mainGO, "imgPet")
	self._disCol = {}

	local mainGo = goutil.findChild(self.mainGO, "disCol")

	self._disCol._mainGo = mainGo
	self._disCol._matCol = goutil.findChild(mainGo, "matCol")
	self._disCol._matScrollercell = goutil.findChild(mainGo, "matCol/matScrollercell")
	self._disCol._matScrollerview = goutil.findChild(mainGo, "matCol/matScrollerview")
	self._disCol._petCol = goutil.findChild(mainGo, "petCol")
	self._disCol._petScrollercell = goutil.findChild(mainGo, "petCol/petScrollercell")
	self._disCol._petScrollerview = goutil.findChild(mainGo, "petCol/petScrollerview")
	self._disCol._ruleScrollercell = goutil.findChild(mainGo, "ruleCol/ruleScrollercell")
	self._disCol._ruleScrollerview = goutil.findChild(mainGo, "ruleCol/ruleScrollerview")
	self._disCol._imgCollecting = goutil.findChild(mainGo, "imgCollecting")
	self._disCol._btnDis = goutil.findChild(mainGo, "btnDis")
	self._disCol._btnFinsih = goutil.findChild(mainGo, "btnFinsih")
	self._disCol._leftTime = goutil.findChild(mainGo, "leftTime")
	self._disCol._txtLeftTime = goutil.findChildTextComponent(mainGo, "leftTime/txt")
	self._disCol._txtLeftCount = goutil.findChildTextComponent(mainGo, "txtLeftCount")
	self._matScrollList = ScrollerList.create(self._disCol._matScrollerview, self._disCol._matScrollercell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
	self._petScrollList = ScrollerList.create(self._disCol._petScrollerview, self._disCol._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._ruleScrollList = ScrollerList.create(self._disCol._ruleScrollerview, self._disCol._ruleScrollercell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRuleCell, self))
	self._bossCol = {}

	local mainGo = goutil.findChild(self.mainGO, "bossCol")

	self._bossCol._mainGo = mainGo
	self._bossCol._descView = goutil.findChild(mainGo, "descView")
	self._bossCol._txtBossDesc = goutil.findChildTextComponent(mainGo, "descView/txtBossDesc")
	self._bossCol._txtBuffDesc = goutil.findChildTextComponent(mainGo, "descView/txtBuffDesc")
	self._bossCol._btnBoss = goutil.findChild(mainGo, "btnBoss")
	self._bossCol._txtBtnBoss = goutil.findChildTextComponent(mainGo, "btnBoss/txt")
	self._bossCol._imgPrize = goutil.findChild(mainGo, "imgPrize")
end

function SeekFoodFoodDisView:bindEvents()
	SeekFoodFoodDisView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._disCol._btnDis, self._onClickBtnDisOfDis, self)
	GameUtil.addClickHandler(self._disCol._btnFinsih, self._onClickBtnDisOfFinsih, self)
	GameUtil.addClickHandler(self._bossCol._btnBoss, self._onClickBtnBossOfBoss, self)
end

function SeekFoodFoodDisView:unbindEvents()
	SeekFoodFoodDisView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._disCol._btnDis)
	GameUtil.rmClickHandler(self._disCol._btnFinsih)
	GameUtil.rmClickHandler(self._bossCol._btnBoss)
end

function SeekFoodFoodDisView:onEnter()
	SeekFoodFoodDisView.super.onEnter(self)

	self._activityType = SeekFoodController.instance:getActivityType()

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._foodId = checknumber(params[2])
	self._saveViewInfoList = params[3] or {}

	local isInTime = SeekFoodController.instance:isInActivityTimeAsSeekFood(self._activityId)

	isInTime = isInTime and SeekFoodController.instance:isInTimeOfFood(self._activityId, self._foodId)

	if not isInTime then
		printError(string.format("活动不在开启期限内( activityId = %d, foodId = %s )", self._activityId, self._foodId))
		self:close()
	end

	self._petIdList = {}

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.SeekFoodInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SeekFoodDispatchRes, self._handleDispatchRes, self)
	self.addGEvent(self, GlobalNotify.SeekFoodGainDispatchRes, self._handleGainDispatchRes, self)
	self.addGEvent(self, GlobalNotify.SeekFoodFightBossRes, self._handleFightBossRes, self)
	self.addGEvent(self, GlobalNotify.NotifySeekFoodFightBossEndRes, self._handleFightBossEndRes, self)
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:onExit()
	SeekFoodFoodDisView.super.onExit(self)
	self:_onClearDisColUI()
	self:_onClearBossColUI()
	uGuiUtil.clearImage(self._foodIcon)
	uGuiUtil.clearImage(self._imgPet)
end

function SeekFoodFoodDisView:_sendInfoReq()
	SeekFoodController.instance:sendPM_SeekFoodInfoReq(self._activityId)
end

function SeekFoodFoodDisView:_handleDispatchRes()
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:_handleGainDispatchRes(status, msg)
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:_handleFightBossRes()
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:_handleFightBossEndRes()
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:_onSetUI()
	local data = SeekFoodConfig.instance:getSfFoodData(self._activityId, self._foodId)
	local path = data.foodPic
	local bgGo = self._foodIcon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	self._txtFoodIcon.text = data.name or ""
end

function SeekFoodFoodDisView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SeekFoodFoodDisView:_onUpdateData()
	local foodState = SeekFoodController.instance:getFoodState(self._activityId, self._foodId)

	if foodState == SeekFoodModel.FoodState.CanFightBoss or foodState == SeekFoodModel.FoodState.HasFightBoss then
		self:_setCurViewType(SeekFoodFoodDisView.ViewType.Boss)
	else
		self:_setCurViewType(SeekFoodFoodDisView.ViewType.Dis)
	end

	self._matInfoList = {}

	local cfg = SeekFoodConfig.instance:getSfMatCfg(self._activityId, self._foodId)

	for _, data in ipairs(cfg) do
		local materialId = data.materialId
		local info = {}

		info.materialId = materialId
		info.data = data
		info.state = SeekFoodModel.instance:getMaterialState(self._foodId, materialId)
		self._matInfoList[materialId] = info
	end

	table.sort(self._matInfoList, function(a, b)
		if a.state == b.state then
			return true
		end

		return a.state < b.state
	end)

	local curMatInfo = self:_getMatInfo(self._curMaterialId)

	if curMatInfo == nil or curMatInfo.state >= SeekFoodModel.MatState.Collecting then
		if self._matInfoList[1] then
			self._curMaterialId = self._matInfoList[1].materialId or 0
		end
	end

	self:_onUpdatePetIdListData()
end

function SeekFoodFoodDisView:_onUpdatePetIdListData()
	if self:_getMatState(self._curMaterialId) ~= SeekFoodModel.MatState.Normal then
		local list = SeekFoodModel.instance:getPetIdsOfMat(self._foodId, self._curMaterialId)

		self._petIdList = TableUtil.deepcopy(list)
	else
		self._petIdList = {}
	end
end

function SeekFoodFoodDisView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateDisColUI()
	self:_onUpdateBossColUI()
end

function SeekFoodFoodDisView:_getCurViewType()
	return self._curViewType
end

function SeekFoodFoodDisView:_setCurViewType(viewType)
	self._curViewType = viewType
end

function SeekFoodFoodDisView:_getMatState(materialId)
	local info = self:_getMatInfo(materialId)

	return info and info.state
end

function SeekFoodFoodDisView:_getMatInfo(materialId)
	for idx, info in ipairs(self._matInfoList) do
		if info.materialId == materialId then
			return self._matInfoList[idx]
		end
	end

	return nil
end

function SeekFoodFoodDisView:_onUpdatePlaneUI()
	local viewType = self:_getCurViewType()

	if viewType == SeekFoodFoodDisView.ViewType.Dis then
		GameUtil.SetActive(self._disCol._mainGo, true)
		GameUtil.SetActive(self._bossCol._mainGo, false)
	elseif viewType == SeekFoodFoodDisView.ViewType.Boss then
		GameUtil.SetActive(self._disCol._mainGo, false)
		GameUtil.SetActive(self._bossCol._mainGo, true)
	end

	local foodData = SeekFoodConfig.instance:getSfFoodData(self._activityId, self._foodId)
	local creepsData = SeekFoodConfig.instance:getSfCreepsData(foodData.creepsMasterId, 1)

	if creepsData then
		local skinId = checknumber(creepsData.faceId)

		if skinId <= 0 then
			skinId = creepsData.raceId
		end

		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		uGuiUtil.setSpriteToImage(self._imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	else
		uGuiUtil.clearImage(self._imgPet)
	end
end

function SeekFoodFoodDisView:_onUpdateDisColUI()
	if self:_getCurViewType() ~= SeekFoodFoodDisView.ViewType.Dis then
		self:_onClearDisColUI()

		return
	end

	self:_onUpdateMatColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateRuleColUI()
	self:_onUpdateBtnDis()
end

function SeekFoodFoodDisView:_onClearDisColUI()
	self:_onClearMatCol()
	self:_onClearPetCol()
	self:_onClearRuleCol()
	self:_clearBtnDis()
end

function SeekFoodFoodDisView:_onUpdateMatColUI()
	self._matScrollList:reloadData(self._matInfoList)
end

function SeekFoodFoodDisView:_onClearMatCol()
	self._matScrollList:dispose()
end

function SeekFoodFoodDisView:_updateMatCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local materialId = info.materialId
	local matData = info.data
	local matState = info.state
	local icon = goutil.findChild(mainGo, "icon")
	local imgTag = goutil.findChild(mainGo, "imgTag")
	local txtImgTag = goutil.findChildTextComponent(mainGo, "imgTag/txt")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	GameUtil.SetActive(imgSelected, self._curMaterialId == materialId)

	local path = matData.pic
	local bgGo = icon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	local groupIdx = 0

	if matState == SeekFoodModel.MatState.Normal then
		txtImgTag.text = "待采集"
		groupIdx = 0
	elseif matState == SeekFoodModel.MatState.Collecting then
		txtImgTag.text = "采集中"
		groupIdx = 1
	elseif matState == SeekFoodModel.MatState.CanFinishCollect then
		txtImgTag.text = "可领取"
		groupIdx = 2
	elseif matState == SeekFoodModel.MatState.HasFinishCollected then
		txtImgTag.text = "已采集"
		groupIdx = 2
	end

	GameUtil.setUIGroupIdx(imgTag, groupIdx)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickBtnMatCell, self, materialId))
end

function SeekFoodFoodDisView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(btnSelect)
end

function SeekFoodFoodDisView:_onClickBtnMatCell(materialId)
	if self._curMaterialId == materialId or self:_getMatState(materialId) == SeekFoodModel.MatState.HasFinishCollected then
		return
	end

	self._curMaterialId = materialId

	self:_onUpdatePetIdListData()
	self:_onUpdateUI()
end

function SeekFoodFoodDisView:_onUpdatePetColUI()
	local matData = SeekFoodConfig.instance:getSfMatData(self._activityId, self._foodId, self._curMaterialId)
	local petInfoList = {}

	for idx = 1, matData.petNum do
		local info = {}

		info.index = idx
		info.materialId = self._curMaterialId

		local petId = checknumber(self._petIdList[idx])

		if petId > 0 then
			info.petMo = BagPetsController.instance:getPet(petId)
		end

		info.petId = petId

		table.insert(petInfoList, info)
	end

	self._petScrollList:reloadData(petInfoList)

	local state = self:_getMatState(self._curMaterialId)

	if state == SeekFoodModel.MatState.HasFinishCollected then
		GameUtil.SetActive(self._disCol._petCol, false)
		GameUtil.SetActive(self._disCol._imgCollecting, false)
	elseif state == SeekFoodModel.MatState.Collecting then
		GameUtil.SetActive(self._disCol._petCol, false)
		GameUtil.SetActive(self._disCol._imgCollecting, true)
	else
		GameUtil.SetActive(self._disCol._petCol, true)
		GameUtil.SetActive(self._disCol._imgCollecting, false)
	end
end

function SeekFoodFoodDisView:_onClearPetCol()
	self._petScrollList:dispose()
end

function SeekFoodFoodDisView:_updatePetCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local index = info.index
	local materialId = info.materialId
	local petMo = info.petMo
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	if petMo then
		local skinId = petMo.curFaceId
		local proxy = MaterialMgr.setCell(MatType.Pet, skinId, item)
	else
		MaterialMgr.resetAll(item)
	end

	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickBtnPetCell, self, materialId, index))
end

function SeekFoodFoodDisView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	MaterialMgr.resetAll(item)
end

function SeekFoodFoodDisView:_onClickBtnPetCell(materialId, index)
	if checknumber(self._petIdList[index]) > 0 then
		return
	end

	local result, tips = SeekFoodController.instance:getTryCollectMaterialResultAndTips(self._activityId, self._foodId, materialId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._petIdList = SeekFoodController.instance:getPetIdListOfFitToDis(self._activityId, self._foodId, materialId)

	self:_onUpdateUI()
end

function SeekFoodFoodDisView:_onUpdateRuleColUI()
	local matData = SeekFoodConfig.instance:getSfMatData(self._activityId, self._foodId, self._curMaterialId)

	self._ruleScrollList:reloadData(matData.condDescList or {})
end

function SeekFoodFoodDisView:_onClearRuleCol()
	self._ruleScrollList:dispose()
end

function SeekFoodFoodDisView:_updateRuleCell(view, cell, condDesc, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local matData = SeekFoodConfig.instance:getSfMatData(self._activityId, self._foodId, self._curMaterialId)
	local validator = matData.validator
	local imgYes = goutil.findChild(mainGo, "imgYes")
	local imgNo = goutil.findChild(mainGo, "imgNo")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local val = validator[index]
	local isYes = false

	for _, v in ipairs(self._petIdList) do
		local petMo = BagPetsController.instance:getPet(v)

		if petMo and SeekFoodController.instance:isFitCond(petMo, val) then
			isYes = true

			break
		end
	end

	GameUtil.SetActive(imgYes, isYes)
	GameUtil.SetActive(imgNo, not GameUtil.GetActive(imgYes))

	txtDesc.text = condDesc
end

function SeekFoodFoodDisView:_clearRuleCell(cell)
	return
end

function SeekFoodFoodDisView:_onClickBtnDisOfDis()
	local limitPetNum = SeekFoodConfig.instance:getLimitPetNumOfMat(self._activityId, self._foodId, self._curMaterialId)

	if limitPetNum > #self._petIdList then
		FloatWordMgr.instance:show("派遣所需精灵数量不足")

		return
	end

	SeekFoodController.instance:sendPM_SeekFoodDispatchReq(self._activityId, self._foodId, self._curMaterialId, self._petIdList)
end

function SeekFoodFoodDisView:_onClickBtnDisOfFinsih()
	local state = self:_getMatState(self._curMaterialId)

	if state ~= SeekFoodModel.MatState.CanFinishCollect then
		return
	end

	SeekFoodController.instance:sendPM_SeekFoodGainDispatchReq(self._activityId, self._foodId, self._curMaterialId)
end

function SeekFoodFoodDisView:_onUpdateBtnDis()
	local matState = self:_getMatState(self._curMaterialId)
	local limitPetNum = SeekFoodConfig.instance:getLimitPetNumOfMat(self._activityId, self._foodId, self._curMaterialId)

	GameUtil.SetGray(self._disCol._btnDis, limitPetNum > #self._petIdList)
	GameUtil.SetActive(self._disCol._btnDis, matState == SeekFoodModel.MatState.Normal)
	GameUtil.SetActive(self._disCol._btnFinsih, matState == SeekFoodModel.MatState.CanFinishCollect)
	GameUtil.SetActive(self._disCol._leftTime, matState == SeekFoodModel.MatState.Collecting)
	GameUtil.SetActive(self._disCol._txtLeftCount.gameObject, matState == SeekFoodModel.MatState.Normal)

	local curSeekTimes = SeekFoodModel.instance:getSeekTimes()
	local baseData = SeekFoodConfig.instance:getSfBaseData(self._activityId)
	local maxSeekTimes = baseData.seekTimes
	local leftTime = Mathf.Max(maxSeekTimes - curSeekTimes, 0)

	self._disCol._txtLeftCount.text = leftTime > 0 and string.format("今日派遣次数：<color=#20b376>%s</color>/%s", leftTime, maxSeekTimes) or string.format("今日派遣次数：%s/%s", leftTime, maxSeekTimes)

	if matState == SeekFoodModel.MatState.Collecting then
		self:_startTickingLeftTime()
	else
		self:_stopTickingLeftTime()
		self:_stopDelayEndTickingLeftTimeHandle()
	end
end

function SeekFoodFoodDisView:_clearBtnDis()
	self:_stopTickingLeftTime()
	self:_stopDelayEndTickingLeftTimeHandle()
end

function SeekFoodFoodDisView:_startTickingLeftTime()
	self:_stopTickingLeftTime()

	self._leftTimeStamp = SeekFoodModel.instance:getEndTimeStampOfMat(self._foodId, self._curMaterialId)
	self._leftTimeStamp = checknumber(self._leftTimeStamp) / 1000 - ServerTime.now()
	self._step = 1

	if self._leftTimeStamp > 0 then
		settimer(self._step, self._tickingLeftTime, self)
		self:_tickingLeftTime()
	end
end

function SeekFoodFoodDisView:_stopTickingLeftTime()
	removetimer(self._tickingLeftTime, self)
end

function SeekFoodFoodDisView:_tickingLeftTime()
	self._leftTimeStamp = self._leftTimeStamp - self._step

	if self._leftTimeStamp <= 0 then
		self:_stopTickingLeftTime()
		self:_delayEndTickingLeftTimeHandle()
	else
		self._disCol._txtLeftTime.text = string.format("剩余:%s", GameUtil.FormatTimeSymbol(self._leftTimeStamp))
	end
end

function SeekFoodFoodDisView:_delayEndTickingLeftTimeHandle()
	settimer(1, self._endTickingLeftTimeHandle, self)
end

function SeekFoodFoodDisView:_stopDelayEndTickingLeftTimeHandle()
	removetimer(self._endTickingLeftTimeHandle, self)
end

function SeekFoodFoodDisView:_endTickingLeftTimeHandle()
	self:_sendInfoReq()
end

function SeekFoodFoodDisView:_onUpdateBossColUI()
	if self:_getCurViewType() ~= SeekFoodFoodDisView.ViewType.Boss then
		self:_onClearBossColUI()

		return
	end

	local foodState = SeekFoodController.instance:getFoodState(self._activityId, self._foodId)
	local foodData = SeekFoodConfig.instance:getSfFoodData(self._activityId, self._foodId)
	local masterData = SeekFoodConfig.instance:getSfMasterData(foodData.creepsMasterId)

	self._bossCol._txtBossDesc.text = string.format("战胜%s，即可成功获得美食", masterData.name)

	if foodState == SeekFoodModel.FoodState.CanFightBoss then
		self._bossCol._txtBtnBoss.text = "立即挑战"

		GameUtil.SetGray(self._bossCol._btnBoss, false)
	elseif foodState == SeekFoodModel.FoodState.HasFightBoss then
		self._bossCol._txtBtnBoss.text = "挑战成功"

		GameUtil.SetGray(self._bossCol._btnBoss, true)
	else
		self._bossCol._txtBtnBoss.text = ""

		GameUtil.SetGray(self._bossCol._btnBoss, true)
	end

	local toDay = SeekFoodController.instance:getToDayByActOpen(self._activityId)
	local buffData = SeekFoodConfig.instance:getSfBuffData(self._activityId, toDay)

	GameUtil.SetActive(self._bossCol._txtBuffDesc.gameObject, buffData ~= nil)

	if buffData then
		self._bossCol._txtBuffDesc.text = string.format("今日buff：%s", buffData.desc)
	end

	if not string.nilorempty(foodData.prize) then
		MaterialMgr.setCellByCfg(foodData.prize, self._bossCol._imgPrize)
	else
		MaterialMgr.resetAll(self._bossCol._imgPrize)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bossCol._descView:GetComponent(goutil.Type_RectTransform))
end

function SeekFoodFoodDisView:_onClearBossColUI()
	MaterialMgr.resetAll(self._bossCol._imgPrize)
end

function SeekFoodFoodDisView:_onClickBtnBossOfBoss()
	local foodState = SeekFoodController.instance:getFoodState(self._activityId, self._foodId)

	if foodState ~= SeekFoodModel.FoodState.CanFightBoss then
		return
	end

	UIJumper.instance:clear()

	for _, info in ipairs(self._saveViewInfoList) do
		if info.params then
			UIJumper.instance:pushOneStack(info.viewName, nil, unpack(info.params))
		else
			UIJumper.instance:pushOneStack(info.viewName, nil)
		end
	end

	self:close()

	if #self._saveViewInfoList <= 0 then
		UIJumper.instance:saveCurStack()
	end

	SeekFoodController.instance:enterBattleAsSf(self._activityId, self._foodId)
end

function SeekFoodFoodDisView:_onClickBtnTip()
	local value = SeekFoodConfig.instance:getSfCommonValue(self._activityId, "SF_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(value)
end

return SeekFoodFoodDisView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventDispatchShopView.lua

module("logic.extensions.domainadventure.view.DomAdvEventDispatchShopView", package.seeall)

local DomAdvEventDispatchShopView = class("DomAdvEventDispatchShopView", ViewComponent)

function DomAdvEventDispatchShopView:buildUI()
	DomAdvEventDispatchShopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")
	self._btnFilter = goutil.findChild(self.mainGO, "bagCol/btnFilter")

	local bagScrView = goutil.findChild(self.mainGO, "bagCol/scrView")
	local bagScrCell = goutil.findChild(self.mainGO, "bagCol/scrCell")

	self._bagScrollerList = ScrollerList.create(bagScrView, bagScrCell, GameUtil.handler(self._updateBagPetCell, self), GameUtil.handler(self._clearBagPetCell, self))

	local shopScrView = goutil.findChild(self.mainGO, "shopCol/scrView")
	local shopScrCell = goutil.findChild(self.mainGO, "shopCol/scrCell")

	self._shopScrollerList = ScrollerList.create(shopScrView, shopScrCell, GameUtil.handler(self._updateShopPetCell, self), GameUtil.handler(self._clearShopPetCell, self))
	self._btnDis = goutil.findChild(self.mainGO, "btnDis/btn")
	self._descIcon = goutil.findChild(self.mainGO, "btnDis/desc/icon")
	self._txtDescInBtnDis = goutil.findChildTextComponent(self.mainGO, "btnDis/desc/txt")
end

function DomAdvEventDispatchShopView:bindEvents()
	DomAdvEventDispatchShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnDis, self._onClickBtnDis, self)
end

function DomAdvEventDispatchShopView:unbindEvents()
	DomAdvEventDispatchShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnDis)
end

function DomAdvEventDispatchShopView:onEnter()
	DomAdvEventDispatchShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._blockId = checknumber(params[2])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._actData = DomainAdventureConfig.instance:getActData(self._activityId)
	self._mapData = DomainAdventureConfig.instance:getMapData(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._eventData = DomainAdventureConfig.instance:getDispatchData(self._activityId, self._eventId)
	self._globalDispatchLimit = DomainAdventureConfig.instance:getGlobalDispatchLimit(self._activityId)
	self._dispatchPetLimit = DomainAdventureConfig.instance:getDispatchPetLimit(self._activityId)
	self._lockTxtDic = {}
	self._lockInfoDics = {}
	self._lockPetIdList = {}
	self._lockPetIdListInBlock = {}
	self._selectPetIdDic = {}
	self._selectPetIdList = {}
	self._petMoList = BagModel.instance:getPets()
	self._dispathValueDic = {}

	for _, petMo in pairs(self._petMoList) do
		local petId = petMo:getId()

		self._dispathValueDic[petId] = self:_calcDispathValue(petId)
	end

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)
	self:_onSetUI()
	self:_onUpdate()
	settimer(0.3, self._onTicking, self, true)
	self:_onTicking()
end

function DomAdvEventDispatchShopView:onExit()
	DomAdvEventDispatchShopView.super.onExit(self)
	MaterialMgr.clearIcon(self._descIcon)
	removetimer(self._onTicking, self)
	self:_clearAllPetUpFlashEff()
	self:_clearBagPetCol()
	self:_clearShopPetCol()

	self._mapData = nil
	self._eventId = nil
	self._eventData = nil
	self._lockTxtDic = nil
	self._lockInfoDics = nil
	self._lockPetIdList = nil
	self._lockPetIdListInBlock = nil
	self._dispathValueDic = nil
	self._selectPetIdDic = nil
	self._selectPetIdList = nil
end

function DomAdvEventDispatchShopView:_handlePM_DomainAdventureNotifyActionRes(msg)
	local activityId = msg.actionParam.activityId
	local blockId = msg.actionParam.blockId

	if activityId == self._activityId and blockId == self._blockId then
		-- block empty
	end
end

function DomAdvEventDispatchShopView:_onTicking()
	local nowTime = ServerTime.now()

	for txt, lockTime in pairs(self._lockTxtDic) do
		if txt then
			txt.text = GameUtil.FormatTimeSymbol(Mathf.Max(lockTime - nowTime, 0))
		end
	end
end

function DomAdvEventDispatchShopView:_onSetUI()
	local list = {}
	local tab = {
		showAdd = false,
		id = DomainAdventureConfig.instance:getCostItem(self._activityId)
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local costItem = DomainAdventureConfig.instance:getCostItem(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

	MaterialMgr.setIcon(self._descIcon, matType, matId)

	self._txtDescInBtnDis.text = self._mapData.costStrength
end

function DomAdvEventDispatchShopView:_onUpdate()
	local infos = self._scene:getAllDsipatchInfo()

	table.clear(self._lockInfoDics)
	table.clear(self._lockPetIdList)
	table.clear(self._lockPetIdListInBlock)

	for k, v in pairs(infos) do
		local petId = v.petId

		self._lockInfoDics[petId] = v

		table.insert(self._lockPetIdList, petId)

		if v.blockId == self._blockId then
			table.insert(self._lockPetIdListInBlock, petId)
		end
	end

	table.sort(self._lockPetIdListInBlock, function(a, b)
		local aLockTime = self:_getLockTimeInPet(a)
		local bLockTime = self:_getLockTimeInPet(b)

		return aLockTime < bLockTime
	end)
	table.clear(self._lockTxtDic)
	self:_onUpdatePetDataList()
	self:_updateShopPetCol()
	self:_updateBagPetCol()
end

function DomAdvEventDispatchShopView:_isLockInPet(petId)
	local time = self:_getLockTimeInPet(petId)

	return time > 0
end

function DomAdvEventDispatchShopView:_getLockTimeInPet(petId)
	local info = self._lockInfoDics[petId]

	return info and checknumber(info.unlockTime) or 0
end

function DomAdvEventDispatchShopView:_setPetIdInList(petId, isAdd)
	if isAdd then
		if not self:_isSelectedInList(petId) and self:_getPetNumInList() < self._dispatchPetLimit then
			table.insert(self._selectPetIdList, petId)

			self._selectPetIdDic[petId] = true
		end
	else
		table.removebyvalue(self._selectPetIdList, petId)

		self._selectPetIdDic[petId] = false
	end
end

function DomAdvEventDispatchShopView:_isSelectedInList(petId)
	return self._selectPetIdDic[petId] == true
end

function DomAdvEventDispatchShopView:_getPetNumInList()
	local selectNum = #self._selectPetIdList
	local lockNum = #self._lockPetIdListInBlock

	return selectNum + lockNum
end

function DomAdvEventDispatchShopView:_getPetNumInGlobal()
	local selectNum = #self._selectPetIdList
	local lockNum = #self._lockPetIdList

	return selectNum + lockNum
end

function DomAdvEventDispatchShopView:_updateBagPetCol()
	self._bagScrollerList:reloadData(self._curViewDatas)
end

function DomAdvEventDispatchShopView:_clearBagPetCol()
	self._bagScrollerList:dispose()
end

function DomAdvEventDispatchShopView:_updateBagPetCell(view, cell, petMo, tag)
	local petId = petMo:getId()
	local skinId = petMo.curFaceId
	local level = petMo:getPetLv()
	local isSelected = self:_isSelectedInList(petId)
	local isLock = self:_isLockInPet(petId)
	local lockTime = self:_getLockTimeInPet(petId)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local lock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txt")
	local cover = goutil.findChild(mainGo, "cover")
	local Img_attr = goutil.findChild(mainGo, "cover/Img_attr")
	local ImgC_Job = goutil.findChild(mainGo, "cover/ImgC_Job")
	local ImgC_Job_1 = goutil.findChild(mainGo, "cover/ImgC_Job")
	local txtLvl = goutil.findChildTextComponent(mainGo, "cover/txtLvl")
	local awake = goutil.findChild(mainGo, "cover/awake")
	local imgLv = goutil.findChild(mainGo, "cover/awake/imgLv")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	else
		uGuiUtil.clearImage(con)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	GameUtil.setUIImageSpriteIdx(ImgC_Job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(Nego_Job1, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(ImgC_Job_1, secondJobIdx - 1 - 20)
	end

	txtLvl.text = level

	local awakenLv = petMo and petMo:getAwakenLv() or 0

	GameUtil.setUIImageSpriteIdx(imgLv, awakenLv)
	GameUtil.SetActive(imgSelect, isSelected)
	GameUtil.SetActive(lock, isLock)
	GameUtil.SetActive(awake, not isLock)

	self._lockTxtDic[txtLock] = isLock and lockTime / 1000 or nil

	local nowTime = ServerTime.now()

	txtLock.text = GameUtil.FormatTimeSymbol(Mathf.Max(lockTime / 1000 - nowTime, 0))

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickBagPetCell, self, petId))
end

function DomAdvEventDispatchShopView:_clearBagPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txt")

	self._lockTxtDic[txtLock] = nil

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function DomAdvEventDispatchShopView:_onClickBagPetCell(petId)
	if self:_isLockInPet(petId) then
		FloatWordMgr.instance:show("派遣中")

		return
	end

	local isSelected = self:_isSelectedInList(petId)
	local isNeedUpdate = false

	if isSelected then
		self:_setPetIdInList(petId, false)

		isNeedUpdate = true
	elseif self:_getPetNumInList() >= self._dispatchPetLimit then
		FloatWordMgr.instance:show("已达到该地块派遣上限")
	elseif self:_getPetNumInGlobal() >= self._globalDispatchLimit then
		FloatWordMgr.instance:show("已达到总派遣上限")
	elseif self._dispathValueDic[petId] <= 0 then
		FloatWordMgr.instance:show("精灵派遣值不足")
	else
		self:_setPetIdInList(petId, true)

		isNeedUpdate = true
	end

	if isNeedUpdate then
		self:_updateBagPetCol()
		self:_updateShopPetCol()
	end
end

function DomAdvEventDispatchShopView:_updateShopPetCol()
	local list = {}

	for _, v in ipairs(self._lockPetIdListInBlock) do
		table.insert(list, v)
	end

	for i, v in ipairs(self._selectPetIdList) do
		table.insert(list, v)
	end

	for idx = #list + 1, self._dispatchPetLimit do
		list[idx] = 0
	end

	local value = 0

	for _, petId in ipairs(self._selectPetIdList) do
		value = value + self._dispathValueDic[petId]
	end

	self._txtProgress.text = string.format("%s", value)

	self._shopScrollerList:reloadData(list)

	local result, tips = self:_getTryBtnDisResultAndTips()

	GameUtil.SetGray(self._btnDis, result ~= GameEnum.ResultCode.Success)
end

function DomAdvEventDispatchShopView:_clearShopPetCol()
	self._shopScrollerList:dispose()
end

function DomAdvEventDispatchShopView:_updateShopPetCell(view, cell, petId, tag)
	local petMo = BagModel.instance:getPet(petId)
	local skinId = checknumber(petMo and petMo.curFaceId)
	local level = petMo and petMo:getPetLv()
	local isLock = self:_isLockInPet(petId)
	local lockTime = self:_getLockTimeInPet(petId)
	local isSelected = self:_isSelectedInList(petId)
	local mainGo = cell.gameObject
	local empty = goutil.findChild(mainGo, "empty")
	local seat = goutil.findChild(mainGo, "seat")
	local con = goutil.findChild(seat, "mask/con")
	local cover = goutil.findChild(seat, "cover")
	local Img_attr = goutil.findChild(seat, "cover/Img_attr")
	local ImgC_Job = goutil.findChild(seat, "cover/ImgC_Job")
	local ImgC_Job_1 = goutil.findChild(seat, "cover/ImgC_Job")
	local txtLvl = goutil.findChildTextComponent(seat, "cover/txtLvl")
	local lock = goutil.findChild(seat, "lock")
	local txtLock = goutil.findChildTextComponent(seat, "lock/txt")
	local awake = goutil.findChild(seat, "cover/awake")
	local imgLv = goutil.findChild(seat, "cover/awake/imgLv")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	else
		uGuiUtil.clearImage(con)
	end

	if skinId > 0 then
		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

		race = race % 10

		GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

		GameUtil.setUIImageSpriteIdx(ImgC_Job, firstJobIdx - 1)

		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
		local isNeedJob1 = secondJobIdx > 20

		GameUtil.SetActive(Nego_Job1, isNeedJob1)

		if isNeedJob1 then
			GameUtil.setUIImageSpriteIdx(ImgC_Job_1, secondJobIdx - 1 - 20)
		end
	end

	local awakenLv = petMo and petMo:getAwakenLv() or 0

	GameUtil.setUIImageSpriteIdx(imgLv, awakenLv)

	txtLvl.text = level

	GameUtil.SetActive(lock, isLock)
	GameUtil.SetActive(cover, not isLock)

	self._lockTxtDic[txtLock] = isLock and lockTime / 1000 or nil

	local nowTime = ServerTime.now()

	txtLock.text = GameUtil.FormatTimeSymbol(Mathf.Max(lockTime / 1000 - nowTime, 0))

	GameUtil.SetActive(seat, isSelected or isLock)
	GameUtil.SetActive(empty, not isSelected and not isLock)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickShopPetCell, self, petId))
end

function DomAdvEventDispatchShopView:_clearShopPetCell(cell)
	local mainGo = cell.gameObject
	local seat = goutil.findChild(mainGo, "seat")
	local con = goutil.findChild(seat, "mask/con")
	local txtLock = goutil.findChildTextComponent(seat, "lock/txt")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)

	self._lockTxtDic[txtLock] = nil
end

function DomAdvEventDispatchShopView:_onClickShopPetCell(petId)
	if self:_isLockInPet(petId) then
		FloatWordMgr.instance:show("派遣中")

		return
	end

	if self:_isSelectedInList(petId) then
		self:_setPetIdInList(petId, false)
		self:_updateShopPetCol()
	end
end

function DomAdvEventDispatchShopView:_calcDispathValue(petId)
	local value = 0

	if petId < 0 then
		return value
	end

	local petMo = BagModel.instance:getPet(petId)
	local raceId = petMo:getDefineId()
	local level = petMo:getPetLv()
	local dataLv = DomainAdventureConfig.instance:getDisProgressDataByValue(self._eventData.levelPlan, level)

	if dataLv then
		value = value + dataLv.progress
	end

	local awakenLv = petMo:getAwakenLv()
	local dataAwakenLv = DomainAdventureConfig.instance:getDisProgressDataByValue(self._eventData.awakenPlan, awakenLv)

	if dataAwakenLv then
		value = value + dataAwakenLv.progress
	end

	local rare = CharacterConfig.instance:getRareByAwakenLv(awakenLv, raceId)
	local dataRare = DomainAdventureConfig.instance:getDisProgressDataByValue(self._eventData.skinPlan, rare)

	if dataRare then
		value = value + dataRare.progress
	end

	return value
end

function DomAdvEventDispatchShopView:_loadPetUpFlashEff(effParent)
	local pathName = "20230331/dafuweng/fx_ui_dafuweng_shenji"

	self:_clearPetUpFlashEff(effParent)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_clearPetUpFlashEff(effParent)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		local handlerTarget

		if self._petUpFlashEffPool == nil then
			self._petUpFlashEffPool = {}
		end

		local effValue = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)

		effValue.hideEffWhileNotOnTop = false
		self._petUpFlashEffPool[effParent] = effValue
	end
end

function DomAdvEventDispatchShopView:_clearPetUpFlashEff(effParent)
	if self._petUpFlashEffPool then
		UIEffectManager.instance:stopEffect(self._petUpFlashEffPool[effParent])

		self._petUpFlashEffPool[effParent] = nil
	end
end

function DomAdvEventDispatchShopView:_clearAllPetUpFlashEff()
	if self._petUpFlashEffPool then
		for k, v in pairs(self._petUpFlashEffPool) do
			self:_clearPetUpFlashEff(k)
		end
	end
end

function DomAdvEventDispatchShopView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("lingyumaoxian_paiqian_rule")
end

function DomAdvEventDispatchShopView:_updateFilter(starList, jobList, rareList)
	self:_RefreshPetList()
end

function DomAdvEventDispatchShopView:_onUpdatePetDataList()
	self._curViewDatas = {}

	for k, v in pairs(self._petMoList) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)

	local petIdA, petIdB = 0, 0
	local valueA, valueB = 0, 0
	local lockNumA, lockNumB = 0, 0

	table.sort(self._curViewDatas, function(petMoA, petMoB)
		petIdA, petIdB = petMoA:getId(), petMoB:getId()
		lockNumA = self._lockInfoDics[petMoA:getId()] and 2 or 0
		lockNumB = self._lockInfoDics[petMoB:getId()] and 2 or 0

		if lockNumA ~= lockNumB then
			return lockNumA < lockNumB
		end

		valueA, valueB = self._dispathValueDic[petIdA], self._dispathValueDic[petIdB]

		return valueA > valueB
	end)
end

function DomAdvEventDispatchShopView:_RefreshPetList()
	self:_onUpdatePetDataList()
	self:_updateBagPetCol()
end

function DomAdvEventDispatchShopView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (pet:isExist() or nil) and PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, petCo, pet.rare, pet.curFaceId)
end

function DomAdvEventDispatchShopView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function DomAdvEventDispatchShopView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self._updateFilter, self))
end

function DomAdvEventDispatchShopView:_onClickBtnDis()
	local result, tips = self:_getTryBtnDisResultAndTips()

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function okFunc()
		local extParam = ""

		if self._selectPetIdList[1] then
			extParam = extParam .. self._selectPetIdList[1]
		end

		for index = 2, #self._selectPetIdList do
			local petId = self._selectPetIdList[index]

			extParam = extParam .. "," .. petId
		end

		table.clear(self._selectPetIdList)
		table.clear(self._selectPetIdDic)
		DomainAdventureController.instance:sendPM_DomainAdventureActionReq(self._activityId, self._blockId, extParam, nil)
	end

	local cur = #self._selectPetIdList + #self._lockPetIdListInBlock

	if cur < self._dispatchPetLimit and self:_getPetNumInGlobal() <= self._globalDispatchLimit then
		local tipsContent = string.format("您未选择满%s只精灵进行派遣，所获得的驱逐值收益减少，是否继续？", self._dispatchPetLimit)

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	else
		okFunc()
	end
end

function DomAdvEventDispatchShopView:_getTryBtnDisResultAndTips()
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		result, tips = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)
	end

	if result == GameEnum.ResultCode.Success then
		if self:_getPetNumInList() > self._dispatchPetLimit then
			result = GameEnum.ResultCode.Error
			tips = "已达到该地块派遣上限"
		elseif self:_getPetNumInGlobal() > self._globalDispatchLimit then
			result = GameEnum.ResultCode.Error
			tips = "已达到总派遣上限"
		elseif #self._selectPetIdList <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "未选择派遣精灵"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local value = 0

		for _, petId in ipairs(self._selectPetIdList) do
			value = value + self._dispathValueDic[petId]
		end

		if value <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "驱逐值不能为零"
		end
	end

	return result, tips
end

return DomAdvEventDispatchShopView

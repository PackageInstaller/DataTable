-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightPetShopView.lua

module("logic.extensions.holylight.view.HolyLightPetShopView", package.seeall)

local HolyLightPetShopView = class("HolyLightPetShopView", ViewComponent)

function HolyLightPetShopView:buildUI()
	HolyLightPetShopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")

	local bagPetScrollerview = goutil.findChild(self.mainGO, "bagPetCol/bagPetScrollerview")
	local bagPetScrollercell = goutil.findChild(self.mainGO, "bagPetCol/bagPetScrollercell")

	self._bagPetScrollList = ScrollerList.create(bagPetScrollerview, bagPetScrollercell, GameUtil.handler(self._updateBagPetCell, self), GameUtil.handler(self._clearBagPetCell, self))

	local RaceFilterGo = goutil.findChild(self.mainGO, "bagPetCol/RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._btnFilter = goutil.findChild(self.mainGO, "bagPetCol/btnFilter")

	local shopPetScrollerview = goutil.findChild(self.mainGO, "shopPetCol/shopPetScrollerview")
	local shopPetScrollercell = goutil.findChild(self.mainGO, "shopPetCol/shopPetScrollercell")

	self._shopPetScrollList = ScrollerList.create(shopPetScrollerview, shopPetScrollercell, GameUtil.handler(self._updateShopPetCell, self), GameUtil.handler(self._clearShopPetCell, self))
	self._refreshCol = {}

	local mainGo = goutil.findChild(self.mainGO, "refreshCol")

	self._refreshCol._mainGo = mainGo
	self._refreshCol._btn = goutil.findChild(mainGo, "btn")
	self._refreshCol._txtCost = goutil.findChildTextComponent(mainGo, "txtCost")
	self._refreshCol._costIcon = goutil.findChild(mainGo, "txtCost/icon")
	self._refreshCol._txtFreeCost = goutil.findChildTextComponent(mainGo, "txtFreeCost")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
end

function HolyLightPetShopView:bindEvents()
	HolyLightPetShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._refreshCol._btn, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	self._raceFilter:bindEvents()
	self._raceFilter:setValueChanged(self.updateFilterData, self)
end

function HolyLightPetShopView:unbindEvents()
	HolyLightPetShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._refreshCol._btn)
	GameUtil.rmClickHandler(self._btnFilter)
	self._raceFilter:unbindEvents()
end

function HolyLightPetShopView:onEnter()
	HolyLightPetShopView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()
	self._activityType = HolyLightController.instance:getActivityType()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)
	self._usedRandCreepsIds = {}

	GlobalDispatcher:addListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyLightRandCreepsRes, self._onUpdateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyLightChoiceCreepsRes, self._handleChoiceCreepsRes, self)

	local effParent = self.mainGO
	local pathName = "20230331/shengguangzhaoyao/fx_ui_kuang_zhaomu"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	self:_onUpdateUI()
end

function HolyLightPetShopView:onExit()
	HolyLightPetShopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightRandCreepsRes, self._onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightChoiceCreepsRes, self._handleChoiceCreepsRes, self)
	UIEffectManager.instance:stopEffect(self._bgEff)
	self:_clearAllPetUpFlashEff()
	table.clear(self._usedRandCreepsIds)
	self:_onClearUI()

	self._holyLightMgr = nil
end

function HolyLightPetShopView:_handleChoiceCreepsRes()
	FloatWordMgr.instance:show("购买成功")
	self:_onUpdateUI()
end

function HolyLightPetShopView:_onUpdateUI()
	self:_updateRefreshCol()
	self:_updateShopPetCol()
	self:updateFilterData()
end

function HolyLightPetShopView:_onClearUI()
	self:_clearRefreshCol()
	self:_clearBagPetCol()
	self:_clearShopPetCol()
end

function HolyLightPetShopView:_updateBagPetCol()
	local function reloadFinish()
		local petId = self._usedRandCreepsIds[#self._usedRandCreepsIds]
		local cellIndex = 0

		if petId then
			local index

			for idx, petMo in ipairs(self._curViewDatas) do
				if petMo:getPetId() == petId then
					index = idx - 1
				end
			end

			if index then
				cellIndex = index

				local function springFinishCallback(tableview)
					local cell = self._bagPetScrollList._tableview:GetCellAtIndex(index)
					local effRoot = cell and goutil.findChild(cell.gameObject, "effRoot")

					if not goutil.isNil(effRoot) then
						table.removebyvalue(self._usedRandCreepsIds, petId)
						self:_loadPetUpFlashEff(effRoot)
					end

					self._bagPetScrollList._tableview:RegisterOnSetOffsetSpringFinishCallback(nil)
				end

				local offset = self._bagPetScrollList._tableview:GetOffsetByIndex(index)
				local currOffset = self._bagPetScrollList._tableview:GetOffset()
				local viewSize = self._bagPetScrollList._tableview:GetViewSize()
				local cellSize = self._bagPetScrollList._tableview:GetCellSize(index)

				if currOffset <= offset and offset <= currOffset + viewSize - cellSize then
					springFinishCallback()
				else
					self._bagPetScrollList._tableview:RegisterOnSetOffsetSpringFinishCallback(springFinishCallback)
				end
			end
		end

		self._bagPetScrollList:MoveCellInView(cellIndex, true)
	end

	self._bagPetScrollList:regReloadFinish(reloadFinish)
	self._bagPetScrollList:reloadData(self._curViewDatas)
end

function HolyLightPetShopView:_clearBagPetCol()
	self._bagPetScrollList:dispose()
end

function HolyLightPetShopView:_updateBagPetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effRoot = goutil.findChild(mainGo, "effRoot")
	local petId = petMo:getPetId()
	local skinId = petMo.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, item)

	if proxy then
		local function func()
			CommonTipsMgr.instance:showPetTips(petMo, false)
		end

		proxy.binder:setClickCallBack(func)
		proxy.binder:setLvl(petMo:getPetLv())
	end

	self:_clearPetUpFlashEff(effRoot)
end

function HolyLightPetShopView:_clearBagPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function HolyLightPetShopView:_updateShopPetCol()
	local petMoList = {}
	local petIdList = self._holyLightMgr:getShopPetIdList()

	for _, petId in ipairs(petIdList) do
		local petMo = self._holyLightMgr:getShopPetMo(petId)

		table.insert(petMoList, petMo)
	end

	self._shopPetScrollList:reloadData(petMoList)
end

function HolyLightPetShopView:_clearShopPetCol()
	self._shopPetScrollList:dispose()
end

function HolyLightPetShopView:_updateShopPetCell(view, cell, petMo, tag)
	local petId = petMo:getId()
	local skinId = petMo.curFaceId
	local level = self._holyLightMgr:getShopPetLevel(petId)
	local isPurchased = self._holyLightMgr:isPurchasedOfShopPet(petId)
	local price = self._holyLightMgr:getShopPetPrice(petId)
	local data = HolyLightConfig.instance:getHlPetData(self._activityId, petId, level)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local lock = goutil.findChild(mainGo, "lock")
	local txtCost = goutil.findChildTextComponent(mainGo, "cost/txtCost")
	local costIcon = goutil.findChild(mainGo, "cost/txtCost/icon")
	local txtLvl = goutil.findChildTextComponent(mainGo, "cover/txtLvl")
	local Nego_Attr = goutil.findChild(mainGo, "cover/layout/Nego_Attr")
	local Img_attr = goutil.findChild(mainGo, "cover/layout/Nego_Attr/Img_attr")
	local Nego_Job = goutil.findChild(mainGo, "cover/layout/Nego_Job")
	local ImgC_Job = goutil.findChild(mainGo, "cover/layout/Nego_Job/ImgC_Job")
	local Nego_Job1 = goutil.findChild(mainGo, "cover/layout/Nego_Job1")
	local ImgC_Job_1 = goutil.findChild(mainGo, "cover/layout/Nego_Job1/ImgC_Job")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	GameUtil.SetActive(lock, isPurchased)

	txtCost.text = price

	if not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		MaterialMgr.setIcon(costIcon, matType, matId, nil, nil)
	end

	txtLvl.text = data.lv

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

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickShopPetCell, self, petMo))
end

function HolyLightPetShopView:_clearShopPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local costIcon = goutil.findChild(mainGo, "txtCost/icon")

	uGuiUtil.clearImage(con)
	MaterialMgr.resetAll(costIcon)
	GameUtil.addClickHandler(mainGo)
end

function HolyLightPetShopView:_onClickShopPetCell(petMo)
	local petId = petMo:getPetId()
	local result, tips = self._holyLightMgr:getTryBuyShopPetResultAndTips(self._activityId, petId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local cost = self._holyLightMgr:getShopPetPrice(petId)

	if cost == 0 then
		HolyLightController.instance:sendPM_HolyLightChoiceCreepsReq(self._activityId, petId)
	else
		local level = self._holyLightMgr:getShopPetLevel(petId)
		local data = HolyLightConfig.instance:getHlPetData(self._activityId, petId, level)
		local txtTarget = string.format("<quad name=%s:%s|icon size=75 width=1 offsetY=-20/>", MatType.Pet, petMo.curFaceId)
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)
		local txtCost = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)
		local content = string.format("是否消耗%s%s购买%s", matNum, txtCost, txtTarget)

		local function successCallBack()
			table.insert(self._usedRandCreepsIds, petId)
			HolyLightController.instance:sendPM_HolyLightChoiceCreepsReq(self._activityId, petId)
		end

		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter
		local otherCallBack, autoOpenSource

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	end
end

function HolyLightPetShopView:_updateRefreshCol()
	local times = self._holyLightMgr:getRefreshTimesOfShop()
	local cost = self._holyLightMgr:getRefreshCostOfShop(times)
	local refreshData = HolyLightConfig.instance:getHlRefreshDataByTimes(self._activityId, times)

	self._refreshCol._txtCost.text = cost

	if not string.nilorempty(refreshData.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(refreshData.dec)

		MaterialMgr.setIcon(self._refreshCol._costIcon, matType, matId, nil, nil)
	end

	GameUtil.SetActive(self._refreshCol._txtCost.gameObject, cost ~= 0)
	GameUtil.SetActive(self._refreshCol._txtFreeCost.gameObject, cost == 0)

	local value = HolyLightConfig.instance:getHlCommonValue("PET_SHOP_GOLD_COINS")

	if not string.nilorempty(value) then
		local itemStrList = string.split(value, "#")
		local list = {}

		for _, itemStr in ipairs(itemStrList) do
			local tab = {
				id = itemStr
			}

			table.insert(list, tab)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function HolyLightPetShopView:_clearRefreshCol()
	MaterialMgr.resetAll(self._refreshCol._costIcon)
end

function HolyLightPetShopView:_onClickBtnRefresh()
	local times = self._holyLightMgr:getRefreshTimesOfShop()
	local result, tips = self._holyLightMgr:getTryRefreshShopResultAndTips(self._activityId, times)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local cost = self._holyLightMgr:getRefreshCostOfShop(times)

	if cost == 0 then
		HolyLightController.instance:sendPM_HolyLightRandCreepsReq(self._activityId)
	else
		local refreshData = HolyLightConfig.instance:getHlRefreshDataByTimes(self._activityId, times)
		local matType, matId, matNum = MaterialMgr.getMatParams(refreshData.dec)
		local txtCost = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)
		local content = string.format("是否消耗%s%s进行刷新", matNum, txtCost)

		local function successCallBack()
			HolyLightController.instance:sendPM_HolyLightRandCreepsReq(self._activityId)
		end

		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter
		local otherCallBack, autoOpenSource

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	end
end

function HolyLightPetShopView:_loadPetUpFlashEff(effParent)
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

function HolyLightPetShopView:_clearPetUpFlashEff(effParent)
	if self._petUpFlashEffPool then
		UIEffectManager.instance:stopEffect(self._petUpFlashEffPool[effParent])

		self._petUpFlashEffPool[effParent] = nil
	end
end

function HolyLightPetShopView:_clearAllPetUpFlashEff()
	if self._petUpFlashEffPool then
		for k, v in pairs(self._petUpFlashEffPool) do
			self:_clearPetUpFlashEff(k)
		end
	end
end

function HolyLightPetShopView:_onClickBtnTip()
	local key = HolyLightConfig.instance:getHlCommonValue("PET_SHOP_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function HolyLightPetShopView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_PETVIEW)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

function HolyLightPetShopView:_RefreshPetList(force)
	self._curViewDatas = {}

	local petMoList = {}
	local petIdList = self._holyLightMgr:getMyPetIdList()

	for _, petId in ipairs(petIdList) do
		local petMo = self._holyLightMgr:getMyPetMo(petId)

		table.insert(petMoList, petMo)
	end

	for k, v in pairs(petMoList) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)
	BagModel.instance:setCurPetViewList(self._curViewDatas)

	self._curViewDatas = self:_doCustomFilter(self._curViewDatas)

	table.sort(self._curViewDatas, function(moA, moB)
		return moA:getPetLv() > moB:getPetLv()
	end)
	self:_updateBagPetCol()
end

function HolyLightPetShopView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (self:_isMatch(petCo, pet.rare, pet.curFaceId))
end

function HolyLightPetShopView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function HolyLightPetShopView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function HolyLightPetShopView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function HolyLightPetShopView:_doCustomFilter(petMoList)
	return petMoList
end

return HolyLightPetShopView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetbookView.lua

module("logic.extensions.handbook.view.PetbookView", package.seeall)

local PetbookView = class("PetbookView", ViewComponent)

PetbookView.FlipMode = {
	LeftToRight = 2,
	RightToLeft = 1
}

function PetbookView:buildUI()
	PetbookView.super.buildUI(self)

	self._closeBtn = self:getBtn("title/closeBtn")
	self._gridLeft = goutil.findChildComponent(self.mainGO, "gridLeft", "RectTransform")
	self._gridRight = goutil.findChildComponent(self.mainGO, "gridRight", "RectTransform")
	self._btnOverview = self:getBtn("btnOverview")
	self.petCell = self:getGo("Cell")

	GameUtil.SetActive(self.petCell, false)

	self._btnLeftArrow = self:getBtn("btnLeftArrow")
	self._btnLeftRed = self:getGo("btnLeftArrow/red")
	self._btnRightArrow = self:getBtn("btnRightArrow")
	self._btnRightRed = self:getGo("btnRightArrow/red")
	self._progress = self:getSlider("progressBar")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "progressBar/txtProgress")
	self._txtLeftPage = goutil.findChildTextComponent(self.mainGO, "txtLeftPage")
	self._txtRightPage = goutil.findChildTextComponent(self.mainGO, "txtRightPage")
	self.btnAttr = {}

	local filterTransform = self:getGo("filter").transform

	for i = 1, filterTransform.childCount - 1 do
		table.insert(self.btnAttr, self:getBtn("filter/btnAttr" .. i))
	end

	self._btnAttrAll = self:getBtn("filter/btnAttrAll")
	self._tabPetGroup = self:getGo("tabGroup")
	self._btnRareAll = self:getBtn("tabGroup/rareAll/container")
	self.btnRare = {}

	for i = 1, 5 do
		table.insert(self.btnRare, self:getBtn("tabGroup/rare_" .. i .. "/container"))
	end

	self._tabSkinGroup = self:getGo("tabGroupSkin")
	self._btnQualityAll = self:getBtn("tabGroupSkin/rareAll/container")
	self.btnQuality = {}
	self._redpointSkinRare = {}

	for i = 1, 10 do
		local go = self:getGo("tabGroupSkin/rare_" .. i .. "/container")

		if go then
			self.btnQuality[i] = go
		end

		local red = self:getGo("tabGroupSkin/rare_" .. i .. "/redPoint")

		if red then
			self._redpointSkinRare[i] = red
		end
	end

	self._redpointRare = {}

	for i = 1, 5 do
		table.insert(self._redpointRare, self:getGo("tabGroup/rare_" .. i .. "/redPoint"))
	end

	self._imgBook = self:getGo("Imgbook")
	self._empty = self:getGo("empty")
	self._btnStrengthen = self:getBtn("btnStrengthen")
	self._redStrengthen = self:getGo("btnStrengthen/redPoint")
	self._btnSkinOnKey = self:getBtn("btnSkinOnKey")
	self._redSkinOnKey = self:getGo("btnSkinOnKey/redPoint")
	self._btnTips = self:getGo("sumAttribute/btnTips")
	self._btnTipsRoot = self:getGo("sumAttribute/btnTips/root")
	self._txtLife = self:getTxt("sumAttribute/life/txtNum")
	self._txtAttack = self:getTxt("sumAttribute/attack/txtNum")
	self._txtDefend = self:getTxt("sumAttribute/defend/txtNum")
	self._txtMagic = self:getTxt("sumAttribute/magic/txtNum")
	self._sumAttributeGo = self:getGo("sumAttribute")
	self._petrelationBtn = self:getGo("petrelationBtn")
	self._petSkinBtn = self:getGo("petSkinBtn")
	self._petbookBtn = self:getGo("petbookBtn")
	self._petPosterBtn = self:getGo("petPosterBtn")
	self._petBookBg = self:getGo("Imgbook")
	self._petSkinBg = self:getGo("Imgbook_1")
	self._petSkinRed = self:getGo("petSkinBtn/red")
	self._petrelationRed = self:getGo("petrelationBtn/red")
	self._bookAnim = self:getGo("bookAnim")
	self._animMask = self:getGo("animMask")
	self._filterButton = self:getBtn("btnFilter")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._btnSort = self:getBtn("btnSort")
	self._sortpaneGo = self:getGo("sortpane")
	self._customInput = UICustomInput.Get(self:getGo("sortpane/content"))
	self._txtBtnSort = self:getTxt("btnSort/Text")
	self._imgSort = self:getGo("btnSort/imgSort"):GetComponent(ComponentType.UIImageSpriteChange)

	self:_buildSortCells()
end

function PetbookView:_buildSortCells()
	self._sortCells = {}

	for k, v in pairs(PetbookController.SortType) do
		local detail = PetbookController.SortTypeDetail[v]
		local cellGo = self:getGo("sortpane/content/Cell" .. detail.cellIdx)
		local var_2_0 = {
			go = cellGo,
			btn = Framework.ButtonAdapter.Get(cellGo),
			sortType = v,
			txtName = goutil.findChildTextComponent(cellGo, "txtName")
		}

		var_2_0.imgSort = goutil.findChild(cellGo, "imgSort"):GetComponent(ComponentType.UIImageSpriteChange)

		local item = var_2_0

		item.txtName.text = detail.name
		self._sortCells[k] = item
	end
end

function PetbookView:_loadBookCanvas()
	local prefab = self._viewPresentor:getPrefab(PetbookPresentor.bookCanvasPath)
	local prefabGo = goutil.clone(prefab)

	self:_initBookCapture(prefabGo)

	if not goutil.isNil(self._booktestcanvas) then
		self._booktestcanvas:SetActive(true)
	end

	self._bookScript:setReleaseCallBack(function(_mode)
		self._turnPageFlag = false

		self:_pageChange(_mode, 2)
	end)
	settimer(0.02, self._tickClickUnit, self)

	self._isTouchedDown = false
end

function PetbookView:bindEvents()
	PetbookView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._btnLeftArrow:AddClickListener(self._onClickLeftArrow, self)
	self._btnRightArrow:AddClickListener(self._onClickRightArrow, self)
	self._btnOverview:AddClickListener(self._onClickOverview, self)

	for i = 1, #self.btnAttr do
		self.btnAttr[i]:AddClickListener(function()
			self:_onClickAttr(i)
		end, self)
	end

	self._btnAttrAll:AddClickListener(self._onClickAttr, self)

	for i = 1, #self.btnRare do
		self.btnRare[i]:AddClickListener(function()
			self:_onClickRare(i)
		end, self)
	end

	self._btnRareAll:AddClickListener(self._onClickRare, self)

	for i, v in pairs(self.btnQuality) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickQuality, self, i))
	end

	GameUtil.addClickHandler(self._btnQualityAll, GameUtil.handler(self._onClickQuality, self, nil))
	self._btnStrengthen:AddClickListener(self._onClickAllStrength, self)
	self._btnSkinOnKey:AddClickListener(self._onClickSkinOneKey, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._petrelationBtn, self._onClickBtnRelation, self)
	GameUtil.addClickHandler(self._petSkinBtn, self._onClickTabSkin, self)
	GameUtil.addClickHandler(self._petPosterBtn, self._onClickPoster, self)
	GameUtil.addClickHandler(self._petbookBtn, self._onClickTabPet, self)
	GameUtil.addClickHandler(self._filterButton, self._onClickFilter, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._btnSort:AddClickListener(self._onClickbtnSort, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	for k, item in pairs(self._sortCells) do
		item.btn:AddClickListener(function()
			self:_onClickSortCell(item.sortType)
		end)
	end
end

function PetbookView:unbindEvents()
	PetbookView.super.unbindEvents(self)

	if self._bookScript then
		self._bookScript:setReleaseCallBack(nil)
	end

	self._closeBtn:RemoveClickListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnRightArrow:RemoveClickListener()
	self._btnOverview:RemoveClickListener()

	for i = 1, #self.btnAttr do
		self.btnAttr[i]:RemoveClickListener()
	end

	self._btnAttrAll:RemoveClickListener()

	for i = 1, #self.btnRare do
		self.btnRare[i]:RemoveClickListener()
	end

	self._btnRareAll:RemoveClickListener()
	self._btnStrengthen:RemoveClickListener()
	self._btnSkinOnKey:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnTips)

	for i, v in pairs(self.btnQuality) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnQualityAll)
	GameUtil.rmClickHandler(self._filterButton)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
	GameUtil.rmClickHandler(self._petrelationBtn)
	self._inputSearch:RemoveOnValueChanged()
	self._btnSort:RemoveClickListener()
	self._customInput:RemoveListener()

	for k, v in pairs(self._sortCells) do
		v.btn:RemoveClickListener()
	end
end

function PetbookView:onEnter()
	PetbookView.super.onEnter(self)

	self._curSortType = PetbookModel.instance:getCurrSortType()

	self:_loadBookCanvas()
	PetbookModel.instance:setLoginFirst(true)

	self._tabIndex = PetbookModel.instance:getPetbookTab()

	local attr, rare = PetbookModel.instance:getAttrAndRare()

	self.attr = attr
	self.rare = rare
	self.petCells = {}
	self._turnPageFlag = false
	self._inputSearch.input.text = PetbookModel.instance:getSearching()
	self.page = PetbookModel.instance:getPage() or 1

	self:_refreshPetData()
	self:_updateRedpoint()
	self:_refreshTop()
	GlobalDispatcher:addListener(GlobalNotify.HandBookAttributeChange, self._updateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.PetBookStength, self._oneKeyAllStrength, self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookSkinInfo, self._refreshPetData, self)
	GlobalDispatcher:addListener(GlobalNotify.PetBookSkinActive, self._skinInfoReq, self)
	self:_skinInfoReq()
	goutil.setActive(self._animMask, false)
	RedPointController.instance:regRedPoint(self._petrelationRed, 43)
	goutil.setActive(self._sortpaneGo, false)
end

function PetbookView:_refreshPetData()
	GameUtil.SetActive(self._petbookBtn, false)
	GameUtil.SetActive(self._petPosterBtn, false)
	GameUtil.SetActive(self._petSkinBtn, false)
	GameUtil.SetActive(self._tabSkinGroup, false)
	GameUtil.SetActive(self._tabPetGroup, false)
	GameUtil.SetActive(self._sumAttributeGo, false)
	GameUtil.SetActive(self._petBookBg, false)
	GameUtil.SetActive(self._petSkinBg, false)
	GameUtil.SetActive(self._btnStrengthen.gameObject, false)
	GameUtil.SetActive(self._btnSkinOnKey.gameObject, false)
	GameUtil.SetActive(self._btnSort.gameObject, self._tabIndex == PetbookModel.TAB_PET_RACEID)
	PetbookModel.instance:setPetbookTab(self._tabIndex)
	PetbookModel.instance:setAttrAndRare(self.attr, self.rare)
	PetbookModel.instance:setSkinQuality(self.quality)
	PetbookModel.instance:setPage(self.page)

	self._allPet = {}

	local owned = 0

	if self._tabIndex == PetbookModel.TAB_PET_RACEID then
		GameUtil.SetActive(self._petBookBg, true)
		GameUtil.SetActive(self._petSkinBtn, true)
		GameUtil.SetActive(self._tabPetGroup, true)
		GameUtil.SetActive(self._sumAttributeGo, true)
		GameUtil.SetActive(self._btnStrengthen.gameObject, true)

		local index = PetbookModel.instance:getSortTypeIndex(self._curSortType)

		self._allPet, owned = PetbookModel.instance:getFilterPetList(self._curSortType, index)
	else
		GameUtil.SetActive(self._petSkinBg, true)
		GameUtil.SetActive(self._petbookBtn, true)
		GameUtil.SetActive(self._petPosterBtn, true)
		GameUtil.SetActive(self._tabSkinGroup, true)
		GameUtil.SetActive(self._btnSkinOnKey.gameObject, true)

		self._allPet, owned = PetbookModel.instance:getFilterSkinList()
	end

	if BootstrapPjaqGameConfigMgr.isReview then
		GameUtil.SetActive(self._petSkinBtn, false)
	end

	self._pages = math.ceil(#self._allPet / PetbookModel.MAXPERPAGE)

	if self._bookScript then
		self._bookScript.allFilpPage = self._pages
	end

	self:_pageChange()
	goutil.setActive(self._empty, #self._allPet == 0)

	local petNum = #self._allPet

	self._progress:SetValue(owned / petNum)

	self._txtProgress.text = string.format("%s/<color=#7b7177><size=22>%s</size></color>", owned, petNum)

	goutil.setActive(self._progress.gameObject, self.rare ~= 5 or self._tabIndex ~= PetbookModel.TAB_PET_RACEID)
	self:_updateChange(self.attr, self.btnAttr, self._btnAttrAll)
	self:_updateChange(self.rare, self.btnRare, self._btnRareAll)
	self:_updateChange(self.quality, self.btnQuality, self._btnQualityAll)
	self:_skinRedPoint()
end

function PetbookView:_isPetOnline(cfg, nowTime)
	if not string.nilorempty(cfg.manualOnlineTime) then
		nowTime = nowTime or ServerTime.now()

		local onlineTime = GameUtil.string2time(cfg.manualOnlineTime)

		return onlineTime <= nowTime
	end

	return true
end

function PetbookView:_getIsFilter(cfg)
	return not string.nilorempty(cfg.bookIds) and PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg)
end

function PetbookView:_refreshTop()
	local lifeSum, attackSum, defendSum, magicSum = HandbookController.instance:calculateSumAttr()
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = HandbookController.instance:calculateSumFixAttr()

	self._txtLife.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", lifeSum, fixLifeSum)
	self._txtAttack.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", attackSum, fixAttackSum)
	self._txtDefend.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", defendSum, fixDefendSum)
	self._txtMagic.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", magicSum, fixMagicSum)
end

function PetbookView:_onClickBtnTips()
	local viewName, dataList = HandbookController.instance:getPopWinPetRelationTipsViewAndDataList()

	self:showTabAt(self._btnTipsRoot, viewName, dataList)
end

function PetbookView:_onClickBtnRelation()
	UIStateManager.instance:push(ViewName.PetrelationView)
end

function PetbookView:_onClickTabPet()
	UIEffectManager.instance:stopEffect(self._uiEffect)

	self._uiEffect = self:showEffect("fx_ui_fanye_zong_hong")
	self._tabIndex = PetbookModel.TAB_PET_RACEID

	self:_onClearSearchClick()
end

function PetbookView:_onClickTabSkin()
	UIEffectManager.instance:stopEffect(self._uiEffect)

	self._uiEffect = self:showEffect("fx_ui_fanye_zong_lan")
	self._tabIndex = PetbookModel.TAB_PET_SKINID

	self:_onClearSearchClick()
end

function PetbookView:_onClickPoster()
	local userId = RoleModel.instance:getUserId()

	UIStateManager.instance:push(ViewName.PetskinpreView, userId)
end

function PetbookView:destroyUI()
	PetbookView.super.destroyUI(self)
end

function PetbookView:onExit()
	if self._booktestcanvas then
		self._booktestcanvas:SetActive(false)
	end

	PetbookView.super.onExit(self)

	for i = 1, #self.petCells do
		if self.petCells[i] then
			uGuiUtil.clearImage(goutil.findChild(self.petCells[i], "mask/con"))
			Framework.ButtonAdapter.Get(self.petCells[i]):RemoveClickListener()
			goutil.destroy(self.petCells[i])

			self.petCells[i] = nil
		end
	end

	self:_clearBookCanvas()
	GlobalDispatcher:removeListener(GlobalNotify.HandBookAttributeChange, self._updateRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetBookStength, self._oneKeyAllStrength, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookSkinInfo, self._refreshPetData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetBookSkinActive, self._skinInfoReq, self)
	RedPointController.instance:unregRedPoint(self._petrelationRed)
end

function PetbookView:_clearBookCanvas()
	removetimer(self._tickClickUnit, self)

	if self._booktestcanvas then
		goutil.destroy(self._booktestcanvas)

		self._booktestcanvas = nil
	end
end

function PetbookView:_initBookCapture(booktestcanvas)
	if not booktestcanvas then
		return
	end

	self._booktestcanvas = booktestcanvas
	self._book = goutil.findChild(booktestcanvas, "book")
	self._bookScript = self._book:GetComponent("Book")
	self._autoFlipScript = self._book:GetComponent("AutoFlip")
	self._uiRootRect = goutil.find("UIROOT").gameObject:GetComponent("RectTransform")
	self._uiRootWidth = self._uiRootRect.sizeDelta.x
	self._uiRootHeight = self._uiRootRect.sizeDelta.y
	self._screenW, self._screenH = UnityEngine.Screen.width, UnityEngine.Screen.height
	self._pageBgCaptureW = 544
	self._pageBgCaptureH = 500

	local _curWidthRate = self._screenW * (self._pageBgCaptureH * 2) / self._uiRootWidth
	local _curHeightRate = self._screenH * self._pageBgCaptureW / self._uiRootHeight

	self._book.gameObject:GetComponent("RectTransform").sizeDelta = Vector2.New(_curWidthRate, _curHeightRate)

	local _ImgbookPos = GameUtil.getLocalPos(self._imgBook)
	local _ImgbookRectTra = self._imgBook.gameObject:GetComponent("RectTransform")
	local _ImgbookW = _ImgbookRectTra.rect.width
	local _ImgbookH = _ImgbookRectTra.rect.height
	local _wEdge = (self._uiRootWidth - _ImgbookW) / 2
	local _imgbookToPageBgH = 76

	self._bookScript.leftBeginWRate = (_wEdge + _imgbookToPageBgH) / self._uiRootWidth

	local _hEdge = (self._uiRootHeight - _ImgbookH) / 2 + _ImgbookPos.y
	local _imgbookToPageBgBottomV = 75

	self._bookScript.allbeginHRate = (_hEdge + _imgbookToPageBgBottomV) / self._uiRootHeight
	self._bookScript.rightBeginWRate = 0.51
	self._bookScript.heightRate = self._pageBgCaptureW / self._uiRootHeight
	self._bookScript.widthRate = self._pageBgCaptureH / self._uiRootWidth
	self._bookScript.filpPage = 1

	self._bookScript:InitOper()

	if not goutil.isNil(self._booktestcanvas) then
		self._booktestcanvas:SetActive(false)
	end
end

function PetbookView:_updataPetCellSingle(i)
	if self.showPets[i] then
		if self.petCells[i] == nil then
			self.petCells[i] = i <= 6 and goutil.cloneAndSetParent(self.petCell, self._gridLeft, "pet_" .. i) or goutil.cloneAndSetParent(self.petCell, self._gridRight, "pet_" .. i)
		end

		self:_updateCell(self.petCells[i], self.showPets[i])
	else
		goutil.setActive(self.petCells[i], false)
	end
end

function PetbookView:_updataPetCell(_mode, _step)
	self.showPets = PetbookModel.instance:getPagePet(self.page, 2)

	self:_updateSortCellState()

	if not _mode or not _step then
		for i = 1, PetbookModel.MAXPERPAGE * 2 do
			self:_updataPetCellSingle(i)
		end

		return
	end

	if _mode == PetbookView.FlipMode.RightToLeft then
		if _step == 1 then
			for i = PetbookModel.MAXPERPAGE + 1, PetbookModel.MAXPERPAGE * 2 do
				self:_updataPetCellSingle(i)
			end
		else
			for i = 1, PetbookModel.MAXPERPAGE do
				self:_updataPetCellSingle(i)
			end
		end
	elseif _step == 1 then
		for i = 1, PetbookModel.MAXPERPAGE do
			self:_updataPetCellSingle(i)
		end
	else
		for i = PetbookModel.MAXPERPAGE + 1, PetbookModel.MAXPERPAGE * 2 do
			self:_updataPetCellSingle(i)
		end
	end
end

function PetbookView:_updateCell(cell, data)
	local cellBtn = Framework.ButtonAdapter.Get(cell)

	cellBtn:RemoveClickListener()
	cellBtn:AddClickListener(function()
		self:_onClickPet(data.skinId)
	end)
	goutil.setActive(cell, true)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId)

	race = math.fmod(race, 10)

	local targetValue = race - 1
	local _attrIcon = goutil.findChildComponent(cell, "Nego_Attr/Img_attr", "UIImageSpriteChange")

	if _attrIcon then
		_attrIcon:SetState(targetValue)
	end

	local petImage = goutil.findChild(cell, "mask/con")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	if not modelCo then
		printError("t_model id not exist:" .. data.skinId)

		return
	end

	uGuiUtil.setSpriteToImage(petImage, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local isHave = false

	isHave = self._tabIndex == PetbookModel.TAB_PET_RACEID and HandbookModel.instance:isHasPet(data.raceId) or MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, data.skinId) > 0

	uGuiUtil.setImageGrayState(petImage, not isHave)
	uGuiUtil.setImageGrayState(goutil.findChild(cell, "bg"), not isHave)

	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txtState")

	if self._tabIndex == PetbookModel.TAB_PET_RACEID then
		local isTip, isActive = HandbookController.instance:getIfCanActiveOrUpgrade(data.raceId)

		goutil.setActive(tag, isTip)

		txtTag.text = isActive and "可升级" or "可激活"
		goutil.findChildTextComponent(cell, "txtName").text = data.name
	else
		local isActive, state = PetbookModel.instance:skinIsActiveAndState(data.skinId)

		goutil.setActive(tag, isActive and state)

		txtTag.text = "可激活"
		goutil.findChildTextComponent(cell, "txtName").text = data.skinName
	end
end

function PetbookView:_updateChange(selected, objects, allBtn)
	for k, obj in pairs(objects) do
		goutil.findChildComponent(obj.gameObject, "", "UIImageSpriteChange"):SetState(0)
	end

	if selected then
		goutil.findChildComponent(objects[selected].gameObject, "", "UIImageSpriteChange"):SetState(1)
		goutil.findChildComponent(allBtn.gameObject, "", "UIImageSpriteChange"):SetState(0)
	else
		goutil.findChildComponent(allBtn.gameObject, "", "UIImageSpriteChange"):SetState(1)
	end
end

function PetbookView:_tickClickUnit()
	if not self._isTouchedDown then
		if UGUIToolHelper.IsTouchDown() and UGUIToolHelper.IsOverUI() then
			self._isTouchedDown = true
			self._touchDonwPos = UGUIToolHelper.GetTouchPosition()
		end
	elseif UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	end
end

function PetbookView:_onTouchUp()
	self._isTouchedDown = nil

	if not GlobalModel.instance:isTopView(self._viewPresentor) then
		return
	end

	local mousePos = UGUIToolHelper.GetTouchPosition()

	if self._touchDonwPos.x - mousePos.x > 80 then
		self._touchDonwPos = nil

		local newPage = self.page + 2

		if newPage <= self._pages then
			if self._autoFlipScript then
				self._autoFlipScript:FlipRightPage()
			end

			self.page = newPage

			self:_playSound()

			self._turnPageFlag = true

			self:_pageChange(PetbookView.FlipMode.RightToLeft, 1)
		end
	elseif self._touchDonwPos.x - mousePos.x < -80 then
		self._touchDonwPos = nil

		local newPage = self.page - 2

		if newPage > 0 then
			if self._autoFlipScript then
				self._autoFlipScript:FlipLeftPage()
			end

			self.page = newPage

			self:_playSound()

			self._turnPageFlag = true

			self:_pageChange(PetbookView.FlipMode.LeftToRight, 1)
		end
	end
end

function PetbookView:_onClickPet(raceId)
	if self._turnPageFlag then
		return
	end

	PetbookModel.instance:setPage(self.page)
	PetbookModel.instance:setAttrAndRare(self.attr, self.rare)
	PetbookModel.instance:setSkinQuality(self.quality)

	if self._tabIndex == PetbookModel.TAB_PET_RACEID then
		PetbookController.instance:openPetinfoViewNoSetAttr(raceId)
	else
		PetbookController.instance:openSkinViewNoSetAttr(raceId)
	end
end

function PetbookView:_onClickLeftArrow()
	if self._turnPageFlag then
		return
	end

	self._turnPageFlag = true

	if self._autoFlipScript then
		self._autoFlipScript:FlipLeftPage()
	end

	self.page = self.page - 2

	self:_playSound()
	self:_pageChange(PetbookView.FlipMode.LeftToRight, 1)
end

function PetbookView:_onClickRightArrow()
	if self._turnPageFlag then
		return
	end

	self._turnPageFlag = true

	if self._autoFlipScript then
		self._autoFlipScript:FlipRightPage()
	end

	self.page = self.page + 2

	self:_playSound()
	self:_pageChange(PetbookView.FlipMode.RightToLeft, 1)
end

function PetbookView:_onClickAttr(index)
	if self._turnPageFlag then
		return
	end

	self.page = 1
	self.attr = index

	PetbookModel.instance:setAttrAndRare(self.attr, self.rare)
	self:_refreshPetData()
end

function PetbookView:_onClickRare(index)
	if self._turnPageFlag then
		return
	end

	self.page = 1
	self.rare = index

	PetbookModel.instance:setAttrAndRare(self.attr, self.rare)
	self:_refreshPetData()
end

function PetbookView:_onClickQuality(index)
	if self._turnPageFlag then
		return
	end

	self.page = 1
	self.quality = index

	PetbookModel.instance:setSkinQuality(self.quality)
	self:_refreshPetData()
end

function PetbookView:_onClickRefreshPetData()
	self.page = 1

	self:_refreshPetData()
end

function PetbookView:_onClickOverview()
	UIStateManager.instance:push(ViewName.PlotrecallView)
end

function PetbookView:_onClickClose()
	self:_onClearSearchClick()
	self:_resetDataToZero()
	self:close()
end

function PetbookView:_resetDataToZero()
	PetbookController.instance:resetDataToZero()
end

function PetbookView:_pageChange(_mode, _step)
	self:_updataPetCell(_mode, _step)
	goutil.setActive(self._btnLeftArrow.gameObject, self.page > 1)

	local redFlag = false
	local petList = PetbookModel.instance:getPagePet(1, self.page - 1)

	for i, v in ipairs(petList) do
		if self._tabIndex == PetbookModel.TAB_PET_RACEID then
			if HandbookController.instance:getIfCanActiveOrUpgrade(v.raceId) then
				redFlag = true

				break
			end
		else
			local isActive, state = PetbookModel.instance:skinIsActiveAndState(v.skinId)

			if isActive and state then
				redFlag = true

				break
			end
		end
	end

	goutil.setActive(self._btnLeftRed, redFlag)
	goutil.setActive(self._btnRightArrow.gameObject, self.page + 1 < self._pages)

	redFlag = false
	petList = PetbookModel.instance:getPagePet(self.page + 2, self._pages)

	for i, v in ipairs(petList) do
		if self._tabIndex == PetbookModel.TAB_PET_RACEID then
			if HandbookController.instance:getIfCanActiveOrUpgrade(v.raceId) then
				redFlag = true

				break
			end
		else
			local isActive, state = PetbookModel.instance:skinIsActiveAndState(v.skinId)

			if isActive and state then
				redFlag = true

				break
			end
		end
	end

	goutil.setActive(self._btnRightRed, redFlag)

	self._txtLeftPage.text = "第" .. self.page .. "页"
	self._txtRightPage.text = "第" .. self.page + 1 .. "页"

	if self._bookScript then
		self._bookScript.filpPage = self.page
	end
end

function PetbookView:_playSound()
	AudioPlayerEx.instance:playEffect(30218)
end

function PetbookView:_updateRedpoint()
	local rare = {}
	local allPetCfgs = CharacterConfig.instance:getPetCfg()

	goutil.setActive(self._redStrengthen, false)

	for k, v in pairs(allPetCfgs) do
		if checknumber(v.bookIds) ~= 0 and HandbookController.instance:getIfCanActiveOrUpgrade(v.raceId) then
			local petCo = CharacterConfig.instance:getPetCo(v.raceId)

			rare[petCo.rare] = true

			goutil.setActive(self._redStrengthen, true)
		end
	end

	for i = 1, 4 do
		goutil.setActive(self._redpointRare[i], rare[i] or false)
	end
end

function PetbookView:_onClickAllStrength()
	PetManualAgent.instance:sendPetBenefitOneKeyActivateReq()
end

function PetbookView:_onClickSkinOneKey()
	local unActiveSkin = PetbookModel.instance:getUnActiveSkinIds()

	if #unActiveSkin <= 0 then
		FloatWordMgr.instance:show("所有皮肤已激活")

		return
	end

	PetManualAgent.instance:sendPetSkinOneKeyActivateReq()
end

function PetbookView:_oneKeyAllStrength()
	local allPetCfgs = CharacterConfig.instance:getPetCfg()
	local list = {}

	for k, v in pairs(allPetCfgs) do
		local isTip, isActive = HandbookController.instance:getIfCanActiveOrUpgrade(v.raceId)

		if checknumber(v.bookIds) ~= 0 and isTip then
			local temp = {}

			temp.startLv = HandbookModel.instance:getAttributeLevel(v.raceId)

			self:_upgragePetLevel(v.raceId)

			temp.raceId = v.raceId

			table.insert(list, temp)
		end
	end

	HandbookModel.instance:calcHandBookAttr(true)
	self:_updateRedpoint()

	if #list > 0 then
		UIStateManager.instance:push(ViewName.PetBookStrengthView, list)
	else
		FloatWordMgr.instance:show("暂无精灵可以激活/升级")
	end

	self:_pageChange()
	self:_refreshTop()
end

function PetbookView:_upgragePetLevel(raceId)
	local isTip, isActive = HandbookController.instance:getIfCanActiveOrUpgrade(raceId)

	if isTip then
		if isActive then
			local attLevel = HandbookModel.instance:getAttributeLevel(raceId)

			HandbookModel.instance:setAttributeLevel(raceId, attLevel + 1, true)
		else
			HandbookModel.instance:setAttributeLevel(raceId, 0, true)
		end

		self:_upgragePetLevel(raceId)

		return
	end
end

function PetbookView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= PetbookModel.instance:getSearching() then
		PetbookModel.instance:setSearching(text)

		self.page = 1

		self:_refreshPetData()
	end
end

function PetbookView:_onClearSearchClick()
	PetbookModel.instance:setSearching("")

	self._inputSearch.input.text = ""
	self.page = 1

	self:_refreshPetData()
end

function PetbookView:_onClickbtnSort()
	goutil.setActive(self._sortpaneGo, true)
end

function PetbookView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetbookView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	pos.x = pos.x - 100

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_FILES, pos, sizeDelta, GameUtil.handler(self._onClickRefreshPetData, self))
end

function PetbookView:_skinInfoReq()
	PetManualAgent.instance:sendGetSkinManualInfoReq()
end

function PetbookView:_skinRedPoint()
	local unActiveSkin = PetbookModel.instance:getUnActiveSkinIds()
	local isRed = #unActiveSkin > 0

	goutil.setActive(self._petSkinRed, isRed)
	goutil.setActive(self._redSkinOnKey, isRed)

	for i, v in pairs(self._redpointSkinRare) do
		goutil.setActive(v, false)
	end

	for i, v in ipairs(unActiveSkin) do
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(v)
		local red = self._redpointSkinRare[skinCfg.quality]

		if red then
			goutil.setActive(red, true)
		end
	end
end

function PetbookView:showEffect(name)
	goutil.setActive(self._animMask, true)

	local effect = UIEffectManager.instance:playEffect(self, string.format("20230120/shu/%s.prefab", name), self._bookAnim.transform, 0, 0, false, false, function()
		goutil.setActive(self._animMask, false)
	end)

	effect:setParent(self._bookAnim.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
end

function PetbookView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._sortpaneGo, false)
	end
end

function PetbookView:_onClickSortCell(sortType)
	PetbookModel.instance:setCurrSortType(sortType)

	local isDefault = sortType == PetbookController.SortType.Default
	local isSameType = self._curSortType == sortType

	if isSameType and not isDefault or not isSameType and not isDefault then
		local index = PetbookModel.instance:getSortTypeIndex(sortType)

		PetbookModel.instance:addSortTypeIndex(sortType, index)
	end

	self._curSortType = sortType

	self:_updateSortCellState()
	self:_refreshPetData()
end

function PetbookView:_sortShowPets(pets)
	local index = PetbookModel.instance:getSortTypeIndex(self._curSortType)

	if index == PetbookModel.SortTypeIndex.Default then
		return PetbookModel.instance:getPagePet(self.page, 2)
	end

	if self._curSortType == PetbookController.SortType.Awaken then
		local raceId_awakenLv = {}

		for i, v in ipairs(pets) do
			raceId_awakenLv[v.raceId] = BagModel.instance:getMaxAwakenLv(v.raceId)
		end

		if index == PetbookModel.SortTypeIndex.Down then
			table.sort(pets, function(a, b)
				return raceId_awakenLv[a.raceId] > raceId_awakenLv[b.raceId]
			end)
		elseif index == PetbookModel.SortTypeIndex.Up then
			table.sort(pets, function(a, b)
				return raceId_awakenLv[a.raceId] < raceId_awakenLv[b.raceId]
			end)
		end
	else
		pets = PetbookModel.instance:getPagePet(self.page, 2)
	end

	return pets
end

function PetbookView:_updatePetsSortShow()
	for i = 1, PetbookModel.MAXPERPAGE * 2 do
		self:_updataPetCellSingle(i)
	end
end

function PetbookView:_updateSortCellState()
	for k, v in pairs(self._sortCells) do
		local index = PetbookModel.instance:getSortTypeIndex(v.sortType)

		v.imgSort:SetState(index)

		if v.sortType == self._curSortType then
			local detail = PetbookController.SortTypeDetail[v.sortType]

			self._txtBtnSort.text = detail.name

			self._imgSort:SetState(index)
		end
	end
end

return PetbookView

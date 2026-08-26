-- chunkname: @modules/logic/room/view/RoomInitBuildingViewChange.lua

module("modules.logic.room.view.RoomInitBuildingViewChange", package.seeall)

local RoomInitBuildingViewChange = class("RoomInitBuildingViewChange", BaseView)

function RoomInitBuildingViewChange:onInitView()
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_part/#go_change")
	self._goCategory = gohelper.findChild(self.viewGO, "left/#scroll_catagory")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingViewChange:addEvents()
	self._btncoin:AddClickListener(self._btncoinOnClick, self)
	self._inputvalue:AddOnValueChanged(self._onValueChanged, self)
	self._btnnoformula:AddClickListener(self._btnnoformulaOnClick, self)
	self._btncombine:AddClickListener(self._btncombineOnClick, self)
	self._btnproduct:AddClickListener(self._btnproductOnClick, self)

	local timeMatrix = {}

	timeMatrix[1] = 0.5

	for i = 2, RoomBuildingEnum.MachineSlotMaxCount do
		local time = 0.7 * timeMatrix[i - 1]

		time = math.max(time, 0.1)

		table.insert(timeMatrix, time)
	end

	self._subPress = SLFramework.UGUI.UILongPressListener.Get(self._gosub)

	self._subPress:SetLongPressTime(timeMatrix)
	self._subPress:AddLongPressListener(self._subLongPressTimeEnd, self)

	self._subClick = SLFramework.UGUI.UIClickListener.Get(self._gosub)

	self._subClick:AddClickListener(self._subClickOnClick, self)
	self._subClick:AddClickUpListener(self._subClickUp, self)

	self._addPress = SLFramework.UGUI.UILongPressListener.Get(self._goadd)

	self._addPress:SetLongPressTime(timeMatrix)
	self._addPress:AddLongPressListener(self._addLongPressTimeEnd, self)

	self._addClick = SLFramework.UGUI.UIClickListener.Get(self._goadd)

	self._addClick:AddClickListener(self._addClickOnClick, self)
	self._addClick:AddClickUpListener(self._addClickUp, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.StartProductionLineReply, self._startProductionLine, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, self._refreshNeedTag, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._onSelectFormulaIdChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, self._onShowInitBuildingChangeTitle, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refresh, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.RefreshNeedFormula, self._refreshNeedTag, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refresh, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.JumpBtnClick, self._onJumpBtnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function RoomInitBuildingViewChange:removeEvents()
	self._btncoin:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()
	self._btnnoformula:RemoveClickListener()
	self._btncombine:RemoveClickListener()
	self._btnproduct:RemoveClickListener()
	self._subPress:RemoveLongPressListener()
	self._subClick:RemoveClickListener()
	self._subClick:RemoveClickUpListener()
	self._addPress:RemoveLongPressListener()
	self._addClick:RemoveClickListener()
	self._addClick:RemoveClickUpListener()
	self.removeEventCb(self, RoomController.instance, RoomEvent.StartProductionLineReply, self._startProductionLine, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, self._refreshNeedTag, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._onSelectFormulaIdChanged, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, self._onShowInitBuildingChangeTitle, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refresh, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.RefreshNeedFormula, self._refreshNeedTag, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refresh, self)
	self.removeEventCb(self, JumpController.instance, JumpEvent.JumpBtnClick, self._onJumpBtnClick, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function RoomInitBuildingViewChange:_onJumpBtnClick(jumpId)
	if self.viewParam and self.viewParam.openInOutside then
		local jumpView = JumpConfig.instance:getJumpView(jumpId)

		if jumpView ~= JumpEnum.JumpView.RoomProductLineView and jumpView ~= JumpEnum.JumpView.StoreView then
			self:closeThis()
		end
	end
end

function RoomInitBuildingViewChange:_btncoinOnClick()
	local recordFarmItem = {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	}

	if self._toatalNeedSocre and self._toatalNeedSocre > 0 then
		recordFarmItem.quantity = self._toatalNeedSocre
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, nil, nil, nil, recordFarmItem)
end

function RoomInitBuildingViewChange:_btncombineOnClick()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if self.isEasyCombine then
		local produceItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

		if not produceItem then
			return
		end

		local result, costItemAndFormulaIdList = RoomProductionHelper.getEasyCombineFormulaAndCostItemList(formulaId, count)

		if result then
			local lineId = self.viewContainer:getSelectLine()
			local produceItemData = {
				type = produceItem.type,
				id = produceItem.id,
				quantity = count
			}

			RoomProductionHelper.openRoomFormulaMsgBoxView(costItemAndFormulaIdList, {
				produceItemData
			}, lineId, self.setStartFormulaStrId, self)
		else
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)
		end
	else
		local isEnoughCoin = RoomProductionHelper.isEnoughCoin(formulaId, count)

		if not isEnoughCoin then
			GameFacade.showToast(ToastEnum.RoomFormulaNotEnoughCoin)

			return
		end

		local isEnoughMat = RoomProductionHelper.isEnoughMaterial(formulaId, count)

		if not isEnoughMat then
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)

			return
		end

		local selectLineId = self.viewContainer:getSelectLine()
		local lineMO = RoomProductionModel.instance:getLineMO(selectLineId)

		PopupController.instance:setPause("roominitbuildingview_changestart", true)
		UIBlockMgr.instance:startBlock("roominitbuildingview_changestart")
		self:setStartFormulaStrId()
		RoomRpc.instance:sendStartProductionLineRequest(lineMO.id, {
			{
				formulaId = formulaId,
				count = count
			}
		})
	end
end

function RoomInitBuildingViewChange:_btnproductOnClick()
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

		if formulaId and formulaId ~= 0 then
			local produceItemItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

			if produceItemItem then
				local selectFormulaMo = RoomFormulaListModel.instance:getSelectFormulaMo()
				local selectFormulaStrId = selectFormulaMo and selectFormulaMo:getId()
				local needQuantity = RoomProductionHelper.getFormulaNeedQuantity(selectFormulaStrId)

				if not needQuantity or needQuantity <= 0 then
					needQuantity = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
				end

				local recordFarmItem = {
					type = produceItemItem.type,
					id = produceItemItem.id,
					quantity = needQuantity,
					sceneType = GameSceneMgr.instance:getCurSceneType(),
					openedViewNameList = JumpController.instance:getCurrentOpenedView()
				}

				MaterialTipController.instance:showMaterialInfo(produceItemItem.type, produceItemItem.id, nil, nil, nil, recordFarmItem, nil, needQuantity, true, self.jumpFinishCallback, self)
			end
		end
	end

	self:_openSelectFormulaView()
end

function RoomInitBuildingViewChange:jumpFinishCallback()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormulaItem)
end

function RoomInitBuildingViewChange:_btnitemOnClick(index)
	local materialItem = self._materialItemList[index]

	if materialItem and materialItem.costItem then
		if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
			if not materialItem.isEmpty then
				materialItem.costItem:_onClick(true)
			end
		else
			self:_openSelectFormulaView()
		end
	else
		self:_openSelectFormulaView()
	end
end

function RoomInitBuildingViewChange:_openSelectFormulaView()
	local selectLineId = self.viewContainer:getSelectLine()
	local lineMO = RoomProductionModel.instance:getLineMO(selectLineId)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		local var_10_0 = {
			lineMO = lineMO,
			buildingType = RoomBuildingEnum.FormulaBuildingType.Change
		}

		var_10_0.openInOutside = self.viewParam and self.viewParam.openInOutside

		ViewMgr.instance:openView(ViewName.RoomFormulaView, var_10_0)
	end

	self:_setTitleAndCategoryVisibility(false)
end

function RoomInitBuildingViewChange:_subLongPressTimeEnd()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if self._blockLongPress then
		return
	end

	local isLongPress = self._isLongPress

	self._isLongPress = true

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local success = self:_trySetCount(count - 1, true)

	if not isLongPress and success then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomInitBuildingViewChange:_subClickOnClick()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local success = self:_trySetCount(count - 1, true)

	if success then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomInitBuildingViewChange:_subClickUp()
	self._blockLongPress = false
	self._isLongPress = false
end

function RoomInitBuildingViewChange:_addLongPressTimeEnd()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if self._blockLongPress then
		return
	end

	if not self._isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	local isLongPress = self._isLongPress

	self._isLongPress = true

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local success = self:_trySetCount(count + 1, true, true)

	if not isLongPress and success then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomInitBuildingViewChange:_addClickOnClick()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local success = self:_trySetCount(count + 1, true, true)

	if success then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomInitBuildingViewChange:_addClickUp()
	self._blockLongPress = false
	self._isLongPress = false
end

function RoomInitBuildingViewChange:_onValueChanged(inputStr)
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()

	if not formulaId or formulaId == 0 then
		return
	end

	local tryCount = tonumber(inputStr)

	if tryCount then
		self:_trySetCount(tryCount, true)
	else
		self:_trySetCount(1, true)
	end
end

function RoomInitBuildingViewChange:_btnnoformulaOnClick()
	GameFacade.showToast(ToastEnum.RoomInitBuildingToast)
end

function RoomInitBuildingViewChange:_onSelectFormulaIdChanged(preFormulaStrId)
	local selectFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if preFormulaStrId ~= selectFormulaStrId then
		local resetCount = true

		if not string.nilorempty(selectFormulaStrId) then
			local selectFormulaMO = RoomFormulaModel.instance:getFormulaMo(selectFormulaStrId)
			local isTopFormula = not selectFormulaMO:isTreeFormula()
			local isExpand = selectFormulaMO:getIsExpandTree()

			resetCount = isTopFormula and not isExpand
		end

		if not preFormulaStrId or resetCount then
			self:_resetCount()
		end
	end

	self:_refreshFormula()

	if selectFormulaStrId then
		gohelper.setActive(self._gobgvx, false)
		gohelper.setActive(self._gobgvx, true)
	end
end

function RoomInitBuildingViewChange:_startProductionLine()
	RoomMapController.instance:dispatchEvent(RoomEvent.OnChangePartStart, self._startFormulaStrId)
	PopupController.instance:setPause("roominitbuildingview_changestart", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changestart")
	self:_resetCount()
	self:_refreshFormula()
	gohelper.setActive(self._gohechengeffect, false)
	gohelper.setActive(self._gohechengeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_fountain_mix)
end

function RoomInitBuildingViewChange:_onShowInitBuildingChangeTitle()
	self:_setTitleAndCategoryVisibility(true)
end

function RoomInitBuildingViewChange:_onOpenView(viewName)
	if viewName == ViewName.RoomFormulaView then
		self:_setTitleAndCategoryVisibility(false)
	end
end

function RoomInitBuildingViewChange:_setTitleAndCategoryVisibility(isVisible)
	self.viewContainer:setIsShowTitle(isVisible)
	gohelper.setActive(self._goCategory, isVisible)
end

function RoomInitBuildingViewChange:_editableInitView()
	self._gocombine3 = gohelper.findChild(self._gochange, "combine/#go_combine3")
	self._goproduct = gohelper.findChild(self._gochange, "go_product")
	self._simageproducticon = gohelper.findChildSingleImage(self._gochange, "combine/combineproduct/go_product/simage_producticon")
	self._imageproductrare = gohelper.findChildImage(self._gochange, "combine/combineproduct/go_product/image_productrare")
	self._inputvalue = gohelper.findChildTextMeshInputField(self._gochange, "go_product/productnum/valuebg/input_value")
	self._btnnoformula = gohelper.findChildButtonWithAudio(self._gochange, "go_product/productnum/valuebg/btn_noformula")
	self._gosub = gohelper.findChild(self._gochange, "go_product/productnum/sub/go_sub")
	self._goadd = gohelper.findChild(self._gochange, "go_product/productnum/add/go_add")
	self._txtgold = gohelper.findChildText(self._gochange, "combine/go_combine3/itemcoin/go_gooditem/countbg/txt_gold")
	self._goempty = gohelper.findChild(self._gochange, "combine/go_combine3/itemcoin/go_empty")
	self._gogooditem = gohelper.findChild(self._gochange, "combine/go_combine3/itemcoin/go_gooditem")
	self._btncoin = gohelper.findChildButtonWithAudio(self._gochange, "combine/go_combine3/itemcoin/btn_coin")
	self._btnproduct = gohelper.findChildButtonWithAudio(self._gochange, "combine/combineproduct/btn_product")
	self._goproducticon = gohelper.findChild(self._gochange, "combine/combineproduct/btn_product/icon")
	self._goproductadd = gohelper.findChild(self._gochange, "combine/combineproduct/go_add")
	self._goCanCombine = gohelper.findChild(self._gochange, "combine/combineproduct/#go_Mix")
	self._txtCanCombine = gohelper.findChildText(self._gochange, "combine/combineproduct/#go_Mix/#txt_Mix")
	self._btncombine = gohelper.findChildButton(self._gochange, "go_product/btn_combine")
	self._golevelupbeffect = gohelper.findChild(self._gochange, "go_product/btn_combine/#go_levelupbeffect")
	self._txtCombine = gohelper.findChildText(self._gochange, "go_product/btn_combine/textcn")
	self._simagecombinebg = gohelper.findChildSingleImage(self._gochange, "combine/go_combine3/#simage_combinebg")
	self._gocoinitempos = gohelper.findChild(self._gochange, "combine/go_combine3/itemcoin/go_gooditem/go_gooditempos")
	self._txtNeed = gohelper.findChildText(self._gochange, "go_product/#txt_NeedProp")
	self._gobgvx = gohelper.findChild(self._gochange, "combine/go_combine3/#bgvx")
	self._gohechengeffect = gohelper.findChild(self._gochange, "combine/#hechengeffect")

	self._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))
	gohelper.addUIClickAudio(self._btnproduct.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

	self._materialItemList = {}

	for i = 1, 3 do
		local materialItem = self:getUserDataTb_()

		materialItem.go = gohelper.findChild(self._gochange, "combine/go_combine3/item" .. i)
		materialItem.goempty = gohelper.findChild(materialItem.go, "go_empty")
		materialItem.gogooditem = gohelper.findChild(materialItem.go, "go_gooditem")
		materialItem.gogooditempos = gohelper.findChild(materialItem.go, "go_gooditem/go_gooditempos")
		materialItem.txtcount = gohelper.findChildText(materialItem.go, "go_gooditem/countbg/txt_count")
		materialItem.btnitem = gohelper.findChildButtonWithAudio(materialItem.go, "btn_item")

		materialItem.btnitem:AddClickListener(function(self)
			self:_btnitemOnClick(i)
		end, self)
		gohelper.addUIClickAudio(materialItem.btnitem.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

		materialItem.isEmpty = false

		table.insert(self._materialItemList, materialItem)
	end

	self._coinItem = IconMgr.instance:getRoomGoodsItem(self._gocoinitempos, self.viewContainer)

	self._coinItem:canShowRareCircle(false)
	self._coinItem:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, 0)
	self._coinItem:isEnableClick(false)
	self._coinItem:isShowCount(false)
	self._coinItem:setRecordFarmItem(true)
	self._coinItem:setConsume(true)
	RoomBuildingFormulaController.instance:resetSelectFormulaStrId()
end

function RoomInitBuildingViewChange:onOpen()
	self:_refresh()

	if self.viewParam and self.viewParam.showFormulaView then
		self.viewContainer:setSelectLine(7)
		self:_openSelectFormulaView()
	end
end

function RoomInitBuildingViewChange:_refresh()
	self:_refreshFormula()
end

function RoomInitBuildingViewChange:_refreshFormula()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()
	local isSelect = formulaId and formulaId ~= 0

	self._inputvalue.inputField.interactable = isSelect

	gohelper.setActive(self._btnnoformula.gameObject, not isSelect)
	gohelper.setActive(self._goproducticon.gameObject, isSelect)

	if isSelect then
		self:_refreshSelect()
	else
		self:_refreshEmpty()
	end

	self:_refreshNeedTag()
	self:_refreshCombineBtn()
	self:_refreshInputField()
end

function RoomInitBuildingViewChange:_refreshSelect()
	self:_refreshProduce()
	self:_refreshCostCoinCount()
	self:_refreshCostMaterial()
end

function RoomInitBuildingViewChange:_refreshCostCoinCount()
	local costScore = 0
	local ownScoreQuantity = 0
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()
	local costCoinItemList = RoomProductionHelper.getCostCoinItemList(formulaId)
	local costCoinItem = costCoinItemList[1]

	if costCoinItem then
		costScore = costCoinItem.quantity or 0
		ownScoreQuantity = ItemModel.instance:getItemQuantity(costCoinItem.type, costCoinItem.id)
	end

	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local totalNeedScore = costScore * count

	self._txtgold.text = ownScoreQuantity < totalNeedScore and string.format("<color=#d97373>%s</color>", totalNeedScore) or GameUtil.numberDisplay(totalNeedScore)
	self._toatalNeedSocre = totalNeedScore

	gohelper.setActive(self._gogooditem, totalNeedScore > 0)
	gohelper.setActive(self._goempty, totalNeedScore <= 0)
end

function RoomInitBuildingViewChange:_refreshCostMaterial()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()
	local count = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local costItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	for i = 1, math.min(#costItemList, #self._materialItemList) do
		local costItem = costItemList[i]
		local materialItem = self._materialItemList[i]

		if materialItem then
			materialItem.costItem = materialItem.costItem or IconMgr.instance:getRoomGoodsItem(materialItem.gogooditempos, self.viewContainer)

			materialItem.costItem:canShowRareCircle(false)
			materialItem.costItem:setMOValue(costItem.type, costItem.id, costItem.quantity * count)
			materialItem.costItem:isEnableClick(false)
			materialItem.costItem:isShowCount(false)
			materialItem.costItem:setRecordFarmItem(true)
			materialItem.costItem:setConsume(true)
			materialItem.costItem:setJumpFinishCallback(self.jumpFinishCallback, self)

			local ownQuantity = ItemModel.instance:getItemQuantity(costItem.type, costItem.id)
			local totalNeedQuantity = costItem.quantity * count

			if ownQuantity < totalNeedQuantity then
				materialItem.txtcount.text = string.format("<color=#d97373>%s/%s</color>", ownQuantity, totalNeedQuantity)

				materialItem.costItem:setGrayscale(true)
			else
				materialItem.txtcount.text = string.format("%s/%s", RoomProductionHelper.formatItemNum(ownQuantity), totalNeedQuantity)

				materialItem.costItem:setGrayscale(false)
			end

			materialItem.isEmpty = false

			gohelper.setActive(materialItem.go, true)
			gohelper.setActive(materialItem.goempty, false)
			gohelper.setActive(materialItem.gogooditem, true)
		end
	end

	for i = math.min(#costItemList, #self._materialItemList) + 1, #self._materialItemList do
		local materialItem = self._materialItemList[i]

		materialItem.isEmpty = true

		gohelper.setActive(materialItem.go, true)
		gohelper.setActive(materialItem.goempty, true)
		gohelper.setActive(materialItem.gogooditem, false)
	end
end

function RoomInitBuildingViewChange:_refreshProduce()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()
	local produceItemItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

	gohelper.setActive(self._simageproducticon.gameObject, produceItemItem)
	gohelper.setActive(self._imageproductrare.gameObject, produceItemItem)
	gohelper.setActive(self._goproductadd, produceItemItem == nil)

	if produceItemItem then
		local config, icon = ItemModel.instance:getItemConfigAndIcon(produceItemItem.type, produceItemItem.id)

		self._simageproducticon:LoadImage(icon)
		UISpriteSetMgr.instance:setRoomSprite(self._imageproductrare, "huangyuan_pz_" .. CharacterEnum.Color[config.rare])
	end
end

function RoomInitBuildingViewChange:_refreshEmpty()
	self._inputvalue:SetText(tostring(0))
	gohelper.setActive(self._simageproducticon.gameObject, false)
	gohelper.setActive(self._imageproductrare.gameObject, false)
	gohelper.setActive(self._goproductadd, true)

	for _, materialItem in ipairs(self._materialItemList) do
		gohelper.setActive(materialItem.go, true)
		gohelper.setActive(materialItem.goempty, true)
		gohelper.setActive(materialItem.gogooditem, false)
	end

	gohelper.setActive(self._goempty, true)
	gohelper.setActive(self._gogooditem, false)
end

function RoomInitBuildingViewChange:_refreshNeedTag()
	local langId, ownQuantity, needQuantity
	local selectFormulaMo = RoomFormulaListModel.instance:getSelectFormulaMo()

	if selectFormulaMo then
		local selectFormulaStrId = selectFormulaMo:getId()
		local formulaId = selectFormulaMo:getFormulaId()

		needQuantity = RoomProductionHelper.getFormulaNeedQuantity(selectFormulaStrId)

		local produceItemParam = RoomProductionHelper.getFormulaProduceItem(formulaId)

		if produceItemParam then
			ownQuantity = ItemModel.instance:getItemQuantity(produceItemParam.type, produceItemParam.id)
		end

		local isTreeFormula = selectFormulaMo:isTreeFormula()

		langId = isTreeFormula and "room_formula_need_desc2" or "room_formula_need_desc3"
	end

	if ownQuantity and needQuantity and langId and needQuantity ~= 0 then
		local ownNumDisplay = GameUtil.numberDisplay(ownQuantity)
		local needNumDisplay = GameUtil.numberDisplay(needQuantity)
		local strShowQuantity = string.format("<color=%s>%s</color>/%s", (needQuantity <= ownQuantity or nil) and "#81ce83", ownNumDisplay, needNumDisplay)

		self._txtNeed.text = formatLuaLang(langId, strShowQuantity)

		gohelper.setActive(self._txtNeed.gameObject, true)
	else
		gohelper.setActive(self._txtNeed.gameObject, false)
	end
end

function RoomInitBuildingViewChange:_refreshCombineBtn()
	local formulaId = RoomFormulaListModel.instance:getSelectFormulaId()
	local hasCombineNum = false
	local totalCanCombineNum = 0

	if formulaId and formulaId ~= 0 then
		totalCanCombineNum = RoomProductionHelper.getTotalCanCombineNum(formulaId)
		hasCombineNum = totalCanCombineNum ~= 0
	end

	local canCombineDirectly = false
	local langId = "room_formula_combine"
	local canCombine = false

	if hasCombineNum then
		local numDisplay = GameUtil.numberDisplay(totalCanCombineNum)

		self._txtCanCombine.text = formatLuaLang("room_formula_can_combine", numDisplay)

		local selectCombineCount = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
		local isEnoughCoin = RoomProductionHelper.isEnoughCoin(formulaId, selectCombineCount)
		local isEnoughMat = RoomProductionHelper.isEnoughMaterial(formulaId, selectCombineCount)

		canCombineDirectly = isEnoughCoin and isEnoughMat

		if canCombineDirectly then
			canCombine = true
		elseif selectCombineCount <= totalCanCombineNum then
			canCombine = true
			langId = "room_formula_easy_combine"
		end
	end

	self._txtCombine.text = luaLang(langId)
	self.isEasyCombine = not canCombineDirectly

	gohelper.setActive(self._goCanCombine, hasCombineNum)
	gohelper.setActive(self._golevelupbeffect, canCombine)
	ZProj.UGUIHelper.SetGrayscale(self._btncombine.gameObject, not canCombine)
end

function RoomInitBuildingViewChange:_refreshInputField()
	local formulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(formulaStrId) then
		return
	end

	local selectCombineCount = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	self._inputvalue:RemoveOnValueChanged()
	self._inputvalue:SetText(tostring(selectCombineCount))
	self._inputvalue:AddOnValueChanged(self._onValueChanged, self)
end

function RoomInitBuildingViewChange:setStartFormulaStrId()
	self._startFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()
end

function RoomInitBuildingViewChange:_resetCount()
	local formulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(formulaStrId) then
		return
	end

	local formulaMO = RoomFormulaModel.instance:getFormulaMo(formulaStrId)

	if formulaMO then
		formulaMO:resetFormulaCombineCount()
	end
end

function RoomInitBuildingViewChange:_trySetCount(tryCount, isManual, effect)
	local formulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(formulaStrId) then
		return
	end

	local success = true
	local count = math.max(1, tryCount)

	if count >= 0 and count > RoomBuildingEnum.MachineSlotMaxCount then
		count = RoomBuildingEnum.MachineSlotMaxCount

		if isManual and not self._blockLongPress then
			GameFacade.showToast(ToastEnum.RoomInitBuildingSetCount)

			success = false
		end

		self:_setBlockLongPress()
	end

	local preCount = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if preCount < count and effect then
		gohelper.setActive(self._gobgvx, false)
		gohelper.setActive(self._gobgvx, true)
	end

	local formulaMO = RoomFormulaModel.instance:getFormulaMo(formulaStrId)

	if formulaMO then
		formulaMO:setFormulaCombineCount(count)
	end

	self:_refreshFormula()

	return success
end

function RoomInitBuildingViewChange:_setBlockLongPress()
	if self._isLongPress then
		self._blockLongPress = true
	end
end

function RoomInitBuildingViewChange:onClose()
	JumpModel.instance:clearRecordFarmItem()
end

function RoomInitBuildingViewChange:onDestroyView()
	PopupController.instance:setPause("roominitbuildingview_changestart", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changestart")

	for _, materialItem in ipairs(self._materialItemList) do
		materialItem.btnitem:RemoveClickListener()
	end

	self._simageproducticon:UnLoadImage()
	self._simagecombinebg:UnLoadImage()
end

return RoomInitBuildingViewChange

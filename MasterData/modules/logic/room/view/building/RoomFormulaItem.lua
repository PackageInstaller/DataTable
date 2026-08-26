-- chunkname: @modules/logic/room/view/building/RoomFormulaItem.lua

module("modules.logic.room.view.building.RoomFormulaItem", package.seeall)

local RoomFormulaItem = class("RoomFormulaItem", ListScrollCellExtend)

function RoomFormulaItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/layout/#txt_name")
	self._goitem = gohelper.findChild(self.viewGO, "#go_normal/materials/#go_coinitem/#go_item")
	self._imagecoinRare = gohelper.findChildImage(self.viewGO, "#go_normal/materials/#go_coinitem/#go_item/image_coinRare")
	self._simagecoinIcon = gohelper.findChildSingleImage(self.viewGO, "#go_normal/materials/#go_coinitem/#go_item/simage_coinIcon")
	self._txtgold = gohelper.findChildText(self.viewGO, "#go_normal/materials/#go_coinitem/#txt_gold")
	self._goempty = gohelper.findChild(self.viewGO, "#go_normal/materials/#go_coinitem/#go_empty")
	self._txtCombineNum = gohelper.findChildText(self.viewGO, "#go_normal/layout/itemNum/#txt_num")
	self._simageproduceitem = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_produceitem")
	self._gomaterialitem = gohelper.findChild(self.viewGO, "#go_normal/materials/#go_materialitem")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._golockitem = gohelper.findChildText(self.viewGO, "#go_lock/locklayout/#go_lockitem")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_lock/#txt_lock")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_normal/raremask/#image_rare")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_click")
	self._btncoin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/materials/#go_coinitem/#go_item/#btn_coin")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lock/#btn_lock")
	self._goNeedTag = gohelper.findChild(self.viewGO, "#go_normal/#go_TagNeed")
	self._goOwnNum = gohelper.findChild(self.viewGO, "#go_normal/itemNum")
	self._txtOwnNum = gohelper.findChildText(self.viewGO, "#go_normal/itemNum/#txt_num")
	self._goNeed = gohelper.findChild(self.viewGO, "#go_normal/layout/#go_Need")
	self._goCanCombine = gohelper.findChild(self.viewGO, "#go_normal/layout/#go_Mix")
	self._txtCanCombine = gohelper.findChildText(self.viewGO, "#go_normal/layout/#go_Mix/#txt_Mix")
	self._gonormalTrs = self._gonormal.transform
	self._golockTrs = self._golock.transform

	gohelper.setActive(self._goNeed, false)
	gohelper.setActive(self._goOwnNum, false)
	gohelper.setActive(self._goCanCombine, false)

	self._animator = self.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	self._lineAnimator = self._gonormal:GetComponent(RoomEnum.ComponentType.Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFormulaItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btncoin:AddClickListener(self._btncoinOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, self._onFormulaCombineCountRefresh, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, self._onHideAnimAnimation, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, self._onShowAnimAnimation, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, self._onMoveAnimAnimation, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, self._refreshUI, self)
end

function RoomFormulaItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btncoin:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, self._onFormulaCombineCountRefresh, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, self._onHideAnimAnimation, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, self._onShowAnimAnimation, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, self._onMoveAnimAnimation, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, self._refreshUI, self)
end

function RoomFormulaItem:_btnclickOnClick()
	if self._unlock then
		local formulaStrId = self._mo:getId()
		local treeLevel = self._mo:getFormulaTreeLevel()

		RoomBuildingFormulaController.instance:setSelectFormulaStrId(formulaStrId, nil, treeLevel)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
	else
		self:_btnlockOnClick()
	end
end

function RoomFormulaItem:_btncoinOnClick()
	if not self._unlock then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, false, nil, false, {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		quantity = self.costScore,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function RoomFormulaItem:_btnlockOnClick()
	local formulaId = self._mo:getFormulaId()
	local _, needRoomLevel, needProductionLevel, needEpisodeId = RoomProductionHelper.isFormulaUnlock(formulaId, self._lineMO.level)

	if needRoomLevel then
		GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, needRoomLevel)
	elseif needProductionLevel then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, self._lineMO.config.name, needProductionLevel)
	elseif needEpisodeId then
		GameFacade.showToast(ToastEnum.ClickRoomFormula)
	end
end

function RoomFormulaItem:_onFormulaCombineCountRefresh(formulaStrId)
	local curFormulaStrId = self._mo:getId()

	if formulaStrId == curFormulaStrId then
		self:_refreshCoinCount()
		self:_refreshMaterialItemCount()
	end
end

function RoomFormulaItem:_onChangePartStart(formulaStrId)
	local curFormulaStrId = self._mo:getId()

	if formulaStrId == curFormulaStrId then
		gohelper.setActive(self._gosynthesis, false)
		gohelper.setActive(self._gosynthesis, true)
	end
end

function RoomFormulaItem:_editableInitView()
	self._materialItemList = {}

	gohelper.setActive(self._gomaterialitem, false)

	self._maxMaterialItemCount = 3

	for i = 1, self._maxMaterialItemCount do
		local materialItem = self:getUserDataTb_()

		materialItem.go = gohelper.cloneInPlace(self._gomaterialitem, "item" .. i)
		materialItem.goitem = gohelper.findChild(materialItem.go, "go_item")
		materialItem.gopos = gohelper.findChild(materialItem.go, "go_item/go_pos")
		materialItem.txtnum = gohelper.findChildText(materialItem.go, "go_item/txt_num")
		materialItem.goempty = gohelper.findChild(materialItem.go, "go_empty")

		table.insert(self._materialItemList, materialItem)
		gohelper.setActive(materialItem.go, true)
	end

	self._canvasGroup = self._gonormal:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.removeUIClickAudio(self._btnclick.gameObject)

	self._gosynthesis = gohelper.findChild(self.viewGO, "#go_normal/#synthesis")
	self._treeLevelItemList = {}

	for i = 1, RoomFormulaModel.MAX_FORMULA_TREE_LEVEL do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "#go_normal/#go_BG" .. i)
		item.goSelect = gohelper.findChild(item.go, "#go_Select")
		item.lineT = gohelper.findChild(item.go, "#go_LineT")
		item.lineTNo = gohelper.findChild(item.go, "#go_LineT/normal")
		item.lineTHL = gohelper.findChild(item.go, "#go_LineT/highlight")
		item.lineL = gohelper.findChild(item.go, "#go_LineL")
		item.lineLNo = gohelper.findChild(item.go, "#go_LineL/normal")
		item.lineLHL = gohelper.findChild(item.go, "#go_LineL/highlight")
		item.lineI1 = gohelper.findChild(item.go, "#go_LineI1")
		item.lineI1No = gohelper.findChild(item.go, "#go_LineI1/normal")
		item.lineI1HL = gohelper.findChild(item.go, "#go_LineI1/highlight")
		item.lineI2 = gohelper.findChild(item.go, "#go_LineI2")
		item.lineI2No = gohelper.findChild(item.go, "#go_LineI2/normal")
		item.lineI2HL = gohelper.findChild(item.go, "#go_LineI2/highlight")

		table.insert(self._treeLevelItemList, item)
	end
end

function RoomFormulaItem:_editableAddEvents()
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._refreshSelect, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.OnChangePartStart, self._onChangePartStart, self)
end

function RoomFormulaItem:_editableRemoveEvents()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshUI, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshUI, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._refreshSelect, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.OnChangePartStart, self._onChangePartStart, self)
end

function RoomFormulaItem:onUpdateMO(mo)
	self._lineMO = self._view.viewParam.lineMO
	self._callback = self._view.viewParam.callback
	self._callbackObj = self._view.viewParam.callbackObj
	self._mo = mo

	self:_refreshUI()
	self:_refreshSelect()
	self:_checkAnimation()
	gohelper.setActive(self._gosynthesis, false)
end

function RoomFormulaItem:_refreshSelect(preFormulaStrId)
	local curFormulaStrId = self._mo:getId()

	if preFormulaStrId and curFormulaStrId == preFormulaStrId then
		self:_refreshCoinCount()
		self:_refreshMaterialItemCount()
	end

	local selectFormulaId = RoomFormulaListModel.instance:getSelectFormulaStrId()
	local formulaTreeLevel = self._mo:getFormulaTreeLevel()

	if self._treeLevelItemList[formulaTreeLevel] then
		gohelper.setActive(self._treeLevelItemList[formulaTreeLevel].goSelect, selectFormulaId == curFormulaStrId)
	end
end

function RoomFormulaItem:_refreshUI()
	local needRoomLevel, needProductionLevel, needEpisodeId
	local formulaId = self._mo:getFormulaId()

	self._unlock, needRoomLevel, needProductionLevel, needEpisodeId = RoomProductionHelper.isFormulaUnlock(formulaId, self._lineMO.level)

	if not self._unlock then
		self:_refreshLockText(needRoomLevel, needProductionLevel, needEpisodeId)
	end

	self._canvasGroup.alpha = self._unlock and 1 or 0.2

	gohelper.setActive(self._golock, not self._unlock)
	ZProj.UGUIHelper.SetColorAlpha(self._simageproduceitem.gameObject:GetComponent(gohelper.Type_Image), self._unlock and 1 or 0.5)
	UISpriteSetMgr.instance:setRoomSprite(self._imagecoinRare, "bg_wupindi_3")
	self._simagecoinIcon:LoadImage(ResUrl.getCurrencyItemIcon("203"))

	local costItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	for i = 1, math.min(self._maxMaterialItemCount, #costItemList) do
		local costItemParam = costItemList[i]
		local materialItem = self._materialItemList[i]

		materialItem.costItem = materialItem.costItem or IconMgr.instance:getRoomGoodsItem(materialItem.gopos, ViewMgr.instance:getContainer(ViewName.RoomFormulaView))

		materialItem.costItem:canShowRareCircle(false)
		materialItem.costItem:setMOValue(costItemParam.type, costItemParam.id, costItemParam.quantity)
		materialItem.costItem:isEnableClick(true)
		materialItem.costItem:isShowCount(false)
		materialItem.costItem:setRecordFarmItem(true)
		materialItem.costItem:setConsume(true)
		materialItem.costItem:setJumpFinishCallback(self.jumpFinishCallback, self)
		gohelper.setActive(materialItem.goitem, true)
		gohelper.setActive(materialItem.goempty, false)
	end

	for i = math.min(self._maxMaterialItemCount, #costItemList) + 1, #self._materialItemList do
		local materialItem = self._materialItemList[i]

		gohelper.setActive(materialItem.goempty, true)
		gohelper.setActive(materialItem.goitem, false)
	end

	local isShowNeedTag = false
	local produceItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

	gohelper.setActive(self._simageproduceitem.gameObject, produceItem)
	gohelper.setActive(self._txtname.gameObject, produceItem)

	local rare = 1

	if produceItem then
		local config, icon = ItemModel.instance:getItemConfigAndIcon(produceItem.type, produceItem.id)

		self._simageproduceitem:LoadImage(icon)

		rare = config.rare
		self._txtname.text = config.name

		local isTreeFormula = self._mo:isTreeFormula()
		local recordFarmItem = JumpModel.instance:getRecordFarmItem()

		if recordFarmItem and not isTreeFormula then
			isShowNeedTag = recordFarmItem.id == produceItem.id
		end
	end

	gohelper.setActive(self._goNeedTag, isShowNeedTag)
	UISpriteSetMgr.instance:setRoomSprite(self._imagerare, "huangyuan_pz_" .. CharacterEnum.Color[rare])
	self:_refreshTreeLevel()
	self:_refreshCoinCount()
	self:_refreshMaterialItemCount()
end

function RoomFormulaItem:_refreshLockText(needRoomLevel, needProductionLevel, needEpisodeId)
	local lockDescList = {}

	if needRoomLevel then
		table.insert(lockDescList, string.format(luaLang("room_formula_lock_roomlevel"), needRoomLevel))
	end

	if needProductionLevel then
		table.insert(lockDescList, string.format(luaLang("room_formula_lock_productionlevel"), needProductionLevel))
	end

	if needEpisodeId then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(needEpisodeId)

		if episodeConfig then
			::label_15_0::

			local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
			local normalEpisodeConfig = episodeConfig
			local hardStr = ""
			local var_15_0

			if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
				hardStr = luaLang("dungeon_lock_tips_hard2")
				normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
				var_15_0 = normalEpisodeConfig and DungeonController.getEpisodeName(normalEpisodeConfig) or ""
			end

			table.insert(lockDescList, string.format(luaLang("room_formula_lock_episode"), "<color=#FF0000>" .. hardStr .. var_15_0 .. "</color>"))
		end
	end

	if #lockDescList > 0 then
		self._golockitem.text = lockDescList[1] or ""
	end
end

function RoomFormulaItem:_refreshTreeLevel()
	local lineTOrL, lineI1, lineI2 = self:getShowLineObj()
	local parentStrId = self._mo:getParentStrId()

	if parentStrId and lineTOrL.hasData then
		local isParentSelected = RoomFormulaListModel.instance:isSelectedFormula(parentStrId)

		gohelper.setActive(lineTOrL.normal, not isParentSelected)
		gohelper.setActive(lineTOrL.highlight, isParentSelected)
	end

	if lineI1.hasData then
		local isGrandParentSelected = RoomFormulaListModel.instance:isSelectedFormula(lineI1.grandParentStrId)

		gohelper.setActive(lineI1.normal, not isGrandParentSelected)
		gohelper.setActive(lineI1.highlight, isGrandParentSelected)
	end

	if lineI2.hasData then
		local isGreatGrandParentSelected = RoomFormulaListModel.instance:isSelectedFormula(lineI2.greatGrandParentStrId)

		gohelper.setActive(lineI2.normal, not isGreatGrandParentSelected)
		gohelper.setActive(lineI2.highlight, isGreatGrandParentSelected)
	end
end

function RoomFormulaItem:getShowLineObj()
	local lineTOrL = {
		hasData = false
	}
	local lineI1 = {
		hasData = false
	}
	local lineI2 = {
		hasData = false
	}
	local formulaTreeLevel = self._mo:getFormulaTreeLevel()
	local isLast = self._mo:getIsLast()
	local parentStrId = self._mo:getParentStrId()

	for i, treeLevelItem in ipairs(self._treeLevelItemList) do
		local isCurLevelItem = i == formulaTreeLevel

		gohelper.setActive(treeLevelItem.go, isCurLevelItem)

		if isCurLevelItem then
			if treeLevelItem.lineT then
				gohelper.setActive(treeLevelItem.lineT, not isLast)

				if not isLast then
					lineTOrL.normal = treeLevelItem.lineTNo
					lineTOrL.highlight = treeLevelItem.lineTHL
					lineTOrL.hasData = true
				end
			end

			if treeLevelItem.lineL then
				gohelper.setActive(treeLevelItem.lineL, isLast)

				if isLast then
					lineTOrL.normal = treeLevelItem.lineLNo
					lineTOrL.highlight = treeLevelItem.lineLHL
					lineTOrL.hasData = true
				end
			end

			if parentStrId then
				local grandParentStrId = RoomFormulaModel.instance:getFormulaParentStrId(parentStrId)

				if treeLevelItem.lineI1 then
					local parentIsLast = RoomFormulaModel.instance:getFormulaIsLast(parentStrId)

					gohelper.setActive(treeLevelItem.lineI1, not parentIsLast)

					if not parentIsLast then
						lineI1.normal = treeLevelItem.lineI1No
						lineI1.highlight = treeLevelItem.lineI1HL
						lineI1.grandParentStrId = grandParentStrId
						lineI1.hasData = true
					end
				end

				if treeLevelItem.lineI2 then
					local grandParentIsLast = RoomFormulaModel.instance:getFormulaIsLast(grandParentStrId)

					gohelper.setActive(treeLevelItem.lineI2, not grandParentIsLast)

					if not grandParentIsLast then
						lineI2.normal = treeLevelItem.lineI2No
						lineI2.highlight = treeLevelItem.lineI2HL
						lineI2.greatGrandParentStrId = RoomFormulaModel.instance:getFormulaParentStrId(grandParentStrId)
						lineI2.hasData = true
					end
				end
			end
		end
	end

	return lineTOrL, lineI1, lineI2
end

function RoomFormulaItem:_refreshCoinCount()
	self.costScore = 0

	local formulaId = self._mo:getFormulaId()
	local isCoinEnough = true
	local costCoinItemList = RoomProductionHelper.getCostCoinItemList(formulaId)
	local costCoinItem = costCoinItemList[1]

	if costCoinItem then
		local formulaCombineCount = self._mo:getFormulaCombineCount()

		self.costScore = (costCoinItem.quantity or 0) * formulaCombineCount

		local hasQuantity = ItemModel.instance:getItemQuantity(costCoinItem.type, costCoinItem.id)

		isCoinEnough = hasQuantity >= self.costScore
	end

	self._txtgold.text = isCoinEnough and GameUtil.numberDisplay(self.costScore) or string.format("<color=#d97373>%s</color>", self.costScore)

	gohelper.setActive(self._goitem, self.costScore > 0)
	gohelper.setActive(self._goempty, self.costScore <= 0)
end

function RoomFormulaItem:_refreshMaterialItemCount()
	local formulaId = self._mo:getFormulaId()
	local formulaCombineCount = self._mo:getFormulaCombineCount()
	local costItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	for i = 1, math.min(self._maxMaterialItemCount, #costItemList) do
		local materialItem = self._materialItemList[i]
		local costItem = costItemList[i]
		local totalNeedQuantity = costItem.quantity * formulaCombineCount
		local hasQuantity = ItemModel.instance:getItemQuantity(costItem.type, costItem.id)
		local isMaterialEnough = totalNeedQuantity <= hasQuantity

		if materialItem.costItem then
			materialItem.costItem:setMOValue(costItem.type, costItem.id, totalNeedQuantity)
			materialItem.costItem:setGrayscale(not isMaterialEnough)
		end

		local hasQuantityStr = RoomProductionHelper.formatItemNum(hasQuantity)

		materialItem.txtnum.text = isMaterialEnough and string.format("%s/%s", hasQuantityStr, totalNeedQuantity) or string.format("<color=#d97373>%s/%s</color>", hasQuantityStr, totalNeedQuantity)
	end

	local produceItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

	gohelper.setActive(self._txtCombineNum.gameObject, produceItem)

	if produceItem then
		self._txtCombineNum.text = luaLang("multiple") .. produceItem.quantity * formulaCombineCount
	end
end

function RoomFormulaItem:_refreshOwnQuantityAndTag()
	local formulaId = self._mo:getFormulaId()
	local ownQuantity = 0
	local produceItemParam = RoomProductionHelper.getFormulaProduceItem(formulaId)

	if produceItemParam then
		ownQuantity = ItemModel.instance:getItemQuantity(produceItemParam.type, produceItemParam.id)
	end

	local formulaStrId = self._mo:getId()
	local needQuantity = RoomProductionHelper.getFormulaNeedQuantity(formulaStrId)

	if needQuantity and needQuantity ~= 0 then
		local showText = ""
		local isEnough = needQuantity <= ownQuantity

		if isEnough then
			showText = string.format("%s/%s", ownQuantity, needQuantity)

			gohelper.setActive(self._goCanCombine, false)
			gohelper.setActive(self._goNeed, false)
		else
			showText = string.format("<color=#d97373>%s</color>/%s", ownQuantity, needQuantity)

			local canCombineNum = RoomProductionHelper.getTotalCanCombineNum(formulaId)
			local canCombine = canCombineNum ~= 0

			if canCombine then
				self._txtCanCombine.text = formatLuaLang("room_formula_can_combine", canCombineNum)
			end

			gohelper.setActive(self._goCanCombine, canCombine)
			gohelper.setActive(self._goNeed, not canCombine)
		end

		self._txtOwnNum.text = showText
	else
		self._txtOwnNum.text = ownQuantity

		gohelper.setActive(self._goCanCombine, false)
		gohelper.setActive(self._goNeed, false)
	end
end

function RoomFormulaItem:_playAnimByName(animName)
	self._lastAnimName = animName

	self._animator:Play(animName, 0, 0)
end

function RoomFormulaItem:_onHideAnimAnimation(treeLevel)
	if self:_canTreeAnim(treeLevel) then
		self:_playAnimByName(RoomProductLineEnum.AnimName.TreeHide)
	end
end

function RoomFormulaItem:_onShowAnimAnimation(treeLevel)
	self._showLevel = treeLevel
end

function RoomFormulaItem:_onMoveAnimAnimation(treeLevel)
	self._checkMove = true
end

function RoomFormulaItem:_checkAnimation()
	local treeLevel = self._showLevel

	self._showLevel = nil

	if self._checkMove then
		self._lineAnimator:Play(RoomProductLineEnum.AnimName.TreeHide, 0, 0)
	end

	if treeLevel and self:_canTreeAnim(treeLevel) then
		self:_playAnimByName(RoomProductLineEnum.AnimName.TreeShow, 0, 0)

		self._checkMove = false
	end

	self:_checkMoveAnimation()

	if self._lastAnimName == RoomProductLineEnum.AnimName.TreeHide then
		self:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle, 0, 0)
	end
end

function RoomFormulaItem:_checkMoveAnimation()
	if self._checkMove ~= true then
		self:_tweenKill(true)

		return
	end

	self._checkMove = false

	local rankDiff = RoomFormulaListModel.instance:getRankDiff(self._mo)

	if rankDiff and rankDiff ~= 0 then
		self:_tweenKill()
		self:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle)

		local posy = RoomFormulaViewContainer.cellHeightSize * rankDiff

		transformhelper.setLocalPosXY(self._gonormalTrs, 0, posy)
		transformhelper.setLocalPosXY(self._golockTrs, 0, posy)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self._gonormalTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
		self._golockMoveId = ZProj.TweenHelper.DOAnchorPosY(self._golockTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		self:_tweenKill(true)
	end
end

function RoomFormulaItem:_tweenKill(resetPos)
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)
		ZProj.TweenHelper.KillById(self._golockMoveId)

		self._rankDiffMoveId = nil
		self._golockMoveId = nil

		if resetPos then
			transformhelper.setLocalPosXY(self._gonormalTrs, 0, 0)
			transformhelper.setLocalPosXY(self._golockTrs, 0, 0)
		end
	end
end

function RoomFormulaItem:_canTreeAnim(treeLevel)
	if treeLevel then
		local curTreeLevel = self._mo:getFormulaTreeLevel()

		if curTreeLevel and treeLevel < curTreeLevel then
			return true
		end
	end

	return false
end

function RoomFormulaItem:jumpFinishCallback()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
end

function RoomFormulaItem:onDestroyView()
	self._simageproduceitem:UnLoadImage()
	self._simagecoinIcon:UnLoadImage()
	self:_tweenKill()
end

return RoomFormulaItem

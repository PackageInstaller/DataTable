-- chunkname: @modules/logic/room/view/RoomInitBuildingView.lua

module("modules.logic.room.view.RoomInitBuildingView", package.seeall)

local RoomInitBuildingView = class("RoomInitBuildingView", BaseView)
local SWITCH_TIME = 0.3

RoomInitBuildingView.TabId = {
	ProductionLine = 1,
	BuildDegree = 2
}

function RoomInitBuildingView:onInitView()
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._gocategoryItem = gohelper.findChild(self.viewGO, "left/#scroll_catagory/viewport/content/#go_catagoryItem")
	self._gotitle = gohelper.findChild(self.viewGO, "left/title")
	self._imageicon = gohelper.findChildImage(self.viewGO, "left/title/#image_icon")
	self._txttitle = gohelper.findChildText(self.viewGO, "left/title/#txt_title")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "left/title/#txt_title/#txt_titleEn")
	self._golevelitem = gohelper.findChild(self.viewGO, "left/title/activeLv/#go_levelitem")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.viewGO, "left/title/layout/#btn_levelup")
	self._goreddot = gohelper.findChild(self.viewGO, "left/title/layout/#btn_levelup/#go_reddot")
	self._btnskin = gohelper.findChildButtonWithAudio(self.viewGO, "left/title/layout/#btn_skin")
	self._goskinreddot = gohelper.findChild(self.viewGO, "left/title/layout/#btn_skin/#go_reddot")
	self._gopart = gohelper.findChild(self.viewGO, "right/#go_part")
	self._goinit = gohelper.findChild(self.viewGO, "right/#go_init")
	self._goskin = gohelper.findChild(self.viewGO, "right/#go_skin")
	self._gohubList = gohelper.findChild(self.viewGO, "right/#go_init/#go_hubList")
	self._goactiveList = gohelper.findChild(self.viewGO, "right/#go_init/#go_activeList")
	self._btnbuildingHub = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_init/buildingLayout/#btn_buildingHub")
	self._btnbuildingActive = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_init/buildingLayout/#btn_buildingActive")
	self._gogatherpart = gohelper.findChild(self.viewGO, "right/#go_init/#go_hubList/#go_gatherpart")
	self._gochangepart = gohelper.findChild(self.viewGO, "right/#go_init/#go_hubList/#go_changepart")
	self._gogather = gohelper.findChild(self.viewGO, "right/#go_part/#go_gather")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_part/#go_change")
	self._simagecombinebg = gohelper.findChildSingleImage(self.viewGO, "right/#go_part/#go_change/combine/go_combine3/#simage_combinebg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingView:addEvents()
	self._btnskin:AddClickListener(self._btnskinOnClick, self)
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self._btnbuildingHub:AddClickListener(self._btnbuildingHubOnClick, self)
	self._btnbuildingActive:AddClickListener(self._btnbuildingActiveOnClick, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, self._onSkinListViewShowChange, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, self._refreshSkinReddot, self)
end

function RoomInitBuildingView:removeEvents()
	self._btnskin:RemoveClickListener()
	self._btnlevelup:RemoveClickListener()
	self._btnbuildingHub:RemoveClickListener()
	self._btnbuildingActive:RemoveClickListener()
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, self._onSkinListViewShowChange, self)
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, self._refreshSkinReddot, self)
end

function RoomInitBuildingView:_btnskinOnClick()
	RoomSkinController.instance:setRoomSkinListVisible(self._selectPartId)
end

function RoomInitBuildingView:_btnlevelupOnClick()
	RoomMapController.instance:openRoomLevelUpView()
end

function RoomInitBuildingView:_btnbuildingHubOnClick()
	self:_changeSelectTab(1)
end

function RoomInitBuildingView:_btnbuildingActiveOnClick()
	self:_changeSelectTab(2)
end

function RoomInitBuildingView:_categoryItemOnClick(index)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		return
	end

	local categoryItem = self._categoryItemList[index]

	self:_changeSelectPart(categoryItem.partId, true)

	if self._lastItemIndex ~= index then
		self._lastItemIndex = index

		if index == 1 then
			self:_changeSelectTab(1)
		end
	end
end

function RoomInitBuildingView:_btninitpartproductOnClick(partId)
	local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(partId)

	if #requestLineIdList > 0 then
		self._flyEffectRewardInfoList = {}

		local partItem = self:_getPartItemByPartId(partId)

		for i, lineId in ipairs(requestLineIdList) do
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)
			local per = lineMO:getReservePer()

			if not LuaUtil.tableNotEmpty(self._flyEffectRewardInfoList) then
				table.insert(self._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(lineMO.formulaId),
					position = partItem.simagereward.gameObject.transform.position
				})
			end

			self._lineIdPerDict[lineId] = per
		end

		RoomRpc.instance:sendGainProductionLineRequest(requestLineIdList, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end
end

function RoomInitBuildingView:_btninitpartProductOnClick(partId)
	self:_changeSelectPart(partId)
end

function RoomInitBuildingView:_btninitpartChangeOnClick(partId)
	self:_changeSelectPart(partId, false, true)
end

function RoomInitBuildingView:_btnupgradeOnClick(index)
	local lineItem = self:_getLineItemByIndex(index)
	local lineMO = RoomProductionModel.instance:getLineMO(lineItem.lineId)

	ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
		lineMO = lineMO,
		selectPartId = self._selectPartId
	})
end

function RoomInitBuildingView:_lineclickOnClick(index)
	local lineItem = self:_getLineItemByIndex(index)
	local lineMO = RoomProductionModel.instance:getLineMO(lineItem.lineId)

	if lineMO:isLock() then
		self:_hideExpandDetailUI()
		ToastController.instance:showToast(RoomEnum.Toast.RoomProductLineLockTips, lineMO.config.needRoomLevel)
	elseif self._selectLineId == lineItem.lineId then
		if self._expandDetailLineId == self._selectLineId then
			self._expandDetailLineId = nil
		else
			self._expandDetailLineId = self._selectLineId
		end

		self:_refreshDetailPartGather(self._selectPartId)
	else
		self._expandDetailLineId = lineItem.lineId

		self:_changeSelectLine(lineItem.lineId)
	end
end

function RoomInitBuildingView:_detailgathergetOnClick()
	local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(self._selectPartId)

	if #requestLineIdList > 0 then
		self._flyEffectRewardInfoList = {}
		self._lineIdPerDict = {}

		for i, lineId in ipairs(requestLineIdList) do
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)
			local per = lineMO:getReservePer()

			if not LuaUtil.tableNotEmpty(self._flyEffectRewardInfoList) then
				table.insert(self._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(lineMO.formulaId),
					position = self._gatherItem.btnget.gameObject.transform.position
				})
			end

			self._lineIdPerDict[lineId] = per
		end

		RoomRpc.instance:sendGainProductionLineRequest(requestLineIdList, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end

	self:_hideExpandDetailUI()
end

function RoomInitBuildingView:_gainProductionLineCallback(resultCode, lineIds)
	if resultCode ~= 0 then
		return
	end

	self:_playLineAnimation()

	if not self._flyEffectRewardInfoList or #self._flyEffectRewardInfoList <= 0 then
		return
	end

	for i, flyEffectRewardInfo in ipairs(self._flyEffectRewardInfoList) do
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
			startPos = flyEffectRewardInfo.position,
			itemType = flyEffectRewardInfo.rewardInfo.type,
			itemId = flyEffectRewardInfo.rewardInfo.id,
			startQuantity = flyEffectRewardInfo.rewardInfo.quantity
		})
	end

	self._flyEffectRewardInfoList = nil
end

function RoomInitBuildingView:_playLineAnimation()
	if self._lineGetTweenId then
		if self._scene.tween then
			self._scene.tween:killById(self._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(self._lineGetTweenId)
		end

		self._lineGetTweenId = nil
	end

	if LuaUtil.tableNotEmpty(self._lineIdPerDict) then
		self._lineGetTweenId = self._scene.tween and self._scene.tween:tweenFloat(1, 0, 0.5, self._lineAnimationFrame, self._lineAnimationFinish, self) or ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, self._lineAnimationFrame, self._lineAnimationFinish, self)
	end
end

function RoomInitBuildingView:_lineAnimationFrame(value)
	if self._selectPartId == 0 then
		for _, initPartProductItem in ipairs(self._initPartProductItemList) do
			for _, lineItem in ipairs(initPartProductItem.lineItemList) do
				local per = self._lineIdPerDict[lineItem.lineId]

				if per then
					self:_refreshLineAnimationShow(per, value, lineItem.imageprocess, lineItem.txtprocess)
				end
			end
		end
	else
		for _, lineItem in ipairs(self._gatherItem.lineItemList) do
			local per = self._lineIdPerDict[lineItem.lineId]

			if per then
				self:_refreshLineAnimationShow(per, value, lineItem.imageprocess, lineItem.txtprocess)
			end
		end

		local per = self._lineIdPerDict[self._selectLineId]

		if per then
			self:_refreshLineAnimationShow(per, value, nil, nil)
		end
	end
end

function RoomInitBuildingView:_refreshLineAnimationShow(per, value, imageprocess, txtprocess)
	per = per * value

	if imageprocess then
		imageprocess.fillAmount = per
	end

	if txtprocess then
		local per100 = math.max(0, math.floor(per * 100))

		txtprocess.text = string.format("%d%%", per100)
	end
end

function RoomInitBuildingView:_lineAnimationFinish()
	self:_lineAnimationFrame(0)

	self._lineIdPerDict = {}
end

function RoomInitBuildingView:_clearLineAnimation()
	if self._lineGetTweenId then
		if self._scene.tween then
			self._scene.tween:killById(self._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(self._lineGetTweenId)
		end

		self._lineGetTweenId = nil
	end

	self._lineIdPerDict = {}
end

function RoomInitBuildingView:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._selectPartId = 0
	self._selectTabId = RoomInitBuildingView.TabId.ProductionLine
	self._selectLineId = 0

	self.viewContainer:setSelectLine(self._selectLineId)

	self._categoryItemList = {}

	gohelper.setActive(self._gocategoryItem, false)

	self._levelItemList = {}

	gohelper.setActive(self._golevelitem, false)

	self._buildingInfoItemList = {}
	self._detailInitTabHubItem = self:_getDetailInitItem(self._btnbuildingHub.gameObject)
	self._detailInitTabActiveItem = self:_getDetailInitItem(self._btnbuildingActive.gameObject)
	self._initPartProductItemList = {}
	self._initPartChangeItemList = {}

	gohelper.setActive(self._gogatherpart, false)
	gohelper.setActive(self._gochangepart, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._lineIdPerDict = {}

	gohelper.addUIClickAudio(self._btnlevelup.gameObject, AudioEnum.UI.UI_Rolesopen)
	self._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))
	self._simagemask:LoadImage(ResUrl.getRoomImage("full/bg_yinyingzhezhao"))

	self._expandDetailLineId = nil
	self._golevelupeffect = gohelper.findChild(self.viewGO, "left/title/layout/#btn_levelup/#go_reddot/#leveup_effect")
end

function RoomInitBuildingView:_getLineItemByIndex(index)
	if index == 0 then
		return self._changeItem.lineItem
	else
		return self._gatherItem.lineItemList[index]
	end
end

function RoomInitBuildingView:_getLineItemByLineId(lineId)
	for i, lineItem in ipairs(self._gatherItem.lineItemList) do
		if lineItem.lineId == lineId then
			return lineItem
		end
	end
end

function RoomInitBuildingView:_getPartItemByPartId(partId)
	for i, partItem in ipairs(self._initPartProductItemList) do
		if partItem.partId == partId then
			return partItem
		end
	end

	for i, partItem in ipairs(self._initPartChangeItemList) do
		if partItem.partId == partId then
			return partItem
		end
	end
end

function RoomInitBuildingView:_initChangeItem()
	local item = self:getUserDataTb_()

	item.go = self._gochange
	item.goline = gohelper.findChild(item.go, "productLineItem")
	item.gobgvx = gohelper.findChild(item.go, "combine/go_combine3/#bgvx")
	item.gohechengeffect = gohelper.findChild(item.go, "combine/#hechengeffect")
	item.lineItem = self:getUserDataTb_()

	self:_initLine(item.lineItem, item.goline, false, 0)
	gohelper.setActive(item.goline, true)

	return item
end

function RoomInitBuildingView:_initGatherItem()
	local item = self:getUserDataTb_()

	item.go = self._gogather
	item.txtname = gohelper.findChildText(item.go, "collect/txt_productLineName")
	item.txtprocess = gohelper.findChildText(item.go, "collect/txt_collectprocess")
	item.goarrow = gohelper.findChild(item.go, "collect/txt_collectprocess/go_arrow")
	item.gopause = gohelper.findChild(item.go, "collect/txt_collectprocess/go_pause")
	item.imagereward = gohelper.findChildImage(item.go, "collect/image_curcollectitem")
	item.goline = gohelper.findChild(item.go, "scroll_productLine/viewport/content/go_productLineItem")
	item.goinfo = gohelper.findChild(item.go, "go_gatherInfo")
	item.txtstore = gohelper.findChildText(item.go, "go_gatherInfo/collectinfo/num/txt_store")
	item.txttime = gohelper.findChildText(item.go, "go_gatherInfo/collectinfo/num/txt_expspeed")
	item.txtremain = gohelper.findChildText(item.go, "go_gatherInfo/collectinfo/go_time/txt_time")
	item.goget = gohelper.findChild(item.go, "btn_get/go_get")
	item.gonoget = gohelper.findChild(item.go, "btn_get/go_noget")
	item.btnget = gohelper.findChildButton(item.go, "btn_get")
	item.btnnewget = gohelper.findChildButton(item.go, "collect/btn_get")

	local circleGO = gohelper.findChild(item.go, "collect/bg")

	item.animatorcircle = circleGO:GetComponent(typeof(UnityEngine.Animator))
	item.animatorget = item.btnget.gameObject:GetComponent(typeof(UnityEngine.Animator))

	item.btnget:AddClickListener(self._detailgathergetOnClick, self)
	item.btnnewget:AddClickListener(self._detailgathergetOnClick, self)

	item.lineItemList = {}

	gohelper.setActive(item.goline, false)

	return item
end

function RoomInitBuildingView:_initLine(lineItem, lineGO, isGather, index)
	lineItem.go = lineGO
	lineItem.index = index
	lineItem.isGather = isGather
	lineItem.txtname = gohelper.findChildText(lineItem.go, "name")
	lineItem.goshowprocess = gohelper.findChild(lineItem.go, "go_process")
	lineItem.golevelitem = gohelper.findChild(lineItem.go, "name/go_activeLv/go_normalitem")
	lineItem.imageprocess = gohelper.findChildImage(lineItem.go, "go_process/go_process/processbar")
	lineItem.txtprocess = gohelper.findChildText(lineItem.go, "go_process/go_process/num")
	lineItem.goprocess = gohelper.findChild(lineItem.go, "go_process/go_process")
	lineItem.btnupgrade = gohelper.findChildButtonWithAudio(lineItem.go, "btn_upgrade")
	lineItem.reddot = gohelper.findChild(lineItem.go, "btn_upgrade/reddot")

	lineItem.btnupgrade:AddClickListener(self._btnupgradeOnClick, self, lineItem.index)
	gohelper.addUIClickAudio(lineItem.btnupgrade.gameObject, AudioEnum.UI.UI_Rolesopen)

	lineItem.levelItemList = self:getUserDataTb_()

	if isGather then
		lineItem.gofull = gohelper.findChild(lineItem.go, "go_process/go_full")
		lineItem.gonormalbg = gohelper.findChild(lineItem.go, "go_normalbg")
		lineItem.gofullbg = gohelper.findChild(lineItem.go, "go_fullbg")
		lineItem.goselectbg = gohelper.findChild(lineItem.go, "go_selectbg")
		lineItem.golock = gohelper.findChild(lineItem.go, "go_lock")
		lineItem.txtlock = gohelper.findChildText(lineItem.go, "go_lock/txt_lock")
		lineItem.btnclick = gohelper.findChildButtonWithAudio(lineItem.go, "btn_click")

		lineItem.btnclick:AddClickListener(self._lineclickOnClick, self, lineItem.index)

		lineItem.gatherAnimator = lineItem.go:GetComponent(typeof(UnityEngine.Animator))
	else
		lineItem.goselectbg = gohelper.findChild(lineItem.go, "selectbg")
		lineItem.animator = lineItem.goprocess:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(lineItem.golevelitem, false)
end

function RoomInitBuildingView:_getDetailInitItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.gonormal = gohelper.findChild(item.go, "go_normalbg")
	item.goselect = gohelper.findChild(item.go, "go_selectbg")

	return item
end

function RoomInitBuildingView:_changeSelectPart(partId, fromLeftBtn, fromGOChangeBtn)
	if partId ~= 0 and not RoomProductionHelper.hasUnlockLine(partId) then
		local productType = RoomProductionHelper.getPartType(partId)

		if productType == RoomProductLineEnum.ProductType.Change then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
		end

		return
	end

	if self._selectPartId == partId then
		return
	end

	self._expandDetailLineId = nil
	self._waitChangeSelectPartId = partId

	self:_refreshCategory()
	self:_refreshCamera()

	self._keepOpenSkinListAfterChange = RoomSkinModel.instance:getIsShowRoomSkinList()

	RoomSkinController.instance:clearPreviewRoomSkin()

	self._animator.enabled = true

	self._animator:Play("swicth", 0, 0)
	TaskDispatcher.cancelTask(self._realChangeSelectPart, self)
	TaskDispatcher.runDelay(self._realChangeSelectPart, self, SWITCH_TIME)

	if fromLeftBtn then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	end

	if fromGOChangeBtn then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)
	end
end

function RoomInitBuildingView:_realChangeSelectPart()
	if not self._waitChangeSelectPartId then
		return
	end

	self._selectPartId = self._waitChangeSelectPartId

	self.viewContainer:setSelectPartId(self._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. self._selectPartId])

	self._waitChangeSelectPartId = nil

	self:_refreshSelectPart(false, true)

	if self._keepOpenSkinListAfterChange then
		self:_btnskinOnClick()

		self._keepOpenSkinListAfterChange = false
	end
end

function RoomInitBuildingView:_changeSelectTab(tabId)
	if self._selectTabId == tabId then
		return
	end

	self._selectTabId = tabId

	self:_refreshSelectTab()
end

function RoomInitBuildingView:_changeSelectLine(lineId)
	if self._selectLineId == lineId then
		return
	end

	self._selectLineId = lineId

	self.viewContainer:setSelectLine(self._selectLineId)
	self:_refreshDetailPartGather(self._selectPartId)
end

function RoomInitBuildingView:_refreshUI(isInit)
	local param = self.viewParam

	if param then
		self._selectPartId = param.partId or 0
	end

	if param then
		self._selectLineId = param.lineId or 0
	end

	self.viewContainer:setSelectLine(self._selectLineId)
	self.viewContainer:setSelectPartId(self._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. self._selectPartId])
	self:_refreshSelectPart(isInit)
end

function RoomInitBuildingView:_refreshSelectPart(isInit, notCamera)
	self:_clearLineAnimation()

	if not isInit and not notCamera then
		self:_refreshCamera()
	end

	self:_refreshCategory()
	self:_refreshTitle()
	self:_refreshLevel()
	self:_realChangeShowSkinList()
	self:_refreshSkinReddot()
	RoomSkinController.instance:clearInitBuildingEntranceReddot(self._selectPartId)
end

function RoomInitBuildingView:_refreshCamera()
	if not self._waitChangeSelectPartId then
		RoomBuildingController.instance:tweenCameraFocusPart(self._waitChangeSelectPartId, RoomEnum.CameraState.Normal, 0)
	end
end

function RoomInitBuildingView:_refreshCategory()
	local partIdList = {}

	table.insert(partIdList, 0)

	local partConfigList = RoomConfig.instance:getProductionPartConfigList()

	for i, config in ipairs(partConfigList) do
		table.insert(partIdList, config.id)
	end

	for i = 1, #partIdList do
		local partId = partIdList[i]
		local categoryItem = self._categoryItemList[i]

		if not categoryItem then
			categoryItem = self:getUserDataTb_()
			categoryItem.index = i
			categoryItem.go = gohelper.cloneInPlace(self._gocategoryItem, "categoryItem" .. i)
			categoryItem.gonormal = gohelper.findChild(categoryItem.go, "go_normal")
			categoryItem.imageiconnormal = gohelper.findChildImage(categoryItem.go, "go_normal/icon")
			categoryItem.goselect = gohelper.findChild(categoryItem.go, "go_select")
			categoryItem.imageiconselect = gohelper.findChildImage(categoryItem.go, "go_select/icon")
			categoryItem.goreddot = gohelper.findChild(categoryItem.go, "reddot")
			categoryItem.gosubLine = gohelper.findChild(categoryItem.go, "go_subLine")
			categoryItem.btnclick = gohelper.findChildButtonWithAudio(categoryItem.go, "btn_click")

			categoryItem.btnclick:AddClickListener(self._categoryItemOnClick, self, categoryItem.index)
			table.insert(self._categoryItemList, categoryItem)
		end

		categoryItem.partId = partId

		if not self._waitChangeSelectPartId then
			local selectPartId = self._selectPartId

			gohelper.setActive(categoryItem.gosubLine, partId == 0)

			if partId == 0 then
				if selectPartId ~= partId then
					UISpriteSetMgr.instance:setRoomSprite(categoryItem.imageiconnormal, "bg_init")
				else
					UISpriteSetMgr.instance:setRoomSprite(categoryItem.imageiconselect, "bg_init_ovr")
				end
			elseif selectPartId ~= partId then
				UISpriteSetMgr.instance:setRoomSprite(categoryItem.imageiconnormal, "bg_part" .. partId)
			else
				UISpriteSetMgr.instance:setRoomSprite(categoryItem.imageiconselect, "bg_part" .. partId .. "_ovr")
			end

			gohelper.setActive(categoryItem.gonormal, selectPartId ~= partId)
			gohelper.setActive(categoryItem.goselect, selectPartId == partId)
			gohelper.setActive(categoryItem.goreddot, false)
			gohelper.setActive(categoryItem.go, partId == 0 or RoomProductionHelper.hasUnlockLine(partId))
		end
	end

	for i = #partIdList + 1, #self._categoryItemList do
		local categoryItem = self._categoryItemList[i]

		gohelper.setActive(categoryItem.go, false)
	end
end

function RoomInitBuildingView:_refreshTitle()
	if self._selectPartId == 0 then
		UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_init")

		self._txttitle.text = luaLang("room_initbuilding_title")
		self._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_part" .. self._selectPartId)

		local partConfig = RoomConfig.instance:getProductionPartConfig(self._selectPartId)

		self._txttitle.text = partConfig.name
		self._txttitleEn.text = partConfig.nameEn
	end
end

function RoomInitBuildingView:_refreshLevel()
	local maxLevel = 0
	local currentLevel = 0

	if self._selectPartId == 0 then
		maxLevel = RoomConfig.instance:getMaxRoomLevel()
		currentLevel = RoomMapModel.instance:getRoomLevel()
	end

	for level = 1, maxLevel do
		local levelItem = self._levelItemList[level]

		if not levelItem then
			levelItem = self:getUserDataTb_()
			levelItem.go = gohelper.cloneInPlace(self._golevelitem, "levelitem" .. level)
			levelItem.golight = gohelper.findChild(levelItem.go, "go_light")

			table.insert(self._levelItemList, levelItem)
		end

		gohelper.setActive(levelItem.golight, level <= currentLevel)
		gohelper.setActive(levelItem.go, true)
	end

	for level = maxLevel + 1, #self._levelItemList do
		local levelItem = self._levelItemList[level]

		gohelper.setActive(levelItem.go, false)
	end

	local showLevelUpBtn = self._selectPartId == 0 and currentLevel < maxLevel

	gohelper.setActive(self._btnlevelup.gameObject, showLevelUpBtn)

	if showLevelUpBtn then
		RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
		self:_refreshRoomLevelUpEffect()
	end
end

function RoomInitBuildingView:_refreshSkinReddot()
	if not self.skinRedDot then
		self.skinRedDot = RedDotController.instance:addNotEventRedDot(self._goskinreddot, self._checkNewSkinReddot, self)

		return
	end

	self.skinRedDot:refreshRedDot()
end

function RoomInitBuildingView:_checkNewSkinReddot()
	return (RoomSkinModel.instance:isHasNewRoomSkin(self._selectPartId))
end

function RoomInitBuildingView:_onSkinListViewShowChange(playSwitchAnim)
	self._animator.enabled = true

	if playSwitchAnim then
		self._animator:Play("swicth", 0, 0)
	end

	TaskDispatcher.cancelTask(self._realChangeShowSkinList, self)
	TaskDispatcher.runDelay(self._realChangeShowSkinList, self, SWITCH_TIME)
end

function RoomInitBuildingView:_realChangeShowSkinList()
	local isShowSkinList = RoomSkinModel.instance:getIsShowRoomSkinList()

	if isShowSkinList then
		gohelper.setActive(self._goinit, false)
		gohelper.setActive(self._gopart, false)
	else
		self:_refreshDetail(true)
	end

	self:setTitleShow(not isShowSkinList)
	gohelper.setActive(self._goskin, isShowSkinList)
end

function RoomInitBuildingView:setTitleShow(isShow)
	gohelper.setActive(self._gotitle, isShow)
end

function RoomInitBuildingView:_refreshRoomLevelUpEffect()
	gohelper.setActive(self._golevelupeffect, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomInitBuildingLevel, 0))
end

function RoomInitBuildingView:_refreshDetail(fromChangePart)
	gohelper.setActive(self._goinit, self._selectPartId == 0)
	gohelper.setActive(self._gopart, self._selectPartId ~= 0)

	if self._selectPartId == 0 then
		self:_refreshDetailInit()
	else
		self:_refreshDetailPart(fromChangePart)
	end
end

function RoomInitBuildingView:_refreshDetailInit()
	self:_refreshSelectTab()
end

function RoomInitBuildingView:_refreshSelectTab()
	gohelper.setActive(self._detailInitTabHubItem.gonormal, self._selectTabId ~= RoomInitBuildingView.TabId.ProductionLine)
	gohelper.setActive(self._detailInitTabHubItem.goselect, self._selectTabId == RoomInitBuildingView.TabId.ProductionLine)
	gohelper.setActive(self._detailInitTabActiveItem.gonormal, self._selectTabId ~= RoomInitBuildingView.TabId.BuildDegree)
	gohelper.setActive(self._detailInitTabActiveItem.goselect, self._selectTabId == RoomInitBuildingView.TabId.BuildDegree)
	gohelper.setActive(self._gohubList, self._selectTabId == RoomInitBuildingView.TabId.ProductionLine)
	gohelper.setActive(self._goactiveList, self._selectTabId == 2)

	if self._selectTabId == RoomInitBuildingView.TabId.ProductionLine then
		self:_refreshInitPart()
	elseif self._selectTabId == RoomInitBuildingView.TabId.BuildDegree then
		self:_refreshBuildDegree()
	end
end

function RoomInitBuildingView:_refreshTabCountText()
	local partConfigList = RoomConfig.instance:getProductionPartConfigList()

	self._detailInitTabHubItem.txtcount.text = #partConfigList
	self._detailInitTabActiveItem.txtcount.text = RoomMapModel.instance:getAllBuildDegree()
end

function RoomInitBuildingView:_refreshBuildDegree()
	RoomShowDegreeListModel.instance:setShowDegreeList()
end

function RoomInitBuildingView:_refreshInitPart()
	if self._selectPartId ~= 0 then
		return
	end

	local partConfigList = RoomConfig.instance:getProductionPartConfigList()
	local productIndex = 0
	local changeIndex = 0

	for i, config in ipairs(partConfigList) do
		local productType, productItemType = RoomProductionHelper.getPartType(config.id)

		if productType == RoomProductLineEnum.ProductType.Product then
			productIndex = productIndex + 1

			self:_refreshInitPartProduct(config, productIndex)
		elseif productType == RoomProductLineEnum.ProductType.Change then
			changeIndex = changeIndex + 1

			self:_refreshInitPartChange(config, changeIndex)
		end
	end

	for i = productIndex + 1, #self._initPartProductItemList do
		local item = self._initPartProductItemList[i]

		gohelper.setActive(item.go, false)
	end

	for i = changeIndex + 1, #self._initPartChangeItemList do
		local item = self._initPartChangeItemList[i]

		gohelper.setActive(item.go, false)
	end

	self:_refreshInitPartProductGet()
end

function RoomInitBuildingView:_refreshInitPartProduct(config, index)
	local item = self._initPartProductItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.partId = config.id
		item.go = gohelper.cloneInPlace(self._gogatherpart, "gatheritem" .. index)
		item.txtname = gohelper.findChildText(item.go, "title/txt")
		item.txtnameen = gohelper.findChildText(item.go, "title/txt/txtEn")
		item.golineitem = gohelper.findChild(item.go, "scroll_productline/viewport/content/go_productLineItem")
		item.simagereward = gohelper.findChildSingleImage(item.go, "reward/simage_reward")

		local circleGO = gohelper.findChild(item.go, "reward/circle")

		item.animator = circleGO:GetComponent(typeof(UnityEngine.Animator))
		item.btnget = gohelper.findChildButton(item.go, "reward/btn_get")
		item.btnjumpclick = gohelper.findChildButtonWithAudio(item.go, "btn_jumpclick")

		item.btnget:AddClickListener(self._btninitpartproductOnClick, self, item.partId)
		item.btnjumpclick:AddClickListener(self._btninitpartProductOnClick, self, item.partId)

		item.lineItemList = {}

		gohelper.setActive(item.golineitem, false)
		table.insert(self._initPartProductItemList, item)
	end

	gohelper.setActive(item.go, true)

	local productType, productItemType = RoomProductionHelper.getPartType(config.id)

	item.txtname.text = config.name
	item.txtnameen.text = config.nameEn

	if productItemType == RoomProductLineEnum.ProductItemType.ProductExp then
		item.simagereward:LoadImage(ResUrl.getPropItemIcon("5"))
		transformhelper.setLocalPosXY(item.simagereward.gameObject.transform, -11, 5.45)

		item.simagereward.gameObject.transform.rotation = Quaternion.Euler(0, 0, -7)
	elseif productItemType == RoomProductLineEnum.ProductItemType.ProductGold then
		item.simagereward:LoadImage(ResUrl.getPropItemIcon("3"))
	end

	self:_refreshInitPartProductLine(item, config)
end

function RoomInitBuildingView:_refreshInitPartProductLine(partItem, partConfig)
	local lineIdList = partConfig.productionLines

	for i, lineId in ipairs(lineIdList) do
		local lineItem = partItem.lineItemList[i]

		if not lineItem then
			lineItem = self:getUserDataTb_()
			lineItem.lineId = lineId
			lineItem.go = gohelper.cloneInPlace(partItem.golineitem, "item" .. i)
			lineItem.gonormal = gohelper.findChild(lineItem.go, "go_normal")
			lineItem.txtname = gohelper.findChildText(lineItem.go, "go_normal/name")
			lineItem.golevel = gohelper.findChild(lineItem.go, "go_normal/name/go_activeLv/go_normalitem")
			lineItem.gofull = gohelper.findChild(lineItem.go, "go_normal/go_process/go_full")
			lineItem.goprocess = gohelper.findChild(lineItem.go, "go_normal/go_process/go_process")
			lineItem.imageprocess = gohelper.findChildImage(lineItem.go, "go_normal/go_process/go_process/processbar")
			lineItem.txtprocess = gohelper.findChildText(lineItem.go, "go_normal/go_process/go_process/num")
			lineItem.golock = gohelper.findChild(lineItem.go, "go_lock")
			lineItem.lockdesc = gohelper.findChildText(lineItem.go, "go_lock/txt_lockdesc")
			lineItem.levelItemList = {}

			gohelper.setActive(lineItem.golevel, false)

			lineItem.animator = lineItem.go:GetComponent(typeof(UnityEngine.Animator))

			table.insert(partItem.lineItemList, lineItem)
		end

		gohelper.setActive(lineItem.go, true)

		local lineMO = RoomProductionModel.instance:getLineMO(lineId)

		lineItem.lockdesc.text = string.format(luaLang("room_initbuilding_linelock"), lineMO.config.needRoomLevel)
		lineItem.txtname.text = lineMO.config.name

		if lineMO:isLock() or lineMO:isIdle() then
			gohelper.setActive(lineItem.gofull, false)
			gohelper.setActive(lineItem.goprocess, false)
		elseif lineMO:isFull() then
			gohelper.setActive(lineItem.gofull, true)
			gohelper.setActive(lineItem.goprocess, false)
		else
			gohelper.setActive(lineItem.gofull, false)
			gohelper.setActive(lineItem.goprocess, true)

			local process, process100 = lineMO:getReservePer()

			if not self._lineIdPerDict[lineItem.lineId] then
				lineItem.imageprocess.fillAmount = process
				lineItem.txtprocess.text = string.format("%d%%", process100)
			end
		end

		if not lineMO.level then
			local currentLevel = 0

			if not lineMO.maxLevel then
				local maxLevel = 0

				if lineMO:isLock() then
					maxLevel = 0
				end

				for level = 1, maxLevel do
					local levelItem = lineItem.levelItemList[level]

					if not levelItem then
						levelItem = self:getUserDataTb_()
						levelItem.go = gohelper.cloneInPlace(lineItem.golevel, "item" .. level)
						levelItem.golight = gohelper.findChild(levelItem.go, "go_light")

						table.insert(lineItem.levelItemList, levelItem)
					end

					gohelper.setActive(levelItem.golight, level <= currentLevel)
					gohelper.setActive(levelItem.go, true)
				end

				for level = maxLevel + 1, #lineItem.levelItemList do
					local levelItem = lineItem.levelItemList[level]

					gohelper.setActive(levelItem.go, false)
				end

				if lineMO:isLock() then
					lineItem.animator.speed = 0

					lineItem.animator:Play("unlock", 0, 0)
					lineItem.animator:Update(0)
				elseif RoomProductionModel.instance:shouldPlayLineUnlock(lineId) then
					lineItem.animator.speed = 0

					lineItem.animator:Play("unlock", 0, 0)
					lineItem.animator:Update(0)

					if not RoomMapModel.instance:isRoomLeveling() and not ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
						RoomProductionModel.instance:setPlayLineUnlock(lineId, nil)
						TaskDispatcher.runDelay(self._playLineUnlock, lineItem, 0.4)
					end
				else
					lineItem.animator.speed = 0

					lineItem.animator:Play(UIAnimationName.Idle, 0, 0)
					lineItem.animator:Update(0)
				end
			end
		end
	end

	for i = #lineIdList + 1, #partItem.lineItemList do
		local lineItem = partItem.lineItemList[i]

		gohelper.setActive(lineItem.go, false)
	end
end

function RoomInitBuildingView._playLineUnlock(lineItem)
	lineItem.animator.speed = 1

	lineItem.animator:Play("unlock", 0, 0)
end

function RoomInitBuildingView:_refreshInitPartProductGet()
	for _, initPartProductItem in ipairs(self._initPartProductItemList) do
		local config = RoomConfig.instance:getProductionPartConfig(initPartProductItem.partId)
		local lineIdList = config.productionLines
		local unlockOneMore = false
		local isGathering = false

		for _, lineId in ipairs(lineIdList) do
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)

			if lineMO and not lineMO:isLock() then
				unlockOneMore = true

				if not lineMO:isIdle() and not lineMO:isFull() then
					isGathering = true
				end
			end
		end

		local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(initPartProductItem.partId)
		local canGet = #requestLineIdList > 0 and unlockOneMore

		gohelper.setActive(initPartProductItem.btnget.gameObject, canGet)
		initPartProductItem.animator:Play((isGathering or nil) and (UIAnimationName.Loop or "idle"))
	end
end

function RoomInitBuildingView:_refreshInitPartChange(config, index)
	local item = self._initPartChangeItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.partId = config.id
		item.go = gohelper.cloneInPlace(self._gochangepart, "changeitem" .. index)
		item.txtname = gohelper.findChildText(item.go, "title/txt")
		item.txtnameen = gohelper.findChildText(item.go, "title/txt/txtEn")
		item.goformulaitem = gohelper.findChild(item.go, "scroll_productline/viewport/content/go_materialItem")
		item.simagedoor = gohelper.findChildSingleImage(item.go, "reward/simage_door")
		item.btncombine = gohelper.findChildButton(item.go, "reward/btn_combine")

		item.btncombine:AddClickListener(self._btninitpartChangeOnClick, self, item.partId)

		item.formulaItemList = {}

		gohelper.setActive(item.goformulaitem, false)
		table.insert(self._initPartChangeItemList, item)
	end

	gohelper.setActive(item.go, true)

	local lineLevel = RoomProductionHelper.getPartMaxLineLevel(config.id)

	item.txtname.text = config.name
	item.txtnameen.text = config.nameEn

	item.simagedoor:LoadImage(ResUrl.getCurrencyItemIcon("door_room"))
	self:_refreshInitPartChangeFormula(item, config, lineLevel)
end

function RoomInitBuildingView:_refreshInitPartChangeFormula(partItem, partConfig, lineLevel)
	local showTypeList = {}

	for i, showTypeConfig in ipairs(lua_formula_showtype.configList) do
		table.insert(showTypeList, showTypeConfig)
	end

	table.sort(showTypeList, function(x, y)
		local xUnlock = RoomProductionHelper.isFormulaShowTypeUnlock(x.id) <= lineLevel
		local yUnlock = RoomProductionHelper.isFormulaShowTypeUnlock(y.id) <= lineLevel

		if xUnlock and not yUnlock then
			return true
		elseif yUnlock and not xUnlock then
			return false
		else
			return x.id < y.id
		end
	end)

	local hasUnlockLine = RoomProductionHelper.hasUnlockLine(partConfig.id)

	for i, showTypeConfig in ipairs(showTypeList) do
		local showTypeItem = partItem.formulaItemList[i]
		local unlockLevel = RoomProductionHelper.isFormulaShowTypeUnlock(showTypeConfig.id)
		local unlock = unlockLevel <= lineLevel and hasUnlockLine

		if not showTypeItem then
			showTypeItem = self:getUserDataTb_()
			showTypeItem.go = gohelper.cloneInPlace(partItem.goformulaitem, "item" .. i)
			showTypeItem.gonormal = gohelper.findChild(showTypeItem.go, "go_normal")
			showTypeItem.txtnamenormal = gohelper.findChildText(showTypeItem.go, "go_normal/txt_name")
			showTypeItem.golock = gohelper.findChild(showTypeItem.go, "go_lock")
			showTypeItem.txtnamelock = gohelper.findChildText(showTypeItem.go, "go_lock/txt_name")
			showTypeItem.btnlockclick = gohelper.findChildButtonWithAudio(showTypeItem.go, "go_lock/btn_lockclick")
			showTypeItem.param = {}

			table.insert(partItem.formulaItemList, showTypeItem)
		end

		showTypeItem.btnlockclick:RemoveClickListener()

		showTypeItem.param.partConfig = partConfig
		showTypeItem.param.unlockLevel = unlockLevel
		showTypeItem.param.unlockLevel = unlockLevel

		if not unlock then
			if hasUnlockLine then
				showTypeItem.btnlockclick:AddClickListener(self._btnMaterialItemLockOnClick, self, showTypeItem.param)
			else
				showTypeItem.btnlockclick:AddClickListener(self._btnMaterialItemLockOnClick2, self)
			end
		end

		gohelper.setActive(showTypeItem.gonormal, unlock)
		gohelper.setActive(showTypeItem.golock, not unlock)

		if unlock then
			showTypeItem.txtnamenormal.text = showTypeConfig.name
		else
			showTypeItem.txtnamelock.text = showTypeConfig.name
		end

		gohelper.setActive(showTypeItem.go, true)
	end

	for i = #showTypeList + 1, #partItem.formulaItemList do
		local showTypeItem = partItem.formulaItemList[i]

		gohelper.setActive(showTypeItem.go, false)
	end
end

function RoomInitBuildingView:_btnMaterialItemLockOnClick(param)
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, param.partConfig.name, param.unlockLevel)
end

function RoomInitBuildingView:_btnMaterialItemLockOnClick2()
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
end

function RoomInitBuildingView:_refreshDetailPart(fromChangePart)
	if self._selectPartId == 0 then
		return
	end

	local partConfig = RoomConfig.instance:getProductionPartConfig(self._selectPartId)
	local lineIdList = partConfig.productionLines

	if self._selectLineId == 0 or not LuaUtil.tableContains(lineIdList, self._selectLineId) then
		self._selectLineId = lineIdList[1]

		self.viewContainer:setSelectLine(self._selectLineId)
	end

	local productType = RoomProductionHelper.getPartType(self._selectPartId)

	gohelper.setActive(self._gogather, productType == RoomProductLineEnum.ProductType.Product)
	gohelper.setActive(self._gochange, productType == RoomProductLineEnum.ProductType.Change)

	if productType == RoomProductLineEnum.ProductType.Product then
		self:_refreshDetailPartGather(self._selectPartId, not fromChangePart)
	elseif productType == RoomProductLineEnum.ProductType.Change then
		self:_refreshDetailPartChange(self._selectPartId)
	end
end

function RoomInitBuildingView:_refreshDetailPartGather(partId, anim)
	if partId == 0 then
		return
	end

	self._gatherItem = self._gatherItem or self:_initGatherItem()

	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)
	local lineIdList = partConfig.productionLines
	local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(partId)
	local canGet = #requestLineIdList > 0

	gohelper.setActive(self._gatherItem.btnget.gameObject, false)

	local isGathering = false
	local workCount = 0
	local rewardIcon

	self._lastDetailPartGatherCanGet = canGet

	for i, lineId in ipairs(lineIdList) do
		local lineItem = self._gatherItem.lineItemList[i]

		if not lineItem then
			lineItem = self:getUserDataTb_()
			lineItem.lineId = lineId
			lineItem.go = gohelper.cloneInPlace(self._gatherItem.goline, "item" .. i)

			self:_initLine(lineItem, lineItem.go, true, i)
			table.insert(self._gatherItem.lineItemList, lineItem)
		end

		local lineMO = RoomProductionModel.instance:getLineMO(lineId)

		gohelper.setActive(lineItem.go, true)
		self:_refreshLine(lineItem, lineMO, true)

		if not lineMO:isLock() and not lineMO:isIdle() and not lineMO:isFull() then
			workCount = workCount + 1
			isGathering = true
		end

		if not rewardIcon then
			if lineMO.config.type == RoomProductLineEnum.ProductItemType.ProductExp then
				rewardIcon = "1_huibiao"
			elseif lineMO.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
				rewardIcon = "2_huibiao"
			end
		end
	end

	for i = #lineIdList + 1, #self._gatherItem.lineItemList do
		local lineItem = self._gatherItem.lineItemList[i]

		gohelper.setActive(lineItem.go, false)
	end

	gohelper.setActive(self._gatherItem.btnnewget.gameObject, canGet)

	self._gatherItem.txtname.text = partConfig.name

	local unlockNum = RoomProductionHelper.getUnlockLineCount(partId)

	self._gatherItem.txtprocess.text = string.format("%s/%s", workCount, unlockNum)

	self._gatherItem.animatorcircle:Play((isGathering or nil) and (UIAnimationName.Loop or "idle"))
	UISpriteSetMgr.instance:setRoomSprite(self._gatherItem.imagereward, rewardIcon or "2_huibiao")

	local isfull = workCount == 0 and unlockNum > 0

	gohelper.setActive(self._gatherItem.gopause, isfull)
	gohelper.setActive(self._gatherItem.goarrow, not isfull)
	SLFramework.UGUI.GuiHelper.SetColor(self._gatherItem.txtprocess, isfull and "#D97373" or "#999999")
	self:_refreshDetailPartGatherSelectLine()
end

function RoomInitBuildingView:_hideExpandDetailUI()
	if self._expandDetailLineId then
		self._expandDetailLineId = nil

		self:_refreshDetailPartGather(self._selectPartId)
	end
end

function RoomInitBuildingView:_refreshDetailPartGatherSelectLine()
	TaskDispatcher.cancelTask(self._updateDetailPartGatherSelectLineTime, self)

	if self._selectPartId == 0 then
		gohelper.setActive(self._gatherItem.goinfo, false)

		return
	end

	gohelper.setActive(self._gatherItem.goinfo, self._expandDetailLineId == self._selectLineId)

	if self._expandDetailLineId == self._selectLineId then
		local lineMO = RoomProductionModel.instance:getLineMO(self._selectLineId)
		local productDesc = ""

		if lineMO.config.type == RoomProductLineEnum.ProductItemType.ProductExp then
			productDesc = luaLang("roominitbuildingview_dust")
		elseif lineMO.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
			productDesc = luaLang("roominitbuildingview_coin")
		end

		self._gatherItem.txtstore.text = string.format("<color=#65b96f>%s</color>/%s", lineMO.useReserve, lineMO.reserve)

		local hour, minute, second = TimeUtil.secondToHMS(lineMO.costTime)
		local minute = minute + hour * 60

		self._gatherItem.txttime.text = minute > 0 and (second > 0 and string.format("<color=#65b96f>%d</color>%s/<color=#65b96f>%d</color>%s<color=#65b96f>%d</color>%s", lineMO.produceSpeed, productDesc, minute, luaLang("time_minute"), second, luaLang("time_second")) or string.format("<color=#65b96f>%d</color>%s/<color=#65b96f>%d</color>%s", lineMO.produceSpeed, productDesc, minute, luaLang("time_minute"))) or string.format("<color=#65b96f>%d</color>%s/<color=#65b96f>%d</color>%s", lineMO.produceSpeed, productDesc, second, luaLang("time_second"))

		self:_updateDetailPartGatherSelectLineTime()
		TaskDispatcher.runRepeat(self._updateDetailPartGatherSelectLineTime, self, 1)

		local lineItem = self:_getLineItemByLineId(self._selectLineId)

		gohelper.addChild(lineItem.go, self._gatherItem.goinfo)

		local posX, posY, posZ = transformhelper.getLocalPos(self._gatherItem.goinfo.transform)

		transformhelper.setLocalPos(self._gatherItem.goinfo.transform, posX, 0, posZ)
	end
end

function RoomInitBuildingView:_updateDetailPartGatherSelectLineTime()
	if self._selectPartId == 0 then
		TaskDispatcher.cancelTask(self._updateDetailPartGatherSelectLineTime, self)

		return
	end

	if self._selectLineId == 0 then
		TaskDispatcher.cancelTask(self._updateDetailPartGatherSelectLineTime, self)

		return
	end

	local lineMO = RoomProductionModel.instance:getLineMO(self._selectLineId)

	if lineMO.config.logic ~= RoomProductLineEnum.ProductType.Product then
		TaskDispatcher.cancelTask(self._updateDetailPartGatherSelectLineTime, self)

		return
	end

	local limitSec = math.floor(lineMO.allFinishTime - ServerTime.now())

	self._gatherItem.txtremain.text = not lineMO:isIdle() and lineMO:isFull() and luaLang("roominitbuildingview_fullpro") or string.format("<color=#65B96F>%s</color>%s", TimeUtil.second2TimeString(math.max(0, limitSec), true), luaLang("roominitbuildingview_stopproduct"))
end

function RoomInitBuildingView:_refreshDetailPartChange(partId)
	self._changeItem = self._changeItem or self:_initChangeItem()

	self:_refreshDetailPartChangeTitle(partId)
	gohelper.setActive(self._changeItem.gobgvx, false)
	gohelper.setActive(self._changeItem.gohechengeffect, false)
end

function RoomInitBuildingView:_refreshDetailPartChangeTitle(partId)
	local lineMO = RoomProductionHelper.getChangePartLineMO(partId)

	self:_refreshLine(self._changeItem.lineItem, lineMO, false)
end

function RoomInitBuildingView:_refreshLine(lineItem, lineMO, isGather)
	lineItem.lineId = lineMO.id
	lineItem.txtname.text = lineMO.config.name

	gohelper.setActive(lineItem.btnupgrade.gameObject, lineMO.level < lineMO.maxConfigLevel)

	if isGather then
		gohelper.setActive(lineItem.txtname.gameObject, not lineMO:isLock())

		local needRoomLevel = lineMO.config.needRoomLevel

		lineItem.txtlock.text = string.format(luaLang("room_initbuilding_linelock"), needRoomLevel)

		if lineMO:isLock() then
			gohelper.setActive(lineItem.gonormalbg, true)
			gohelper.setActive(lineItem.gofullbg, false)
			gohelper.setActive(lineItem.goshowprocess, false)
			gohelper.setActive(lineItem.btnupgrade.gameObject, false)
			gohelper.setActive(lineItem.goselectbg, false)
		else
			gohelper.setActive(lineItem.gonormalbg, lineMO:isIdle() or not lineMO:isFull())
			gohelper.setActive(lineItem.gofullbg, not lineMO:isIdle() and lineMO:isFull())
			gohelper.setActive(lineItem.goshowprocess, not lineMO:isIdle())
			gohelper.setActive(lineItem.goselectbg, self._expandDetailLineId == lineMO.id)

			if lineMO:isIdle() then
				gohelper.setActive(lineItem.gofull, false)
				gohelper.setActive(lineItem.goprocess, false)
			elseif lineMO:isFull() then
				gohelper.setActive(lineItem.gofull, true)
				gohelper.setActive(lineItem.goprocess, false)
			else
				gohelper.setActive(lineItem.gofull, false)
				gohelper.setActive(lineItem.goprocess, true)

				local process, process100 = lineMO:getReservePer()

				if not self._lineIdPerDict[lineItem.lineId] then
					lineItem.imageprocess.fillAmount = process
					lineItem.txtprocess.text = string.format("%d%%", process100)
				end
			end
		end

		if lineMO:isLock() then
			lineItem.gatherAnimator.speed = 0

			lineItem.gatherAnimator:Play("unlock", 0, 0)
			lineItem.gatherAnimator:Update(0)
		elseif RoomProductionModel.instance:shouldPlayLineUnlockDetail(lineItem.lineId) then
			RoomProductionModel.instance:setPlayLineUnlockDetail(lineItem.lineId, nil)

			lineItem.gatherAnimator.speed = 0

			lineItem.gatherAnimator:Play("unlock", 0, 0)
			lineItem.gatherAnimator:Update(0)
			TaskDispatcher.runDelay(self._playLineUnlockDetail, lineItem, 0.4)
		else
			lineItem.gatherAnimator.speed = 0

			lineItem.gatherAnimator:Play(UIAnimationName.Idle, 0, 0)
			lineItem.gatherAnimator:Update(0)
		end
	else
		gohelper.setActive(lineItem.goselectbg, false)
		gohelper.setActive(lineItem.goshowprocess, true)

		lineItem.imageprocess.fillAmount = 0
		lineItem.txtprocess.text = string.format("%d%%", 0)
	end

	if not lineMO.level then
		local currentLevel = 0

		if not lineMO.maxLevel then
			local maxLevel = 0

			for level = 1, maxLevel do
				local levelItem = lineItem.levelItemList[level]

				if not levelItem then
					levelItem = self:getUserDataTb_()
					levelItem.go = gohelper.cloneInPlace(lineItem.golevelitem, "item" .. level)
					levelItem.golight = gohelper.findChild(levelItem.go, "go_light")

					table.insert(lineItem.levelItemList, levelItem)
				end

				gohelper.setActive(levelItem.golight, level <= currentLevel)
				gohelper.setActive(levelItem.go, true)
			end

			for level = maxLevel + 1, #lineItem.levelItemList do
				local levelItem = lineItem.levelItemList[level]

				gohelper.setActive(levelItem.go, false)
			end

			RedDotController.instance:addRedDot(lineItem.reddot, RedDotEnum.DotNode.RoomProductionLevel, lineItem.lineId)
		end
	end
end

function RoomInitBuildingView._playLineUnlockDetail(lineItem)
	lineItem.gatherAnimator.speed = 1

	lineItem.gatherAnimator:Play("unlock", 0, 0)
end

function RoomInitBuildingView:_onChangePartStart()
	PopupController.instance:setPause("roominitbuildingview_changeeffect", true)
	UIBlockMgr.instance:startBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(self._resetChangeProcessText, self)
	self._changeItem.lineItem.animator:Play(UIAnimationName.Open, 0, 0)

	if self._changeItem.lineItem.tweenId then
		if self._scene.tween then
			self._scene.tween:killById(self._changeItem.lineItem.tweenId)
		else
			ZProj.TweenHelper.KillById(self._changeItem.lineItem.tweenId)
		end

		self._changeItem.lineItem.tweenId = nil
	end

	self._changeItem.lineItem.tweenId = self._scene.tween and self._scene.tween:tweenFloat(0, 1, 1.3, self._changeEffectFrame, self._changeEffectFinish, self) or ZProj.TweenHelper.DOTweenFloat(0, 1, 1.3, self._changeEffectFrame, self._changeEffectFinish, self)
end

function RoomInitBuildingView:_changeEffectFrame(value)
	self._changeItem.lineItem.txtprocess.text = string.format("%d%%", math.ceil(value * 100))
end

function RoomInitBuildingView:_changeEffectFinish()
	self._changeItem.lineItem.txtprocess.text = "100%"

	PopupController.instance:setPause("roominitbuildingview_changeeffect", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.runDelay(self._resetChangeProcessText, self, 1)
end

function RoomInitBuildingView:_resetChangeProcessText()
	if self._changeItem then
		self._changeItem.lineItem.txtprocess.text = "0%"
	end
end

function RoomInitBuildingView:_onCloseView(viewName)
	self:_resetChangeProcessText()

	if viewName == ViewName.RoomLevelUpTipsView and self._selectTabId == RoomInitBuildingView.TabId.ProductionLine then
		self:_refreshInitPart()
	end
end

function RoomInitBuildingView:onUpdateParam()
	self:_refreshUI(true)
end

function RoomInitBuildingView:onOpen()
	self:_refreshUI(true)

	if self.viewParam and self.viewParam.showFormulaView then
		self:_changeSelectPart(3)
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._refreshLevel, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._refreshCategory, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.UpdateProduceLineData, self._refreshInitPart, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.UpdateProduceLineData, self._refreshDetailPart, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.GainProductionLineReply, self._gainProductionLineCallback, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.OnChangePartStart, self._onChangePartStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshRoomLevelUpEffect, self)
	NavigateMgr.instance:addEscape(ViewName.RoomInitBuildingView, self._onEscape, self)
end

function RoomInitBuildingView:onClose()
	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_close)
	end
end

function RoomInitBuildingView:_onEscape()
	ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, false, true)
	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function RoomInitBuildingView:onDestroyView()
	PopupController.instance:setPause("roominitbuildingview_changeeffect", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(self._resetChangeProcessText, self)
	TaskDispatcher.cancelTask(self._realChangeSelectPart, self)
	TaskDispatcher.cancelTask(self._changeShowSkinList, self)
	TaskDispatcher.cancelTask(self._updateDetailPartGatherSelectLineTime, self)

	self._keepOpenSkinListAfterChange = false

	for i, categoryItem in ipairs(self._categoryItemList) do
		categoryItem.btnclick:RemoveClickListener()
	end

	for i, initPartProductItem in ipairs(self._initPartProductItemList) do
		initPartProductItem.simagereward:UnLoadImage()
		initPartProductItem.btnget:RemoveClickListener()
		initPartProductItem.btnjumpclick:RemoveClickListener()

		for _, lineItem in ipairs(initPartProductItem.lineItemList) do
			TaskDispatcher.cancelTask(self._playLineUnlock, lineItem)
		end
	end

	for i, initPartChangeItem in ipairs(self._initPartChangeItemList) do
		initPartChangeItem.simagedoor:UnLoadImage()
		initPartChangeItem.btncombine:RemoveClickListener()

		for _, initPartChangeFormulaItem in ipairs(initPartChangeItem.formulaItemList) do
			initPartChangeFormulaItem.btnlockclick:RemoveClickListener()
		end
	end

	if self._changeItem then
		self._changeItem.lineItem.btnupgrade:RemoveClickListener()

		if self._changeItem.lineItem.tweenId then
			if self._scene.tween then
				self._scene.tween:killById(self._changeItem.lineItem.tweenId)
			else
				ZProj.TweenHelper.KillById(self._changeItem.lineItem.tweenId)
			end

			self._changeItem.lineItem.tweenId = nil
		end

		self._changeItem = nil
	end

	if self._gatherItem then
		self._gatherItem.btnget:RemoveClickListener()
		self._gatherItem.btnnewget:RemoveClickListener()

		for i, lineItem in ipairs(self._gatherItem.lineItemList) do
			lineItem.btnupgrade:RemoveClickListener()
			lineItem.btnclick:RemoveClickListener()
		end

		for _, lineItem in ipairs(self._gatherItem.lineItemList) do
			TaskDispatcher.cancelTask(self._playLineUnlockDetail, lineItem)
		end

		self._gatherItem = nil
	end

	self._flyEffectRewardInfoList = nil

	self:_clearLineAnimation()
	self._simagecombinebg:UnLoadImage()
	self._simagemask:UnLoadImage()
	RoomSkinController.instance:setRoomSkinListVisible()
end

return RoomInitBuildingView

-- chunkname: @modules/logic/equip/view/EquipStrengthenView.lua

module("modules.logic.equip.view.EquipStrengthenView", package.seeall)

local EquipStrengthenView = class("EquipStrengthenView", BaseView)

function EquipStrengthenView:onInitView()
	self._gobeforewhite = gohelper.findChild(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_beforewhite")
	self._imagewhite = gohelper.findChildImage(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_white")
	self._goafterwhite = gohelper.findChild(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_afterwhite")
	self._imagegreen1 = gohelper.findChildImage(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_green1")
	self._gofullexp = gohelper.findChild(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_fullexp")
	self._txtaddexp = gohelper.findChildText(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_addexp")
	self._txtexp = gohelper.findChildText(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_exp")
	self._gomaxbreakbartip = gohelper.findChild(self.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_maxbreakbartip")
	self._gobarPos = gohelper.findChild(self.viewGO, "layoutgroup/progress/bar/#go_barPos")
	self._txtcurlevel = gohelper.findChildText(self.viewGO, "layoutgroup/progress/#txt_curlevel")
	self._golevelupeffect = gohelper.findChild(self.viewGO, "layoutgroup/progress/#go_leveup")
	self._txttotallevel = gohelper.findChildText(self.viewGO, "layoutgroup/progress/#txt_curlevel/#txt_totallevel")
	self._goengravingEffect = gohelper.findChild(self.viewGO, "layoutgroup/progress/#engraving")
	self._gomaxbreaktip = gohelper.findChild(self.viewGO, "#go_maxbreaktip")
	self._golevelup = gohelper.findChild(self.viewGO, "layoutgroup/attribute/container/#go_levelup")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "layoutgroup/attribute/container/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "layoutgroup/attribute/container/#go_breakeffect")
	self._gocost = gohelper.findChild(self.viewGO, "#go_cost")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "#go_cost/txt_onceCombine")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "#go_cost/strengthen_cost/currency/#simage_currency")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "#go_cost/strengthen_cost/currency/#txt_currency")
	self._gonocurrency = gohelper.findChild(self.viewGO, "#go_cost/strengthen_cost/currency/#go_nocurrency")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_cost/#go_btns")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cost/#go_btns/start/#btn_upgrade")
	self._btnbreak = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cost/#go_btns/break/#btn_break")
	self._txtcostcount = gohelper.findChildText(self.viewGO, "#go_cost/title/#txt_costcount")
	self._gobreakcount = gohelper.findChild(self.viewGO, "#go_cost/title/#go_breakcount")
	self._goimprove = gohelper.findChild(self.viewGO, "#go_improve")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cost/fast/#btn_fastadd")
	self._gosortbtns = gohelper.findChild(self.viewGO, "#go_improve/#go_sortbtns")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_improve/#go_sortbtns/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_improve/#go_sortbtns/#btn_rarerank")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_improve/#go_sortbtns/#btn_filter")
	self._btnback = gohelper.findChildButton(self.viewGO, "#go_improve/#btn_back")
	self._golackequip = gohelper.findChild(self.viewGO, "#go_improve/#go_lackequip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipStrengthenView:addEvents()
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
	self._btnbreak:AddClickListener(self._btnbreakOnClick, self)
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function EquipStrengthenView:removeEvents()
	self._btnupgrade:RemoveClickListener()
	self._btnbreak:RemoveClickListener()
	self._btnfastadd:RemoveClickListener()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

EquipStrengthenView.ShowContainerStatusEnum = {
	ShowBreak = 2,
	ShowUpgrade = 1,
	ShowMax = 3
}
EquipStrengthenView.LevelChangeAnimationTime = 0.5
EquipStrengthenView.Color = {
	NormalColor = Color.New(0.8509803921568627, 0.6274509803921569, 0.43529411764705883, 1),
	NextColor = Color.New(0.5137254901960784, 0.7372549019607844, 0.5176470588235295, 1)
}

function EquipStrengthenView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = self.viewName
	})
end

function EquipStrengthenView:_btnlvrankOnClick()
	EquipChooseListModel.instance:sordByLevel()
	self:_refreshEquipBtnIcon()
end

function EquipStrengthenView:_btnrarerankOnClick()
	EquipChooseListModel.instance:sordByQuality()
	self:_refreshEquipBtnIcon()
end

function EquipStrengthenView:_refreshEquipBtnIcon()
	local tag = EquipChooseListModel.instance:getBtnTag()

	gohelper.setActive(self._equipLvBtns[1], tag ~= 1)
	gohelper.setActive(self._equipLvBtns[2], tag == 1)
	gohelper.setActive(self._equipQualityBtns[1], tag ~= 2)
	gohelper.setActive(self._equipQualityBtns[2], tag == 2)

	local levelState, qualityState = EquipChooseListModel.instance:getRankState()

	transformhelper.setLocalScale(self._equipLvArrow[1], 1, levelState, 1)
	transformhelper.setLocalScale(self._equipLvArrow[2], 1, levelState, 1)
	transformhelper.setLocalScale(self._equipQualityArrow[1], 1, qualityState, 1)
	transformhelper.setLocalScale(self._equipQualityArrow[2], 1, qualityState, 1)
end

function EquipStrengthenView:_btnbackOnClick()
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function EquipStrengthenView:_btnfastaddOnClick()
	if self.breaking then
		return
	end

	EquipChooseListModel.instance:fastAddEquip()
end

function EquipStrengthenView:_btnupgradeOnClick()
	local key = PlayerModel.instance:getPlayerPrefsKey(EquipLvUpEnum.ShowUseTipKey)
	local today = ServerTime.getServerTimeToday(true)
	local saveToday = PlayerPrefsHelper.getNumber(key, 0)

	if today ~= saveToday then
		local lvUpItem = EquipLvUpModel.instance:getCanUseItemId(self._equipMO.equipId)

		if lvUpItem then
			ViewMgr.instance:openView(ViewName.EquipLvUpItemUseTipView, {
				itemId = lvUpItem,
				equipMo = self._equipMO,
				yesFunc = self.closeThis,
				yesFuncObj = self,
				closeFunc = self._upgradeFunc,
				closeFuncObj = self
			})

			return
		end
	end

	self:_upgradeFunc()
end

function EquipStrengthenView:_upgradeFunc()
	local list = EquipChooseListModel.instance:getChooseEquipList()

	if not list or #list == 0 then
		if self._goimprove.activeSelf then
			GameFacade.showToast(ToastEnum.EquipStrengthenNoItem)
		end

		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)

		return
	end

	if not self._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	local uids = {}
	local haveFiveStar = false
	local haveInteam = false

	for i, v in ipairs(list) do
		table.insert(uids, {
			v.uid,
			v._chooseNum
		})

		haveInteam = haveInteam or EquipChooseListModel.instance:getHeroMoByEquipUid(v.uid)

		if v.config.isExpEquip == 0 and v.config.rare >= 4 then
			haveFiveStar = true
		end
	end

	local now = os.date("*t", ServerTime.nowInLocal() - 18000)

	if haveInteam ~= nil or haveFiveStar then
		if self._playerSaveTabs.saveTime ~= nil then
			if self._playerSaveTabs.saveTime ~= now.day then
				local var_11_0 = {
					callback = function(notPrompt)
						if notPrompt then
							self._playerSaveTabs.saveTime = now.day
							self._playUserIdTabs[self._curPlayerInfoId] = self._playerSaveTabs

							local saveStr = cjson.encode(self._playUserIdTabs)

							PlayerPrefsHelper.setString(PlayerPrefsKey.EquipStrengthen, saveStr)
						end

						EquipRpc.instance:sendEquipStrengthenRequest(self._equipMO.uid, uids)
					end
				}

				var_11_0.content = haveInteam == nil and luaLang("equip_lang_3") or luaLang("equip_lang_2")

				EquipController.instance:openEquipStrengthenAlertView(var_11_0)

				goto label_11_0
			end
		end
	end

	EquipRpc.instance:sendEquipStrengthenRequest(self._equipMO.uid, uids)

	::label_11_0::
end

function EquipStrengthenView:_hideGravingEffect()
	gohelper.setActive(self._goengravingEffect, false)
end

function EquipStrengthenView:_btnbreakOnClick()
	if not self._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	if not self._enoughBreak then
		if self._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onEasyCombineFinished, self)
		end

		return
	end

	self.breaking = true

	EquipChooseListModel.instance:setIsLock(self.breaking)
	EquipRpc.instance:sendEquipBreakRequest(self._equipMO.uid)
end

function EquipStrengthenView:_onEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnbreakOnClick()
end

function EquipStrengthenView:_hideLevelUpEffect()
	gohelper.setActive(self._golevelupeffect, false)
end

function EquipStrengthenView:_editableInitView()
	self.breakSuccessAnimationTime = self._golevelupeffect:GetComponent(typeof(UnityEngine.Animation)).clip.length
	self._animimprove = self._goimprove:GetComponent(typeof(UnityEngine.Animator))
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._strengthenattrs = self:getUserDataTb_()

	gohelper.setActive(self._gostrengthenattr, false)

	self._whiteWidth = recthelper.getWidth(self._imagewhite.transform)
	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")
	self.txtBreakPreValue = gohelper.findChildText(self._gobreakeffect, "txt_prevalue")
	self.goBreakRightArrow = gohelper.findChild(self._gobreakeffect, "go_rightarrow")
	self.goNotFilter = gohelper.findChild(self.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_notfilter")
	self.goFilter = gohelper.findChild(self.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_filter")

	local currencyname = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Gold).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrency, currencyname .. "_1")

	self._equipLvBtns = self:getUserDataTb_()
	self._equipLvArrow = self:getUserDataTb_()
	self._equipQualityBtns = self:getUserDataTb_()
	self._equipQualityArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._equipLvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._equipLvArrow[i] = gohelper.findChild(self._equipLvBtns[i], "txt/arrow").transform
		self._equipQualityBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._equipQualityArrow[i] = gohelper.findChild(self._equipQualityBtns[i], "txt/arrow").transform
	end

	gohelper.setActive(self._equipLvArrow[1].gameObject, false)
	gohelper.setActive(self._equipQualityArrow[1].gameObject, false)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnbreak.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(self._btnupgrade.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(self._btnfastadd.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Addall)

	self._enoughBreak = false
	self.breaking = false

	EquipChooseListModel.instance:setIsLock(self.breaking)

	self.initDropDone = false

	self:initFilterDrop()

	self._goupgrade = gohelper.findChild(self._gobtns, "start")
	self._gobreak = gohelper.findChild(self._gobtns, "break")

	gohelper.setActive(self._goimprove, false)

	self.initDropDone = true
	self.showContainerStatus = EquipStrengthenView.ShowContainerStatusEnum.ShowUpgrade

	self:setBtnBackWidth()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.setBtnBackWidth, self)
end

function EquipStrengthenView:setBtnBackWidth()
	local improveWidth = recthelper.getWidth(self._goimprove.transform)

	recthelper.setWidth(self._btnback.gameObject.transform, 0.45 * improveWidth)
end

function EquipStrengthenView:onDropHide()
	transformhelper.setLocalScale(self.trDropArrow, 1, 1, 1)
end

function EquipStrengthenView:onDropShow()
	transformhelper.setLocalScale(self.trDropArrow, 1, -1, 1)
end

function EquipStrengthenView:initFilterDrop()
	self.dropFilter = gohelper.findChildDropdown(self._gocost, "#drop_filter")
	self.trDropArrow = gohelper.findChildComponent(self.dropFilter.gameObject, "Arrow", typeof(UnityEngine.Transform))
	self.dropClick = gohelper.getClick(self.dropFilter.gameObject)
	self.dropExtend = DropDownExtend.Get(self.dropFilter.gameObject)

	self.dropExtend:init(self.onDropShow, self.onDropHide, self)

	self.filterRareLevelList = {}

	for i = 2, EquipConfig.instance:getMaxFilterRare() do
		table.insert(self.filterRareLevelList, i)
	end

	local dropStrList = {}

	for _, value in ipairs(self.filterRareLevelList) do
		if value == 0 then
			table.insert(dropStrList, luaLang("equip_filter_all"))
		else
			table.insert(dropStrList, string.format(luaLang("equip_filter_str"), value))
		end
	end

	self.dropFilter:ClearOptions()
	self.dropFilter:AddOptions(dropStrList)
	self.dropFilter:AddOnValueChanged(self.onDropValueChanged, self)
	self.dropClick:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)

	local filterRare = EquipChooseListModel.instance:getFilterRare()

	for index, value in ipairs(self.filterRareLevelList) do
		if value == filterRare then
			self.dropFilter:SetValue(index - 1)

			break
		end
	end
end

function EquipStrengthenView:onDropValueChanged(index)
	if not self.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipChooseListModel.instance:setFilterRare(self.filterRareLevelList[index + 1])
end

function EquipStrengthenView:onUpdateParam()
	return
end

function EquipStrengthenView:onOpen()
	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)
	self._equipMO = self.viewContainer.viewParam.equipMO
	self._config = self._equipMO.config
	self._equipMaxLv = EquipConfig.instance:getMaxLevel(self._config)

	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self._onEquipStrengthenReply, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onChooseChange, self._onChooseChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self._onUpdateEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._onUpdateEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onStrengthenFast, self._btnfastaddOnClick, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onStrengthenUpgrade, self._btnupgradeOnClick, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self._onBreakSuccess, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipLockChange, self._onEquipLockChange, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshBreakCostIcon, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCost, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onEquipTypeHasChange, self)
	EquipChooseListModel.instance:initEquipMo(self._equipMO, false)
	EquipChooseListModel.instance:initEquipList(self.filterCareer)

	self._playUserIdTabs = self:getUserDataTb_()
	self._playerSaveTabs = self:getUserDataTb_()

	local savePlayerIdTab = PlayerPrefsHelper.getString(PlayerPrefsKey.EquipStrengthen, "")

	if not string.nilorempty(savePlayerIdTab) then
		self._playUserIdTabs = cjson.decode(savePlayerIdTab)
	end

	self._curPlayerInfoId = PlayerModel.instance:getPlayinfo().userId

	if self._playUserIdTabs[self._curPlayerInfoId] == nil then
		self._playerSaveTabs.saveTime = nil
		self._playUserIdTabs[self._curPlayerInfoId] = self._playerSaveTabs
	else
		self._playerSaveTabs = self._playUserIdTabs[self._curPlayerInfoId]
	end

	self:showContainer()
	self:updateLevelInfo(self._equipMO.level)

	if self.viewContainer:getIsOpenLeftBackpack() then
		self.viewContainer.equipView:hideRefineScrollAndShowStrengthenScroll()
	else
		gohelper.setActive(self._goimprove, false)
	end

	self._viewAnim:Play(UIAnimationName.Open)
	self:playOutsideNodeAnimation(UIAnimationName.Open)
	self.viewContainer:playCurrencyViewAnimation("go_righttop_ina")

	if self.viewParam.useLvUpItem then
		self:playExpBreakAnimationEffect()
		self:playExpAnimationEffect()

		self.viewParam.useLvUpItem = nil
	end
end

function EquipStrengthenView:showContainer()
	if self._equipMO.level == self._equipMaxLv then
		self.showContainerStatus = EquipStrengthenView.ShowContainerStatusEnum.ShowMax

		self:hideUpgradeAndBreakContainer()

		return
	end

	if self._equipMO.level == EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO) then
		self.showContainerStatus = EquipStrengthenView.ShowContainerStatusEnum.ShowBreak

		self:showBreakContainer()

		return
	end

	self.showContainerStatus = EquipStrengthenView.ShowContainerStatusEnum.ShowUpgrade

	self:showUpgradeContainer()
end

function EquipStrengthenView:showScrollContainer()
	self.isShow = true

	EquipChooseListModel.instance:setEquipList()
	self:refreshEquipChooseEmptyContainer()
	self:_refreshEquipBtnIcon()
	gohelper.setActive(self._goimprove, true)
	self._animimprove:Play("go_improve_in")
end

function EquipStrengthenView:hideScrollContainer()
	self.isShow = false

	self._animimprove:Play("go_improve_out")
	TaskDispatcher.runDelay(self._hideImprove, self, EquipEnum.AnimationDurationTime)
end

function EquipStrengthenView:refreshEquipChooseEmptyContainer()
	local count = EquipChooseListModel.instance:getCount()

	gohelper.setActive(self._golackequip, count == 0)
end

function EquipStrengthenView:_hideImprove()
	gohelper.setActive(self._goimprove, false)
end

function EquipStrengthenView:onEquipTypeHasChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self.viewContainer.equipView:setStrengthenScrollVerticalNormalizedPosition(1)
	EquipChooseListModel.instance:initEquipList(self.filterMo, true)
	EquipChooseListModel.instance:setEquipList()
	self:refreshFilterBtn()
end

function EquipStrengthenView:refreshFilterBtn()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self.goNotFilter, not isFiltering)
	gohelper.setActive(self.goFilter, isFiltering)
end

function EquipStrengthenView:_onUpdateEquip()
	if self.tabContainer._curTabId ~= EquipCategoryListModel.ViewIndex.EquipStrengthenViewIndex then
		return
	end

	EquipChooseListModel.instance:initEquipList(self.career, true)
	EquipChooseListModel.instance:setEquipList()
	self:refreshEquipChooseEmptyContainer()
end

function EquipStrengthenView:_updateCostItemList()
	local exp = EquipChooseListModel.instance:calcStrengthen()

	self._txtaddexp.text = exp > 0 and "EXP+" .. exp or ""

	self:showStrengthenEffect(exp)
end

function EquipStrengthenView:_onChooseChange()
	self._txtcostcount.text = string.format("%s<color=#E8E5DF>(%s/%s)</color>", luaLang("p_equip_8"), EquipChooseListModel.instance:getChooseEquipsNum(), EquipEnum.StrengthenMaxCount)

	self:_updateCostItemList()
end

function EquipStrengthenView:playExpAnimationEffect()
	TaskDispatcher.cancelTask(self._hideGravingEffect, self)
	gohelper.setActive(self._goengravingEffect, true)
	TaskDispatcher.runDelay(self._hideGravingEffect, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_engrave)
end

function EquipStrengthenView:playExpBreakAnimationEffect()
	gohelper.setActive(self._golevelupeffect, true)
end

function EquipStrengthenView:_onEquipStrengthenReply()
	self.isUpgradeReply = true

	EquipChooseListModel.instance:initEquipList(self.career, false)
	EquipChooseListModel.instance:setEquipList()
	self:refreshEquipChooseEmptyContainer()
	EquipChooseListModel.instance:resetSelectedEquip()
	self:playExpAnimationEffect()

	self._expList = nil

	self:showContainer()

	self.isUpgradeReply = false
end

function EquipStrengthenView:showStrengthenEffect(addexp)
	if self._equipMaxLv == self._equipMO.level then
		return
	end

	addexp = addexp or 0

	local costCo = EquipConfig.instance:getEquipStrengthenCostCo(self._config.rare, self._equipMO.level + 1)
	local nextLevel = self._equipMO.level

	recthelper.setWidth(self._imagegreen1.transform, 0)

	local upgrade = false

	if addexp > 0 then
		nextLevel = EquipConfig.instance:getStrengthenToLv(self._config.rare, self._equipMO.level, self._equipMO.exp + addexp)
		upgrade = nextLevel ~= self._equipMO.level

		local costCoin = EquipConfig.instance:getStrengthenToLvCost(self._config.rare, self._equipMO.level, self._equipMO.exp, addexp)

		self._enoughGold = self:setCurrencyValue(costCoin)

		self:showExpAnimation(addexp, costCo)
	else
		self._enoughGold = self:setCurrencyValue(0)
		self._txtcurrency.text = ""

		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurrency, "#E8E5DF")

		if self._expList then
			self:showExpAnimation(addexp, costCo)

			self._expList = nil
		end
	end

	ZProj.UGUIHelper.SetGrayscale(self._btnupgrade.gameObject, addexp <= 0)

	local curExp, costExp = EquipConfig.instance:getStrengthenToLvExpInfo(self._config.rare, self._equipMO.level, self._equipMO.exp, addexp)
	local progressWidth = self._whiteWidth * math.min(self._equipMO.exp / costCo.exp, 1)

	recthelper.setWidth(self._imagewhite.transform, progressWidth)

	self._txtexp.text = string.format("%s/%s", curExp, costExp)

	self:setAttribute(addexp, upgrade, costCo, nextLevel)
end

function EquipStrengthenView:setAttribute(addexp, upgrade, costCo, nextLevel)
	self._upgrade = upgrade
	self._addexp = addexp
	self._attrIndex = 1

	if upgrade then
		local hp1, atk1, def1, mdef1 = EquipConfig.instance:getEquipAddBaseAttr(self._equipMO)
		local hp, atk, def, mdef = EquipConfig.instance:getEquipAddBaseAttr(self._equipMO, nextLevel)

		self:showAttr(CharacterEnum.AttrId.Attack, 0, atk, atk1, costCo)
		self:showAttr(CharacterEnum.AttrId.Hp, 0, hp, hp1, costCo)
		self:showAttr(CharacterEnum.AttrId.Defense, 0, def, def1, costCo)
		self:showAttr(CharacterEnum.AttrId.Mdefense, 0, mdef, mdef1, costCo)
	else
		local hp, atk, def, mdef = EquipConfig.instance:getEquipAddBaseAttr(self._equipMO)

		self:showAttr(CharacterEnum.AttrId.Attack, 0, atk)
		self:showAttr(CharacterEnum.AttrId.Hp, 0, hp)
		self:showAttr(CharacterEnum.AttrId.Defense, 0, def)
		self:showAttr(CharacterEnum.AttrId.Mdefense, 0, mdef)
	end

	for i = self._attrIndex, #self._strengthenattrs do
		gohelper.setActive(self._strengthenattrs[i].go, false)
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(self._config, self._equipMO.breakLv)

	if attrId then
		gohelper.setActive(self._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.imageBreakIcon, "icon_att_" .. attrId)

		self.txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)

		gohelper.setAsLastSibling(self._gobreakeffect)

		if self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowBreak then
			local _, nextValue = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(self._config, self._equipMO.breakLv + 1)

			self.txtBreakPreValue.text = EquipHelper.getAttrPercentValueStr(value)
			self.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(nextValue)
			self.txtBreakValue.color = EquipStrengthenView.Color.NextColor

			gohelper.setActive(self.goBreakRightArrow, true)
			gohelper.setActive(self.txtBreakPreValue, true)
		else
			self.txtBreakValue.color = EquipStrengthenView.Color.NormalColor

			gohelper.setActive(self.goBreakRightArrow, false)
			gohelper.setActive(self.txtBreakPreValue, false)

			self.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)
		end
	else
		gohelper.setActive(self._gobreakeffect, false)
	end
end

function EquipStrengthenView:showBreakLv(go, lv)
	local transform = go.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)
		local image = gohelper.onceAddComponent(child.gameObject, gohelper.Type_Image)

		UISpriteSetMgr.instance:setEquipSprite(image, i <= lv and "xx_11" or "xx_10")
	end
end

function EquipStrengthenView:calcTotalExp(expList)
	if not expList then
		return 0, 0
	end

	return expList[1], expList[2]
end

function EquipStrengthenView:showExpAnimation(addexp, costCo)
	if self.isUpgradeReply then
		return
	end

	local prevExpList = self._expList
	local isArrivedMax

	self._expList, isArrivedMax = EquipConfig.instance:getStrengthenToLvCostExp(self._config.rare, self._equipMO.level, self._equipMO.exp, addexp, self._equipMO.breakLv)

	local prevStartValue, prevTotalValue = self:calcTotalExp(prevExpList)
	local curStartValue, curTotalValue = self:calcTotalExp(self._expList)

	if self._sequence then
		self._sequence:destroy()
	end

	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO)

	local function linearScale(value)
		local addPercentLevel = curStartValue + value
		local floorAddLevel = Mathf.Floor(addPercentLevel)
		local percentLevel = addPercentLevel - floorAddLevel
		local currentLevel = self._equipMO.level + floorAddLevel

		if curTotalValue >= prevTotalValue and currentLevel >= currentBreakLvMaxLevel or curTotalValue <= prevTotalValue and self._equipMO.level + curTotalValue + curStartValue >= currentBreakLvMaxLevel then
			if self.tweenWork then
				self.tweenWork:clearWork()
				self:setExpProgressStatus(true)
				self:updateLevelInfo(currentBreakLvMaxLevel)
				self:setMaxLevelTxtExp(true)
			end

			return
		end

		if floorAddLevel > 0 then
			recthelper.setWidth(self._imagewhite.transform, 0)
			self._imagegreen1.transform:SetParent(self._goafterwhite.transform)
		else
			if costCo then
				local progressWidth = self._whiteWidth * math.min(self._equipMO.exp / costCo.exp, 1)

				recthelper.setWidth(self._imagewhite.transform, progressWidth)
			end

			self._imagegreen1.transform:SetParent(self._gobeforewhite.transform)
		end

		recthelper.setWidth(self._imagegreen1.transform, percentLevel * self._whiteWidth)
		self:updateLevelInfo(currentLevel)
	end

	local time = self._skipExpAnimation and 0 or 0.2

	self:setExpProgressStatus(false)

	self.tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		from = prevTotalValue,
		to = curTotalValue,
		t = time,
		frameCb = linearScale,
		ease = EaseType.Linear
	})
	self._sequence = FlowSequence.New()

	self._sequence:addWork(self.tweenWork)
	self._sequence:registerDoneListener(function()
		if isArrivedMax then
			self:setExpProgressStatus(true)
			self:updateLevelInfo(currentBreakLvMaxLevel)
			self:setMaxLevelTxtExp(true)
		end
	end)
	self._sequence:start()
end

function EquipStrengthenView:updateLevelInfo(level)
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO)

	self._txttotallevel.text = string.format("<color=#E8E5DF>/%s</color>", currentBreakLvMaxLevel)
	self._txtcurlevel.text = math.min(level, currentBreakLvMaxLevel)
end

function EquipStrengthenView:showAttr(attrId, type, attrValue, prevAttrValue, costCo)
	if attrValue <= -1 then
		return
	end

	local isIncrease = prevAttrValue and prevAttrValue < attrValue
	local _attrCo = HeroConfig.instance:getHeroAttributeCO(attrId)
	local index = self._attrIndex
	local strengthenattr = self._strengthenattrs[index]

	if not strengthenattr then
		strengthenattr = self:getUserDataTb_()
		strengthenattr.go = gohelper.cloneInPlace(self._gostrengthenattr, "item" .. index)
		strengthenattr.txtvalue = gohelper.findChildText(strengthenattr.go, "layout/txt_value")
		strengthenattr.txtname = gohelper.findChildText(strengthenattr.go, "layout/txt_name")
		strengthenattr.imageicon = gohelper.findChildImage(strengthenattr.go, "image_icon")
		strengthenattr.txtprevvalue = gohelper.findChildText(strengthenattr.go, "layout/txt_prevvalue")
		strengthenattr.gorightarrow = gohelper.findChild(strengthenattr.go, "layout/go_rightarrow")
		strengthenattr.bg = gohelper.findChild(strengthenattr.go, "layout/go_bg")

		table.insert(self._strengthenattrs, strengthenattr)
	end

	gohelper.setActive(strengthenattr.bg, index % 2 == 0)
	CharacterController.instance:SetAttriIcon(strengthenattr.imageicon, attrId, GameUtil.parseColor("#736E6A"))

	strengthenattr.txtvalue.text = self._upgrade and EquipConfig.instance:dirGetEquipValueStr(type, attrValue) or "+0"

	if self._upgrade and self._addexp > 0 then
		SLFramework.UGUI.GuiHelper.SetColor(strengthenattr.txtvalue, "#83BC84")
	else
		SLFramework.UGUI.GuiHelper.SetColor(strengthenattr.txtvalue, "#CAC8C5")
	end

	strengthenattr.txtname.text = _attrCo.name

	if isIncrease then
		strengthenattr.txtprevvalue.text = EquipConfig.instance:dirGetEquipValueStr(type, prevAttrValue) or EquipConfig.instance:dirGetEquipValueStr(type, attrValue)
	end

	gohelper.setActive(strengthenattr.gorightarrow, true)
	gohelper.setActive(strengthenattr.go, true)

	self._attrIndex = self._attrIndex + 1

	if not costCo then
		strengthenattr.txtvalue.text = strengthenattr.txtprevvalue.text

		gohelper.setActive(strengthenattr.txtprevvalue.gameObject, false)
		gohelper.setActive(strengthenattr.gorightarrow, false)
	else
		gohelper.setActive(strengthenattr.txtprevvalue.gameObject, true)
		gohelper.setActive(strengthenattr.gorightarrow, true)
	end
end

function EquipStrengthenView:showUpgradeContainer()
	EquipSelectedListModel.instance:initList()
	self:_onChooseChange()
	EquipController.instance:dispatchEvent(EquipEvent.onShowStrengthenListModelContainer)
	gohelper.setActive(self._gocost, true)
	gohelper.setActive(self._gostart, true)
	gohelper.setActive(self._gobreak, false)
	self._gomaxbreaktip:SetActive(false)
	self._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(self._golevelup, false)
	gohelper.setActive(self._gobreakcount, false)
	gohelper.setActive(self._txtcostcount.gameObject, true)
	gohelper.setActive(self._goupgrade, true)
	gohelper.setActive(self._gobreak, false)
	gohelper.setActive(self._gocaneasycombinetip, false)
	self:setExpProgressStatus(false)
	self:refreshFilterBtn()
end

function EquipStrengthenView:showBreakContainer()
	local costCo = EquipConfig.instance:getNextBreakLevelCostCo(self._equipMO)

	if not costCo or not costCo.cost then
		return
	end

	self._enoughBreak = self:setBreakCostIconAndDispatchEvent(costCo)
	self._enoughGold = self:setCurrencyValue(costCo.scoreCost)

	self:setAttribute(0, false)
	ZProj.UGUIHelper.SetGrayscale(self._btnbreak.gameObject, not self._enoughBreak and not self._canEasyCombine or not self._enoughGold)
	gohelper.setActive(self._gocost, true)
	gohelper.setActive(self._gostart, false)
	gohelper.setActive(self._gobreak, true)
	self._gomaxbreaktip:SetActive(false)
	self._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(self._golevelup, true)
	gohelper.setActive(self._gobreakcount, true)
	gohelper.setActive(self._txtcostcount.gameObject, false)
	gohelper.setActive(self._goupgrade, false)
	gohelper.setActive(self._gobreak, true)
	self:setExpProgressStatus(true)
	self:setMaxLevelTxtExp()

	local currentMaxLvTxt = gohelper.findChildText(self._golevelup, "layout/txt_prevvalue")
	local nextMaxLvTxt = gohelper.findChildText(self._golevelup, "layout/txt_value")

	currentMaxLvTxt.text = string.format("%s/%s", self._equipMO.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO))
	nextMaxLvTxt.text = string.format("%s/%s", self._equipMO.level, EquipConfig.instance:getNextBreakLevelMaxLevel(self._equipMO))
end

function EquipStrengthenView:hideUpgradeAndBreakContainer()
	EquipController.instance:dispatchEvent(EquipEvent.onHideBreakAndStrengthenListModelContainer)
	self:setAttribute(0, false)
	self:setMaxLevelTxtExp()

	self._txttotallevel.text = ""
	self._txtcurlevel.text = self._equipMO.level

	recthelper.setWidth(self._imagewhite.transform, self._whiteWidth)
	self._gomaxbreaktip:SetActive(true)
	self:hideStrengthenScroll()
	self._gomaxbreakbartip:SetActive(false)
	self._gocost:SetActive(false)
	self:setExpProgressStatus(true)
end

function EquipStrengthenView:setMaxLevelTxtExp(showAddExp)
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO)
	local currentLevelNeedExp = EquipConfig.instance:getEquipStrengthenCostCo(self._config.rare, currentBreakLvMaxLevel).exp

	self._txtexp.text = string.format("%s/%s", tostring(currentLevelNeedExp), tostring(currentLevelNeedExp))

	if not showAddExp then
		self._txtaddexp.text = ""
	end
end

function EquipStrengthenView:setCurrencyValue(value)
	local enoughGold = false

	if value <= CurrencyModel.instance:getGold() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurrency, "#E8E5DF")

		enoughGold = true
		self._occupyGold = value
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurrency, "#CC4E4E")

		enoughGold = false
		self._occupyGold = 0
	end

	self._txtcurrency.text = value ~= 0 and value or ""

	gohelper.setActive(self._gonocurrency, value <= 0)
	self:checkCanEasyCombine()

	return enoughGold
end

function EquipStrengthenView:enoughBreakConsume(costItems)
	self._lackedItemDataList = {}
	self._occupyItemDic = {}

	local isEnough = true

	for i = 1, #costItems do
		local type = costItems[i].type
		local id = costItems[i].id
		local costQuantity = costItems[i].quantity
		local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

		if hasQuantity < costQuantity then
			local lackedQuantity = costQuantity - hasQuantity

			table.insert(self._lackedItemDataList, {
				type = type,
				id = id,
				quantity = lackedQuantity
			})

			isEnough = false
		else
			self._occupyItemDic[type] = self._occupyItemDic[type] or {}
			self._occupyItemDic[type][id] = (self._occupyItemDic[type][id] or 0) + costQuantity
		end
	end

	self:checkCanEasyCombine()

	return isEnough
end

function EquipStrengthenView:checkCanEasyCombine()
	local occupyDic = {}

	if self._occupyItemDic then
		for type, itemDic in pairs(self._occupyItemDic) do
			occupyDic[type] = itemDic
		end
	end

	local goldOccupyDic = occupyDic[MaterialEnum.MaterialType.Currency]

	if not goldOccupyDic then
		goldOccupyDic = {}
		occupyDic[MaterialEnum.MaterialType.Currency] = goldOccupyDic
	end

	goldOccupyDic[CurrencyEnum.CurrencyType.Gold] = (goldOccupyDic[CurrencyEnum.CurrencyType.Gold] or 0) + (self._occupyGold or 0)
	self._canEasyCombine = false

	if self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowBreak then
		self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, occupyDic)
	end

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
end

function EquipStrengthenView:setExpProgressStatus(isMaxLevel)
	gohelper.setActive(self._gofullexp, isMaxLevel)
	gohelper.setActive(self._goafterwhite, not isMaxLevel)
	gohelper.setActive(self._imagewhite.gameObject, not isMaxLevel)
end

function EquipStrengthenView:_onBreakSuccess()
	self:showContainer()

	if self.flow then
		self.flow:destroy()
	end

	self.flow = FlowSequence.New()

	if self.viewContainer:isOpenLeftStrengthenScroll() then
		self.flow:addWork(DelayFuncWork.New(self.hideStrengthenScroll, self, EquipEnum.AnimationDurationTime))
	end

	self.flow:addWork(DelayFuncWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_breach)
	end, self, 0.3))
	self.flow:addWork(DelayFuncWork.New(self.playExpBreakAnimationEffect, self, self.breakSuccessAnimationTime))
	self.flow:addWork(DelayFuncWork.New(self._hideLevelUpEffect, self, 0))
	self.flow:addWork(DelayFuncWork.New(self.levelChangeAnimation, self, EquipStrengthenView.LevelChangeAnimationTime))
	self.flow:addWork(DelayFuncWork.New(self.refreshLevelInfo, self, 0))
	self.flow:registerDoneListener(self.onBreakAnimationDone, self)
	self.flow:start()
end

function EquipStrengthenView:onBreakAnimationDone()
	self.breaking = false

	EquipChooseListModel.instance:setIsLock(self.breaking)
end

function EquipStrengthenView:_onEquipLockChange(param)
	local equipUid = param.uid
	local isLock = param.isLock

	if isLock then
		local equipMo = EquipModel.instance:getEquip(equipUid)

		EquipChooseListModel.instance:deselectEquip(equipMo)
	end
end

function EquipStrengthenView:hideStrengthenScroll()
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function EquipStrengthenView:levelChangeAnimation()
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO)
	local preBreakLvMaxLevel = EquipConfig.instance:_getBreakLevelMaxLevel(self._equipMO.config.rare, self._equipMO.breakLv - 1)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(preBreakLvMaxLevel, currentBreakLvMaxLevel, EquipStrengthenView.LevelChangeAnimationTime, self.setMaxLevel, self.tweenDone, self, nil, EaseType.Linear)
end

function EquipStrengthenView:setMaxLevel(value)
	self._txttotallevel.text = "/" .. value
end

function EquipStrengthenView:tweenDone()
	self.tweenId = nil
end

function EquipStrengthenView:refreshLevelInfo()
	self:updateLevelInfo(self._equipMO.level)
end

function EquipStrengthenView:setBreakCostIconAndDispatchEvent(costCo)
	local costItems = {}
	local costStrItems = string.split(costCo.cost, "|")

	for i = 1, #costStrItems do
		local consume = string.splitToNumber(costStrItems[i], "#")
		local o = {}

		o.type = tonumber(consume[1])
		o.id = tonumber(consume[2])
		o.quantity = tonumber(consume[3])

		table.insert(costItems, o)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onShowBreakCostListModelContainer, costStrItems)

	return self:enoughBreakConsume(costItems)
end

function EquipStrengthenView:_refreshBreakCostIcon()
	local costCo = EquipConfig.instance:getNextBreakLevelCostCo(self._equipMO)

	self._enoughBreak = self:setBreakCostIconAndDispatchEvent(costCo)

	ZProj.UGUIHelper.SetGrayscale(self._btnbreak.gameObject, not self._enoughBreak and not self._canEasyCombine or not self._enoughGold)
end

function EquipStrengthenView:refreshCost()
	if self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowUpgrade then
		local exp = EquipChooseListModel.instance:calcStrengthen()
		local costCoin = EquipConfig.instance:getStrengthenToLvCost(self._config.rare, self._equipMO.level, self._equipMO.exp, exp)

		self._enoughGold = self:setCurrencyValue(costCoin)
	elseif self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowBreak then
		local costCo = EquipConfig.instance:getNextBreakLevelCostCo(self._equipMO)

		if not costCo or not costCo.cost then
			return
		end

		self._enoughGold = self:setCurrencyValue(costCo.scoreCost)
	end
end

function EquipStrengthenView:onClose()
	EquipChooseListModel.instance:clearEquipList()
	EquipSelectedListModel.instance:clearList()

	self._expList = nil

	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipStrengthenView)
	EquipBreakCostListModel.instance:clearList()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if self.flow then
		self.flow:destroy()
	end

	self.flow = nil
	self.breaking = false

	EquipChooseListModel.instance:setIsLock(self.breaking)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self:playCloseAnimation()
end

function EquipStrengthenView:playCloseAnimation()
	self._viewAnim:Play(UIAnimationName.Close)
	self:playOutsideNodeAnimation(UIAnimationName.Close)
	self.viewContainer:playCurrencyViewAnimation("go_righttop_out")
end

function EquipStrengthenView:playOutsideNodeAnimation(aniName)
	if self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowUpgrade then
		self.viewContainer.equipView.costEquipScrollAnim:Play(aniName)
	elseif self.showContainerStatus == EquipStrengthenView.ShowContainerStatusEnum.ShowBreak then
		self.viewContainer.equipView.breakEquipScrollAnim:Play(aniName)
	end
end

function EquipStrengthenView:onDestroyView()
	EquipFilterModel.instance:clear(self.viewName)
	TaskDispatcher.cancelTask(self._hideGravingEffect, self)
	TaskDispatcher.cancelTask(self._hideImprove, self)
	self.dropFilter:RemoveOnValueChanged()
	self.dropClick:RemoveClickListener()

	if self._sequence then
		self._sequence:destroy()
	end

	if self.dropExtend then
		self.dropExtend:dispose()
	end
end

return EquipStrengthenView

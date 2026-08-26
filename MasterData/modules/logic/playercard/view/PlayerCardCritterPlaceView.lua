-- chunkname: @modules/logic/playercard/view/PlayerCardCritterPlaceView.lua

module("modules.logic.playercard.view.PlayerCardCritterPlaceView", package.seeall)

local PlayerCardCritterPlaceView = class("PlayerCardCritterPlaceView", BaseView)

function PlayerCardCritterPlaceView:onInitView()
	self._gocritterview1 = gohelper.findChild(self.viewGO, "#go_critterview1")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview1/#btn_unfold")
	self._gocritterview2 = gohelper.findChild(self.viewGO, "#go_critterview2")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview2/#btn_fold")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview1/#btn_close")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview2/#btn_close")
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnbadge = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview1/#go_switch/#btn_badge")
	self._btncritter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview1/#go_switch/#btn_critter")
	self._gobadgeicon = gohelper.findChild(self.viewGO, "#go_badgeicon")
	self._goselected = gohelper.findChild(self.viewGO, "#go_badgeicon/#go_selected")
	self._imagebadge = gohelper.findChildImage(self.viewGO, "#go_badgeicon/#image_badge")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_badgeicon/#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_badgeicon/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCritterPlaceView:addEvents()
	self._btnunfold:AddClickListener(self._btnunfoldOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self, true)
	self._btnclose1:AddClickListener(self.closeThis, self, true)
	self._btnclose2:AddClickListener(self.closeThis, self, true)
	self._btnbadge:AddClickListener(self._btnbadgeOnClick, self)
	self._btncritter:AddClickListener(self._btncritterOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SelectCritter, self._onRefreshCritter, self)
end

function PlayerCardCritterPlaceView:removeEvents()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btnbadge:RemoveClickListener()
	self._btncritter:RemoveClickListener()
	self._toggleHideBadge:RemoveOnValueChanged()
end

function PlayerCardCritterPlaceView:_btnbadgeOnClick()
	self:_cutEquipType(PlayerCardEnum.EquipType.Badge)
end

function PlayerCardCritterPlaceView:_btncritterOnClick()
	self:_cutEquipType(PlayerCardEnum.EquipType.Critter)
end

function PlayerCardCritterPlaceView:_btnunfoldOnClick()
	self._isFold = false
	self._canvasGroup1.blocksRaycasts = false
	self._canvasGroup2.blocksRaycasts = true
	self.currentScrollView = self._critterView2
	self._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	self._critterView2.scrollCritter.verticalNormalizedPosition = 1

	self:playAnim("switchup")
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(self.filterMO)

	self._scrollRect = self._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function PlayerCardCritterPlaceView:_btnfoldOnClick(playAnim)
	self._isFold = true
	self._canvasGroup1.blocksRaycasts = true
	self._canvasGroup2.blocksRaycasts = false
	self.currentScrollView = self._critterView1
	self._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	self._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if playAnim then
		self:playAnim("switchdown")
	end

	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(self.filterMO)

	self._scrollRect = self._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function PlayerCardCritterPlaceView:_editableInitView()
	self._canvasGroup1 = self._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._canvasGroup2 = self._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._critterView1 = self:getUserDataTb_()
	self._critterView2 = self:getUserDataTb_()

	self:initCritterView(self._critterView1, self._gocritterview1, 1)
	self:initCritterView(self._critterView2, self._gocritterview2, 2)

	self.currentScrollView = self._critterView1
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._equipTb = self:getUserDataTb_()
	self._equipTb[PlayerCardEnum.EquipType.Critter] = self:getUserDataTb_()
	self._equipTb[PlayerCardEnum.EquipType.Badge] = self:getUserDataTb_()
	self._equipTb[PlayerCardEnum.EquipType.Critter].scorllList = self:getUserDataTb_()
	self._equipTb[PlayerCardEnum.EquipType.Badge].scorllList = self:getUserDataTb_()
	self._equipTb[PlayerCardEnum.EquipType.Badge].goempty = self:getUserDataTb_()

	for i = 1, 2 do
		local go1 = gohelper.findChild(self.viewGO, string.format("#go_critterview%s/critterscroll", i))

		table.insert(self._equipTb[PlayerCardEnum.EquipType.Critter].scorllList, go1)

		local go2 = gohelper.findChild(self.viewGO, string.format("#go_critterview%s/badgescroll", i))
		local empty = gohelper.findChild(go2, "#go_empty")

		table.insert(self._equipTb[PlayerCardEnum.EquipType.Badge].scorllList, go2)
		table.insert(self._equipTb[PlayerCardEnum.EquipType.Badge].goempty, empty)
	end

	self._equipTb[PlayerCardEnum.EquipType.Critter].btnSelect = gohelper.findChild(self._btncritter.gameObject, "go_select")
	self._equipTb[PlayerCardEnum.EquipType.Critter].btnUnselect = gohelper.findChild(self._btncritter.gameObject, "go_normal")
	self._equipTb[PlayerCardEnum.EquipType.Badge].btnSelect = gohelper.findChild(self._btnbadge.gameObject, "go_select")
	self._equipTb[PlayerCardEnum.EquipType.Badge].btnUnselect = gohelper.findChild(self._btnbadge.gameObject, "go_normal")
	self._toggleHideBadge = gohelper.findChildToggle(self.viewGO, "#go_critterview1/badgescroll/#toggle_option")

	self._toggleHideBadge:AddOnValueChanged(self._toggleHideBadgeOnClick, self)
end

function PlayerCardCritterPlaceView:_toggleHideBadgeOnClick()
	PlayerCardModel.instance:setHideBadgeFromOthers(self._toggleHideBadge.isOn)
end

function PlayerCardCritterPlaceView:initMatureDropFilter(dropmaturefilter)
	self._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local filterName = {}

	for _, filterType in ipairs(self._filterTypeList) do
		local filterTypeNameLangId = CritterEnum.MatureFilterTypeName[filterType]
		local filterTypeName = luaLang(filterTypeNameLangId)

		table.insert(filterName, filterTypeName)
	end

	dropmaturefilter:ClearOptions()
	dropmaturefilter:AddOptions(filterName)
end

function PlayerCardCritterPlaceView:playAnim(animName)
	self.animator.enabled = true

	self.animator:Play(animName)
end

function PlayerCardCritterPlaceView:onDropShow()
	transformhelper.setLocalScale(self._critterView1._transmatureDroparrow, 1, 1, 1)
	transformhelper.setLocalScale(self._critterView2._transmatureDroparrow, 1, 1, 1)
end

function PlayerCardCritterPlaceView:onMatureDropValueChange(index)
	self:_refreshDropCareer(self._critterView1._dropmaturefilter, index)
	self:_refreshDropCareer(self._critterView2._dropmaturefilter, index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	if self._filterTypeList then
		PlayerCardCritterPlaceListModel.instance:selectMatureFilterType(self._filterTypeList, self.filterMO)
	end
end

function PlayerCardCritterPlaceView:_refreshDropCareer(dropdown, index)
	dropdown:SetValue(index)
end

function PlayerCardCritterPlaceView:onDropHide()
	transformhelper.setLocalScale(self._critterView1._transmatureDroparrow, 1, -1, 1)
	transformhelper.setLocalScale(self._critterView2._transmatureDroparrow, 1, -1, 1)
end

function PlayerCardCritterPlaceView:initCritterView(critterView, goCritterView, index)
	critterView._btncirtterRare = gohelper.findChildButtonWithAudio(goCritterView, "crittersort/#btn_cirtterRare")
	critterView._transcritterRareArrow = gohelper.findChild(goCritterView, "crittersort/#btn_cirtterRare/selected/txt/arrow").transform
	critterView._dropmaturefilter = gohelper.findChildDropdown(goCritterView, "crittersort/#drop_mature")
	critterView._transmatureDroparrow = gohelper.findChild(goCritterView, "crittersort/#drop_mature/#go_arrow").transform
	critterView.scrollCritter = gohelper.findChildScrollRect(goCritterView, "critterscroll")
	critterView.sortMoodItem = self:getUserDataTb_()
	critterView.sortRareItem = self:getUserDataTb_()
	critterView.dropExtend = DropDownExtend.Get(critterView._dropmaturefilter.gameObject)

	critterView.dropExtend:init(self.onDropShow, self.onDropHide, self)
	critterView._dropmaturefilter:AddOnValueChanged(self.onMatureDropValueChange, self)
	critterView._btncirtterRare:AddClickListener(self._btncirtterRareOnClick, self)
	self:initMatureDropFilter(critterView._dropmaturefilter)
end

function PlayerCardCritterPlaceView:onUpdateParam()
	return
end

function PlayerCardCritterPlaceView:onOpen()
	self.animator:Play("open")

	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	self:_btnfoldOnClick()
	self:refreshRareSort()
	self:_onRefreshSelectEquipType()

	local constCo = lua_playercard_const.configDict[4]
	local tasktypeIds = string.splitToNumber(constCo.value2, "#")

	TaskRpc.instance:sendGetTaskInfoRequest(tasktypeIds, self._refreshBadgeList, self)

	local isHideBadge = self:getCardInfo():getShowSettingByType(PlayerCardEnum.ShowSettingsType.HideBadgeFormOther)

	self._toggleHideBadge.isOn = isHideBadge == 1

	local isCritterOpen = PlayerCardModel.instance:getCritterOpen()

	gohelper.setActive(self._btncritter.gameObject, isCritterOpen)
end

function PlayerCardCritterPlaceView:_refreshBadgeList()
	PlayerCardBadgeListModel.instance:setBadgeList()

	local list = PlayerCardBadgeListModel.instance:getList()
	local tb = self._equipTb[PlayerCardEnum.EquipType.Badge]

	for i = 1, 2 do
		gohelper.setActive(tb.goempty[i], #list == 0)
	end
end

function PlayerCardCritterPlaceView:refreshRareSort()
	local cardInfo = self:getCardInfo()

	if not cardInfo then
		return
	end

	local isRareAscend
	local equipType = cardInfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.ShowEquipType)
	local scaleY = (equipType == PlayerCardEnum.EquipType.Critter and PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend() or PlayerCardBadgeListModel.instance:isRareAscend()) and 1 or -1

	transformhelper.setLocalScale(self._critterView1._transcritterRareArrow, 1, scaleY, 1)
	transformhelper.setLocalScale(self._critterView2._transcritterRareArrow, 1, scaleY, 1)
end

function PlayerCardCritterPlaceView:_btncirtterRareOnClick()
	local cardInfo = self:getCardInfo()

	if not cardInfo then
		return
	end

	local equipType = cardInfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.ShowEquipType)

	if equipType == PlayerCardEnum.EquipType.Critter then
		local isRareAscend = PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend()

		PlayerCardCritterPlaceListModel.instance:setIsSortByRareAscend(not isRareAscend)
		PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(self.filterMO)
	else
		local isRareAscend = PlayerCardBadgeListModel.instance:isRareAscend()

		PlayerCardBadgeListModel.instance:sortList(not isRareAscend)
	end

	self:refreshRareSort()
end

function PlayerCardCritterPlaceView:_onRefreshCritter()
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(self.filterMO)
end

function PlayerCardCritterPlaceView:getCardInfo()
	self._cardInfo = self._cardInfo or PlayerCardModel.instance:getCardInfo()

	return self._cardInfo
end

function PlayerCardCritterPlaceView:_onRefreshSelectEquipType()
	local cardInfo = self:getCardInfo()

	if not cardInfo then
		return
	end

	local equipType = cardInfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.ShowEquipType)

	for _, type in pairs(PlayerCardEnum.EquipType) do
		local isSelect = equipType == type
		local tb = self._equipTb[type]

		gohelper.setActive(tb.btnSelect, isSelect)
		gohelper.setActive(tb.btnUnselect, not isSelect)

		for i = 1, 2 do
			gohelper.setActive(tb.scorllList[i], isSelect)
		end
	end

	gohelper.setActive(self._critterView1._dropmaturefilter.gameObject, equipType == PlayerCardEnum.EquipType.Critter)
	gohelper.setActive(self._critterView2._dropmaturefilter.gameObject, equipType == PlayerCardEnum.EquipType.Critter)
end

function PlayerCardCritterPlaceView:_cutEquipType(type)
	local cardInfo = self:getCardInfo()

	if cardInfo then
		local settings = cardInfo:setShowSetting(PlayerCardEnum.ShowSettingsType.ShowEquipType, type)

		PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(settings)
	end

	self:_onRefreshSelectEquipType()
	self:refreshRareSort()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.CutEquipType)
end

function PlayerCardCritterPlaceView:onClose()
	PlayerCardCritterPlaceListModel.instance:clearData()
	self.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseCritterView)
end

function PlayerCardCritterPlaceView:onDestroyView()
	self:_critterViewOnDestroy(self._critterView1)
	self:_critterViewOnDestroy(self._critterView2)
end

function PlayerCardCritterPlaceView:_critterViewOnDestroy(critterView)
	if critterView.dropExtend then
		critterView.dropExtend:dispose()
	end

	if critterView._btncirtterRare then
		critterView._btncirtterRare:RemoveClickListener()
	end

	if critterView._dropmaturefilter then
		critterView._dropmaturefilter:RemoveOnValueChanged()
	end
end

return PlayerCardCritterPlaceView

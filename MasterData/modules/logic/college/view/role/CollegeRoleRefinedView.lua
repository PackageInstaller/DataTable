-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedView.lua

module("modules.logic.college.view.role.CollegeRoleRefinedView", package.seeall)

local CollegeRoleRefinedView = class("CollegeRoleRefinedView", BaseView)
local ViewState = {
	Compare = 2,
	Select = 1,
	Success = 3
}

function CollegeRoleRefinedView:onInitView()
	self._goRoleRoot = gohelper.findChild(self.viewGO, "root/#go_Select/#go_RoleRoot")
	self._goSelect = gohelper.findChild(self.viewGO, "root/#go_Select")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Select/Buttons/#btn_Start")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Select/Buttons/#btn_Start/#txt_tips")
	self._btnReplace = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Select/#btn_Replace")
	self._goCompare = gohelper.findChild(self.viewGO, "root/#go_Compare")
	self._goOldRoleRoot = gohelper.findChild(self.viewGO, "root/#go_Compare/#go_OldRoleRoot")
	self._goOldRolePos = gohelper.findChild(self.viewGO, "root/#go_Compare/#go_OldRoleRoot/#go_OldRolePos")
	self._btnSelectOld = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Compare/#go_OldRoleRoot/#btn_SelectOld")
	self._goNewRoleRoot = gohelper.findChild(self.viewGO, "root/#go_Compare/#go_NewRoleRoot")
	self._goNewRolePos = gohelper.findChild(self.viewGO, "root/#go_Compare/#go_NewRoleRoot/#go_NewRolePos")
	self._btnSelectNew = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Compare/#go_NewRoleRoot/#btn_SelectNew")
	self._goSuccess = gohelper.findChild(self.viewGO, "root/#go_Success")
	self._goSuccessRolePos = gohelper.findChild(self.viewGO, "root/#go_Success/#go_SuccessRolePos")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Success/#btn_Close")
	self._goButtons = gohelper.findChild(self.viewGO, "root/#go_Select/Buttons")
	self._goCostRow = gohelper.findChild(self.viewGO, "root/#go_Select/Buttons/#go_CostRow")
	self._costComp = CollegeResCostComp.Get(self._goCostRow)
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Compare/#go_NewRoleRoot/#btn_Refresh")
	self._goRefreshCostRow = gohelper.findChild(self.viewGO, "root/#go_Compare/#go_NewRoleRoot/#btn_Refresh/#go_RefreshCostRow")
	self._refreshCostComp = CollegeResCostComp.Get(self._goRefreshCostRow)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRoleRefinedView:addEvents()
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnReplace:AddClickListener(self._btnReplaceOnClick, self)
	self._btnSelectOld:AddClickListener(self._btnSelectOldOnClick, self)
	self._btnSelectNew:AddClickListener(self._btnSelectNewOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnSelectRefined, self._onSelectRefined, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnServerMsgUpdate, self.refreshUI, self)
end

function CollegeRoleRefinedView:removeEvents()
	self._btnStart:RemoveClickListener()
	self._btnReplace:RemoveClickListener()
	self._btnSelectOld:RemoveClickListener()
	self._btnSelectNew:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function CollegeRoleRefinedView:_btnStartOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoleRefreshEntry)
	CollegeRpc.instance:sendCollegeBuildingRefined(self._selectMo.uid)
end

function CollegeRoleRefinedView:_btnReplaceOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRefinedBagView, {
		selectMo = self._selectMo
	})
end

function CollegeRoleRefinedView:_btnSelectOldOnClick()
	self._newCharacterMo = nil
	self._isSelectLeft = true
	self._isRefresh = false

	CollegeRpc.instance:sendCollegeBuildingConfirmEntry(1)
end

function CollegeRoleRefinedView:_btnSelectNewOnClick()
	self._isSelectLeft = false
	self._isRefresh = false

	CollegeStoryHelper.instance:setLockPlayStory(true)
	CollegeRpc.instance:sendCollegeBuildingConfirmEntry(2)
end

function CollegeRoleRefinedView:_btnCloseOnClick()
	self._newCharacterMo = nil

	self._animatorPlayer:Play("again", self._updateViewVisible, self)
	self:refreshUI()
end

function CollegeRoleRefinedView:_btnRefreshOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	self._isRefresh = true

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoleRefreshEntry)
	CollegeRpc.instance:sendCollegeBuildingRefined(self._newCharacterMo.uid)
end

function CollegeRoleRefinedView:_defaultPlayAnimDone()
	return
end

function CollegeRoleRefinedView:_editableInitView()
	self._goBtnReplace = self._btnReplace.gameObject
	self._goBtnStart = self._btnStart.gameObject
	self._goBtnRefresh = self._btnRefresh.gameObject
	self._goRolePanel = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goRoleRoot)
	self._selectRolePanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._goRolePanel, CollegeRoleRefinedPanelItem, self)
	self._characterBox = CollegeModel.instance:getSceneMo().characterBox
	self._state = ViewState.Select
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	gohelper.setActive(self._goSelect, false)
	gohelper.setActive(self._goCompare, false)
	gohelper.setActive(self._goSuccess, false)
end

function CollegeRoleRefinedView:onOpen()
	self._animatorPlayer:Play("open", self._defaultPlayAnimDone, self)
	self:refreshUI()
end

function CollegeRoleRefinedView:refreshUI()
	local buildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)

	if buildingMo then
		::label_13_0::

		local var_13_0 = buildingMo.refinedProp

		if buildingMo.refinedProp then
			local refinedActorUid = buildingMo.refinedProp.uid
			local state = ViewState.Select

			if refinedActorUid and refinedActorUid ~= 0 then
				local characterBox = CollegeModel.instance:getSceneMo().characterBox

				self._selectMo = characterBox:getCharacterMo(refinedActorUid)
				state = ViewState.Compare
			elseif self._newCharacterMo then
				state = ViewState.Success
			else
				self._selectMo = self._selectMo or self.viewParam and self.viewParam.selectMo
			end

			self:switchState(state)
		end
	end
end

function CollegeRoleRefinedView:switchState(state)
	self._state = state or self._state

	if self._state == ViewState.Select then
		self:refreshSelectStateUI()
	elseif self._state == ViewState.Compare then
		self:refreshCompareStateUI()
	elseif self._state == ViewState.Success then
		self:refreshSuccessStateUI()
	end
end

function CollegeRoleRefinedView:isSelectState()
	return self._state == ViewState.Select
end

function CollegeRoleRefinedView:refreshSelectStateUI()
	gohelper.setActive(self._goSelect, true)

	local isSelectMo = self._selectMo ~= nil

	gohelper.setActive(self._goBtnReplace.gameObject, isSelectMo)
	gohelper.setActive(self._goButtons, isSelectMo)
	self._selectRolePanel:onUpdateMO(self._selectMo)

	if isSelectMo then
		local lockEntriesNum = self._selectMo:getLockEntriesNum()
		local refinedBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)

		if refinedBuildingMo then
			if not refinedBuildingMo.refineCanLockNum then
				local maxLockEntriesNum = 0

				maxLockEntriesNum = math.min(maxLockEntriesNum, #self._selectMo.entries - 1)

				gohelper.setActive(self._txtTips.gameObject, maxLockEntriesNum > 0)

				if maxLockEntriesNum > 0 then
					self._txtTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_rolerefined_tips"), lockEntriesNum, maxLockEntriesNum)
				end

				local costTb, rate = CollegeAttrHelper.getRefineCostAndRate(lockEntriesNum)

				self._costComp:onUpdateMO(costTb, {
					rate
				})

				self._isEnough = CollegeModel.instance:isEnoughItemsTb(costTb, rate)

				ZProj.UGUIHelper.SetGrayscale(self._goBtnStart, not self._isEnough)
			end
		end
	end

	if self._isSelectLeft then
		self._animatorPlayer:Play("left_success", self._updateViewVisible, self)
	end
end

function CollegeRoleRefinedView:refreshCompareStateUI()
	gohelper.setActive(self._goCompare, true)
	self:checkCompareCharacterInitDone()
	self:createNewCharacterMo()
	self:updateRefreshBtn()
	self._oldCharacterItem:onUpdateMO(self._selectMo)
	self._newCharacterItem:onUpdateMO(self._newCharacterMo, self._newEntryIndexMap)

	if not self._isRefresh then
		UIBlockHelper.instance:startBlock(self.viewName, 0.33, self.viewName)
		self._animatorPlayer:Play("compare", self._onPlayCompareAnimDone, self)
	else
		self:_onPlayCompareAnimDone()
	end
end

function CollegeRoleRefinedView:updateRefreshBtn()
	local costTb, rate = CollegeAttrHelper.getRefineCostAndRate(self._newCharacterMo:getLockEntriesNum())

	self._refreshCostComp:onUpdateMO(costTb, {
		rate
	})

	self._isEnough = CollegeModel.instance:isEnoughItemsTb(costTb, rate)

	ZProj.UGUIHelper.SetGrayscale(self._goBtnRefresh, not self._isEnough)
end

function CollegeRoleRefinedView:_onPlayCompareAnimDone()
	self:_updateViewVisible()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.NewEntry)
end

function CollegeRoleRefinedView:_updateViewVisible()
	gohelper.setActive(self._goSelect, self._state == ViewState.Select)
	gohelper.setActive(self._goCompare, self._state == ViewState.Compare)
	gohelper.setActive(self._goSuccess, self._state == ViewState.Success)
end

function CollegeRoleRefinedView:checkCompareCharacterInitDone()
	if not self._oldCharacterItem then
		local goOldCharacterItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goOldRolePos)

		self._oldCharacterItem = MonoHelper.addNoUpdateLuaComOnceToGo(goOldCharacterItem, CollegeRoleRefinedNewPanelItem, self)
	end

	if not self._newCharacterItem then
		self._goNewCharacterItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goNewRolePos)
		self._newCharacterItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goNewCharacterItem, CollegeRoleRefinedNewPanelItem, self)
	end
end

function CollegeRoleRefinedView:createNewCharacterMo()
	local buildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)
	local newEntryIds = buildingMo and buildingMo.refinedProp.newEntryId
	local newEntryInfoList = {}

	self._newEntryIndexMap = {}

	for i, newEntryId in ipairs(newEntryIds) do
		local oldEntryMo = self._selectMo.entries[i]

		if not oldEntryMo or not oldEntryMo.locked then
			self._newEntryIndexMap[i] = true
		end

		local locked = oldEntryMo and oldEntryMo.locked

		table.insert(newEntryInfoList, {
			id = newEntryId,
			locked = locked
		})
	end

	self._newCharacterMo = CollegeCharacterMo.New()

	self._newCharacterMo:init({
		uid = self._selectMo.uid,
		id = self._selectMo.id,
		level = self._selectMo.level,
		entries = newEntryInfoList,
		attributeContainer = {
			attributes = {}
		}
	})
end

function CollegeRoleRefinedView:refreshSuccessStateUI()
	gohelper.setActive(self._goSuccess, true)

	if not self._successHeroItem then
		local goSuccessHeroItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goSuccessRolePos)

		self._successHeroItem = MonoHelper.addNoUpdateLuaComOnceToGo(goSuccessHeroItem, CollegeRoleRefinedNewPanelItem, self)
	end

	self._successHeroItem:onUpdateMO(self._newCharacterMo, self._newEntryIndexMap)

	self._selectMo = CollegeModel.instance:getSceneMo().characterBox:getCharacterMo(self._newCharacterMo.uid)

	self._animatorPlayer:Play("right_success", self._updateViewVisible, self)
end

function CollegeRoleRefinedView:_onSelectRefined(mo)
	self._selectMo = mo

	self:refreshUI()
	self._selectRolePanel:playAnim("add_has")
end

function CollegeRoleRefinedView:onClose()
	CollegeStoryHelper.instance:setLockPlayStory(false)
end

function CollegeRoleRefinedView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return CollegeRoleRefinedView

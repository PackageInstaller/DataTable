-- chunkname: @modules/logic/college/view/role/CollegeRoleRecruitView.lua

module("modules.logic.college.view.role.CollegeRoleRecruitView", package.seeall)

local CollegeRoleRecruitView = class("CollegeRoleRecruitView", BaseView)

function CollegeRoleRecruitView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._scrollRoleList = gohelper.findChild(self.viewGO, "root/#scroll_RoleList")
	self._goRoleContent = gohelper.findChild(self.viewGO, "root/#scroll_RoleList/Viewport/Content")
	self._goStart = gohelper.findChild(self.viewGO, "root/#go_Start")
	self._goRefresh = gohelper.findChild(self.viewGO, "root/#go_Refresh")
	self._btnAbandon = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Refresh/#btn_Abandon")
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Refresh/#btn_Refresh")
	self._goEnableRefresh = gohelper.findChild(self.viewGO, "root/#go_Refresh/#btn_Refresh/#go_EnableRefresh")
	self._goDisableRefresh = gohelper.findChild(self.viewGO, "root/#go_Refresh/#btn_Refresh/#go_DisableRefresh")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Start/#btn_Start", CollegeAudioEnum.RoleFirstRefresh)
	self._goEnableStart = gohelper.findChild(self.viewGO, "root/#go_Start/#btn_Start/#go_EnableStart")
	self._goDisableStart = gohelper.findChild(self.viewGO, "root/#go_Start/#btn_Start/#go_DisableStart")
	self._goRecruitCostRow = gohelper.findChild(self.viewGO, "root/#go_Start/#go_RecruitCostRow")
	self._goRefreshCostRow = gohelper.findChild(self.viewGO, "root/#go_Refresh/#go_RefreshCostRow")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRoleRecruitView:addEvents()
	self._btnAbandon:AddClickListener(self._btnAbandonOnClick, self)
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateBuilding, self._onUpdateBuilding, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateBag, self.refreshUI, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.ConfirmRecruit, self._onConfirmRecruit, self)
end

function CollegeRoleRecruitView:removeEvents()
	self._btnAbandon:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function CollegeRoleRecruitView:_btnAbandonOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.CollegeAbortRecruitment, MsgBoxEnum.BoxType.Yes_No, self._onRealAbandon, nil, nil, self)
end

function CollegeRoleRecruitView:_onRealAbandon()
	self._animatorPlayer:Play("again", self._defaultAnimDone, self)
	self:_playRolePanelAnim("empty")

	self._abandonRpcId = CollegeRpc.instance:sendCollegeBuildingRecruitmentConfirm(2, 0, self._sendAbandonRpcCallback, self)
end

function CollegeRoleRecruitView:_sendAbandonRpcCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._isRecruit = false

	self:refreshUI()
end

function CollegeRoleRecruitView:_btnRefreshOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	if CollegeHelper.instance:checkCanRecruit() then
		self._isStartRefresh = true

		CollegeRpc.instance:sendCollegeBuildingRecruitment()
	end
end

function CollegeRoleRecruitView:_btnStartOnClick()
	if self._isRecruit then
		return
	end

	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	if CollegeHelper.instance:checkCanRecruit() then
		self._isStartRecruit = true

		CollegeRpc.instance:sendCollegeBuildingRecruitment()
	end
end

function CollegeRoleRecruitView:_editableInitView()
	self._recruitCostComp = CollegeResCostComp.Get(self._goRecruitCostRow, CollegeEnum.ItemCostColorType.Light)
	self._refreshCostComp = CollegeResCostComp.Get(self._goRefreshCostRow, CollegeEnum.ItemCostColorType.Light)
	self._goPanelItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goRoleContent, "#go_PanelItem")
	self._rolePanelItemList = self:getUserDataTb_()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	gohelper.setActive(self._goSuccess, false)
end

function CollegeRoleRecruitView:onOpen()
	self._buildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.RecruitCharacter)
	self._buildingId = self._buildingMo and self._buildingMo.id

	self:initEmptyList()
	self:refreshUI()
end

function CollegeRoleRecruitView:onUpdateParam()
	self:refreshUI()
end

function CollegeRoleRecruitView:initEmptyList()
	self._emptyActorList = {}

	for i = 1, self._buildingMo.recruitCount do
		table.insert(self._emptyActorList, true)
	end
end

function CollegeRoleRecruitView:refreshUI()
	self._newRecruitList = self.viewParam and self.viewParam.newRecruitList

	if self._newRecruitList then
		local hasNewRecruit = #self._newRecruitList > 0

		gohelper.setActive(self._goRoot, not hasNewRecruit)

		if hasNewRecruit then
			self:onRecruitHeroSuccess()

			return
		end

		gohelper.setActive(self._goSuccess, false)

		local costTb, rate = CollegeAttrHelper.getRecruitCostAndRate()

		self._recruitCostComp:onUpdateMO(costTb, {
			rate
		})
		self._refreshCostComp:onUpdateMO(costTb, {
			rate
		})
		self:refreshRecruitHero()
		gohelper.setActive(self._goStart, not self._isRecruit)
		gohelper.setActive(self._goRefresh, self._isRecruit)

		self._isEnough = CollegeModel.instance:isEnoughItemsTb(costTb, rate)

		gohelper.setActive(self._goEnableRefresh, self._isEnough)
		gohelper.setActive(self._goDisableRefresh, not self._isEnough)
		gohelper.setActive(self._goEnableStart, self._isEnough)
		gohelper.setActive(self._goDisableStart, not self._isEnough)
	end
end

function CollegeRoleRecruitView:refreshRecruitHero()
	local actorList = self:_buildReadySelectActorList()

	gohelper.CreateObjList(self, self._refreshRecruitItem, actorList, self._goRoleContent, self._goPanelItem, CollegeRoleRecruitPanelItem)
end

function CollegeRoleRecruitView:_refreshRecruitItem(recruitItem, actorMo, index)
	recruitItem._view = self
	recruitItem._index = index

	local mo = self._isRecruit and actorMo or nil

	recruitItem:onUpdateMO(mo, self._buildingMo)

	self._rolePanelItemList[index] = recruitItem
end

function CollegeRoleRecruitView:_buildReadySelectActorList()
	if self._buildingMo then
		self._isRecruit = self._buildingMo and self._buildingMo:isRecruit()

		return (self._isRecruit or nil) and (self._buildingMo.characters or self._emptyActorList)
	end
end

function CollegeRoleRecruitView:_playRolePanelAnim(animName, ignoreHeroIndex)
	for i, roleItem in ipairs(self._rolePanelItemList) do
		if i ~= ignoreHeroIndex then
			roleItem:playAnim(animName)
		end
	end
end

function CollegeRoleRecruitView:_onUpdateBuilding()
	TaskDispatcher.cancelTask(self.refreshUI, self)

	if self._isStartRecruit then
		self:refreshUI()
		self:_playRolePanelAnim("empty_has")

		self._isStartRecruit = false
	elseif self._isStartRefresh then
		self:_tryPlayRefreshAudio()
		self:_playRolePanelAnim("update")

		self._isStartRefresh = false

		UIBlockHelper.instance:startBlock(self.viewName, 0.33, self.viewName)
		TaskDispatcher.runDelay(self.refreshUI, self, 0.33)
	else
		self:refreshUI()
	end
end

function CollegeRoleRecruitView:_tryPlayRefreshAudio()
	if self._buildingMo then
		local recruitmentProp = self._buildingMo.recruitmentProp
		local characterList = recruitmentProp and recruitmentProp.characters

		if not characterList then
			return
		end

		local maxRarity = 0

		for _, characterMo in ipairs(characterList) do
			local rarity = characterMo.co.rarity

			if maxRarity < rarity then
				maxRarity = rarity
			end
		end

		local audioId = CollegeAudioEnum["RoleRefresh" .. maxRarity]

		CollegeAudioHelper.instance:playAudio(audioId)
	end
end

function CollegeRoleRecruitView:_onConfirmRecruit(confirmIndex)
	self._confirmIndex = confirmIndex

	CollegeStoryHelper.instance:setLockPlayStory(true)
	CollegeRpc.instance:sendCollegeBuildingRecruitmentConfirm(1, confirmIndex - 1)
end

function CollegeRoleRecruitView:onRecruitHeroSuccess()
	UIBlockHelper.instance:startBlock(self.viewName, 0.5, self.viewName)
	gohelper.setActive(self._goRoot, true)
	gohelper.setActive(self._goSuccess, true)
	self:_playRolePanelAnim("close", self._confirmIndex)
	TaskDispatcher.cancelTask(self._onPlayHeroCloseAnimDone, self)
	TaskDispatcher.runDelay(self._onPlayHeroCloseAnimDone, self, 0.16)
end

function CollegeRoleRecruitView:_onPlayHeroCloseAnimDone()
	self._animatorPlayer:Play("success", self._onPlaySuccessAnimDone, self)
end

function CollegeRoleRecruitView:_onPlaySuccessAnimDone()
	UIBlockHelper.instance:endBlock(self.viewName)
	gohelper.setActive(self._goRoot, false)
	CollegeStoryHelper.instance:setLockPlayStory(false)
end

function CollegeRoleRecruitView:onClose()
	if self._abandonRpcId then
		CollegeRpc.instance:removeCallbackById(self._abandonRpcId)

		self._abandonRpcId = nil
	end

	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.cancelTask(self._onPlayHeroCloseAnimDone, self)
	UIBlockHelper.instance:endBlock(self.viewName)
end

return CollegeRoleRecruitView

-- chunkname: @modules/logic/survival/view/shelter/SurvivalMainViewButton.lua

module("modules.logic.survival.view.shelter.SurvivalMainViewButton", package.seeall)

local SurvivalMainViewButton = class("SurvivalMainViewButton", BaseView)

function SurvivalMainViewButton:onInitView()
	self.btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lefttop/#btn_exit")
	self.btnTarget = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Left/#btn_target")
	self.btnRoleWareHouse = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Left/#btn_RoleWarehouse")
	self.btnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Left/#btn_equip")
	self._goequipred = gohelper.findChild(self.viewGO, "go_normalroot/Left/#btn_equip/go_arrow")
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/BottomRight/#btn_start")
	self.btnNpc = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Left/#btn_npc")
	self.btnWareHouse = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/BottomRight/layout/#btn_Warehouse")
	self.btnBuilding = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/BottomRight/layout/#btn_build")
	self.goNewBuilding = gohelper.findChild(self.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_New")
	self.goLevupBuilding = gohelper.findChild(self.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_levelUp")
	self.goFixBuilding = gohelper.findChild(self.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_Fix")
	self.txtProgress = gohelper.findChildTextMesh(self.viewGO, "go_normalroot/Top/#go_progress/#txt_progress")
	self.goMonster = gohelper.findChild(self.viewGO, "go_normalroot/Top/#go_monster")

	gohelper.setActive(self.goMonster, false)

	self.btnMonster = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Top/#go_monster")
	self.sImgMonster = gohelper.findChildSingleImage(self.viewGO, "go_normalroot/Top/#go_monster/#go_monsterHeadIcon")
	self.txtMonsterTime = gohelper.findChildTextMesh(self.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime")
	self.goMonsterTimeIcon = gohelper.findChild(self.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime/icon")
	self.txtTaskDesc = gohelper.findChildTextMesh(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_target")
	self.txtSubTaskDesc = gohelper.findChildTextMesh(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub")
	self.goSubTaskIcon = gohelper.findChild(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/image_icon")
	self.goSubTaskReward = gohelper.findChild(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/rewardIcon")
	self.btnSubTask = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/btn")
	self.goSubTaskMask = gohelper.findChild(self.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/image_mask")
	self.goUI = gohelper.findChild(self.viewGO, "go_ui")
	self.goUI2 = gohelper.findChild(self.viewGO, "go_ui2")
	self.goNormalRoot = gohelper.findChild(self.viewGO, "go_normalroot")
	self.goLeftTop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self.igoreViewList = {
		ViewName.SurvivalRoleLevelTipPopView,
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goRaycast = gohelper.findChild(self.viewGO, "raycast")
	self.interceptMask = gohelper.findChild(self.viewGO, "interceptMask")
	self.btnLossReturn = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/BottomRight/#btnLossReturn")
end

function SurvivalMainViewButton:addEvents()
	self.addClickCb(self, self.btnSubTask, self.onClickSubTask, self)
	self.addClickCb(self, self.btnExit, self.onClickExit, self)
	self.addClickCb(self, self.btnStart, self.onClickStart, self)
	self.addClickCb(self, self.btnEquip, self.onClickEquip, self)
	self.addClickCb(self, self.btnRoleWareHouse, self.onClickRoleWareHouse, self)
	self.addClickCb(self, self.btnTarget, self.onClickTarget, self)
	self.addClickCb(self, self.btnNpc, self.onClickNpc, self)
	self.addClickCb(self, self.btnBuilding, self.onClickBuilding, self)
	self.addClickCb(self, self.btnWareHouse, self.onClickWareHouse, self)
	self.addClickCb(self, self.btnMonster, self.onClickMonster, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, self.onTaskDataUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, self.updateEquipRed, self)

	if SurvivalController.instance.isOldSettle then
		self.addEventCb(self, SurvivalController.instance, SurvivalEvent.BossPerformFinish, self.refreshInterceptMask, self)
	else
		self.addEventCb(self, SurvivalController.instance, SurvivalEvent.BossFightSuccessShowFinish, self.refreshInterceptMask, self)
	end

	self.addClickCb(self, self.btnLossReturn, self.onClickLossReturn, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalLossReturnRewardReply, self.onReceiveSurvivalLossReturnRewardReply, self)
end

function SurvivalMainViewButton:removeEvents()
	self:removeClickCb(self.btnSubTask)
	self:removeClickCb(self.btnExit)
	self:removeClickCb(self.btnStart)
	self:removeClickCb(self.btnNpc)
	self:removeClickCb(self.btnBuilding)
	self:removeClickCb(self.btnEquip)
	self:removeClickCb(self.btnRoleWareHouse)
	self:removeClickCb(self.btnTarget)
	self:removeClickCb(self.btnWareHouse)
	self:removeClickCb(self.btnMonster)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, self.onTaskDataUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, self.updateEquipRed, self)
	TaskDispatcher.cancelTask(self.onDelayCheckMainViewAnim, self)
end

function SurvivalMainViewButton:refreshHelpBtnPos()
	recthelper.setAnchorX(self.btnExit.transform, 220)
end

function SurvivalMainViewButton:_addUnlockComp(go, unlockConditions, eventParams)
	MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalButtonUnlockPart, {
		unlockConditions = unlockConditions,
		eventParams = eventParams
	})
end

function SurvivalMainViewButton:onClickSubTask()
	if not self.subTaskId then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local taskBox = weekInfo.taskPanel:getTaskBoxMo(SurvivalEnum.TaskModule.SubTask)
	local taskMo = taskBox:getTaskInfo(self.subTaskId)

	if not taskMo then
		return
	end

	if taskMo:isCangetReward() then
		SurvivalWeekRpc.instance:sendSurvivalReceiveTaskRewardRequest(SurvivalEnum.TaskModule.SubTask, taskMo.id)
	else
		JumpController.instance:jumpByParam(taskMo.co.jump)
	end
end

function SurvivalMainViewButton:onClickExit()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, self._sendGiveUp, nil, nil, self, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("onClickExit", "SurvivalMainView")
end

function SurvivalMainViewButton:_sendGiveUp()
	SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
end

function SurvivalMainViewButton:onClickStart()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()
	local needKillBoss = fight:needKillBoss()

	if needKillBoss then
		local survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()

		if not survivalBubbleComp:isPlayerBubbleShow() then
			local param = SurvivalBubbleParam.New()

			param.content = luaLang("SurvivalBubble_1")
			param.duration = -1
			self.bubbleId = survivalBubbleComp:showPlayerBubble(param)
		end

		return
	end

	SurvivalMapHelper.instance:stopShelterPlayerMove()
	SurvivalController.instance:enterSurvival()
	SurvivalStatHelper.instance:statBtnClick("onClickStart", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickMonster()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local masterFight = weekInfo:getMonsterFight()

	if masterFight and masterFight:canShowEntity() then
		SurvivalMapHelper.instance:gotoMonster(masterFight.fightId)
	end

	SurvivalStatHelper.instance:statBtnClick("onClickMonster", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickWareHouse()
	ViewMgr.instance:openView(ViewName.ShelterMapBagView)
end

function SurvivalMainViewButton:onClickRoleWareHouse()
	ViewMgr.instance:openView(ViewName.ShelterHeroWareHouseView)
	SurvivalStatHelper.instance:statBtnClick("onClickRoleWareHouse", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickTarget()
	ViewMgr.instance:openView(ViewName.ShelterTaskView)
	SurvivalStatHelper.instance:statBtnClick("onClickTarget", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickNpc()
	ViewMgr.instance:openView(ViewName.ShelterNpcManagerView)
	SurvivalStatHelper.instance:statBtnClick("onClickNpc", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickBuilding()
	ViewMgr.instance:openView(ViewName.ShelterBuildingManagerView)
	SurvivalStatHelper.instance:statBtnClick("onClickBuilding", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickEquip()
	SurvivalController.instance:openEquipView()
	SurvivalStatHelper.instance:statBtnClick("onClickEquip", "SurvivalMainView")
end

function SurvivalMainViewButton:onClickLossReturn()
	local items = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if self:haveLossReturn() then
		for k, v in ipairs(weekInfo.lossReturnItems) do
			local itemMo = SurvivalBagItemMo.New()

			itemMo:init({
				id = v.itemId,
				count = v.count
			})
			table.insert(items, itemMo)
		end

		ViewMgr.instance:openView(ViewName.SurvivalGiveBackView, {
			items = items
		})
	end
end

function SurvivalMainViewButton:onReceiveSurvivalLossReturnRewardReply()
	self:refreshLossReturnRed()
end

function SurvivalMainViewButton:refreshLossReturnRed()
	gohelper.setActive(self.btnLossReturn.gameObject, self:haveLossReturn())
end

function SurvivalMainViewButton:haveLossReturn()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo.lossReturnItems and #weekInfo.lossReturnItems > 0
end

function SurvivalMainViewButton:onOpenView()
	self:refreshViewUIVisible()
	self:refreshInterceptMask()
end

function SurvivalMainViewButton:onCloseViewFinish()
	self:refreshViewUIVisible()
end

function SurvivalMainViewButton:refreshViewUIVisible()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName, self.igoreViewList)

	self:setViewUIVisible(isTop)
end

function SurvivalMainViewButton:refreshBtnStart()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()
	local canFight = fight:needKillBoss()

	ZProj.UGUIHelper.SetGrayscale(self.btnStart.gameObject, canFight)
end

function SurvivalMainViewButton:setViewUIVisible(isVisible)
	if self._isViewUIVisible == isVisible then
		return
	end

	self._isViewUIVisible = isVisible

	TaskDispatcher.cancelTask(self.onDelayCheckMainViewAnim, self)

	if isVisible then
		self.animator:Play("in", 0, 0)
		TaskDispatcher.runDelay(self.onDelayCheckMainViewAnim, self, 0.767)
	else
		self.animator:Play("out", 0, 0)
	end

	gohelper.setActive(self.goRaycast, not isVisible)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMainViewVisible, isVisible)
end

function SurvivalMainViewButton:onDelayCheckMainViewAnim()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDelayCheckMainViewAnim)
end

function SurvivalMainViewButton:refreshInterceptMask()
	return
end

function SurvivalMainViewButton:onTaskDataUpdate()
	self:refreshTask()
end

function SurvivalMainViewButton:onWeekInfoUpdate()
	self:refreshView()
end

function SurvivalMainViewButton:onBuildingInfoUpdate()
	self:_refreshBuildingButton()
end

function SurvivalMainViewButton:onShelterBagUpdate()
	self:_refreshBuildingButton()
end

function SurvivalMainViewButton:onOpen()
	self:refreshView()
	self:refreshHelpBtnPos()
	self:refreshLossReturnRed()
end

function SurvivalMainViewButton:updateEquipRed()
	gohelper.setActive(self._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

function SurvivalMainViewButton:refreshView()
	self:refreshProgress()
	self:refreshTask()
	self:refreshButton()
	self:updateEquipRed()
	self:refreshBtnStart()
end

function SurvivalMainViewButton:refreshProgress()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.txtProgress.text = formatLuaLang("versionactivity_1_2_114daydes", weekInfo.day)
end

function SurvivalMainViewButton:refreshTask()
	local list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MainTask)
	local taskMo

	for _, v in ipairs(list) do
		if v:isUnFinish() then
			taskMo = v

			break
		end
	end

	self.txtTaskDesc.text = taskMo and taskMo:getDesc() or ""
	list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.SubTask)
	taskMo = nil

	for _, v in ipairs(list) do
		if v:isUnFinish() or v:isCangetReward() then
			taskMo = v

			break
		end
	end

	self.txtSubTaskDesc.text = taskMo and taskMo:getDesc() or ""

	local canGetReward = taskMo and taskMo:isCangetReward() or false

	gohelper.setActive(self.goSubTaskIcon, taskMo and not canGetReward)
	gohelper.setActive(self.goSubTaskReward, canGetReward)
	gohelper.setActive(self.goSubTaskMask, canGetReward)

	self.subTaskId = taskMo and taskMo.id
end

function SurvivalMainViewButton:refreshButton()
	self:_refreshBuildingButton()
end

function SurvivalMainViewButton:_refreshBuildingButton()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingStatus = weekInfo:getBuildingBtnStatus()

	gohelper.setActive(self.goNewBuilding, buildingStatus == SurvivalEnum.ShelterBuildingBtnStatus.New)
	gohelper.setActive(self.goFixBuilding, buildingStatus == SurvivalEnum.ShelterBuildingBtnStatus.Destroy)
	gohelper.setActive(self.goLevupBuilding, buildingStatus == SurvivalEnum.ShelterBuildingBtnStatus.Levelup)
end

return SurvivalMainViewButton

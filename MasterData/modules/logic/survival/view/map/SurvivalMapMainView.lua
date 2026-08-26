-- chunkname: @modules/logic/survival/view/map/SurvivalMapMainView.lua

module("modules.logic.survival.view.map.SurvivalMapMainView", package.seeall)

local SurvivalMapMainView = class("SurvivalMapMainView", SurvivalMapDragBaseView)

function SurvivalMapMainView:onInitView()
	SurvivalMapMainView.super.onInitView(self)

	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "BottomRight/#btn_bag")
	self._gobagfull = gohelper.findChild(self.viewGO, "BottomRight/#btn_bag/#go_overweight")
	self._gowarning = gohelper.findChild(self.viewGO, "BottomRight/#btn_bag/#go_warning")
	self._btnmap = gohelper.findChildButtonWithAudio(self.viewGO, "BottomRight/#btn_map")
	self._btnlog = gohelper.findChildButtonWithAudio(self.viewGO, "BottomRight/#btn_log")
	self._btnabort = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_abort")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_task")
	self._btnteam = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_team")
	self._txtTeamLv = gohelper.findChildTextMesh(self.viewGO, "Left/#btn_team/go_level/#txt_level")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_equip")
	self._goequipred = gohelper.findChild(self.viewGO, "Left/#btn_equip/go_arrow")
	self._gotask = gohelper.findChild(self.viewGO, "Left/#go_task")
	self._txtTask = gohelper.findChildTextMesh(self.viewGO, "Left/#go_task/TaskView/Viewport/Content/#txt_task")
	self._viewAnim = gohelper.findChildAnim(self.viewGO, "")
	self._imageBlack = gohelper.findChildImage(self.viewGO, "#image_black")
	self.igoreViewList = {
		ViewName.SurvivalRoleLevelTipPopView,
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView,
		ViewName.SurvivalCurrencyTipView,
		ViewName.SurvivalCommonTipsView
	}
	self.survivalrolelevelcomp = gohelper.findChild(self.viewGO, "Left/survivalrolelevelcomp")
	self.survivalRoleLevelComp = GameFacade.createLuaCompByGo(self.survivalrolelevelcomp, SurvivalRoleLevelComp)

	self.survivalRoleLevelComp:setOnClickFunc(self._onClickTeam, self)
end

function SurvivalMapMainView:addEvents()
	SurvivalMapMainView.super.addEvents(self)
	self._btnabort:AddClickListener(self._onClickAbort, self)
	self._btntask:AddClickListener(self._onClickTask, self)
	self._btnteam:AddClickListener(self._onClickTeam, self)
	self._btnequip:AddClickListener(self._onClickEquip, self)
	self._btnbag:AddClickListener(self._onClickBag, self)
	self._btnmap:AddClickListener(self._onClickMap, self)
	self._btnlog:AddClickListener(self._onClickLog, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagFull, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDerivedUpdate, self._refreshBagFull, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnRoleDateChange, self._refreshTeamLv, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, self._refreshCurTask, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, self.updateEquipRed, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnPlayerTornadoTransferBegin, self.onPlayerTornadoTransferBegin, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnPlayerTornadoTransferEnd, self.onPlayerTornadoTransferEnd, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, self.checkPlaySpBlockAudio, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onRefreshViewState, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onRefreshViewState, self)
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.refreshHelpBtnPos, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self.refreshHelpBtnPos, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnPlayGainExpAnim, self.onPlayGainExpAnim, self)
end

function SurvivalMapMainView:removeEvents()
	SurvivalMapMainView.super.removeEvents(self)
	self._btnabort:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnteam:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	self._btnmap:RemoveClickListener()
	self._btnlog:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagFull, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDerivedUpdate, self._refreshBagFull, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnRoleDateChange, self._refreshTeamLv, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, self._refreshCurTask, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, self.updateEquipRed, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnPlayerTornadoTransferBegin, self.onPlayerTornadoTransferBegin, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnPlayerTornadoTransferEnd, self.onPlayerTornadoTransferEnd, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, self.checkPlaySpBlockAudio, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onRefreshViewState, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onRefreshViewState, self)
	self.removeEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.refreshHelpBtnPos, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self.refreshHelpBtnPos, self)
end

function SurvivalMapMainView:onOpen()
	SurvivalMapMainView.super.onOpen(self)

	self._scale = 1

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	self._targetPos = Vector3(sceneMo.player:getWorldPos())

	SurvivalMapHelper.instance:setFocusPos(self._targetPos.x, self._targetPos.y, self._targetPos.z)
	self:_setScale(SurvivalMapModel.instance.save_mapScale, true)
	self:_refreshBagFull()
	self:_refreshCurTask()
	self:_refreshTeamLv()
	self:onRefreshViewState()
	self:updateEquipRed()
	self:refreshHelpBtnPos()
	self.survivalRoleLevelComp:setData()
end

function SurvivalMapMainView:refreshHelpBtnPos()
	local showHelp = HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.Survival)

	if showHelp then
		recthelper.setAnchorX(self._btnabort.transform, 349.3)
	else
		recthelper.setAnchorX(self._btnabort.transform, 215.1)
	end
end

function SurvivalMapMainView:onPlayGainExpAnim()
	self.survivalRoleLevelComp:playExpGainAnim()
end

function SurvivalMapMainView:updateEquipRed()
	gohelper.setActive(self._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

function SurvivalMapMainView:onRefreshViewState()
	if self._isTopView == nil then
		self._isTopView = true
	end

	local isInTop = ViewHelper.instance:checkViewOnTheTop(self.viewName, self.igoreViewList)

	if isInTop == self._isTopView then
		return
	end

	self._isTopView = isInTop

	self._viewAnim:Play(self._isTopView and "in" or "close", 0, 0)
end

function SurvivalMapMainView:_onClickAbort()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUp, MsgBoxEnum.BoxType.Yes_No, self._sendGiveUp, nil, nil, self, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onClickAbort", "SurvivalMapMainView")
end

function SurvivalMapMainView:_sendGiveUp()
	SurvivalInteriorRpc.instance:sendSurvivalSceneGiveUp()
end

function SurvivalMapMainView:_onClickBag()
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
	SurvivalStatHelper.instance:statBtnClick("_onClickBag", "SurvivalMapMainView")
end

function SurvivalMapMainView:_onClickTask()
	ViewMgr.instance:openView(ViewName.ShelterTaskView, {
		moduleId = SurvivalEnum.TaskModule.NormalTask
	})
	SurvivalStatHelper.instance:statBtnClick("_onClickTask", "SurvivalMapMainView")
end

function SurvivalMapMainView:_onClickTeam()
	ViewMgr.instance:openView(ViewName.SurvivalMapTeamView)
	SurvivalStatHelper.instance:statBtnClick("_onClickTeam", "SurvivalMapMainView")
end

function SurvivalMapMainView:_onClickEquip()
	SurvivalController.instance:openEquipView()
	SurvivalStatHelper.instance:statBtnClick("_onClickEquip", "SurvivalMapMainView")
end

function SurvivalMapMainView:_onClickMap()
	if SurvivalMapHelper.instance:isInFlow() then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalSmallMapView)
	SurvivalStatHelper.instance:statBtnClick("_onClickMap", "SurvivalMapMainView")
end

function SurvivalMapMainView:_onClickLog()
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperationLog()
	SurvivalStatHelper.instance:statBtnClick("_onClickLog", "SurvivalMapMainView")
end

function SurvivalMapMainView:_refreshBagFull()
	local bagMo = SurvivalMapHelper.instance:getBagMo()
	local max = bagMo:getMaxWeightLimit()
	local isFull = max < bagMo.totalMass

	gohelper.setActive(self._gobagfull, isFull)

	local per = bagMo.totalMass / max

	gohelper.setActive(self._gowarning, per >= 0.75 and per <= 1)
end

function SurvivalMapMainView:_refreshCurTask()
	local followTask = SurvivalMapModel.instance:getSceneMo().mainTask
	local taskCo = followTask.taskId > 0 and SurvivalConfig.instance:getTaskCo(followTask.moduleId, followTask.taskId)

	gohelper.setActive(self._gotask, taskCo)

	if taskCo then
		self._txtTask.text = taskCo.desc2
	end
end

function SurvivalMapMainView:calcSceneBoard()
	local camera = SurvivalMapHelper.instance:getSceneCameraComp()

	self._mapMinX = camera.mapMinX
	self._mapMaxX = camera.mapMaxX
	self._mapMinY = camera.mapMinY
	self._mapMaxY = camera.mapMaxY
	self._maxDis = camera.maxDis
	self._minDis = camera.minDis
end

function SurvivalMapMainView:onClickScene(worldpos, hexPos)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_general_click)

	local data = {}

	self.viewContainer:dispatchEvent(SurvivalEvent.OnClickSurvivalScene, hexPos, data)

	if data.use then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local playerPos = sceneMo.player.pos

	if playerPos == hexPos then
		SurvivalMapModel.instance:setShowTarget()

		if not SurvivalMapHelper.instance:isInFlow() then
			SurvivalMapHelper.instance:tryShowEventView(playerPos)
		end

		return
	end

	if not SurvivalMapHelper.instance:isInFlow() and isDebugBuild and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		local player = SurvivalMapHelper.instance:getEntity(0)

		player:setPosAndDir(hexPos, player._unitMo.dir)
		GMRpc.instance:sendGMRequest("surPlayerMove " .. hexPos.q .. " " .. hexPos.r)

		return
	end

	if not SurvivalMapModel.instance:canWalk(true) then
		return
	end

	if SurvivalMapModel.instance:isInFog2(hexPos) then
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()

		return
	end

	local walkables = SurvivalMapModel.instance:getCurMapCo().walkables
	local path = SurvivalAStarFindPath.instance:findPath(playerPos, hexPos, walkables)

	if path then
		local showTargetPos = SurvivalMapModel.instance:getShowTargetPos()

		if showTargetPos == hexPos then
			SurvivalMapModel.instance:setMoveToTarget(path[#path], path)
			SurvivalMapModel.instance:setShowTarget(nil, true)

			if not SurvivalMapHelper.instance:isInFlow() then
				local dir = SurvivalHelper.instance:getDir(playerPos, path[1])

				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(dir))
			else
				SurvivalMapHelper.instance:tryRemoveFlow()
			end
		else
			SurvivalMapModel.instance:setShowTarget(hexPos)
			table.insert(path, 1, playerPos)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(path)

			if SurvivalMapModel.instance._targetPos ~= hexPos then
				SurvivalMapModel.instance:setMoveToTarget()
			end
		end
	else
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end
end

function SurvivalMapMainView:setScenePosSafety(targetPos)
	SurvivalMapMainView.super.setScenePosSafety(self, targetPos)
	SurvivalMapHelper.instance:getSceneFogComp():updateCenterPos(targetPos)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
	SurvivalMapHelper.instance:updateCloudShow()
	self:checkPlaySpBlockAudio()
end

function SurvivalMapMainView:onSceneScaleChange()
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
	SurvivalMapHelper.instance:updateCloudShow()
end

function SurvivalMapMainView:_refreshTeamLv()
	self._txtTeamLv.text = "Lv." .. SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo.level
end

function SurvivalMapMainView:onPlayerTornadoTransferBegin()
	gohelper.setActive(self._imageBlack, true)
	ZProj.TweenHelper.DoFade(self._imageBlack, 0, 1, 0.8)
end

function SurvivalMapMainView:onPlayerTornadoTransferEnd()
	gohelper.setActive(self._imageBlack, false)
end

local v3 = Vector3()
local node = SurvivalHexNode.New()
local tornadoSpEvent

function SurvivalMapMainView:checkPlaySpBlockAudio()
	tornadoSpEvent = tornadoSpEvent or tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TornadoSpEvent)))

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height

	v3:Set(screenWidth / 2, screenHeight / 2, 0)

	local screenCenterPos = SurvivalHelper.instance:getScene3DPos(v3)

	node:set(SurvivalHelper.instance:worldPointToHex(screenCenterPos.x, screenCenterPos.y, screenCenterPos.z))

	local haveTornado
	local allPoints = SurvivalHelper.instance:getAllPointsByDis(node, 6)

	for i, v in ipairs(allPoints) do
		local units = sceneMo:getListByPos(v)

		if units then
			for _, unitMo in ipairs(units) do
				if unitMo.cfgId == tornadoSpEvent then
					haveTornado = true

					break
				end
			end
		end

		if haveTornado then
			break
		end
	end

	if haveTornado ~= self._haveTornado then
		self._haveTornado = haveTornado

		if haveTornado then
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoStart)
		else
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoEnd)
		end
	end

	local magmaState = sceneMo.sceneProp.magmaStatus

	if magmaState == SurvivalEnum.MagmaStatus.Active then
		local haveMagma

		for i, v in ipairs(allPoints) do
			local blockType = sceneMo:getBlockTypeByPos(v)

			if blockType == SurvivalEnum.UnitSubType.Magma then
				haveMagma = true

				break
			end
		end

		if haveMagma ~= self._haveMagma then
			self._haveMagma = haveMagma

			if haveMagma then
				AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaActive)
			else
				AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
			end
		end
	elseif self._haveMagma then
		self._haveMagma = nil

		AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
	end
end

function SurvivalMapMainView:onClose()
	SurvivalMapModel.instance.save_mapScale = self._scale or 1
end

function SurvivalMapMainView:onDestroyView()
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoEnd)
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
end

return SurvivalMapMainView

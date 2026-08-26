-- chunkname: @modules/logic/fight/view/FightSkillSelectView.lua

module("modules.logic.fight.view.FightSkillSelectView", package.seeall)

local FightSkillSelectView = class("FightSkillSelectView", BaseView)
local UILongPressListener = SLFramework.UGUI.UILongPressListener

function FightSkillSelectView:onInitView()
	self._clickBlock = gohelper.findChildClick(self.viewGO, "clickBlock")
	self._clickBlockTransform = self._clickBlock:GetComponent(gohelper.Type_RectTransform)
	self._longPress = UILongPressListener.Get(self._clickBlock.gameObject)
	self._guideClickObj = gohelper.findChild(self.viewGO, "guideClick")

	gohelper.setActive(self._guideClickObj, false)

	self._guideClickObj.name = "guideClick"
	self._guideClickList = {}
	self._containerGO = self.viewGO
	self._containerTr = self._containerGO.transform
	self._imgSelectGO = gohelper.findChild(self.viewGO, "imgSkillSelect")
	self._imgSelectTr = self._imgSelectGO.transform
	self._imgSelectAnimator = self._containerGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._containerGO, false)

	self.showUI = true
	self.entityVisible = true

	self:_setSelectGOActive(false)

	self.started = nil

	self._clickBlock:AddClickListener(self._onClick, self)
	self._clickBlock:AddClickDownListener(self._onClickDown, self)
	self._clickBlock:AddClickUpListener(self._onClickUp, self)
	self._longPress:AddLongPressListener(self._onLongPress, self)

	self._pressTab = {
		0.5,
		99999
	}

	self._longPress:SetLongPressTime(self._pressTab)
end

function FightSkillSelectView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self.onCameraFocusChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEnemyActionStatusChange, self.onEnemyActionStatusChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartReplay, self._removeAllEvent, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRestartStageBefore, self._onRestartStage, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillTimeLineDone, self._onSkillTimeLineDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetEntityVisibleByTimeline, self._setEntityVisibleByTimeline, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBeginWave, self._onBeginWave, self)
	self.addEventCb(self, FightController.instance, FightEvent.EntityDeadFinish, self.onEntityDeadFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.GuideCreateClickBySkinId, self._onGuideCreateClickBySkinId, self)
	self.addEventCb(self, FightController.instance, FightEvent.GuideReleaseClickBySkilId, self._onGuideReleaseClickBySkilId, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnChangeEntity, self.onChangeEntity, self)
end

function FightSkillSelectView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self.onCameraFocusChanged, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnEnemyActionStatusChange, self.onEnemyActionStatusChange, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StartReplay, self._removeAllEvent, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRestartStageBefore, self._onRestartStage, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillTimeLineDone, self._onSkillTimeLineDone, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetEntityVisibleByTimeline, self._setEntityVisibleByTimeline, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnBeginWave, self._onBeginWave, self)
	self.removeEventCb(self, FightController.instance, FightEvent.EntityDeadFinish, self.onEntityDeadFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelect, self.OnKeySelect, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnChangeEntity, self.onChangeEntity, self)
	self._clickBlock:RemoveClickListener()
	self._clickBlock:RemoveClickDownListener()
	self._clickBlock:RemoveClickUpListener()
	self._longPress:RemoveLongPressListener()

	for i, v in ipairs(self._guideClickList) do
		local click = v.click

		click:RemoveClickListener()
		click:RemoveClickDownListener()
		click:RemoveClickUpListener()
		v.longPress:RemoveLongPressListener()
	end
end

function FightSkillSelectView:_onRoundSequenceFinish()
	self:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function FightSkillSelectView:onChangeEntity(newEntity)
	local entity = FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId)

	if not entity then
		self:_resetDefaultFocus()
		FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function FightSkillSelectView:_updateGuideClick()
	for i, v in ipairs(self._guideClickList) do
		local entity = v.entity
		local entityMO = entity:getMO()
		local rectPos1X, rectPos1Y, rectPos2X, rectPos2Y = FightHelper.calcRect(entity, self._clickBlockTransform)
		local rectPosX, rectPosY
		local mountmiddleGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

		if mountmiddleGO then
			local trposX, trposY, trposZ = transformhelper.getPos(mountmiddleGO.transform)

			rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(trposX, trposY, trposZ, self._containerTr)
		else
			rectPosX = (rectPos1X + rectPos2X) / 2
			rectPosY = (rectPos1Y + rectPos2Y) / 2
		end

		recthelper.setAnchor(v.transform, rectPosX, rectPosY)

		local width = math.abs(rectPos1X - rectPos2X)
		local height = math.abs(rectPos1Y - rectPos2Y)
		local monsterSkinCO = lua_monster_skin.configDict[entityMO.skin]
		local clickBoxUnlimit = monsterSkinCO and monsterSkinCO.clickBoxUnlimit == 1
		local maxWidth = clickBoxUnlimit and 800 or 200
		local maxHeight = clickBoxUnlimit and 800 or 500
		local fixWidth = Mathf.Clamp(width, 150, maxWidth)
		local fixHeight = Mathf.Clamp(height, 150, maxHeight)

		recthelper.setSize(v.transform, fixWidth, fixHeight)
	end
end

function FightSkillSelectView:_onGuideCreateClickBySkinId(skinId, pos)
	skinId = tonumber(skinId)
	pos = tonumber(pos)

	local list = FightHelper.getAllEntitys()

	for i, v in ipairs(list) do
		local entityMO = v:getMO()

		if self:_checkEntityGuideClick(entityMO, skinId, pos) then
			FightModel.instance:setClickEnemyState(true)

			self._curClickEntityId = v.id

			local tab = self:getUserDataTb_()

			tab.entity = v

			local obj = gohelper.cloneInPlace(self._guideClickObj, "guideClick" .. skinId)

			gohelper.setActive(obj, true)

			tab.obj = obj
			tab.transform = obj.transform

			local click = gohelper.getClick(obj)

			click:AddClickListener(self._onClick, self)
			click:AddClickDownListener(self._onClickDown, self)
			click:AddClickUpListener(self._onClickUp, self)

			tab.click = click

			local longPress = UILongPressListener.Get(obj)

			longPress:AddLongPressListener(self._onLongPress, self)
			longPress:SetLongPressTime(self._pressTab)

			tab.longPress = longPress

			table.insert(self._guideClickList, tab)
			TaskDispatcher.runRepeat(self._updateGuideClick, self, 0.01)

			break
		end
	end
end

function FightSkillSelectView:_checkEntityGuideClick(entityMO, skinId, pos)
	if not entityMO then
		return false
	end

	if entityMO.skin ~= tonumber(skinId) then
		return false
	end

	if pos and tonumber(pos) ~= entityMO.position then
		return false
	end

	return true
end

function FightSkillSelectView:_onGuideReleaseClickBySkilId(skinId, pos)
	for i = #self._guideClickList, 1, -1 do
		local entityMO = self._guideClickList[i].entity:getMO()

		if self:_checkEntityGuideClick(entityMO, skinId, pos) then
			local tab = table.remove(self._guideClickList, i)
			local click = tab.click

			click:RemoveClickListener()
			click:RemoveClickDownListener()
			click:RemoveClickUpListener()
			tab.longPress:RemoveLongPressListener()
			gohelper.destroy(tab.obj)
		end
	end

	if #self._guideClickList == 0 then
		TaskDispatcher.cancelTask(self._updateGuideClick, self)
		FightModel.instance:setClickEnemyState(false)

		self._curClickEntityId = nil
	end
end

function FightSkillSelectView:_onClick(param, screenPosition)
	local entityId = param or self._curClickEntityId

	if not entityId then
		return
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	if not entity:isEnemySide() then
		return
	end

	local openFightFocus = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightFocus)
	local finishFirstGuide = GuideModel.instance:isGuideFinish(GuideController.FirstGuideId)

	if not openFightFocus and not finishFirstGuide then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

	if curOperateState == FightStageMgr.OperateStateType.Discard or curOperateState == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		if entityId == FightDataHelper.operationDataMgr.curSelectEntityId then
			FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
		else
			self:_playSelectAnim()
			FightDataHelper.operationDataMgr:setCurSelectEntityId(entityId)
		end
	else
		if entityId ~= FightDataHelper.operationDataMgr.curSelectEntityId then
			self:_playSelectAnim()
		end

		FightDataHelper.operationDataMgr:setCurSelectEntityId(entityId)
	end

	self:_updateSelectUI()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, entityId)
end

function FightSkillSelectView:_onClickDown(param, screenPosition)
	self._curClickEntityId = nil

	local entityList = FightHelper.getAllEntitys()

	for i = #entityList, 1, -1 do
		if not self:checkCanSelect(entityList[i].id) then
			table.remove(entityList, i)
		end
	end

	local entityId = FightHelper.getClickEntity(entityList, self._clickBlockTransform, screenPosition)

	if entityId then
		FightModel.instance:setClickEnemyState(true)

		self._curClickEntityId = entityId
	end
end

function FightSkillSelectView:checkCanSelect(entityId)
	if FightDataHelper.tempMgr.canNotSelectEntityIdDic[entityId] then
		return false
	end

	local entityData = FightDataHelper.entityMgr:getById(entityId)

	if entityData:isAct191Boss() then
		return false
	end

	if FightDataHelper.entityMgr:isSub(entityId) then
		return false
	end

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return false
	end

	return true
end

function FightSkillSelectView:_onClickUp(param, screenPosition)
	if self._curClickEntityId then
		FightModel.instance:setClickEnemyState(false)
	end
end

function FightSkillSelectView:_onLongPress(param)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if not self._curClickEntityId then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

	if curOperateState == FightStageMgr.OperateStateType.Discard or curOperateState == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	local entity = FightHelper.getEntity(self._curClickEntityId)

	if not entity then
		return
	end

	if FightDataHelper.entityMgr:isSub(entity.id) then
		return
	end

	self.currentFocusEntityMO = FightDataHelper.entityMgr:getById(self._curClickEntityId)

	if not self.currentFocusEntityMO then
		return
	end

	self.viewContainer:openFightFocusView(self.currentFocusEntityMO.id)
end

function FightSkillSelectView:onStageChanged(stage)
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if FightDataHelper.stateMgr.isReplay then
		logError("reply stage ?")

		return
	end

	if curStage == FightStageMgr.StageType.Operate then
		self:clearAllFlag()
		self:_updatePos()
	end
end

function FightSkillSelectView:onEntityDeadFinish()
	self:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	self:_updatePos()
end

function FightSkillSelectView:onEnemyActionStatusChange(status)
	self.showEnemyActioning = FightEnum.EnemyActionStatus.Select == status

	self:_setSelectGOActive(true)
end

function FightSkillSelectView:onUpdateParam()
	gohelper.setAsFirstSibling(self.viewGO)
end

function FightSkillSelectView:onOpen()
	gohelper.setAsFirstSibling(self.viewGO)

	if FightDataHelper.stateMgr.isReplay then
		self:_removeAllEvent()
	end
end

function FightSkillSelectView:onClose()
	TaskDispatcher.cancelTask(self._updateGuideClick, self)
	FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
	TaskDispatcher.cancelTask(self._delayStartSequenceFinish, self)
	self:removeLateUpdate()
end

function FightSkillSelectView:_onBeginWave()
	self:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function FightSkillSelectView:_setEntityVisibleByTimeline(entity, fightStepData, isVisible, transitionTime)
	if entity.id ~= FightDataHelper.operationDataMgr.curSelectEntityId then
		return
	end

	self.entityVisible = isVisible

	self:_setSelectGOActive(true)
end

function FightSkillSelectView:_onSkillPlayStart(entity)
	if FightDataHelper.operationDataMgr.curSelectEntityId ~= entity.id then
		return
	end

	self.playingCurSelectEntityTimeline = true

	self:_setSelectGOActive(false)
end

function FightSkillSelectView:_onSkillTimeLineDone(fightStepData)
	local entityId = fightStepData and fightStepData.fromId

	if FightDataHelper.operationDataMgr.curSelectEntityId ~= entityId then
		return
	end

	self.playingCurSelectEntityTimeline = false

	self:_setSelectGOActive(true)
end

function FightSkillSelectView:_setIsShowUI(isVisible)
	self.showUI = isVisible
	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self._containerGO, typeof(UnityEngine.CanvasGroup))

	gohelper.setActiveCanvasGroup(self._canvasGroup, isVisible)
end

function FightSkillSelectView:_removeAllEvent()
	self:removeEvents()
	self:removeLateUpdate()
end

function FightSkillSelectView:onCameraFocusChanged(isFocus)
	if isFocus then
		self._on_camera_focus = true

		self:_setSelectGOActive(false)
	else
		self._on_camera_focus = false

		self:_setSelectGOActive(true)
	end
end

function FightSkillSelectView:clearAllFlag()
	self._on_camera_focus = nil
	self.playingCurSelectEntityTimeline = nil
	self.entityVisible = true
	self.showEnemyActioning = nil
end

function FightSkillSelectView:_setSelectGOActive(value)
	if not value then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	if self.showEnemyActioning then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	if self._on_camera_focus then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	if self.playingCurSelectEntityTimeline then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	if not self.entityVisible then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	local guiding = GuideModel.instance:isDoingFirstGuide()

	if guiding then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	if not GMFightShowState.monsterSelect then
		gohelper.setActive(self._imgSelectGO, false)

		return
	end

	gohelper.setActive(self._imgSelectGO, true)
end

function FightSkillSelectView:_resetSelect()
	self:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	self:_updateSelectUI()
end

function FightSkillSelectView:_onStartSequenceFinish()
	FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
	TaskDispatcher.runDelay(self._delayStartSequenceFinish, self, 0.01)
end

function FightSkillSelectView:_delayStartSequenceFinish()
	self.started = true

	self:clearAllFlag()
	gohelper.setActive(self._containerGO, true)
	self:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelect, self.OnKeySelect, self)
	self:initUpdateBeat()
end

function FightSkillSelectView:OnKeySelect(LorR)
	local isReplay = FightDataHelper.stateMgr.isReplay

	if isReplay then
		return
	end

	local id = FightDataHelper.operationDataMgr:getSelectEnemyPosLOrR(LorR)

	if id ~= nil then
		self:_onClick(id)
	end
end

function FightSkillSelectView:initUpdateBeat()
	if self.lateUpdateHandle or not self.showUI or self.playingCurSelectEntityTimeline then
		return
	end

	self.lateUpdateHandle = LateUpdateBeat:CreateListener(self._onFrameLateUpdate, self)

	LateUpdateBeat:AddListener(self.lateUpdateHandle)
end

function FightSkillSelectView:_onFrameLateUpdate()
	if self._on_camera_focus then
		return
	end

	self:_updatePos()
end

function FightSkillSelectView:removeLateUpdate()
	if self.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(self.lateUpdateHandle)

		self.lateUpdateHandle = nil
	end
end

function FightSkillSelectView:_playSelectAnim()
	if self._imgSelectAnimator then
		self._imgSelectAnimator:Play("fightview_skillselect", 0, 0)
	else
		logError("无法播放目标锁定动画，Animator不存在")
	end
end

function FightSkillSelectView:_onRestartStage()
	gohelper.setActive(self._containerGO, false)
	self:removeLateUpdate()

	self.started = nil
end

function FightSkillSelectView:_onSwitchPlaneClearAsset()
	gohelper.setActive(self._containerGO, false)
	self:removeLateUpdate()

	self.started = nil
end

function FightSkillSelectView:_updatePos()
	self:_updateSelectUI()
end

function FightSkillSelectView:_resetDefaultFocus()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAutoFocus) then
		FightDataHelper.operationDataMgr:resetCurSelectEntityIdDefault()
	end
end

function FightSkillSelectView:_updateSelectUI()
	local entity = FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId)

	self:_setSelectGOActive(entity ~= nil)

	if entity then
		local middlePosX, middlePosY = self:_getEntityMiddlePos(entity)

		recthelper.setAnchor(self._imgSelectTr, middlePosX, middlePosY)
	end
end

function FightSkillSelectView:_getEntityMiddlePos(entity)
	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local worldPosX, worldPosY, worldPosZ = transformhelper.getPos(entity.go.transform)
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(worldPosX + config.selectPos[1], worldPosY + config.selectPos[2], worldPosZ, self._containerTr)

		return rectPosX, rectPosY
	end

	local mountMiddleGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

	if mountMiddleGO and mountMiddleGO.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local worldPosX, worldPosY, worldPosZ = transformhelper.getPos(mountMiddleGO.transform)
		local entityMO = entity:getMO()

		if entityMO then
			local config3d = lua_fight_monster_3d.configDict[entityMO.skin]

			if config3d then
				worldPosY = worldPosY - 9
			end
		end

		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(worldPosX, worldPosY, worldPosZ, self._containerTr)

		return rectPosX, rectPosY
	else
		local rectPos1X, rectPos1Y, rectPos2X, rectPos2Y = FightHelper.calcRect(entity, self._clickBlockTransform)

		return (rectPos1X + rectPos2X) / 2, (rectPos1Y + rectPos2Y) / 2
	end
end

function FightSkillSelectView:getCurrentFocusEntityId()
	return self.currentFocusEntityMO.id
end

function FightSkillSelectView:onDestroyView()
	return
end

return FightSkillSelectView

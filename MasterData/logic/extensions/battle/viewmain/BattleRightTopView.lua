-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleRightTopView.lua

module("logic.extensions.battle.viewmain.BattleRightTopView", package.seeall)

local BattleRightTopView = class("BattleRightTopView", ViewComponent)
local kRotationAngle = 90
local kCloseAnimDuaration = 0.14
local kLocalSettingKey = "BattleRightTopView"

function BattleRightTopView:buildUI()
	self.mainGO = self:getGoByPath("rightTopHint")
	self._enableState = GameObjectVisibleState.New()
	self._btnSet = Astral.ButtonAdapter.GetFrom(self.mainGO, "buttons/btnSet")
	self._btnAddVisualAngle = Astral.ButtonAdapter.GetFrom(self.mainGO, "visualAngle/btnAddVisualAngle")
	self._btnMinusVisualAngle = Astral.ButtonAdapter.GetFrom(self.mainGO, "visualAngle/btnMinusVisualAngle")
	self._goBtnAutoNormal = goutil.findChild(self.mainGO, "buttons/btnAuto/imgNormal")
	self._goBtnAutoSelect = goutil.findChild(self.mainGO, "buttons/btnAuto/imgSelect")
	self._selectableDangerArea = SelectableButton.New(goutil.findChild(self.mainGO, "buttons/btnDangerZone"))
	self._selectableAuto = SelectableButton.New(goutil.findChild(self.mainGO, "buttons/btnAuto"))
	self._selectableSpeed = SelectableButton.New(goutil.findChild(self.mainGO, "buttons/btnSpeed"))
	self._selectableRepentance = SelectableButton.New(goutil.findChild(self.mainGO, "buttons/btnRepentance"))
	self._txtRemainUndoCount1 = goutil.findChildTextComponent(self.mainGO, "buttons/btnRepentance/imgNormal/txtNum")
	self._txtRemainUndoCount2 = goutil.findChildTextComponent(self.mainGO, "buttons/btnRepentance/imgSelect/txtNum")
	self._transitionRepentance = UIEffectUtil.getButtonTransition(goutil.findChild(self.mainGO, "buttons/btnRepentance"))
	self._mainAnim = self.mainGO:GetComponent(ComponentType.Animation)
	self._timeWaiter = TimeWaiter.New()
end

function BattleRightTopView:destroyUI()
	self._btnSet = nil
	self._btnAddVisualAngle = nil
	self._btnMinusVisualAngle = nil
	self._goBtnAutoNormal = nil
	self._goBtnAutoSelect = nil

	self._selectableDangerArea:destroy()

	self._selectableDangerArea = nil

	self._selectableAuto:destroy()

	self._selectableAuto = nil

	self._selectableSpeed:destroy()

	self._selectableSpeed = nil

	self._selectableRepentance:destroy()

	self._selectableRepentance = nil
	self._txtRemainUndoCount1 = nil
	self._txtRemainUndoCount2 = nil
	self._transitionRepentance = nil
end

function BattleRightTopView:bindEvents()
	self._btnSet:AddClickListener(self._onClickSet, self)
	self._btnAddVisualAngle:AddClickListener(self._onAddVisualAngle, self)
	self._btnMinusVisualAngle:AddClickListener(self._onMinusVisualAngle, self)
	self._selectableDangerArea:addListener(self._onClickDangerArea, self)
	self._selectableAuto:addListener(self._onClickAuto, self)
	self._selectableSpeed:addListener(self._onClickSpeed, self)
	self._selectableRepentance:addListener(self._onClickRepentance, self)
end

function BattleRightTopView:unbindEvents()
	self._btnSet:RemoveClickListener()
	self._btnAddVisualAngle:RemoveClickListener()
	self._btnMinusVisualAngle:RemoveClickListener()
	self._selectableDangerArea:removeListener()
	self._selectableAuto:removeListener()
	self._selectableSpeed:removeListener()
	self._selectableRepentance:removeListener()
end

function BattleRightTopView:onEnter()
	self:_setEvent(true)
	goutil.setActive(self.mainGO, self._enableState:isEnable())
	self:_updateView()
end

function BattleRightTopView:onExit()
	self:_setEvent(false)
	self._enableState:clear()
	self._timeWaiter:clear()
end

function BattleRightTopView:setVisible(visible, key)
	local isPreviewVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	local isCurVisible = self._enableState:isEnable()

	if isCurVisible ~= isPreviewVisible then
		self._timeWaiter:clear()

		if isCurVisible then
			goutil.setActive(self.mainGO, isCurVisible)
			self._mainAnim:Stop()
			self._mainAnim:Play("battle_main_righttophint_open")
		else
			self._mainAnim:Stop()
			self._mainAnim:Play("battle_main_righttophint_close")
			self._timeWaiter:start(kCloseAnimDuaration, self._updateVisibleAfterAnim, self)
		end
	end
end

function BattleRightTopView:playAnim(visible)
	self._mainAnim:Stop()

	if visible then
		self._mainAnim:Play("battle_main_righttophint_open")
	else
		self._mainAnim:Play("battle_main_righttophint_close")
	end
end

function BattleRightTopView:_updateVisibleAfterAnim()
	goutil.setActive(self.mainGO, self._enableState:isEnable())
end

function BattleRightTopView:_setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
		BattleDispatcher:addEventListener(BattleEventType.OnRequestOpenUndoView, self._onRequestOpenUndoView, self)
		BattleDispatcher:addEventListener(BattleEventType.OnRequestCloseUndoView, self._onRequestCloseUndoView, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleUndoCountUpdate, self._onBattleUndoCountUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleAutoModeUpdate, self._onBattleAutoModeUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnRequestOpenUndoView, self._onRequestOpenUndoView, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnRequestCloseUndoView, self._onRequestCloseUndoView, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleUndoCountUpdate, self._onBattleUndoCountUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleAutoModeUpdate, self._onBattleAutoModeUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
	end
end

function BattleRightTopView:_updateView()
	local settingModel = BattleMgr.instance:getSettingModel()

	self:_setAutoButtonState(settingModel:isAutoBattle())
	self:_setSpeedView(settingModel:getBattleSpeed())
	self:_setDangerButtonState(settingModel:isEnableDangerArea())
	self:_updateSystemOpen()
	self:_undateUndoView()
end

function BattleRightTopView:_undateUndoView()
	local settingModel = BattleMgr.instance:getSettingModel()

	if not settingModel:isSupportUndo() then
		BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, false, kLocalSettingKey)

		return
	else
		BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, true, kLocalSettingKey)
	end

	local model = BattleMgr.instance:getModel()
	local remainUndoCount = model:getRemainUndoCount()

	self._txtRemainUndoCount1.text = remainUndoCount
	self._txtRemainUndoCount2.text = remainUndoCount

	if remainUndoCount <= 0 then
		self._transitionRepentance:setDisable(true)
	else
		self._transitionRepentance:setEnable()
	end
end

function BattleRightTopView:_onBattleEnterFinish()
	self:_updateView()
end

function BattleRightTopView:_onRequestOpenUndoView()
	self._selectableRepentance:setSelected(true)
	self:_requestChangeUndoView(true)
end

function BattleRightTopView:_onRequestCloseUndoView(evt, checkClose)
	self._selectableRepentance:setSelected(false)
	self:_requestChangeUndoView(false, checkClose)
end

function BattleRightTopView:_onBattleUndoCountUpdate()
	self:_undateUndoView()
end

function BattleRightTopView:_onBattleAutoModeUpdate(e, autoMode)
	local settingModel = BattleMgr.instance:getSettingModel()

	self:_setAutoButtonState(settingModel:isAutoBattle())
end

function BattleRightTopView:_onClickSet()
	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSetting, false) then
		ViewMgr.instance:open(ViewName.BattleSettingViewPresentor)
	end
end

function BattleRightTopView:_onClickAuto()
	local model = BattleMgr.instance:getModel()

	if not model:getIfCanAutoBattle() then
		FloatWordMgr.instance:show(lang("tip_initiative_problem"))
		self._selectableAuto:setSelected(false)

		return
	end

	local settingModel = BattleMgr.instance:getSettingModel()
	local isAuto = not settingModel:isAutoBattle()

	self:_setAutoMode(isAuto)
end

function BattleRightTopView:_setAutoMode(isAuto)
	self:_setAutoButtonState(isAuto)

	local settingModel = BattleMgr.instance:getSettingModel()

	settingModel:setAutoBattle(isAuto)
	BattleAgent.instance:sendSetAiControlledRequest(isAuto)
end

function BattleRightTopView:_onClickSpeed()
	local settingModel = BattleMgr.instance:getSettingModel()
	local speed = settingModel:getBattleSpeed()

	speed = speed ~= 1 and 1 or 2

	settingModel:setBattleSpeed(speed)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kSpeedAdjust, speed)
end

function BattleRightTopView:_onClickDangerArea(isSelected)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_check, nil, nil, nil)

	local settingModel = BattleMgr.instance:getSettingModel()

	settingModel:setEnableDangerArea(isSelected)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kAutoShowDangerous, isSelected)
end

function BattleRightTopView:_onAddVisualAngle()
	self:_adjustCameraRotation(-kRotationAngle)
end

function BattleRightTopView:_onMinusVisualAngle()
	self:_adjustCameraRotation(kRotationAngle)
end

function BattleRightTopView:_onClickRepentance(isSelected)
	local model = BattleMgr.instance:getModel()
	local remainUndoCount = model:getRemainUndoCount()

	if remainUndoCount <= 0 then
		self._selectableRepentance:setSelected(false)
		FloatWordMgr.instance:show(lang("tip_no_undo_count"))

		return
	end

	if not isSelected then
		local undoMgr = BattleMgr.instance:getUndoMgr()

		undoMgr:cancelUndo()
	end

	self:_requestChangeUndoView(isSelected, true)
end

function BattleRightTopView:_requestChangeUndoView(isOpen)
	local settingModel = BattleMgr.instance:getSettingModel()

	settingModel:setRequestUndo(isOpen)
	BattleChangeUndoViewStateCommand:waitOrExecuteCommand(isOpen)

	if isOpen and settingModel:isAutoBattle() then
		self:_setAutoMode(false)
	end
end

function BattleRightTopView:_adjustCameraRotation(angle)
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local rotation = virtualCamera:getRotation()
	local model = BattleMgr.instance:getModel()

	rotation.y = model:getCameraRotation() + angle

	model:recordCameraRotation(rotation.y)
	virtualCamera:doRotation(rotation.x, rotation.y, rotation.z, BattleConst.CameraRotationTime)
	GlobalDispatcher:dispatchEvent(EventType.ON_CAMERA_ROTATION_UPDATE, BattleConst.CameraRotationTime)
end

function BattleRightTopView:_onSettingContentChanged(evt, settingKey, value)
	if settingKey == SettingConst.kSpeedAdjust then
		local speed = checkint(value)

		self:_setSpeedView(speed)
	end

	if settingKey == SettingConst.kAutoShowDangerous then
		self:_setDangerButtonState(value)
	end
end

function BattleRightTopView:_setSpeedView(speed)
	self._selectableSpeed:setSelected(speed == 2)
	self:_updateSkillAudioSpeed(speed)
end

function BattleRightTopView:_updateSkillAudioSpeed(speed)
	local volumeValume = speed == 2 and 1 or 0.5

	CriwareAudioFacade.instance:setSkillAudioSpeed(volumeValume)
end

function BattleRightTopView:_setAutoButtonState(isAuto)
	self._selectableAuto:setSelected(isAuto)
end

function BattleRightTopView:_setDangerButtonState(isShow)
	self._selectableDangerArea:setSelected(isShow)
end

function BattleRightTopView:_updateSystemOpen()
	SystemOpenFacade.instance:judgeUIState(GameEnum.SystemEnum.FightSetting, self._btnSet.gameObject)
end

return BattleRightTopView

-- chunkname: @modules/logic/fight/view/preview/SkillEditorView.lua

module("modules.logic.fight.view.preview.SkillEditorView", package.seeall)

local SkillEditorView = class("SkillEditorView", BaseViewExtended)

SkillEditorView.selectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}
SkillEditorView.prevSelectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}

function SkillEditorView.setSelectPosId(side, position)
	SkillEditorView.prevSelectPosId[side] = SkillEditorView.selectPosId[side]
	SkillEditorView.selectPosId[side] = position
end

SkillEditorView.selectSkillId = {}
SkillEditorView.lockCamera = false
SkillEditorView.useVirtualCamera2 = false

function SkillEditorView:onInitView()
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)

	self._btnSpeed = gohelper.findChildButton(self.viewGO, "btnSpeed")
	self._btnExit = gohelper.findChildButton(self.viewGO, "right/btnExit")
	self._btnVisible = gohelper.findChildButton(self.viewGO, "right/btnVisible")
	self._txtSpeed = gohelper.findChildText(self.viewGO, "btnSpeed/Text")
	self._btnUseSub = gohelper.findChildButton(self.viewGO, "right/btn_use_sub")
	self._btnSceneDissolve = gohelper.findChildButton(self.viewGO, "right/btn_scene_dissolve")
	self._toggleLockCamera = gohelper.findChildToggle(self.viewGO, "scene/goToggleRoot/lockCamera")
	self._toggleVirtualCamera = gohelper.findChildToggle(self.viewGO, "scene/goToggleRoot/toggleVirtualCamera")
	self._toggleList = gohelper.findChild(self.viewGO, "scene/goToggleRoot")
	self._btnShowToggleList = gohelper.findChildButton(self.viewGO, "scene/btnToggleList")

	self:_updateSpeed()

	local userId = tonumber(PlayerModel.instance:getPlayinfo().userId)

	gohelper.setActive(self._btnExit.gameObject, userId and userId ~= 0)
	self:_showSceneDissolveBtn()

	SkillEditorView.lockCamera = false

	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function SkillEditorView:_showSceneDissolveBtn()
	local id = FightGameMgr.sceneLevelMgr:getCurLevelId()
	local config = lua_scene_level.configDict[id]

	gohelper.setActive(self._btnSceneDissolve.gameObject, config and config.sceneId == 115 or false)
end

function SkillEditorView:addEvents()
	self._btnShowToggleList:AddClickListener(self._onBtnShowToggleList, self)
	self._btnSpeed:AddClickListener(self._onClickSpeed, self)
	self._btnExit:AddClickListener(self._onClickExit, self)
	self._btnVisible:AddClickListener(self._onClickVisible, self)
	self._btnUseSub:AddClickListener(self._onBtnUseSub, self)
	self._btnSceneDissolve:AddClickListener(self._onBtnSceneDissolve, self)
	self._toggleLockCamera:AddOnValueChanged(self._onToggleLockCameraChanged, self)
	self._toggleVirtualCamera:AddOnValueChanged(self._onToggleVritualCameraChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillEditorSceneChange, self._showSceneDissolveBtn, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetSkillEditorViewVisible, self._onSetSkillEditorViewVisible, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffClick, self._onBuffClick, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetGMViewVisible, self.onSetGMViewVisible, self)
end

function SkillEditorView:removeEvents()
	self._btnShowToggleList:RemoveClickListener()
	self._btnSpeed:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnVisible:RemoveClickListener()
	self._btnUseSub:RemoveClickListener()
	self._btnSceneDissolve:RemoveClickListener()
	self._toggleLockCamera:RemoveOnValueChanged()
	self._toggleVirtualCamera:RemoveOnValueChanged()
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillEditorSceneChange, self._showSceneDissolveBtn, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetSkillEditorViewVisible, self._onSetSkillEditorViewVisible, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffClick, self._onBuffClick, self)
end

function SkillEditorView:onOpen()
	self:openSubView(SkillEditorToolsBtnView, self.viewGO)
end

function SkillEditorView:_updateSpeed()
	local speed = FightModel.instance:getUserSpeed()
	local speedShow = speed == 1 and 1 or 2

	self._txtSpeed.text = string.format("X%d", speedShow)
end

function SkillEditorView:_onClickSpeed()
	local curSpeed = FightModel.instance:getUserSpeed()
	local newSpeed = curSpeed == 1 and 2 or 1

	FightModel.instance:setUserSpeed(newSpeed)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	self:_updateSpeed()
end

function SkillEditorView:_onClickExit()
	self:closeThis()
	FightController.instance:exitFightScene()
end

function SkillEditorView:_onClickVisible()
	local canvasGorup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	if canvasGorup.alpha == 1 then
		canvasGorup.alpha = 0

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	else
		canvasGorup.alpha = 1

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	end
end

function SkillEditorView:_onBtnUseSub()
	if not SkillEditorMgr.instance.select_sub_hero_model then
		return
	end

	local dead_model = FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide]):getMO()

	if dead_model.uid == SkillEditorMgr.instance.select_sub_hero_model.uid then
		dead_model = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)[1]
	end

	local entityMgr = FightGameMgr.entityMgr

	entityMgr:delEntity(dead_model.id)

	local entityMO = FightDataHelper.entityMgr:getById(dead_model.id)

	entityMO:setDead()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, dead_model.id)
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, dead_model.id)

	local step_data = {}

	step_data.fromId = SkillEditorMgr.instance.select_sub_hero_model.uid
	step_data.toId = dead_model.uid
	self.change_hero_work_flow = FlowSequence.New()

	local action = FightWorkStepChangeHero.New(step_data)

	self.change_hero_work_flow:addWork(action)
	self.change_hero_work_flow:addWork(WorkWaitSeconds.New(1))
	self.change_hero_work_flow:addWork(FunctionWork.New(function()
		SkillEditorMgr.instance:_buildSubHero()
	end))
	self.change_hero_work_flow:start({})
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSubHeroEnter, SkillEditorMgr.instance.select_sub_hero_model.id)

	SkillEditorMgr.instance.select_sub_hero_model = nil
end

function SkillEditorView:_onBtnSceneDissolve()
	self._loader = MultiAbLoader.New()

	self._loader:addPath(ResUrl.getCameraAnim("m_s63_zjmzd/m_s63_zjmzd"))
	self._loader:startLoad(self._onLoaded, self)
end

function SkillEditorView:_onFinish()
	gohelper.setActive(self.viewContainer.viewGO, true)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	TaskDispatcher.cancelTask(self._onFinish, self)
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function SkillEditorView:_onLoaded()
	gohelper.setActive(self.viewContainer.viewGO, false)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, false)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	local Animation = FightGameMgr.sceneLevelMgr:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	Animation:Play("m_s63_ani")
	TaskDispatcher.runDelay(self._onFinish, self, Animation.clip.length)

	self._animatorInst = self._loader:getFirstAssetItem():GetResource()
	self._animComp = CameraMgr.instance:getCameraRootAnimator()
	self._animComp.enabled = true
	self._animComp.runtimeAnimatorController = nil
	self._animComp.runtimeAnimatorController = self._animatorInst
	self._animComp.speed = FightModel.instance:getSpeed()

	self._animComp:Play("popcam")
end

function SkillEditorView:_onToggleLockCameraChanged()
	SkillEditorView.lockCamera = not SkillEditorView.lockCamera

	local camera_obj = CameraMgr.instance:getMainCameraGO()

	camera_obj:GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = not SkillEditorView.lockCamera
end

function SkillEditorView:_onToggleVritualCameraChanged()
	SkillEditorView.useVirtualCamera2 = not not self._toggleVirtualCamera.isOn

	local virtualCameraId = SkillEditorView.useVirtualCamera2 and 2 or 1

	CameraMgr.instance:switchVirtualCamera(virtualCameraId)
end

function SkillEditorView:_onBtnShowToggleList()
	self._showToggleList = not self._showToggleList

	gohelper.setActive(self._toggleList, self._showToggleList)
end

function SkillEditorView:onClose()
	if self.change_hero_work_flow then
		self.change_hero_work_flow:stop()

		self.change_hero_work_flow = nil
	end

	FightModel.instance:setUserSpeed(1)

	local camera_obj = CameraMgr.instance:getMainCameraGO()

	camera_obj:GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = true

	FightSystem.instance:dispose()
	SkillEditorMgr.instance:exit()
end

function SkillEditorView:_onSetSkillEditorViewVisible(state)
	TaskDispatcher.runDelay(function()
		if self.viewGO then
			gohelper.setActive(self.viewGO, state)
			FightView._resetCamera()
		end
	end, self, 0.16)
end

function SkillEditorView:_onBuffClick(entityId, buffIconTransform, offsetX, offsetY)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		logError("get EntityMo fail, entityId : " .. tostring(entityId))

		return
	end

	if isDebugBuild then
		local tempList = {}

		for _, buffMO in pairs(entityMO:getBuffDic()) do
			local buffCO = lua_skill_buff.configDict[buffMO.buffId]
			local noShow = buffCO.isNoShow == 0 and "show" or "noShow"
			local goodOrBad = buffCO.isGoodBuff == 1 and "good" or "bad"
			local id = buffMO.buffId
			local name = buffCO.name
			local count = buffMO.count
			local duration = buffMO.duration
			local desc = buffCO.desc
			local s = string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", id, count, duration, name, desc, goodOrBad, noShow)

			table.insert(tempList, s)
		end

		logNormal(string.format("buff list %d :\n%s", #tempList, table.concat(tempList, "\n")))
	end
end

function SkillEditorView:onSetGMViewVisible(state)
	gohelper.setActive(self.viewGO, state)
end

return SkillEditorView

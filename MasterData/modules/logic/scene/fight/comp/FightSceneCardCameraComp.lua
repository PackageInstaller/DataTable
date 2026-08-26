-- chunkname: @modules/logic/scene/fight/comp/FightSceneCardCameraComp.lua

module("modules.logic.scene.fight.comp.FightSceneCardCameraComp", package.seeall)

local FightSceneCardCameraComp = class("FightSceneCardCameraComp", BaseSceneComp)

function FightSceneCardCameraComp:onSceneStart(sceneId, levelId)
	FightController.instance:registerCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)
	FightController.instance:registerCallback(FightEvent.StageChanged, self._onStageChange, self)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, self._stopCameraAnim, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAsset, self._stopCameraAnim, self)
	FightController.instance:registerCallback(FightEvent.ChangeWaveEnd, self._onChangeWaveEnd, self)
	FightController.instance:registerCallback(FightEvent.SkillEditorPlayCardCameraAni, self._onSkillEditorPlayCardCameraAni, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	FightController.instance:registerCallback(FightEvent.StopCardCameraAnimator, self._stopCameraAnim, self)
	FightController.instance:registerCallback(FightEvent.SwitchScene_Data, self.onSwitchSceneData, self)
end

function FightSceneCardCameraComp:onSceneClose(sceneId, levelId)
	FightController.instance:unregisterCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self._onStageChange, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, self._stopCameraAnim, self)
	FightController.instance:unregisterCallback(FightEvent.OnSwitchPlaneClearAsset, self._stopCameraAnim, self)
	FightController.instance:unregisterCallback(FightEvent.ChangeWaveEnd, self._onChangeWaveEnd, self)
	FightController.instance:unregisterCallback(FightEvent.SkillEditorPlayCardCameraAni, self._onSkillEditorPlayCardCameraAni, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	FightController.instance:unregisterCallback(FightEvent.StopCardCameraAnimator, self._stopCameraAnim, self)
	FightController.instance:unregisterCallback(FightEvent.SwitchScene_Data, self.onSwitchSceneData, self)

	if self._multiLoader then
		self._multiLoader:dispose()

		self._multiLoader = nil
	end

	if self._editorLoader then
		self._editorLoader:dispose()

		self._editorLoader = nil
	end

	self._cardCameraName = nil
	self._path = nil
	self._waveId = nil
	self._animatorInst = nil

	if self._isPlaying then
		self._isPlaying = false

		local animComp = CameraMgr.instance:getCameraRootAnimator()

		animComp.enabled = false
		animComp.runtimeAnimatorController = nil
	end
end

function FightSceneCardCameraComp:onSwitchSceneData(levelId)
	self:resetCameraAnim(levelId)
end

function FightSceneCardCameraComp:_onLevelLoaded(levelId)
	self:resetCameraAnim(levelId)
end

function FightSceneCardCameraComp:resetCameraAnim(levelId)
	local waveId = FightModel.instance:getCurWaveId()
	local cardCameraName = self:_getCameraName(levelId, waveId)

	if cardCameraName ~= self._cardCameraName then
		self._cardCameraName = cardCameraName

		if cardCameraName ~= "" and cardCameraName ~= "1" then
			self:_loadAnimRes()
		else
			self:_stopCameraAnim()
			self:_clearAnimRes()
		end
	end
end

function FightSceneCardCameraComp:_onChangeWaveEnd()
	local levelId = GameSceneMgr.instance:getCurLevelId()

	self._waveId = FightModel.instance:getCurWaveId()

	local cardCameraName = self:_getCameraName(levelId, self._waveId)

	if cardCameraName ~= self._cardCameraName then
		self._cardCameraName = cardCameraName

		if cardCameraName ~= "" and cardCameraName ~= "1" then
			self:_loadAnimRes()
		else
			self:_stopCameraAnim()
			self:_clearAnimRes()
		end
	end
end

function FightSceneCardCameraComp:_getCameraName(levelId, waveId)
	if FightHelper.checkInPaTaAfterSwitchScene() then
		return "1"
	end

	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		::label_7_0::

		local var_7_0 = fightParam.monsterGroupIds

		if fightParam.monsterGroupIds then
			local monsterGroupId = fightParam.monsterGroupIds[waveId]
			local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
			local enemyStanceId = monsterGroupCO and monsterGroupCO.stanceId
			local enemyStanceCO = enemyStanceId and lua_stance.configDict[enemyStanceId]
			local enemyStanceCardCamera = enemyStanceCO and enemyStanceCO.cardCamera

			if not string.nilorempty(enemyStanceCardCamera) then
				return enemyStanceCardCamera
			end

			local battleCO = fightParam and lua_battle.configDict[fightParam.battleId]

			if battleCO then
				::label_7_1::

				local myStanceIds = FightStrUtil.instance:getSplitToNumberCache(battleCO.myStance, "#")

				if myStanceIds then
					::label_7_2::

					local var_7_1 = myStanceIds[waveId]

					if not myStanceIds[waveId] then
						local myStanceId = myStanceIds[#myStanceIds]
						local myStanceCO = myStanceId and lua_stance.configDict[myStanceId]
						local myStanceCardCamera = myStanceCO and myStanceCO.cardCamera

						if not string.nilorempty(myStanceCardCamera) then
							return myStanceCardCamera
						end

						local levelCO = lua_scene_level.configDict[levelId]

						return levelCO and levelCO.cardCamera
					end
				end
			end
		end
	end
end

function FightSceneCardCameraComp:_loadAnimRes()
	if not string.nilorempty(self._cardCameraName) then
		local path = "scenes/dynamic/scene_anim/" .. self._cardCameraName .. ".controller"

		if path == self._path then
			return
		end

		if self._multiLoader then
			self._multiLoader:dispose()
		end

		self._path = path
		self._multiLoader = MultiAbLoader.New()

		self._multiLoader:addPath(self._path)
		self._multiLoader:startLoad(self._onResLoadCallback, self)
	end
end

function FightSceneCardCameraComp:_onResLoadCallback(loader)
	self._animatorInst = self._multiLoader:getFirstAssetItem():GetResource(self._path)

	self:_onStageChange()
end

function FightSceneCardCameraComp:_onStageChange()
	if self._isPlaying then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if self._animatorInst and FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local cameraComp = GameSceneMgr.instance:getCurScene().camera

		cameraComp:switchNextVirtualCamera()
		self:_playCameraAnim()
	end
end

function FightSceneCardCameraComp:_playCameraAnim()
	self._isPlaying = true

	local animComp = CameraMgr.instance:getCameraRootAnimator()

	animComp.enabled = true
	animComp.runtimeAnimatorController = nil
	animComp.runtimeAnimatorController = self._animatorInst
	animComp.speed = 1 / Time.timeScale
end

function FightSceneCardCameraComp:isPlaying()
	return self._isPlaying
end

function FightSceneCardCameraComp:stop()
	self._isPlaying = false
end

function FightSceneCardCameraComp:_clearAnimRes()
	self._animatorInst = nil

	if self._multiLoader then
		self._multiLoader:dispose()

		self._multiLoader = nil
	end
end

function FightSceneCardCameraComp:_stopCameraAnim()
	if not self._animatorInst then
		return
	end

	self._isPlaying = false

	local cameraComp = GameSceneMgr.instance:getCurScene().camera
	local virtualCamera1 = cameraComp:getCurVirtualCamera(1)
	local virtualCamera2 = cameraComp:getCurVirtualCamera(2)
	local followerName1 = "Follower" .. string.sub(virtualCamera1.name, string.len(virtualCamera1.name))
	local followerName2 = "Follower" .. string.sub(virtualCamera2.name, string.len(virtualCamera2.name))
	local follower1 = gohelper.findChild(virtualCamera1.transform.parent.gameObject, followerName1)
	local follower2 = gohelper.findChild(virtualCamera2.transform.parent.gameObject, followerName2)
	local pos1x, pos1y, pos1z = transformhelper.getPos(follower1.transform)
	local pos2x, pos2y, pos2z = transformhelper.getPos(follower2.transform)
	local animComp = CameraMgr.instance:getCameraRootAnimator()

	animComp.enabled = false
	animComp.runtimeAnimatorController = nil

	transformhelper.setPos(follower1.transform, 0, pos1y, pos1z)
	transformhelper.setPos(follower2.transform, 0, pos2y, pos2z)
end

function FightSceneCardCameraComp:_onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self:_stopCameraAnim()
	end
end

function FightSceneCardCameraComp:_onCloseView(viewName)
	if viewName == ViewName.FightFocusView then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		self:_playCameraAnim()
	end
end

function FightSceneCardCameraComp:_onSkillEditorPlayCardCameraAni(state)
	if state then
		local levelId = GameSceneMgr.instance:getCurLevelId()
		local waveId = FightModel.instance:getCurWaveId()
		local cardCameraName = self:_getCameraName(levelId, waveId)

		if cardCameraName ~= self._cardCameraName and cardCameraName ~= "" and cardCameraName ~= "1" then
			if self._editorLoader then
				self._editorLoader:dispose()

				self._editorLoader = nil
			end

			local path = "scenes/dynamic/scene_anim/" .. cardCameraName .. ".controller"

			self._editorLoader = MultiAbLoader.New()

			self._editorLoader:addPath(path)
			self._editorLoader:startLoad(self._onEditorLoaderFinish, self)
		else
			self:_playCameraAnim()
		end
	else
		self:_stopCameraAnim()
	end
end

function FightSceneCardCameraComp:_onEditorLoaderFinish()
	self._animatorInst = self._editorLoader:getFirstAssetItem():GetResource(self._path)

	local cameraComp = GameSceneMgr.instance:getCurScene().camera

	cameraComp:switchNextVirtualCamera()
	self:_playCameraAnim()
end

return FightSceneCardCameraComp

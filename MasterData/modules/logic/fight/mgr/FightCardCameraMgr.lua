-- chunkname: @modules/logic/fight/mgr/FightCardCameraMgr.lua

module("modules.logic.fight.mgr.FightCardCameraMgr", package.seeall)

local FightCardCameraMgr = class("FightCardCameraMgr", FightBaseClass)

function FightCardCameraMgr:onConstructor()
	self:com_registMsg(FightMsgId.PlayCameraAnimWhenOperateStage, self.playCameraAnimWhenOperateStage)
	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChange)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self.stopCameraAnim)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self.stopCameraAnim)
	self:com_registFightEvent(FightEvent.ChangeWaveEnd, self.onChangeWaveEnd)
	self:com_registFightEvent(FightEvent.SkillEditorPlayCardCameraAni, self.onSkillEditorPlayCardCameraAni)
	self:com_registFightEvent(FightEvent.StopCardCameraAnimator, self.stopCameraAnim)
end

function FightCardCameraMgr:playCameraAnimWhenOperateStage()
	local flow = self:com_registFlowSequence()
end

function FightCardCameraMgr:onLevelLoaded(levelId)
	local waveId = FightModel.instance:getCurWaveId()
	local cardCameraName = self:getCameraName(levelId, waveId)

	if cardCameraName ~= self.cardCameraName then
		self.cardCameraName = cardCameraName

		if cardCameraName ~= "" and cardCameraName ~= "1" then
			self:loadAnimRes()
		else
			self:stopCameraAnim()
		end
	end
end

function FightCardCameraMgr:onChangeWaveEnd()
	local levelId = GameSceneMgr.instance:getCurLevelId()

	self.waveId = FightModel.instance:getCurWaveId()

	local cardCameraName = self:getCameraName(levelId, self.waveId)

	if cardCameraName ~= self.cardCameraName then
		self.cardCameraName = cardCameraName

		if cardCameraName ~= "" and cardCameraName ~= "1" then
			self:loadAnimRes()
		else
			self:stopCameraAnim()
		end
	end
end

function FightCardCameraMgr:getCameraName(levelId, waveId)
	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		::label_5_0::

		local var_5_0 = fightParam.monsterGroupIds

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
				::label_5_1::

				local myStanceIds = FightStrUtil.instance:getSplitToNumberCache(battleCO.myStance, "#")

				if myStanceIds then
					::label_5_2::

					local var_5_1 = myStanceIds[waveId]

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

function FightCardCameraMgr:loadAnimRes()
	if not string.nilorempty(self.cardCameraName) then
		local path = "scenes/dynamic/scene_anim/" .. self.cardCameraName .. ".controller"

		if path == self.path then
			return
		end

		self:com_loadAsset(path, self.onAnimLoaded)
	end
end

function FightCardCameraMgr:onAnimLoaded(success, loader)
	if not success then
		return
	end

	self.animatorInst = loader:GetResource()

	self:onStageChange()
end

function FightCardCameraMgr:onStageChange()
	if self.isPlaying then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if self.animatorInst and FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local cameraComp = GameSceneMgr.instance:getCurScene().camera

		cameraComp:switchNextVirtualCamera()
		self:playCameraAnim()
	end
end

function FightCardCameraMgr:playCameraAnim()
	self.isPlaying = true

	local animComp = CameraMgr.instance:getCameraRootAnimator()

	animComp.enabled = true
	animComp.runtimeAnimatorController = nil
	animComp.runtimeAnimatorController = self.animatorInst
	animComp.speed = 1 / Time.timeScale
end

function FightCardCameraMgr:stop()
	self.isPlaying = false
end

function FightCardCameraMgr:stopCameraAnim()
	if not self.animatorInst then
		return
	end

	self.isPlaying = false

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

function FightCardCameraMgr:onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self:stopCameraAnim()
	end
end

function FightCardCameraMgr:onCloseView(viewName)
	if viewName == ViewName.FightFocusView then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		self:playCameraAnim()
	end
end

function FightCardCameraMgr:onSkillEditorPlayCardCameraAni(state)
	if state then
		local levelId = GameSceneMgr.instance:getCurLevelId()
		local waveId = FightModel.instance:getCurWaveId()
		local cardCameraName = self:getCameraName(levelId, waveId)

		if cardCameraName ~= self.cardCameraName and cardCameraName ~= "" and cardCameraName ~= "1" then
			local path = "scenes/dynamic/scene_anim/" .. cardCameraName .. ".controller"

			self:com_loadAsset(path, self.onEditorLoaderFinish)
		else
			self:playCameraAnim()
		end
	else
		self:stopCameraAnim()
	end
end

function FightCardCameraMgr:onEditorLoaderFinish(success, loader)
	if not success then
		return
	end

	self.animatorInst = loader:GetResource()

	local cameraComp = GameSceneMgr.instance:getCurScene().camera

	cameraComp:switchNextVirtualCamera()
	self:playCameraAnim()
end

function FightCardCameraMgr:onDestructor()
	local animComp = CameraMgr.instance:getCameraRootAnimator()

	animComp.enabled = false
	animComp.runtimeAnimatorController = nil
end

return FightCardCameraMgr

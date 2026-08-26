-- chunkname: @modules/logic/fight/system/work/FightWorkFocusMonster.lua

module("modules.logic.fight.system.work.FightWorkFocusMonster", package.seeall)

local FightWorkFocusMonster = class("FightWorkFocusMonster", BaseWork)

FightWorkFocusMonster.EaseTime = 0
FightWorkFocusMonster.Speed = 15
FightWorkFocusMonster.TweenId = 0

function FightWorkFocusMonster:onStart()
	local entityId, config = FightWorkFocusMonster.getFocusEntityId()

	if entityId then
		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = entityMo,
			config = config
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	else
		self:onDone(true)
	end
end

function FightWorkFocusMonster:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		TaskDispatcher.runDelay(self._delayDone, self, FightWorkFocusMonster.EaseTime)
	end
end

function FightWorkFocusMonster:_delayDone()
	self:onDone(true)
end

function FightWorkFocusMonster:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function FightWorkFocusMonster.getPlayerPrefKey()
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam.episodeId
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local waveId = FightModel.instance:getCurWaveId()

	return string.format("%s&%s&%s&%s", PlayerPrefsKey.FightFocusMonster, playerInfo.userId, tostring(episodeId), tostring(waveId))
end

function FightWorkFocusMonster.getFocusEntityId()
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam.episodeId

	if not episodeId then
		return
	end

	if DungeonModel.instance:hasPassLevel(episodeId) then
		return
	end

	if not lua_monster_guide_focus.configDict[fightParam.episodeId] then
		return
	end

	table.sort(entityList, function(entity1, entity2)
		local mo1 = entity1:getMO()
		local mo2 = entity2:getMO()

		if mo1 and mo2 and mo1.position ~= mo2.position then
			return mo1.position < mo2.position
		end

		return tonumber(mo1.id) < tonumber(mo2.id)
	end)

	for _, entity in ipairs(entityList) do
		local entityMO = entity:getMO()
		local modelId = entityMO and entityMO.modelId
		local config = FightConfig.instance:getMonsterGuideFocusConfig(fightParam.episodeId, FightWorkFocusMonster.invokeType.Enter, FightModel.instance:getCurWaveId(), modelId)

		if config then
			local pre_key = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(config)

			if not PlayerPrefsHelper.hasKey(pre_key) then
				return entityMO.id, config
			end
		end
	end
end

FightWorkFocusMonster.invokeType = {
	Skill = 1,
	Enter = 0,
	Buff = 2
}

function FightWorkFocusMonster:getCameraPositionByEntity(entity)
	local mountMiddleGo = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
	local x, y, z = transformhelper.getPos(mountMiddleGo.transform)

	x = entity:isMySide() and x - 2.7 or x + 2.7
	y = y - 2
	z = z + 5.4

	return x, y, z
end

function FightWorkFocusMonster.focusCamera(entityId)
	local combinative = false
	local tar_entity = FightHelper.getEntity(entityId)

	if tar_entity then
		local entity_mo = tar_entity:getMO()

		if entity_mo then
			local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

			if skin_config and skin_config.canHide == 1 then
				combinative = true
			end
		end
	end

	local entityList = FightHelper.getAllEntitys()

	for _, oneEntity in ipairs(entityList) do
		oneEntity:setVisibleByPos(combinative or entityId == oneEntity.id)

		if oneEntity.buff then
			if entityId ~= oneEntity.id then
				oneEntity.buff:hideBuffEffects()
			else
				oneEntity.buff:showBuffEffects()
			end
		end

		if oneEntity.nameUI then
			oneEntity.nameUI:setActive(entityId == oneEntity.id)
		end
	end

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

	FightGameMgr.sceneLevelMgr:setFrontVisible(false)

	local entity = FightHelper.getEntity(entityId)

	if entity then
		local x, y, z = FightWorkFocusMonster:getCameraPositionByEntity(entity)
		local skinCo = FightConfig.instance:getSkinCO(entity:getMO().skin)
		local focusOffset = skinCo.focusOffset

		if #focusOffset == 3 then
			x = x + focusOffset[1]
			y = y + focusOffset[2]
			z = z + focusOffset[3]
		end

		local distance = Vector3.Distance(Vector3.New(x, y, z), Vector3.zero)

		FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)

		FightWorkFocusMonster.EaseTime = distance / FightWorkFocusMonster.Speed

		local cameraTrs = CameraMgr.instance:getVirtualCameraTrs()

		FightWorkFocusMonster.killTween()

		FightWorkFocusMonster.TweenId = ZProj.TweenHelper.DOMove(cameraTrs, x, y, z, FightWorkFocusMonster.EaseTime)
	end
end

function FightWorkFocusMonster.cancelFocusCamera()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local entityList = FightHelper.getAllEntitys()

	for _, oneEntity in ipairs(entityList) do
		oneEntity:setVisibleByPos(true)

		if oneEntity.buff then
			oneEntity.buff:showBuffEffects()
		end

		if oneEntity.nameUI then
			oneEntity.nameUI:setActive(true)
		end
	end

	local x, y, z = FightWorkFocusMonster.getCurrentSceneCameraOffset()

	FightWorkFocusMonster.setVirtualCameDamping(0.5, 0.5, 0.5)

	local cameraTrs = CameraMgr.instance:getVirtualCameraTrs()

	FightWorkFocusMonster.killTween()

	FightWorkFocusMonster.TweenId = ZProj.TweenHelper.DOMove(cameraTrs, x, y, z, FightWorkFocusMonster.EaseTime, FightWorkFocusMonster.cancelFocusCameraFinished)

	TaskDispatcher.runDelay(FightWorkFocusMonster.showCardPart, FightWorkFocusMonster, FightWorkFocusMonster.EaseTime)

	FightWorkFocusMonster.EaseTime = 0
end

function FightWorkFocusMonster.changeCameraPosition(offsetX, offsetY, offsetZ, doneCallback, doneCallbackObj)
	if not isDebugBuild then
		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightSkillSelectView)

	if not viewContainer then
		return
	end

	local entityId = viewContainer._views[1]:getCurrentFocusEntityId()

	if not entityId then
		return
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local x, y, z = FightWorkFocusMonster:getCameraPositionByEntity(entity)

	x = x + offsetX
	y = y + offsetY
	z = z + offsetZ

	local cameraTrs = CameraMgr.instance:getVirtualCameraTrs()

	FightWorkFocusMonster.killTween()

	FightWorkFocusMonster.TweenId = ZProj.TweenHelper.DOMove(cameraTrs, x, y, z, 0.1, doneCallback, doneCallbackObj)
end

function FightWorkFocusMonster.showCardPart()
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)
end

function FightWorkFocusMonster.getCurrentSceneCameraOffset()
	local sceneLevelId = GameSceneMgr.instance:getCurLevelId()
	local sceneLevelCo = lua_scene_level.configDict[sceneLevelId]

	if sceneLevelCo and not string.nilorempty(sceneLevelCo.cameraOffset) then
		local offsetList = Vector3(unpack(cjson.decode(sceneLevelCo.cameraOffset)))

		return offsetList.x, offsetList.y, offsetList.z
	else
		return 0, 0, 0
	end
end

function FightWorkFocusMonster.setVirtualCameDamping(x, y, z)
	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)
	local virtualCamera = fightScene.camera:getCurActiveVirtualCame()

	ZProj.GameHelper.SetVirtualCameraTrackedDollyDamping(virtualCamera, x, y, z)
end

function FightWorkFocusMonster.cancelFocusCameraFinished()
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	FightGameMgr.sceneLevelMgr:setFrontVisible(true)
end

function FightWorkFocusMonster.killTween()
	if FightWorkFocusMonster.TweenId ~= 0 then
		ZProj.TweenHelper.KillById(FightWorkFocusMonster.TweenId)
	end
end

return FightWorkFocusMonster

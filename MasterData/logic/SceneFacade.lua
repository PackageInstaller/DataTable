-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/facade/SceneFacade.lua

module("logic.extensions.city.facade.SceneFacade", package.seeall)

local SceneFacade = class("SceneFacade", BaseFacade)

SceneFacade.InvalidNpcId = 999

function SceneFacade:firstEnter()
	CityAgent.instance:sendEnterGameReq()
end

function SceneFacade:isInBattleScene()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Battle then
		return true
	end
end

function SceneFacade:enterCity(sceneId, fromSceneId, bornX, bornY)
	if sceneId == fromSceneId then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:clearBridgeState()
		end
	end

	if UnlockFacade.instance:checkSceneUnLock(sceneId) then
		CityModel.instance.toScenePosX = bornX
		CityModel.instance.toScenePosY = bornY

		if scene.startTransitionScene then
			scene:startTransitionScene()
		end

		CityController.instance:enterCity(sceneId, fromSceneId)
	else
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer.transmitPoint = nil
		end
	end
end

function SceneFacade:getMonsterSceneIdByRaceId(raceId)
	return SceneConfig.instance:getMonsterSceneId(raceId)
end

function SceneFacade:isInThisSceneByName(name)
	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return false
	end

	local sceneId = scene:getSceneId()
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	return sceneCo and sceneCo.eng_scene_name == name
end

function SceneFacade:getNpcSceneId(npcId)
	local npcCo = SceneConfig.instance:getNpcCo(self._npcId)

	if npcCo then
		return npcCo.sceneId
	end
end

function SceneFacade:isMonsterInThisScene(raceId)
	local sceneId = self:getMonsterSceneIdByRaceId(npcId)
	local scene = SceneMgr.instance:getCurScene()

	return sceneId == ((scene or nil) and scene:getSceneId())
end

function SceneFacade:isNpcInThisScene(npcId)
	local sceneId = self:getNpcSceneId(npcId)
	local scene = SceneMgr.instance:getCurScene()

	return sceneId == ((scene or nil) and scene:getSceneId())
end

function SceneFacade:isInThisScene(sceneId)
	local scene = SceneMgr.instance:getCurScene()

	return sceneId == ((scene or nil) and scene:getSceneId())
end

function SceneFacade:enterCityFromThisScene(sceneId)
	if MountModel.instance:isTeamMountMember() then
		FloatWordMgr.instance:show("双人骑乘不能切换场景")

		return
	end

	local scene = SceneMgr.instance:getCurScene()
	local fromSceneId = 0

	if scene then
		fromSceneId = scene:getSceneId()
	end

	CityModel.instance.toScenePosX = nil
	CityModel.instance.toScenePosY = nil

	self:enterCity(sceneId, fromSceneId)
end

function SceneFacade:setQuality(level)
	SpineQuality.useLowerQuality = level == HardwareQuality.QualityLevelType.Low

	ScenePreLoaderMgr.instance:disable(true)

	if AoSceneManager and AoSceneManager.Instance then
		AoSceneManager.Instance:SetQualityLevel(level)
	end

	ScenePreLoaderMgr.instance:disable()
end

function SceneFacade:setMaxPlayers(num)
	if AoSceneManager and AoSceneManager.Instance then
		AoSceneManager.Instance:SetPlayerNumberLimit(num)
	end

	if SceneMgr and SceneMgr.instance then
		local currScene = SceneMgr.instance:getCurScene()

		if currScene then
			GameUtil.callBack(currScene.showForcedVisiblePlayers, currScene)
		end
	end
end

function SceneFacade:showAllElements(show)
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.stage and currScene.stage.wholeScene then
		currScene.stage.wholeScene:ShowAllElements(show)
	end
end

function SceneFacade:showSceneObjects(show)
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.stage and currScene.stage.wholeScene then
		currScene.stage.wholeScene:ShowAllElements(show)
	end

	if currScene and currScene.visibleObjects then
		currScene:visibleObjects(show)
	end
end

function SceneFacade:showOthersPlayers(visible)
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.showOthersPlayers then
		currScene:showOthersPlayers(visible)
	end
end

function SceneFacade:visibleOthersObjects(visible)
	self:showAllElements(visible)

	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.visibleOthersObjects then
		currScene:visibleOthersObjects(visible)
	end
end

function SceneFacade:visibleMainPlayer(visible)
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.visibleMainPlayer then
		currScene:visibleMainPlayer(visible)
	end
end

function SceneFacade:forceExit()
	CityModel.instance.toSceneId = 0

	SceneMgr.instance:exitCurScene()
	SceneMgr.instance:onExitFinished()
end

function SceneFacade:getMainPlayer()
	return SceneMainPlayer.instance:getMainPlayer()
end

function SceneFacade:getNpcs()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.unitFactory then
		return currScene.unitFactory:getUnits(UnitTag.Npc)
	end
end

function SceneFacade:getChallengeNpcs()
	local npcs = self:getNpcs()

	if npcs then
		local challengeNpcs

		for k, v in pairs(npcs) do
			local challengeIds = UnlockConfig.instance:getNpcChallengeIds(v.npcId)

			if challengeIds then
				for i = 1, #challengeIds do
					challengeNpcs = challengeNpcs or {}

					local npc = {
						unit = v,
						challengeId = challengeIds[i]
					}

					table.insert(challengeNpcs, npc)
				end
			end
		end

		return challengeNpcs
	end
end

function SceneFacade:getNpcChallengeId(npcId)
	return UnlockConfig.instance:getNpcChallengeIds(npcId)
end

function SceneFacade:getTaskNpcs()
	local npcs = self:getNpcs()

	if npcs then
		local taskNpcs

		for k, v in pairs(npcs) do
			if self:isTaskNpc(v.npcId) then
				taskNpcs = taskNpcs or {}

				table.insert(taskNpcs, v)
			end
		end

		return taskNpcs
	end
end

function SceneFacade:isTaskNpc(npcId)
	local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId)

	return taskes and #taskes > 0
end

function SceneFacade:isLegendNpc(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			if NpcFuncType.Legend == funcCos[i].funcType then
				return true
			end
		end
	end

	return false
end

function SceneFacade:isChallengeNpc(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			if NpcFuncType.Challenge == funcCos[i].funcType then
				return true
			end
		end
	end

	return false
end

function SceneFacade:isEscortNpc(npcId)
	if npcId == SceneFacade.InvalidNpcId then
		return false
	end

	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			if NpcFuncType.Escort == funcCos[i].funcType then
				return true
			end
		end
	end

	return false
end

function SceneFacade:isChallengeNpcIcon(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			if NpcFuncType.Legend == funcCos[i].funcType or NpcFuncType.Challenge == funcCos[i].funcType or NpcFuncType.ShareTask == funcCos[i].funcType or NpcFuncType.NinePlace == funcCos[i].funcType or NpcFuncType.TimeLimitedChallenge == funcCos[i].funcType then
				return true
			end
		end
	end

	return false
end

function SceneFacade:getNpcTaskState(npcId)
	local accepted, compeleted, going = TaskController.instance:getNpcTaskState(npcId)

	if compeleted then
		return GameEnum.NpcTaskState.Commited
	elseif accepted then
		return GameEnum.NpcTaskState.Accepted
	elseif going then
		return GameEnum.NpcTaskState.TaskGoing
	end

	return GameEnum.NpcTaskState.None
end

function SceneFacade:getSceneSize()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.stage and currScene.stage.wholeScene then
		return currScene.stage.wholeScene:GetSize()
	end
end

function SceneFacade:getTransmitPoints()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.stage and currScene.stage.wholeScene then
		return currScene.stage.wholeScene:GetTransmitPoints()
	end
end

function SceneFacade:getSceneMonsters()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.unitFactory then
		return currScene.unitFactory:getUnits(UnitTag.Monster)
	end
end

function SceneFacade:getSceneMonsterZones()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.stage and currScene.stage.wholeScene then
		return currScene.stage.wholeScene:GetMonsterZones()
	end
end

SceneFacade.instance = SceneFacade.New()

return SceneFacade

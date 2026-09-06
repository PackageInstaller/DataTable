-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/facade/UnlockFacade.lua

module("logic.extensions.unlock.agent.UnlockFacade", package.seeall)

local UnlockFacade = class("UnlockFacade", BaseFacade)

UnlockFacade.dontcheckTaskUnlockScene = nil

function UnlockFacade:loadAllChallengeInfos()
	UnlockController.instance:CSGetUnlockNeedInfoRes()
end

function UnlockFacade:checkSceneUnLock(sceneId)
	if UnlockFacade.dontcheckTaskUnlockScene then
		return true
	end

	if not UnlockModel.instance:isSceneUnlock(sceneId) then
		local unlockCo = UnlockConfig.instance:getUnLockSceneCo(sceneId)

		if unlockCo then
			if unlockCo.triggerType == "MofangLevel" then
				local level = tonumber(unlockCo.triggerParams)
				local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

				TipsFacade.instance:openLockTips(level, GameEnum.MagicLockType.Scene, sceneCo.scene_name)
			elseif unlockCo.triggerType == "Task" then
				local tips = unlockCo.lockTips

				if tips and tostring(tips) ~= "0" and #tostring(tips) > 0 then
					ViewMgr.instance:open(ViewName.SceneUnlockView, tips)
				end
			else
				local tips = unlockCo.lockTips

				if tips and tostring(tips) ~= "0" and #tostring(tips) > 0 then
					TipsFacade.instance:openTipWindow(lang("tip"), tips)
				end
			end
		end

		return
	end

	return true
end

function UnlockFacade:isSceneUnLock(sceneId)
	if UnlockFacade.dontcheckTaskUnlockScene then
		return true
	end

	return UnlockModel.instance:isSceneUnlock(sceneId)
end

function UnlockFacade:onSceneUnLock(sceneId)
	UnlockModel.instance:setSceneUnlock(sceneId)
	GlobalFacade.instance:onSceneUnLock(sceneId)
	GlobalDispatcher:dispatch(GlobalNotify.NewSceneUnlock, sceneId)
end

function UnlockFacade:getUnlockStoryCo(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			local funcCo = funcCos[i]

			if funcCo.ulStory > 0 and UnlockModel.instance:isFunctionUnlock(funcCo.index) and not UnlockModel.instance:isFunctionFinished(funcCo.index) then
				return funcCo
			end
		end

		for i = 1, #funcCos do
			local funcCo = funcCos[i]

			if funcCo.fStory > 0 and UnlockModel.instance:isFunctionFinished(funcCo.index) then
				return funcCo
			end
		end
	end
end

function UnlockFacade:getLockStoryCo(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			local funcCo = funcCos[i]

			if not UnlockModel.instance:isFunctionUnlock(funcCo.index) and not UnlockModel.instance:isFunctionFinished(funcCo.index) and funcCo.lStory and #funcCo.lStory > 0 then
				return funcCo
			end
		end
	end
end

function UnlockFacade:getDefalutStoryCo(npcId)
	local defaultCo = UnlockConfig.instance:getNpcChatCo(npcId)

	if not defaultCo then
		return
	end

	if defaultCo.story and #defaultCo.story > 0 then
		return defaultCo
	end
end

function UnlockFacade:getChallengeNpc(challengeId)
	local challengeNpcs = UnlockConfig.instance:getChallengeNpcs(challengeId)

	if challengeNpcs then
		local scene = SceneMgr.instance:getCurScene()
		local unitFactory = scene.unitFactory

		for i = 1, #challengeNpcs do
			local npc = unitFactory:getUnit(UnitTag.Npc, challengeNpcs[i])

			if npc then
				return challengeNpcs[i]
			end
		end

		if #challengeNpcs > 0 then
			return challengeNpcs[1]
		end
	end
end

function UnlockFacade:getNpcFuncIconCo(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			local icoCo = UnlockConfig.instance:getNpcIconsCoByFuncId(funcCos[i].index)

			if icoCo then
				return icoCo
			end

			icoCo = UnlockConfig.instance:getNpcIconsCoByFuncType(funcCos[i].funcType)

			if icoCo then
				return icoCo
			end
		end
	end
end

UnlockFacade.instance = UnlockFacade.New()

return UnlockFacade

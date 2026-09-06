-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/model/UnlockModel.lua

module("logic.extensions.unlock.model.UnlockModel", package.seeall)

local UnlockModel = class("UnlockModel", BaseListModel)

function UnlockModel:ctor()
	UnlockModel.super.ctor(self)

	self._challengeInfos = {}
	self._lockSceneIds = nil
	self._byTimeOpenScenes = nil
end

function UnlockModel:onReset()
	UnlockModel.super.onReset(self)

	self._challengeInfos = {}
	self._lockSceneIds = nil
	self._byTimeOpenScenes = nil
end

function UnlockModel:onChallengeInfos(challengeinfos)
	self._challengeInfos = {}

	if challengeinfos then
		local count = #challengeinfos

		for i = 1, count do
			local cInfo = challengeinfos[i]

			self:_pushChallengeInfo(cInfo)
		end
	end

	self:checkAllScenesUnlock()
end

function UnlockModel:handleMofangLevel()
	self:_checkSceneUnlock()
end

function UnlockModel:handleTaskData(taskId)
	self:_checkSceneUnlock()
end

function UnlockModel:_pushChallengeInfo(cInfo)
	self._challengeInfos = self._challengeInfos or {}

	if cInfo.phaseNotPassedInfo then
		local phaseInfo = {}

		phaseInfo.isGetPrize = cInfo.isGetPrize
		phaseInfo.isOpen = cInfo.isOpen

		local phaseInfos = cInfo.phaseNotPassedInfo

		for i, v in ipairs(phaseInfos) do
			phaseInfo[v.phaseId] = {}

			for i1, v1 in ipairs(v.branchInfo) do
				phaseInfo[v.phaseId][v1.branchId] = cInfo.curPhase < v.phaseId and GameEnum.ChallengeBranchState.UNLOCKED or v1.state
			end
		end

		self._challengeInfos[cInfo.challengeId] = phaseInfo
	else
		self._challengeInfos[cInfo.challengeId] = nil
	end
end

function UnlockModel:pushChallengeInfo(cInfo)
	self:_pushChallengeInfo(cInfo)
	self:_checkSceneUnlock()
end

function UnlockModel:GetChallengeBranchState(challengeId, phase, branch)
	if not self._challengeInfos then
		return GameEnum.ChallengeBranchState.PASSED
	end

	local challengeInfo = self._challengeInfos[challengeId]

	if not challengeInfo then
		return GameEnum.ChallengeBranchState.PASSED
	end

	local phaseInfo = challengeInfo[phase]

	if not phaseInfo then
		return GameEnum.ChallengeBranchState.PASSED
	end

	local state = phaseInfo[branch]

	return state or GameEnum.ChallengeBranchState.PASSED
end

function UnlockModel:isChallengeBranchUnLock(challengeId, phase, branch)
	if UnlockConfig.instance:hasChllenge(challengeId) then
		return self:GetChallengeBranchState(challengeId, phase, branch) == GameEnum.ChallengeBranchState.UNLOCKED
	end

	return true
end

function UnlockModel:isChallengeBranchPassed(challengeId, phase, branch)
	return ChallengeModel.instance:isChallengeAndPrizePass(challengeId)
end

function UnlockModel:isSceneUnlock(sceneId)
	if not self._lockSceneIds then
		return true
	end

	return not self._lockSceneIds[sceneId]
end

function UnlockModel:setSceneUnlock(sceneId)
	if self._lockSceneIds then
		self._lockSceneIds[sceneId] = nil
	end

	if self._byTimeOpenScenes then
		self._byTimeOpenScenes[sceneId] = nil
	end
end

function UnlockModel:checkSceneUnlockByTime()
	if self._byTimeOpenScenes then
		local nowTime

		for k, v in pairs(self._byTimeOpenScenes) do
			nowTime = nowTime or ServerTime.now()

			if v <= nowTime then
				self:setSceneUnlock(k)
				UnlockFacade.instance:onSceneUnLock(k)

				break
			end
		end
	end
end

function UnlockModel:checkAllScenesUnlock()
	self._lockSceneIds = nil

	local byTimeOpenScenes = self._byTimeOpenScenes
	local unlockCos = UnlockConfig.instance:getUnLockSceneCos()

	for k, v in pairs(unlockCos) do
		self._lockSceneIds = self._lockSceneIds or {}

		if not byTimeOpenScenes then
			self:_initSceneWaitingByTime(v)
		end

		if self:_isSceneUnlock(v) then
			self:setSceneUnlock(v.sceneId)
		else
			self._lockSceneIds[v.sceneId] = true
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.SceneUnlockReady)
end

function UnlockModel:_initSceneWaitingByTime(unlockSceneCo)
	if unlockSceneCo.triggerType == "ByTime" then
		self._byTimeOpenScenes = self._byTimeOpenScenes or {}
		self._byTimeOpenScenes[unlockSceneCo.sceneId] = GameUtil.string2time(unlockSceneCo.triggerParams)
	end
end

function UnlockModel:_checkSceneUnlock()
	if not self._lockSceneIds then
		return
	end

	for k, v in pairs(self._lockSceneIds) do
		local sceneUnlockCo = UnlockConfig.instance:getUnLockSceneCo(k)

		if self:_isSceneUnlock(sceneUnlockCo) then
			self:setSceneUnlock(sceneUnlockCo.sceneId)
			UnlockFacade.instance:onSceneUnLock(sceneUnlockCo.sceneId)
		end
	end
end

function UnlockModel:_isSceneUnlock(sceneUnlockCo)
	if sceneUnlockCo.triggerType == "PassChallenge" then
		local challengesInfo = string.split(sceneUnlockCo.triggerParams, ",")

		if self:isChallengeBranchPassed(tonumber(challengesInfo[1]), tonumber(challengesInfo[2]), tonumber(challengesInfo[3])) then
			return true
		end
	elseif sceneUnlockCo.triggerType == "MofangLevel" then
		if MofangModel.instance:getCurLv() >= tonumber(sceneUnlockCo.triggerParams) then
			return true
		end
	elseif sceneUnlockCo.triggerType == "ByTime" then
		if self._byTimeOpenScenes then
			if not self._byTimeOpenScenes[sceneUnlockCo.sceneId] then
				local openTime = 0
				local nowTime = ServerTime.now()

				if openTime <= nowTime then
					return true
				end
			end
		end
	elseif sceneUnlockCo.triggerType == "ByServerDays" then
		if GameUtil.getOpenAreaDaysForFive() >= tonumber(sceneUnlockCo.triggerParams) then
			return true
		end
	elseif sceneUnlockCo.triggerType == "Task" then
		local taskInfo = string.split(sceneUnlockCo.triggerParams, ",")
		local taskId = tonumber(taskInfo[1])
		local stepId = taskInfo[2]

		stepId = stepId and tonumber(stepId)

		if stepId then
			if TaskFacade.instance:isTaskStepCompeleted(taskId, stepId) then
				return true
			end
		elseif TaskFacade.instance:isTaskCompelete(taskId) then
			return true
		end
	end
end

function UnlockModel:isFunctionUnlock(functionIdx)
	local functionCo = UnlockConfig.instance:getFunctionStateCo(functionIdx)

	if functionCo then
		if functionCo.funcType == NpcFuncType.WuShenShou then
			local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(functionCo.funcParams[1])

			if taskId and stepId then
				return TaskModel.instance:isTaskStepAccpeted(taskId, stepId)
			end

			return
		end

		if functionCo.funcType == NpcFuncType.Escort then
			return EscortModel.instance:IsUnlockEscortStep(functionCo.npcId)
		end

		if functionCo.funcType == NpcFuncType.AnswerScene then
			return AnswerSceneController.instance:checkAnswerSceneOpen()
		end

		if functionCo.funcType == NpcFuncType.OpenFunc then
			return FuncOpenModel.instance:getFuncIsOpen(functionCo.funcParams[1])
		end

		if functionCo.funcType == NpcFuncType.KingWay then
			if functionCo.funcParams and functionCo.funcParams[1] == 1 then
				return true
			end

			return KingWayModel.instance:GetLastNpcIsUnlock(true)
		end

		if functionCo.funcType == NpcFuncType.NinePlace then
			return NinePlaceModel.instance:checkStageCanChallenge(functionCo.funcParams[1])
		end

		if functionCo.funcType == NpcFuncType.Imagefragmentcollection then
			return true
		end

		if functionCo.funcType == NpcFuncType.HalloweenNpc then
			return HalloweenGuestModel.instance:isHalloweenNpsPass(functionCo.npcId)
		end

		if functionCo.funcType == NpcFuncType.ChuangkongUnion then
			local taskIds = functionCo.funcParams

			return ChuangkongunionController.instance:isTaskUnlock(taskIds)
		end

		if functionCo.funcType == NpcFuncType.WeakPathFinding then
			return false
		end

		if functionCo.funcType == NpcFuncType.FunCampFinding then
			return false
		end

		if functionCo.triggerType and #functionCo.triggerType > 0 then
			for i = 1, #functionCo.triggerType do
				if not self:isFunctionUnlockByTriggerType(functionCo.triggerType[i], functionCo.triggerParams[i]) then
					return
				end
			end

			return true
		end
	end

	return true
end

function UnlockModel:getUnlockStoryId(functionIdx)
	local functionCo = UnlockConfig.instance:getFunctionStateCo(functionIdx)

	if functionCo and functionCo.triggerType and functionCo.lStory then
		local len = #functionCo.lStory

		for i = 1, #functionCo.triggerType do
			if functionCo.triggerParams then
				if not functionCo.triggerParams[i] then
					local param

					if not self:isFunctionUnlockByTriggerType(functionCo.triggerType[i], param) then
						local idx = math.min(i, len)

						return functionCo.lStory[idx]
					end
				end
			end
		end
	end
end

function UnlockModel:isFunctionUnlockByTriggerType(triggerType, triggerParams)
	if triggerType == "PassChallenge" then
		local challengesInfo = string.split(triggerParams, ",")

		return self:isChallengeBranchPassed(tonumber(challengesInfo[1]), tonumber(challengesInfo[2]), tonumber(challengesInfo[3]))
	elseif triggerType == "MofangLevel" then
		if MofangModel.instance:getCurLv() >= tonumber(triggerParams) then
			return true
		end

		return false, string.format("请达到 %d 等级", tonumber(triggerParams))
	elseif triggerType == "Task" then
		local taskInfo = string.split(triggerParams, ",")

		if TaskFacade.instance:isTaskStepFinished(tonumber(taskInfo[1]), tonumber(taskInfo[2])) then
			return true
		end

		return false
	elseif triggerType == "MaxZdl" then
		local cfgMaxPower = tonumber(triggerParams)
		local curFactMaxPower = RoleModel.instance:getMaxPower()

		if cfgMaxPower <= curFactMaxPower then
			return true
		end

		return false, string.format("请达到 %d 战力", cfgMaxPower)
	elseif triggerType == "Fuben" then
		local fubenInfo = string.split(triggerParams, ":")
		local chapterId = tonumber(fubenInfo[1])
		local stageId = tonumber(fubenInfo[2])
		local isPass = PlotCopyModel.instance:isStagePassedAllCopy(chapterId, stageId)

		if isPass then
			return true
		end

		local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

		if cfg then
			if not cfg.stageName then
				local name = "XX"

				return false, string.format("<color=#ffa429>【主线 %s】</color>\n完成后解锁", name)
			end
		end
	elseif triggerType == "HuSong" then
		return
	elseif triggerType == "WangZhe" then
		return
	elseif triggerType == "NinePlace" then
		return NinePlaceModel.instance:checkStageCanChallenge(tonumber(triggerParams))
	elseif triggerType == "Daodangui" then
		return
	elseif triggerType == "ChuangkongUnion" then
		return
	elseif triggerType == "weakpathfinding" then
		return
	elseif triggerType == "funcampfinding" then
		return
	end

	return true
end

function UnlockModel:isFunctionFinished(functionIdx)
	local functionCo = UnlockConfig.instance:getFunctionStateCo(functionIdx)

	if functionCo then
		if functionCo.funcType == NpcFuncType.Challenge then
			return self:_isChallengeFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.WuShenShou then
			return self:_isWuShenShouFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.Escort then
			return self:IsHuSongFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.AnswerScene then
			return not AnswerSceneController.instance:checkAnswerSceneOpen()
		elseif functionCo.funcType == NpcFuncType.KingWay then
			if functionCo.funcParams and functionCo.funcParams[1] == 1 then
				return false
			end

			return KingWayModel.instance:IsKingWayAllFinished()
		elseif functionCo.funcType == NpcFuncType.NinePlace then
			return self:_isNinePlaceFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.TimeLimitedChallenge then
			return self:_isAnxinMMFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.Imagefragmentcollection then
			return self:_isImagefragmentcollectionFinished(functionCo)
		elseif functionCo.funcType == NpcFuncType.HalloweenNpc then
			return false
		elseif functionCo.funcType == NpcFuncType.ChuangkongUnion then
			local taskIds = functionCo.funcParams

			return ChuangkongunionController.instance:isTaskFinished(taskIds)
		elseif functionCo.funcType == NpcFuncType.WeakPathFinding then
			return false
		elseif functionCo.funcType == NpcFuncType.FunCampFinding then
			return false
		end
	end
end

function UnlockModel:_isChallengeFinished(functionCo)
	local parseID, branchId = UnlockConfig.instance:getKingRoadFinishParseAndBranch(functionCo.funcParams[1])

	if parseID and branchId then
		local challengeInfo = self._challengeInfos[functionCo.funcParams[1]]

		if not challengeInfo then
			return true
		end

		if not self:isChallengeBranchPassed(functionCo.funcParams[1], parseID, branchId) then
			return nil
		end

		if ChallengeModel.instance:getCurId() == functionCo.funcParams[1] then
			challengeInfo.isGetPrize = ChallengeModel.instance._curInfo.isGetPrize
		end

		if challengeInfo.isGetPrize then
			return true
		end

		return not challengeInfo.isOpen
	end

	return UnlockConfig.instance:hasChllenge(functionCo.funcParams[1])
end

function UnlockModel:_isWuShenShouFinished(functionCo)
	return TaskFacade.instance:isPveTaskFinished(functionCo.funcParams[1])
end

function UnlockModel:IsHuSongFinished(functionCo)
	return EscortModel.instance:IsFinishStep(functionCo.npcId)
end

function UnlockModel:_isNinePlaceFinished(functionCo)
	return NinePlaceModel.instance:isStagePass(functionCo.funcParams[1])
end

function UnlockModel:_isAnxinMMFinished(functionCo)
	if functionCo.funcParams[1] and functionCo.funcParams[1] == AixinmmConfig.instance:getChallengeId() then
		local cid = AixinmmConfig.instance:getChallengeId()
		local isOpen = TLChallengeController.instance:isInOpenTime(cid)

		return not isOpen
	end

	return false
end

function UnlockModel:_isImagefragmentcollectionFinished(functionCo)
	return ImagefragmentcollectionModel.instance:checkFragmentIsFinish(functionCo.funcParams)
end

UnlockModel.instance = UnlockModel.New()

return UnlockModel

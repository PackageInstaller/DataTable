-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/controller/GlobalController.lua

module("logic.extensions.global.controller.GlobalController", package.seeall)

local GlobalController = class("GlobalController", BaseController)

function GlobalController:onInit()
	GlobalController.super.onInit(self)
	self.registerNotify(self, GlobalNotify.SelectNPC, self._onSelectNpc, self)
	self.registerNotify(self, GlobalNotify.SelectElement, self._onSelectElement, self)
	self.registerNotify(self, GlobalNotify.SelectMonster, self._onSelectMonster, self)
	self.registerNotify(self, GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.High)
	self.registerNotify(self, GlobalNotify.OnMaterialGet, self._onMaterialGet, self)
	self.registerNotify(self, GlobalNotify.NPCUnlockStoryStart, self._onNPCUnlockStoryStart, self)
	self.registerNotify(self, GlobalNotify.NPCUnlockStoryEnd, self._onNpcUnlockStoryEnd, self)
	self.registerNotify(self, GlobalNotify.SceneStartLoaded, self._onSceneStartLoaded, self, NotifyPriority.High)
	self.registerNotify(self, GlobalNotify.ApplicationFocus, self._handleOnApplicationFocus, self)
	self.registerNotify(self, GlobalNotify.StartAutoPath, self._onStartAutoPath, self)
	self.registerNotify(self, GlobalNotify.EndAutoPath, self._onEndAutoPath, self)
	self.registerNotify(self, GlobalNotify.PlayerStrengthChange, self._onPlayerStrengthChange, self)
	self:_registerNotifyViews()
	self:_registerIgoreOrderMsgs()

	self._showGetPetEggViewOnLoadScene = nil
	self._showSceneUnLockOnLoadSceneId = nil
	self._showPlayerStrengthCHangeOnLoaded = nil
end

function GlobalController:onReset()
	self._showGetPetEggViewOnLoadScene = nil
	self._showSceneUnLockOnLoadSceneId = nil
	self._showPlayerStrengthCHangeOnLoaded = nil

	NetConnMgrExt.init()
	ViewMgr.instance:setPermanent(ViewName.Popupwindow)
	UIReverseMaskMgr.instance:finish()
	GameUtil.resetClickEnabled()

	if AudioPlayerEx.isInitialized then
		AudioVoicePlayer.instance:stopVoice(true)
	end
end

function GlobalController:_registerIgoreOrderMsgs()
	MsgFlowMgr.instance:setIgoreOrderMsg(25, 2)
	MsgFlowMgr.instance:setIgoreOrderMsg(25, 4)
	MsgFlowMgr.instance:setIgoreOrderMsg(43, 8)
	MsgFlowMgr.instance:setIgoreOrderMsg(7, 5)
	MsgFlowMgr.instance:setIgoreOrderMsg(2, 4)
	MsgFlowMgr.instance:setIgoreOrderMsg(34, 1)
	MsgFlowMgr.instance:setIgoreOrderMsg(34, 2)
	MsgFlowMgr.instance:setIgoreOrderMsg(35, 2)
	MsgFlowMgr.instance:setIgoreOrderMsg(133, 6)
	MsgFlowMgr.instance:setIgoreOrderMsg(133, 7)
	MsgFlowMgr.instance:setIgoreOrderMsg(52, 6)
end

function GlobalController:_registerNotifyViews()
	local viewMgr = ViewMgr.instance

	viewMgr:registerNotifyView(ViewName.GuideFrameView)
	viewMgr:registerNotifyView(ViewName.PlayerAutoPath)
	viewMgr:registerNotifyView(ViewName.PlayerStrength)
	viewMgr:registerNotifyView(ViewName.WeakPathFindingView)
	viewMgr:registerNotifyView(ViewName.CardInfoStackView)
	viewMgr:registerNotifyView(ViewName.TitleView)
	viewMgr:registerNotifyView(ViewName.OtherCardInfoStackView)
	viewMgr:registerNotifyView(ViewName.bubble)
	viewMgr:registerNotifyView(ViewName.PickResultView)
	viewMgr:registerNotifyView(ViewName.TabbgView)
	viewMgr:registerNotifyView(ViewName.TaskCollect)
	viewMgr:registerNotifyView(ViewName.RoleActions)
	viewMgr:registerNotifyView(ViewName.BulletScreen)
	viewMgr:registerNotifyView(ViewName.BattleEvaluateView)
	viewMgr:registerNotifyView(ViewName.BattleVerifyView)
	viewMgr:registerNotifyView(ViewName.GMView)
	viewMgr:registerNotifyView(ViewName.PetFilterView)
	viewMgr:registerNotifyView(ViewName.PetTips)
	viewMgr:registerNotifyView(ViewName.PetSortPaneView)
	viewMgr:registerNotifyView(ViewName.RankRaceBuffTipsView)
	viewMgr:registerNotifyView(ViewName.LotteryRandom)
	viewMgr:registerNotifyView(ViewName.ZooDigView)
end

function GlobalController:onSceneUnLock(sceneId)
	self._showSceneUnLockOnLoadSceneId = sceneId

	self:_checkUnLockSceneViewOnLoadScene()
end

function GlobalController:_onSceneStartLoaded()
	GlobalModel.instance:showUI(true)
end

function GlobalController:_handleOnApplicationFocus()
	if Framework.OSDef.RunOS == Framework.OSDef.IOS then
		return
	end

	GlobalModel.instance.eventSystem:SetActive(false)
	GlobalModel.instance.eventSystem:SetActive(true)

	if not HardwareQuality.currentQuality then
		return
	end

	if HardwareQuality.currentQuality.resolution and HardwareQuality.currentQuality.resolution > 0 then
		local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)

		self._resolutionScale = HardwareQuality.currentQuality.resolution / screenHeight
	else
		self._resolutionScale = 1
	end

	SceneResolution.Instance:SetDirectResolution(self._resolutionScale * 0.5)
	settimer(0.5, self._delatSetResolution, self)
end

function GlobalController:_delatSetResolution()
	removetimer(self._delatSetResolution, self)

	if self._resolutionScale then
		SceneResolution.Instance:SetDirectResolution(self._resolutionScale)

		self._resolutionScale = nil
	end
end

function GlobalController:_onSceneLoadedFinish(sceneType, sceneId)
	TaskController.instance:onSceneLoadedFinish(sceneType, sceneId)
	GuideController.instance:onSceneLoadedFinish(sceneType, sceneId)
	StoryController.instance:onSceneLoadedFinish(sceneType, sceneId)
	GlobalModel.instance:onEnterScene(sceneType)
	ColorfulEggsController.instance:onSceneLoadedFinish(sceneType, sceneId)
	self:_checkUnLockSceneViewOnLoadScene()
	self:_checkPlayerStrengthChangeOnLoadedScene()
	EscortController.instance:OnSceneLoadedFinish(sceneType, sceneId)
end

function GlobalController:_checkPlayerStrengthChangeOnLoadedScene()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if self._showPlayerStrengthCHangeOnLoaded then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() ~= SceneType.Battle then
			self._showPlayerStrengthCHangeOnLoaded = nil
			GlobalModel.instance.isChangingSrength = true

			ViewMgr.instance:open(ViewName.PlayerStrength)
		end
	end
end

function GlobalController:_checkUnLockSceneViewOnLoadScene()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if self._showSceneUnLockOnLoadSceneId then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() ~= SceneType.Battle then
			local unlockCo = UnlockConfig.instance:getUnLockSceneCo(self._showSceneUnLockOnLoadSceneId)

			if unlockCo then
				local tips = unlockCo.unlockTips

				if tips and tostring(tips) ~= "0" and #tostring(tips) > 0 then
					TipsFacade.instance:openTipWindow(lang("tip"), tips)
				end
			end

			self._showSceneUnLockOnLoadSceneId = nil
		end
	end
end

function GlobalController:_onMaterialGet(msg)
	if TaskController.instance:onMaterialGet(msg) then
		return
	end
end

function GlobalController:getNpcFunctionMos(npcId)
	local taskIds = TaskController.instance:handleSelectNpc(npcId)
	local funcMos

	if taskIds then
		for i = 1, #taskIds do
			local funcMo = NpcFunction.New()

			funcMo.taskId = taskIds[i]
			funcMos = funcMos or {}

			table.insert(funcMos, funcMo)
		end
	end

	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			local funcCo = funcCos[i]

			if UnlockModel.instance:isFunctionUnlock(funcCo.index) and not UnlockModel.instance:isFunctionFinished(funcCo.index) then
				local funcMo = NpcFunction.New()

				funcMo.funcCo = funcCo
				funcMos = funcMos or {}

				table.insert(funcMos, funcMo)
			end
		end
	end

	return funcMos
end

function GlobalController:_onSelectNpc(npcId)
	local function callbackFunc()
		if npcId ~= SceneFacade.InvalidNpcId then
			if ColorfulEggsController.instance:onSelectNpc(npcId) then
				return
			end

			local funcMos = self:getNpcFunctionMos(npcId)

			if funcMos and #funcMos > 1 then
				ViewMgr.instance:open(ViewName.UnlockView, npcId, funcMos)

				return
			end
		end

		if TaskController.instance:onSelectNpc(npcId) then
			return
		end

		if self:_checkNpcStory(npcId) then
			return
		end

		if self:_checkNpcFunc(npcId) then
			return
		end

		if self:_checkNpcDefaultStory(npcId) then
			return
		end

		if TaskController.instance:checkNpcChat(npcId) then
			return
		end
	end

	if TaskController.instance:checkPauseOnEscort(callbackFunc) then
		return
	end

	callbackFunc()
end

function GlobalController:_onSelectElement(elementId)
	local function callbackFunc()
		ColorfulEggsController.instance:onSelectElement(elementId)
	end

	if TaskController.instance:checkPauseOnEscort(callbackFunc) then
		return
	end

	callbackFunc()
end

function GlobalController:_onNPCUnlockStoryStart()
	GlobalModel.instance:showUI(false, GlobalModel.UIFadeTime)
end

function GlobalController:_onNpcUnlockStoryEnd(npcId, funcCo)
	GlobalModel.instance:showUI(true, GlobalModel.UIFadeTime)

	if npcId and npcId > 0 then
		self:handleNpcFunc(npcId, funcCo)
	end
end

function GlobalController:_onSelectMonster(mstId)
	local function callbackFunc()
		if TaskController.instance:onSelectMonster(mstId) then
			return
		end

		BattleFacade.instance:selectSceneMonster(mstId)
	end

	if TaskController.instance:checkPauseOnEscort(callbackFunc) then
		return
	end

	callbackFunc()
end

function GlobalController:_checkNpcFunc(npcId)
	local funcCos = UnlockConfig.instance:getNpcFuncTypes(npcId)

	if funcCos then
		for i = 1, #funcCos do
			local funcCo = funcCos[i]

			if self:handleNpcFunc(npcId, funcCo) then
				return true
			end
		end
	end
end

function GlobalController:handleNpcFunc(npcId, funcCo)
	if UnlockModel.instance:isFunctionUnlock(funcCo.index) and not UnlockModel.instance:isFunctionFinished(funcCo.index) then
		local funcType, funcParams = funcCo.funcType, funcCo.funcParams

		if funcType == NpcFuncType.Challenge then
			ChallengeFacade.instance:startChallange(funcParams[1])

			return true
		elseif funcType == NpcFuncType.PetEgg then
			UIStateManager.instance:push(ViewName.petegg)

			return true
		elseif funcType == NpcFuncType.JiuGongBaZhen then
			return true
		elseif funcType == NpcFuncType.WuShenShou then
			BattleFacade.instance:startPve(funcParams[1], false)

			return true
		elseif funcType == NpcFuncType.EvEBattle then
			if not funcParams[1] then
				local eveA = 0

				if not funcParams[2] then
					local eveB = 0

					if eveA ~= 0 and eveB ~= 0 then
						TaskFacade.instance:requestEvEBattle(funcParams[1] or 0, funcParams[2] or 0)
					else
						if eveA ~= 0 then
							BattleFacade.instance:startPve(eveA, false)
						end

						if eveB ~= 0 then
							BattleFacade.instance:startPve(eveB, false)
						end
					end

					return true
				end
			end
		elseif funcType == NpcFuncType.MoFang then
			UIStateManager.instance:push("mofangview")

			return true
		elseif funcType == NpcFuncType.Legend then
			local challengeId = funcParams[1]
			local isCanSweep = LegendConfig.instance:getLegendChallengeCfg(challengeId).openSweep
			local isPass = LegendModel.instance:isChallengePass(challengeId)

			if isPass and not isCanSweep then
				FloatWordMgr.instance:show("本精灵挑战已全部通关~\n可在【挑战】中进行扫荡")
			else
				UIStateManager.instance:push(ViewName.Legend, challengeId)
			end

			return true
		elseif funcType == NpcFuncType.Escort then
			local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

			TaskController.instance:foreceClearState()

			if mainPlayer then
				mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
			end

			return true
		elseif funcType == NpcFuncType.KingWay then
			KingWayModel.instance:OpenLastNpcBattleView()

			return true
		elseif funcType == NpcFuncType.OpenFunc then
			FuncOpenController.instance:openFunc(funcParams[1])

			return true
		elseif funcType == NpcFuncType.ShareTask then
			UIStateManager.instance:push(ViewName.ShareMission)

			return true
		elseif funcType == NpcFuncType.NinePlace then
			UIStateManager.instance:push(ViewName.NineplacechallengeView, funcParams[1])

			return true
		elseif funcType == NpcFuncType.AnswerScene then
			AnswerSceneController.instance:enterAnswerScene()

			return true
		elseif funcType == NpcFuncType.TimeLimitedChallenge then
			local challengeId = funcParams[1]

			TLChallengeController.instance:openChallengeView(challengeId)

			return true
		elseif funcType == NpcFuncType.GuideQilin then
			UIStateManager.instance:push(ViewName.guideQilin)
		elseif funcType == NpcFuncType.Imagefragmentcollection then
			if not ImagefragmentcollectionModel.instance:checkFragmentIsFinish(funcParams) and ImagefragmentcollectionModel.instance:checkFragmentIsOpen(funcParams) then
				ImagefragmentcollectionController.instance:sendActiveFragmentReq(funcParams)
			end

			return true
		elseif funcType == NpcFuncType.ChuangkongUnion then
			local taskIds = funcParams

			ChuangkongunionController.instance:openTaskView(taskIds)

			return true
		elseif funcType == NpcFuncType.ElemeFinding then
			local activityId = funcParams[1]

			ElemeController.instance:onClickNpc(npcId, activityId)

			return true
		end
	end
end

function GlobalController:_checkNpcStory(npcId)
	local funcCo = UnlockFacade.instance:getUnlockStoryCo(npcId)

	funcCo = funcCo or UnlockFacade.instance:getLockStoryCo(npcId)

	if funcCo then
		local funcMos = {}
		local funcMo = NpcFunction.New()

		funcMo.funcCo = funcCo

		table.insert(funcMos, funcMo)
		ViewMgr.instance:open(ViewName.UnlockView, npcId, funcMos)

		return true
	end
end

function GlobalController:_checkNpcDefaultStory(npcId)
	local funcCo = UnlockFacade.instance:getDefalutStoryCo(npcId)

	if funcCo then
		ViewMgr.instance:open(ViewName.UnlockView, npcId)

		return true
	end
end

function GlobalController:_onStartAutoPath()
	if not ViewMgr.instance:isOpen(ViewName.PlayerAutoPath) then
		ViewMgr.instance:open(ViewName.PlayerAutoPath)
	end
end

function GlobalController:_onEndAutoPath()
	ViewMgr.instance:close(ViewName.PlayerAutoPath)
end

function GlobalController:_onPlayerStrengthChange(strength)
	self._showPlayerStrengthCHangeOnLoaded = nil

	if not GlobalModel.instance.isChangingSrength then
		local currS = GlobalModel.instance:getCurrStrength()

		if currS < strength then
			GlobalModel.instance:onPlayerStrengthChange(strength)

			if not SceneMgr.instance.isGogingToEnterBattleScene then
				GlobalModel.instance.isChangingSrength = true

				ViewMgr.instance:open(ViewName.PlayerStrength)
			else
				self._showPlayerStrengthCHangeOnLoaded = true
			end
		end
	else
		GlobalModel.instance:onPlayerStrengthChange(strength)
	end
end

function GlobalController:clearPlayerStrengthChange()
	local strength = GlobalModel.instance:popStrength()

	GlobalModel.instance:cleartCurrStrengths()
	self:closePlayerStrengthChange()

	if strength > 0 then
		self:_onPlayerStrengthChange(strength)
	end
end

function GlobalController:closePlayerStrengthChange()
	if GlobalModel.instance.isChangingSrength then
		GlobalModel.instance.isChangingSrength = nil

		ViewMgr.instance:close(ViewName.PlayerStrength)
	end
end

GlobalController.instance = GlobalController.New()

return GlobalController

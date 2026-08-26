-- chunkname: @modules/logic/gm/controller/GMController.lua

module("modules.logic.gm.controller.GMController", package.seeall)

local GMController = class("GMController", BaseController)

GMController.debugViewGO = nil
GMController.Event = {
	OnRecvGMMsg = 3,
	ChangeSelectHeroItem = 2
}
GMController.GMNodesPrefabUrl = "ui/viewres/gm/gmnodes.prefab"

function GMController:onInit()
	self:_setDebugViewVisible()
	self:ignoreHeartBeatLog()

	self.isShowEditorFightUI = true
	self.showEnemy = true
	self.__testHotFix = false
end

function GMController:onInitFinish()
	if isDebugBuild then
		TaskDispatcher.runDelay(self._delayInit, self, 2)

		if SLFramework.FileHelper.IsFileExists(SLFramework.FrameworkSettings.PersistentResRootDir .. "/ResourceCollector.txt") then
			TaskDispatcher.runRepeat(self.exportCollectInfo, self, 10)
		end
	end
end

function GMController:exportCollectInfo()
	SLFramework.ResourceCollector.ExportCollectInfo("")
end

function GMController:_delayInit()
	if isDebugBuild then
		self:initShowAudioLog()
		self:_loadGMNodes()
		logNormal(string.format("isDebugBuild, openGM:%s", GameConfig.OpenGm and "true" or "false"))
		TaskDispatcher.runRepeat(self._onFrame, self, 0.1)

		local flag = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, -1)

		GMLangController.instance:init()

		if SLFramework.FrameworkSettings.IsEditor then
			if flag == -1 then
				PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
			end

			return
		end

		if not GameConfig.OpenGm then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 0)

			return
		end

		if flag == -1 then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
		end
	end
end

function GMController:isOpenGM()
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function GMController:stopKeyListener()
	logNormal("stop gm key listener")
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function GMController:getCurrency()
	local diamond = CurrencyModel.instance:getDiamond()
	local freediamond = CurrencyModel.instance:getFreeDiamond()
	local gold = CurrencyModel.instance:getGold()
	local power = CurrencyModel.instance:getPower()
	local rewardPointch1 = DungeonMapModel.instance:getRewardPointValue(101)
	local rewardPointch2 = DungeonMapModel.instance:getRewardPointValue(102)

	logError(string.format("粹雨滴：%s,  纯雨滴：%s    利齿子儿：%s,   体力：%s", diamond, freediamond, gold, power))
	logError(string.format("奖励点 —— 第一章：%s, 第二章：%s", rewardPointch1, rewardPointch2))
	GameFacade.showToast(ToastEnum.GMCurrency, "粹雨滴", diamond)
	GameFacade.showToast(ToastEnum.GMCurrency, "纯雨滴", freediamond)
	GameFacade.showToast(ToastEnum.GMCurrency, "利齿子儿", gold)
	GameFacade.showToast(ToastEnum.GMCurrency, "体力", power)
end

function GMController:sendGM(gm)
	if isDebugBuild then
		GMRpc.instance:sendGMRequest(gm)
	end
end

function GMController:back2Main()
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function GMController:_setDebugViewVisible()
	GMController.debugViewGO = gohelper.find("DebugView")

	local isShow = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1

	gohelper.setActive(GMController.debugViewGO, isShow)
end

function GMController:_onFrame()
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F2) then
		self:getCurrency()
	end

	local leftShift = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	local leftControl = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl)
	local toggleGm = UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) and leftShift and leftControl

	toggleGm = toggleGm or UnityEngine.Input.touchCount >= 5

	if toggleGm and isDebugBuild and (SLFramework.FrameworkSettings.IsEditor or GameConfig.OpenGm) then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			self._lastTime = Time.time

			return
		end

		if not self._lastTime then
			do
				local lastTime = 0

				if Time.time - lastTime <= 1 then
					return
				end

				self._lastTime = Time.time

				local openGM = self:isOpenGM() and 0 or 1

				PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, openGM)
				MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)

				if openGM == 1 then
					GameFacade.showToast(ToastEnum.IconId, "GM开启")
					self:openGMView()
				else
					GameFacade.showToast(ToastEnum.IconId, "GM关闭")
				end

				return
			end

			if leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
				GMRpc.instance:sendGMRequest("set fight 1")

				if ViewMgr.instance:isOpen(ViewName.DiceHeroGameView) then
					GMRpc.instance:sendGMRequest("diceFightWin")
					TaskDispatcher.runDelay(function()
						if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
							ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
								status = DiceHeroFightModel.instance.finishResult
							})
							DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

							DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
						end
					end, self, 0.5)
				end

				return
			end

			if leftShift and leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
				self:openGMView()
			elseif leftShift and leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
				LoginController.instance:logout()
			elseif leftShift and leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
				ViewMgr.instance:openView(ViewName.ProtoTestView)
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha1) then
				self:playRightSkill(1)
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha2) then
				self:playRightSkill(2)
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha3) then
				self:playRightSkill(3)
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha4) then
				-- block empty
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha5) then
				-- block empty
			elseif leftControl and leftShift and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha6) then
				-- block empty
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
				FightController.instance:dispatchEvent(FightEvent.GMCopyRoundLog)
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
				ViewMgr.instance:openView(ViewName.FightEditorStateView)
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.M) then
				self:playFightSceneSpineAnimation(SpineAnimState.born)
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
				self:playFightSceneSpineAnimation(SpineAnimState.victory)
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
				self:switchEnemyVisible()
			elseif leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.H) then
				self.isShowEditorFightUI = not self.isShowEditorFightUI

				self:refreshSkillEditorView()
			elseif leftShift and leftControl and UnityEngine.Input.GetKey(UnityEngine.KeyCode.T) then
				if self.______SocketReceiverCD_______ and os.clock() - self.______SocketReceiverCD_______ < 1 then
					return
				end

				require("tolua.reflection")
				tolua.loadassembly("SL_AS")

				local socket = SLFramework.SocketMgr.Instance:GetSocketClient(0)
				local type_client = tolua.findtype("SLFramework.TcpSocketClient")
				local type_client_property = tolua.getproperty(type_client, "Receive", 20)
				local receiver = type_client_property:Get(socket, {})
				local type_receiver = tolua.findtype("SLFramework.TcpSocketReceiver")
				local type_receiver_property = tolua.getfield(type_receiver, "thread", 36)
				local thread = type_receiver_property:Get(receiver)
				local type_thread = tolua.findtype("System.Threading.Thread")
				local type_thread_property = tolua.getproperty(type_thread, "ThreadState", 20)
				local state = type_thread_property:Get(thread, {})
				local thread_resume_mothod = tolua.getmethod(type_thread, "Resume")
				local thread_suspend_mothod = tolua.getmethod(type_thread, "Suspend")

				if not tostring(state):find("Suspended") then
					if tostring(state):find("SuspendRequested") then
						thread_resume_mothod:Call(thread)
						GameFacade.showToast(ToastEnum.IconId, "恢复网络")

						goto label_11_0
					end
				end

				thread_suspend_mothod:Call(thread)
				GameFacade.showToast(ToastEnum.IconId, "暂停网络")

				::label_11_0::

				self.______SocketReceiverCD_______ = os.clock()
			end

			local PlayerPrefs = UnityEngine.PlayerPrefs
			local key = PlayerPrefsKey.OpenGM

			if not string.nilorempty(PlayerPrefs.GetString(key, nil)) then
				PlayerPrefs.DeleteKey(key)
				ViewMgr.instance:openView(ViewName.GMToolView2)
			end
		end
	end
end

function GMController:openGMView()
	if self:checkNeedOpenGM2View() then
		ViewMgr.instance:closeView(ViewName.GMToolView)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	else
		ViewMgr.instance:closeView(ViewName.GMToolView2)
		ViewMgr.instance:openView(ViewName.GMToolView)
	end
end

function GMController:checkNeedOpenGM2View()
	if SkillEditorMgr and SkillEditorMgr.instance and SkillEditorMgr.instance.inEditMode then
		return true
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return true
	end
end

function GMController:ignoreHeartBeatLog()
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"GetServerTimeRequest",
		"GetServerTimeReply"
	})
end

function GMController:resumeHeartBeatLog()
	LuaSocketMgr.instance:setIgnoreSomeCmdLog()
end

function GMController:refreshSkillEditorView()
	self.goUiRoot = self.goUiRoot or gohelper.find("UIRoot")
	self.goCameraRoot = self.goCameraRoot or gohelper.find("cameraroot")
	self.goIDRoot = self.goIDRoot or gohelper.find("IDCanvas")
	self.goNameBar = gohelper.findChild(self.goUiRoot, "HUD/NameBar")
	self.goSkillEffectStatView = gohelper.findChild(self.goUiRoot, "POPUP_TOP/SkillEffectStatView")
	self.goSkillEditorView = gohelper.findChild(self.goUiRoot, "TOP/SkillEditorView")
	self.goText = gohelper.findChild(self.goUiRoot, "Text")
	self.goSubHero = gohelper.findChild(self.goCameraRoot, "SceneRoot/FightScene/Entitys/Player_-1")
	self.goIDPopup = self.goIDPopup or gohelper.findChild(self.goIDRoot, "POPUP")
	self.goFloat = gohelper.findChild(self.goUiRoot, "HUD/Float")

	gohelper.setActive(self.goNameBar, self.isShowEditorFightUI)
	gohelper.setActive(self.goSkillEffectStatView, self.isShowEditorFightUI)
	gohelper.setActive(self.goSkillEditorView, self.isShowEditorFightUI)
	gohelper.setActive(self.goText, self.isShowEditorFightUI)
	gohelper.setActive(self.goSubHero, self.isShowEditorFightUI)
	gohelper.setActive(self.goIDPopup, self.isShowEditorFightUI)
	gohelper.setActive(self.goFloat, self.isShowEditorFightUI)
end

function GMController:getIsShowEditorFightUI()
	return self.isShowEditorFightUI
end

function GMController:playRightSkill(index)
	local container = ViewMgr.instance:getContainer(ViewName.SkillEditorView)

	if container then
		local heroId = container.rightSkillEditorSideView._skillSelectView._entityMO.modelId
		local skillDict = SkillConfig.instance:getHeroBaseSkillIdDict(heroId)

		container.rightSkillEditorSideView._skillSelectView._curSkillId = skillDict[index]

		container.rightSkillEditorSideView:_onClickFight()
	end
end

function GMController:playFightSceneSpineAnimation(animationName)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.SkillEditorView) then
		return
	end

	local fightScene = GameSceneMgr.instance:getCurScene()

	if not fightScene then
		return
	end

	local attacker = SkillEditorMgr.instance.cur_select_entity_id and FightGameMgr.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id) or FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])

	if not attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	self._attacker = attacker

	local entityData = FightDataHelper.entityMgr:getById(self._attacker.id)
	local skinId = entityData and entityData.skin
	local config = lua_fight_skin_entity_enter_timeline.configDict[skinId]

	if animationName == "born" and config and self._attacker.skill then
		local fightStepData = FightStepData.New(FightDef_pb.FightStep())

		fightStepData.fromId = entityData.id
		fightStepData.toId = entityData.id

		local timelineWork = self._attacker.skill:registTimelineWork(config.timeline, fightStepData)

		timelineWork:start()

		return
	end

	local spineActionDict = FightConfig.instance:getSkinSpineActionDict(self._attacker:getMO().skin)
	local spineActionCO = spineActionDict and spineActionDict[animationName]

	TaskDispatcher.cancelTask(self.resetAnim, self)
	self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)

	if spineActionCO and spineActionCO.effectRemoveTime > 0 then
		local animDuration = spineActionCO.effectRemoveTime / FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(self.resetAnim, self, animDuration)
	else
		self._ani_need_transition, self._transition_ani = FightHelper.needPlayTransitionAni(self._attacker, animationName)

		self._attacker.spine:addAnimEventCallback(self._onAnimEvent, self)
	end

	attacker.spine:play(animationName, false, true)
end

function GMController:resetAnim()
	if self._attacker then
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)
		self._attacker:resetAnimState()
	end
end

function GMController:_onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		if self._ani_need_transition and self._transition_ani == actionName then
			return
		end

		self:resetAnim()
	end
end

function GMController:getVisualInteractiveMgr()
	if not self.viaMgr then
		self.viaMgr = VisualInteractiveAreaMgr.New()

		self.viaMgr:init()
	end

	return self.viaMgr
end

function GMController:getVisualInteractive()
	return self.visualInteractive or false
end

function GMController:setVisualInteractive(visual)
	self.visualInteractive = visual
end

function GMController:getTextSizeActive()
	return self.textSizeActive or false
end

function GMController:setTextSizeActive(active)
	self.textSizeActive = active
end

function GMController:switchEnemyVisible()
	self.showEnemy = not self.showEnemy

	local goMasterUi = gohelper.find("UIRoot/HUD/NameBar/Monster_1")
	local goMasterSpine = gohelper.find("cameraroot/SceneRoot/FightScene/Entitys/Monster_1")

	gohelper.setActive(goMasterUi, self.showEnemy)
	gohelper.setActive(goMasterSpine, self.showEnemy)
end

function GMController:_loadGMNodes()
	self._gmNodeLoader = MultiAbLoader.New()

	self._gmNodeLoader:addPath(GMController.GMNodesPrefabUrl)
	self._gmNodeLoader:startLoad(self._onLoadGMNodesFinish, self)
end

function GMController:_onLoadGMNodesFinish(loader)
	self._prefab = loader:getFirstAssetItem():GetResource()
end

function GMController:getGMNode(pathInNode, setParentGO)
	if isDebugBuild then
		if not self._prefab or not setParentGO then
			return nil
		end

		local nodeGOInPrefab = gohelper.findChild(self._prefab, pathInNode)

		if nodeGOInPrefab then
			return (gohelper.clone(nodeGOInPrefab, setParentGO, nodeGOInPrefab.name))
		else
			logError("找不到GM节点：" .. pathInNode)
		end
	end
end

function GMController:initShowAudioLog()
	self.showAudioLog = PlayerPrefsHelper.getNumber("showAudioLogKey", 0) == 1
	ZProj.AudioManager.Instance.gmOpenLog = self.showAudioLog

	if self.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		self:initClearAudioLogBtn()
	end
end

function GMController:getShowAudioLog()
	return self.showAudioLog
end

function GMController:setShowAudioLog(isOpen)
	if isOpen == self.showAudioLog then
		return
	end

	self.showAudioLog = isOpen

	PlayerPrefsHelper.setNumber("showAudioLogKey", isOpen and 1 or 0)

	if self.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		self:initClearAudioLogBtn()
	else
		ZProj.AudioEditorTool.Instance:HideAudioLog()
	end
end

function GMController:initClearAudioLogBtn()
	if not gohelper.isNil(self.clearAudioLogBtn) then
		return
	end

	TaskDispatcher.cancelTask(self._initClearAudioLogBtn, self)
	TaskDispatcher.runRepeat(self._initClearAudioLogBtn, self, 1)
end

function GMController:_initClearAudioLogBtn()
	local viewGo = gohelper.find("UIRoot/TOP/audiolog(Clone)")

	if gohelper.isNil(viewGo) then
		return
	end

	self.clearAudioLogBtn = SLFramework.UGUI.ButtonWrap.GetWithPath(viewGo, "clearBtn")

	self.clearAudioLogBtn:AddClickListener(self.onClickClearAudio, self)

	self.txtLog = gohelper.findChildText(viewGo, "Scroll View/Viewport/Content")

	TaskDispatcher.cancelTask(self._initClearAudioLogBtn, self)
end

function GMController:onClickClearAudio()
	if not gohelper.isNil(self.txtLog) then
		self.txtLog.text = ""
	end
end

function GMController.invokeCSharpInstanceMethod(typeFullName, methodName)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype(typeFullName)
	local baseType = type.BaseType
	local instance = tolua.getproperty(baseType, "Instance")
	local method = tolua.getmethod(type, methodName)

	method:Call(instance:Get(nil, nil))
end

function GMController:TestFightByBattleId(battleId)
	local battleCO = battleId and lua_battle.configDict[battleId]

	if not battleCO then
		return
	end

	local fightParam = FightController.instance:setFightParamByBattleId(battleId)

	HeroGroupModel.instance:setParam(battleId, nil, nil)

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local equips = curGroupMO:getAllHeroEquips()

	for i, v in ipairs(lua_episode.configList) do
		if v.battleId == battleId then
			fightParam.episodeId = v.id
			FightResultModel.instance.episodeId = v.id

			DungeonModel.instance:SetSendChapterEpisodeId(v.chapterId, v.id)

			break
		end
	end

	fightParam.episodeId = fightParam.episodeId or 10101

	fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
	FightController.instance:sendTestFightId(fightParam)
end

function GMController:initProfilerCmdFileCheck()
	if self._initProfiler then
		logNormal("profiler is inited")

		return
	end

	self._initProfiler = true

	local interval = 10
	local directory = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local fileName = "profilerCmd.json"

	self._profilerCmdFilePath = System.IO.Path.Combine(directory, fileName)

	self:_checkProfilerCmdFile()
	logNormal("begin checkProfilerCmdFile")
	TaskDispatcher.runRepeat(self._checkProfilerCmdFile, self, interval)
end

function GMController:_checkProfilerCmdFile()
	logNormal("Checking Profiler Cmd File")

	if SLFramework.FileHelper.IsFileExists(self._profilerCmdFilePath) then
		local jsonStr = SLFramework.FileHelper.ReadText(self._profilerCmdFilePath)

		if not jsonStr or jsonStr == "" then
			return
		end

		BenchmarkApi.AndroidLog("profilerCmd.json: " .. jsonStr)

		local jsonTable = cjson.decode(jsonStr)
		local cmds = jsonTable.cmds

		PerformanceRecorder.instance:doProfilerCmdAction(cmds)
		SLFramework.FileHelper.WriteTextToPath(self._profilerCmdFilePath, "")
	end
end

function GMController:setRecordASFDCo(emitterId, missileId, explosionId)
	self.emitterId = tonumber(emitterId)
	self.missileId = tonumber(missileId)
	self.explosionId = tonumber(explosionId)
end

function GMController.tempHasField(tab, key)
	return false
end

function GMController:startASFDFlow(count, side, toEntityId)
	if self.asfdSequence then
		return
	end

	local emitterEntityMo = FightDataHelper.entityMgr:getASFDEntityMo(side)

	emitterEntityMo = emitterEntityMo or self:createASFDEmitter(side)

	local fightStepDataList = {}

	for index = 1, count do
		local tab = {
			cardIndex = 1,
			actType = 1,
			fromId = emitterEntityMo.id,
			toId = toEntityId,
			actId = FightASFDConfig.instance.skillId,
			actEffect = {
				{
					targetId = toEntityId,
					effectType = FightEnum.EffectType.EMITTERFIGHTNOTIFY,
					reserveStr = cjson.encode({
						splitNum = 0,
						emitterAttackNum = index,
						emitterAttackMaxNum = count
					}),
					HasField = GMController.tempHasField,
					cardInfoList = {},
					fightTasks = {}
				}
			}
		}
		local stepData = FightStepData.New(tab)

		table.insert(fightStepDataList, stepData)
	end

	self.asfdSequence = FlowSequence.New()

	for index, stepData in ipairs(fightStepDataList) do
		local ASFDFlow = FightASFDFlow.New(stepData, fightStepDataList[index + 1], index)

		self.asfdSequence:addWork(ASFDFlow)
	end

	TaskDispatcher.runDelay(self.delayStartASFDFlow, self, 1)
end

function GMController:delayStartASFDFlow()
	GMController.srcGetASFDCoFunc = FightASFDHelper.getASFDCo
	FightASFDHelper.getASFDCo = GMController.tempGetASFDCo

	self.asfdSequence:registerDoneListener(self.onASFDDone, self)
	self.asfdSequence:start()
end

function GMController.tempGetASFDCo(entityId, unit, default)
	if unit == FightEnum.ASFDUnit.Emitter then
		local emitterId = GMController.instance.emitterId

		return lua_fight_asfd.configDict[emitterId] or default
	elseif unit == FightEnum.ASFDUnit.Missile then
		local missileId = GMController.instance.missileId

		return lua_fight_asfd.configDict[missileId] or default
	elseif unit == FightEnum.ASFDUnit.Explosion then
		local explosionId = GMController.instance.explosionId

		return lua_fight_asfd.configDict[explosionId] or default
	else
		return default
	end
end

function GMController:onASFDDone()
	FightASFDHelper.getASFDCo = GMController.srcGetASFDCoFunc
	self.asfdSequence = nil
end

function GMController:createASFDEmitter(side)
	local entityMo = FightEntityMO.New()

	entityMo:init({
		skin = 0,
		exSkillLevel = 0,
		userId = 0,
		career = 0,
		exSkill = 0,
		status = 0,
		position = 0,
		level = 0,
		teamType = 0,
		guard = 0,
		subCd = 0,
		exPoint = 0,
		shieldValue = 0,
		modelId = 0,
		uid = side == FightEnum.TeamType.MySide and "99998" or "-99998",
		entityType = FightEnum.EntityType.ASFDEmitter,
		side = side,
		attr = {
			defense = 0,
			multiHpNum = 0,
			hp = 0,
			multiHpIdx = 0,
			mdefense = 0,
			technic = 0,
			attack = 0
		},
		buffs = {},
		skillGroup1 = {},
		skillGroup2 = {},
		passiveSkill = {},
		powerInfos = {},
		SummonedList = {}
	})

	entityMo.side = side
	entityMo = FightDataHelper.entityMgr:addEntityMO(entityMo)

	local list = FightDataHelper.entityMgr:getOriginASFDEmitterList(entityMo.side)

	table.insert(list, entityMo)
	FightGameMgr.entityMgr:addASFDUnit()

	return entityMo
end

function GMController:getFightFloatPath()
	return self.fightFloatPath
end

function GMController:setFightFloatPath(path)
	self.fightFloatPath = path
end

function GMController:replaceGetFloatPathFunc()
	if self.replaced then
		return
	end

	self.srcGetFightFloatPathFunc = FightFloatMgr.getFloatPrefab
	FightFloatMgr.getFloatPrefab = GMController.getFightFloatPathFunc
	self.replaced = true
end

function GMController.getFightFloatPathFunc(FightFloatMgrInstance)
	local path = GMController.instance:getFightFloatPath()

	if path then
		return ResUrl.getSceneUIPrefab("fight", path)
	end

	return GMController.instance.srcGetFightFloatPathFunc(FightFloatMgrInstance)
end

function GMController:getHeroMaxLevel(heroId)
	self.cacheHeroMaxLevelDict = self.cacheHeroMaxLevelDict or {}

	local level = self.cacheHeroMaxLevelDict[heroId]

	if level then
		return level
	end

	local heroDict = SkillConfig.instance:getherolevelsCO(heroId)

	if not heroDict then
		return 0
	end

	level = 0

	for _, heroCo in pairs(heroDict) do
		if level < heroCo.level then
			level = heroCo.level
		end
	end

	self.cacheHeroMaxLevelDict[heroId] = level

	return level
end

GMController.instance = GMController.New()

return GMController

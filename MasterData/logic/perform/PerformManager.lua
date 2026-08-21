-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\perform\\PerformManager.lua

local ResHookScript = require("ClientData/ResHookScript")
local PerformActorMgr = require("logic/perform/PerformActorMgr")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResMonster = require("ClientData/ResMonster")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local FrameMgr = require("Debug/Modules/Demo/DemoFrameMgr")
local UserData = require("Helper/UserData")
local Model = require("Entity/Model")
local ModelTool = require("Entity/ModelTool")
local GameSettings = require("Helper/GameSettings")
local CameraManager = Framework.CameraSystem.CameraManager
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local CustomShadowManager = require("System/CustomShadowManager")
local EventConst = require("EventConst")
local LoadUtils = require("Entity/LoadUtils")
local PerformManager = {}
local self = PerformManager

self.SceneConfig = {}

for performId, performInfo in pairs(ResHookScript) do
	local sceneId = performInfo.scene_id

	if sceneId then
		if not self.SceneConfig[sceneId] then
			local newT = {}

			newT.randomIds = {}
			self.SceneConfig[sceneId] = newT
		end

		if performInfo.is_init == 1 then
			self.SceneConfig[sceneId].initId = performId
		elseif performInfo.is_init == 2 then
			-- block empty
		else
			table.insert(self.SceneConfig[sceneId].randomIds, performId)
		end
	end
end

local BEGINNER_PERFORM_ID = 100
local TIMELINE_PATH = "Animators/Timeline/"

self.mActorMgr = PerformActorMgr(self)

function PerformManager.start()
	self.stop()

	self.running = true
	self.preScene = UserData.loadCommonData("HookScriptScene")
	self.preStory = UserData.loadCommonData("HookScriptStory")

	if CurAvatar.mainStageAtkedIdx == 0 then
		self.startOneScript(BEGINNER_PERFORM_ID, true)
	else
		local sceneNo = CurAvatar:getMainStageScene()
		local idConfig = self.SceneConfig[sceneNo]

		if self.preScene ~= tostring(sceneNo) and idConfig and idConfig.initId then
			self.preScene = tostring(sceneNo)

			UserData.saveCommonData("HookScriptScene", self.preScene)
			self.startOneScript(idConfig.initId, true)
		elseif idConfig and #idConfig.randomIds > 0 then
			local r = math.random(1, #idConfig.randomIds)

			self.startOneScript(idConfig.randomIds[r], true)
		end
	end
end

function PerformManager.checkScriptEnable(scriptData)
	if scriptData.start_node and scriptData.battle_node then
		return true
	end

	if scriptData.timeline_node and scriptData.timeline_node[1] and scriptData.timeline_heros then
		local formations = CurAvatar:getNowFormation(Const.FORMATION_MAIN_STAGE)

		for index, heroID in ipairs(scriptData.timeline_heros) do
			for gid, pos in pairs(formations) do
				local hero = CurAvatar.heroDic[gid]

				if hero and hero.id == heroID and self.mActorMgr:actorSkinValid(hero.id, hero.skin, scriptData.timeline_skins) then
					return true
				end
			end
		end

		return false
	end

	if scriptData.camera then
		return true
	end

	if scriptData.story_avg then
		return true
	end

	return false
end

function PerformManager.loadDynamicScene(dynamicPath)
	if self.preDynamicPath and self.preDynamicPath ~= dynamicPath then
		DynamicSceneManager.unload("Scenes/world/Chunk/" .. self.preDynamicPath)

		self.preDynamicPath = nil
	end

	if dynamicPath and self.preDynamicPath ~= dynamicPath then
		DynamicSceneManager.load("Scenes/world/Chunk/" .. dynamicPath)

		self.preDynamicPath = dynamicPath
	end
end

function PerformManager.startOneScript(scriptID, isStart)
	self.stopNowScript()

	local scriptData = ResHookScript[scriptID]

	if not scriptData then
		return
	end

	if self.checkScriptEnable(scriptData) then
		self.hookScriptData = scriptData

		GameSettings.setShadowDistance(self.hookScriptData.shadow_dist or 20, "Changeable")
		self.loadDynamicScene(self.hookScriptData.dynamic_path)

		local hasStartDlg = true

		if scriptID == BEGINNER_PERFORM_ID then
			hasStartDlg = false
		elseif scriptData.is_init == 1 and not scriptData.monsters or scriptData.is_init == 2 then
			hasStartDlg = false
		end

		if hasStartDlg then
			local performStartAniDlg = UIManager.getUI("performStartAniDlg")

			if isStart then
				performStartAniDlg:getController():SetInAnimName("StartMainBattleChangeScene")
			end

			performStartAniDlg:setVisible(true)
		else
			local performStartAniDlg = UIManager.getUI("performStartAniDlg", nil, false)

			if performStartAniDlg then
				performStartAniDlg:setVisible(false)
			end
		end

		self._initActorInfo(scriptData)
	else
		self.checkNextAction(scriptData, isStart)
	end
end

function PerformManager.onAllModelLoaded()
	local ui = UIManager.getUI("performStartAniDlg", nil, false)

	if ui then
		ui:onModelReady(self)
	else
		self.realStartAction()
	end
end

function PerformManager.realStartAction()
	if self.running then
		if self.coStartScript then
			coroutine.stop(self.coStartScript)

			self.coStartScript = nil
		end

		self.coStartScript = coroutine.start(self.startScript, self.hookScriptData)
	end
end

function PerformManager.startScript(scriptData)
	self.cameraEndJump = nil

	CustomShadowManager.setTimelineMode(scriptData.timeline_node ~= nil and scriptData.timeline_node[1])
	PerformManager._refreshShadowOnModelLoaded()

	if scriptData.start_node and scriptData.battle_node then
		self.mActorMgr:actorSetPosition(scriptData.start_node, scriptData.battle_node)
	end

	if scriptData.camera then
		CameraManager.PlayCameraAnimator("Camera/CameraCurvy/StagePerform/" .. scriptData.camera, nil, self.onEnterStageOver, 0, 0, 0)
	end

	if scriptData.is_init == 1 and not scriptData.monsters and self.nextAVGActionId(scriptData) then
		UIManager.getUI("sceneNoticeDlg", true)
	end

	if scriptData.delay_time then
		coroutine.wait(scriptData.delay_time)
	end

	if scriptData.start_node and scriptData.battle_node then
		local runTime = self.mActorMgr:runToBattle(scriptData.start_node, scriptData.battle_node)

		coroutine.wait(runTime)

		self.coStartScript = nil

		self._startBattle()
	elseif scriptData.timeline_node and scriptData.timeline_node[1] then
		local timeline_node = scriptData.timeline_node[self.timeLineChooseIdx or 1]

		coroutine.wait(Framework.Tools.LuaToolkit.PlayGoTimeLine(timeline_node, 0))

		self.coStartScript = nil

		self.onFirstActionOver(self.hookScriptData)
	elseif scriptData.is_init == 1 or scriptData.is_init == 2 then
		if scriptData.camera then
			self.cameraEndJump = true
		else
			self.coStartScript = nil

			self.onFirstActionOver(self.hookScriptData)
		end
	else
		self.coStartScript = nil
	end
end

function PerformManager.onEnterStageOver()
	if self.cameraEndJump then
		self.onFirstActionOver(self.hookScriptData)

		self.cameraEndJump = nil
	end
end

function PerformManager._initActorInfo(scriptData)
	if not scriptData.monsters and (not scriptData.timeline_node or not scriptData.timeline_node[1]) then
		self:onAllModelLoaded()

		return
	end

	local monsters = scriptData.monsters or {}
	local noDieTime = scriptData.no_die_time or {}

	self.mEntityDict = {}

	local objId = 1

	for gid, pos in pairs(CurAvatar:getNowFormation(Const.FORMATION_MAIN_STAGE)) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			local playerInfo = {}

			playerInfo.heroObj = hero
			playerInfo.gid = gid
			playerInfo.heroID = hero.id
			playerInfo.star = hero.star
			playerInfo.level = hero.level
			playerInfo.step = hero.step
			playerInfo.pos = pos
			playerInfo.equips = {}
			playerInfo.camp = BattleConst.CAMP_PLAYER
			playerInfo.entityID = objId
			self.mEntityDict[objId] = playerInfo
			objId = objId + 1
		end
	end

	for pos, monsterID in ipairs(monsters) do
		if ResMonster[monsterID] then
			self.mEntityDict[objId] = utils.getBattleMonsterInfo(monsterID, pos, BattleConst.CAMP_MONSTER, objId)
			self.mEntityDict[objId].noDieTime = noDieTime[pos] or 0
			objId = objId + 1
		end
	end

	self.playTimeline(scriptData)
end

function PerformManager.playTimeline(data)
	local scriptData = data

	if scriptData.timeline_node and scriptData.timeline_node[1] then
		self.timeLineChooseIdx = math.random(1, #scriptData.timeline_node)

		local timeline_node = scriptData.timeline_node[self.timeLineChooseIdx]

		local function loadedCB(timelineNode, go)
			if self.mActorMgr then
				self.mActorMgr:initActors(self.mEntityDict, scriptData)
			end

			self.onTimelineGOLoaded(timelineNode, go)
		end

		if scriptData.is_init == 1 then
			local prefabPath = TIMELINE_PATH .. timeline_node .. ".prefab"

			self.preTimeline = LoadUtils.loadPrefabSync(prefabPath, Functor(self.onTimelineGOLoaded, timeline_node))

			self.onAllModelLoaded()
		else
			local prefabPath = TIMELINE_PATH .. timeline_node .. ".prefab"

			self.preTimeline = LoadUtils.loadPrefabAsync(prefabPath, Functor(loadedCB, timeline_node))
		end
	else
		LoadUtils.UnLoadPrefab(self.preTimeline)

		self.preTimeline = nil

		self.mActorMgr:initActors(self.mEntityDict, scriptData)
	end
end

function PerformManager.onTimelineGOLoaded(timelineNode, go)
	if timelineNode == "Timeline_w_dachangjing" then
		CustomShadowManager.registerPerformGameObject(go, true, 10)
	end
end

local listenerFuncConfig = {
	onMatrixOver = BattleConst.MATRIX_EVENT_BATTLE_OVER
}

function PerformManager._startBattle()
	local input = {}

	input.randomSeed = 100
	input.manualOpera = false
	input.entityDict = self.mEntityDict
	input.LR_LEN = 6
	input.UD_LEN = 3
	input.GRID_SIZE = 2.35
	input.battleConfig = ResBattleConfig[1] or {}
	input.speData = {}
	input.BATTLE_SPEC = 1

	EventCenter.addEventListenerGroup(self, listenerFuncConfig)

	self.mMatrixInstance = TheMatrixClass(input, false)

	self.mActorMgr:startBattle(self.mMatrixInstance)

	self.frameMgr = FrameMgr(self.mMatrixInstance)

	self.frameMgr:start()
end

function PerformManager:onMatrixOver(loseCamp, speResultType)
	self.coStartScript = coroutine.start(self.startBattleOver)
end

function PerformManager.startBattleOver()
	if self.hookScriptData and self.hookScriptData.end_node then
		self.mActorMgr:onBattleOver()
		coroutine.wait(1)
		self.mActorMgr:runToEnd(self.hookScriptData.end_node)
		self.mActorMgr:onDeadEffect()
		coroutine.wait(0.25)
		self.mActorMgr:onDeadHide()
		coroutine.wait(1.3)
		self.mActorMgr:onMoneyEffect()
		coroutine.wait(2.5)
		self.onFirstActionOver(self.hookScriptData)
	end
end

function PerformManager.onFirstActionOver(hookScriptData, isStart)
	if hookScriptData.story_avg then
		UIManager.playAVG(hookScriptData.story_avg, nil, Slot(PerformManager.checkNextAction, hookScriptData))
	else
		PerformManager.checkNextAction(hookScriptData)
	end
end

function PerformManager.checkNextAction(hookScriptData, isStart)
	UIManager.tryHideUI("sceneNoticeDlg")

	local nextScript = hookScriptData.next_script
	local nextId = self.nextAVGActionId(hookScriptData)

	if nextId then
		self.preStory = tostring(nextId)

		UserData.saveCommonData("HookScriptStory", self.preStory)

		nextScript = nextId
	end

	if nextScript then
		self.startOneScript(nextScript, isStart)
	end
end

function PerformManager.nextAVGActionId(hookScriptData)
	if hookScriptData.id == BEGINNER_PERFORM_ID then
		return true
	end

	if hookScriptData.is_init == 1 then
		local nextStory = CurAvatar:getBattleChapterStory()

		if nextStory and hookScriptData.id ~= nextStory and self.preStory ~= tostring(nextStory) then
			return nextStory
		end
	end
end

function PerformManager.stopNowScript()
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)

	if self.coStartScript then
		coroutine.stop(self.coStartScript)

		self.coStartScript = nil
	end

	self.hookScriptData = nil

	if self.mMatrixInstance then
		self.mMatrixInstance:destroy()

		self.mMatrixInstance = nil
	end

	if self.frameMgr then
		self.frameMgr:destroy()

		self.frameMgr = nil
	end

	if self.preTimeline then
		LoadUtils.UnLoadPrefab(self.preTimeline)

		self.preTimeline = nil
	end

	self.mActorMgr:stopBattle()
end

function PerformManager.stop()
	self.running = false

	self.stopNowScript()
	self.loadDynamicScene()
	self.mActorMgr:clear()
	UIManager.tryHideUI("sceneNoticeDlg")

	local ui = UIManager.getUI("performStartAniDlg", nil, false)

	if ui then
		ui:setVisible(false)
	end

	CameraManager.PauseCameraAnimator(1)
	GameSettings.resetShadowDistance("Changeable")
end

function PerformManager.pause()
	self.mActorMgr:setActorsMute(true)
	CueManager.setMuteAudios(UIMiscConfig.PERFORM_MUTE_AUDIOS, true)
end

function PerformManager.resume()
	self.mActorMgr:setActorsMute(false)
	CueManager.setMuteAudios(UIMiscConfig.PERFORM_MUTE_AUDIOS, false)
end

function PerformManager._refreshShadowOnModelLoaded()
	if CustomShadowManager.isInState(CustomShadowManager.SHADOW_STATE_ID.PERFORM) then
		self.setCustomShadowActive(true)
	end
end

function PerformManager.setCustomShadowActive(active, registerEvent)
	if registerEvent == nil then
		registerEvent = true
	end

	local actors = self.mActorMgr:getAllActor()

	CustomShadowManager.setPerformShadowActive(active, actors)

	if registerEvent then
		if active then
			EventCenter.addEventListener(EventConst.REFRESH_SHADOW, PerformManager._onRefreshShadow)
		else
			EventCenter.removeEventListener(EventConst.REFRESH_SHADOW, PerformManager._onRefreshShadow)
		end
	end
end

function PerformManager._onRefreshShadow()
	PerformManager.setCustomShadowActive(true, false)
end

return PerformManager

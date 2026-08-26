-- chunkname: @modules/logic/scene/GameSceneMgr.lua

module("modules.logic.scene.GameSceneMgr", package.seeall)

local GameSceneMgr = class("GameSceneMgr")

function GameSceneMgr:ctor()
	self._curSceneType = nil
	self._curSceneId = nil
	self._preSceneType = nil
	self._preSceneId = nil
	self._preLevelId = nil
	self._nextSceneType = nil
	self._allScenes = {}
	self._allRootGo = nil
	self._isStarting = false
	self._isClosing = false
	self._startArgs = {}

	LuaEventSystem.addEventMechanism(self)
end

function GameSceneMgr:init()
	self._allRootGo = CameraMgr.instance:getSceneRoot()

	self:_addScenes()
end

function GameSceneMgr:_addScenes()
	self:_addSceneObj(SceneType.Main, MainScene)
	self:_addSceneObj(SceneType.Fight, FightScene)
	self:_addSceneObj(SceneType.Newbie, NewbieScene)
	self:_addSceneObj(SceneType.Room, RoomScene)
	self:_addSceneObj(SceneType.Explore, ExploreScene)
	self:_addSceneObj(SceneType.PushBox, PushBoxScene)
	self:_addSceneObj(SceneType.Cachot, CachotScene)
	self:_addSceneObj(SceneType.Rouge, RougeScene)
	self:_addSceneObj(SceneType.Rouge2, Rouge2_Scene)
	self:_addSceneObj(SceneType.Survival, SurvivalScene)
	self:_addSceneObj(SceneType.SurvivalShelter, SurvivalShelterScene)
	self:_addSceneObj(SceneType.SurvivalSummaryAct, SurvivalSummaryAct)
	self:_addSceneObj(SceneType.SurvivalCollectionRoom, SurvivalCollectionRoomScene)
	self:_addSceneObj(SceneType.Udimo, UdimoScene)
	self:_addSceneObj(SceneType.PartyGame, PartyGameScene)
	self:_addSceneObj(SceneType.PartyGameLobby, PartyGameLobbyScene)
	self:_addSceneObj(SceneType.RacingCar, V3a9RacingCarScene)
	self:_addSceneObj(SceneType.ChatRoom, ChatRoomScene)
end

function GameSceneMgr:_addSceneObj(sceneType, sceneDefine)
	local rootGo = gohelper.findChild(self._allRootGo, sceneDefine.__cname)

	rootGo = rootGo or gohelper.create3d(self._allRootGo, sceneDefine.__cname)

	local sceneObj = sceneDefine.New(rootGo)

	sceneObj:setOnPreparedCb(self.onScenePrepared, self)
	sceneObj:setOnPreparedOneCb(self.onScenePreparedOne, self)

	self._allScenes[sceneType] = sceneObj
end

function GameSceneMgr:getScene(sceneType)
	return self._allScenes[sceneType]
end

function GameSceneMgr:getCurSceneType()
	return self._curSceneType
end

function GameSceneMgr:getCurSceneId()
	return self._curSceneId
end

function GameSceneMgr:getCurLevelId()
	local curScene = self:getCurScene()

	if curScene then
		return curScene:getCurLevelId()
	end
end

function GameSceneMgr:getPreSceneType()
	return self._preSceneType
end

function GameSceneMgr:getPreSceneId()
	return self._preSceneId
end

function GameSceneMgr:getPreLevelId()
	return self._preLevelId
end

function GameSceneMgr:setPrevScene(sceneType, sceneId, levelId)
	self._preSceneType = sceneType
	self._preSceneId = sceneId
	self._preLevelId = levelId
end

function GameSceneMgr:getCurScene()
	return (self._curSceneType or nil) and (self._allScenes[self._curSceneType] or nil)
end

function GameSceneMgr:onScenePrepared()
	self._isStarting = false

	self:hideLoading()
	self:_runNextArgs()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, self)
	GameSceneMgr.instance:dispatchEvent(self._curSceneType, self._curSceneId, 1)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.EnterSceneFinish, self._curSceneType, self._curSceneId)
end

function GameSceneMgr:onScenePreparedOne()
	return
end

function GameSceneMgr:_runNextArgs()
	if #self._startArgs > 0 then
		local arg = self._startArgs[1]

		table.remove(self._startArgs, 1)
		self:startScene(arg[1], arg[2], arg[3])
	end
end

function GameSceneMgr:startSceneDefaultLevel(sceneType, sceneId, forceStarting, forceSceneType)
	local levelCOs = SceneConfig.instance:getSceneLevelCOs(sceneId)

	if levelCOs then
		self:startScene(sceneType, sceneId, levelCOs[1].id, forceStarting, forceSceneType)
	else
		logError("scene config not exist, sceneId = " .. sceneId)
	end
end

function GameSceneMgr:startScene(sceneType, sceneId, levelId, forceStarting, forceSceneType)
	if self:useDefaultScene() and sceneType == SceneType.Fight then
		sceneId = 13101
		levelId = 13101
	end

	if not forceStarting and self._isStarting then
		local args = {
			sceneType,
			sceneId,
			levelId
		}

		table.insert(self._startArgs, args)

		return
	end

	if not forceSceneType and self._curSceneType == sceneType and self._curSceneId == sceneId then
		self:_runNextArgs()

		return
	end

	self._nextSceneType = sceneType

	self:showLoading(sceneType)
	self:closeScene(sceneType, sceneId, levelId)

	if sceneType == SceneType.Main or sceneType == SceneType.Room or sceneType == SceneType.Explore or sceneType == SceneType.SurvivalShelter or sceneType == SceneType.SurvivalSummaryAct or sceneType == SceneType.SurvivalCollectionRoom or sceneType == SceneType.Survival or sceneType == SceneType.PartyGameLobby or sceneType == SceneType.Cachot then
		TaskDispatcher.runDelay(self._onDelayStartScene, self, 1.467)
	else
		self._isStarting = true
		self._curSceneType = sceneType
		self._curSceneId = sceneId
		self._curSceneLevel = levelId

		TaskDispatcher.runDelay(self._onOtherDelayStartScene, self, 0.1)
	end
end

function GameSceneMgr:_onOtherDelayStartScene()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, self)
	self:getCurScene():onStart(self._curSceneId, self._curSceneLevel)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.EnterScene, self._curSceneType, self._curSceneId)

	local typeName = SceneType.NameDict[self._curSceneType]

	logNormal(string.format("start scene: %s %d level_%d", typeName, self._curSceneId, self._curSceneLevel))
end

function GameSceneMgr:_onDelayStartScene()
	self._isStarting = true

	if self._nextSceneType then
		self._curSceneType = self._nextSceneType or self._curSceneType
	end

	self._nextSceneType = nil

	if self._nextSceneId then
		self._curSceneId = self._nextSceneId or self._curSceneId
	end

	self._nextSceneId = nil

	if self._nextLevelId then
		self._curSceneLevel = self._nextLevelId or self._curSceneLevel
	end

	self._nextLevelId = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, self)
	self:getCurScene():onStart(self._curSceneId, self._curSceneLevel)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.EnterScene, self._curSceneType, self._curSceneId)

	local typeName = SceneType.NameDict[self._curSceneType]

	logNormal(string.format("start scene: %s %d level_%d", typeName, self._curSceneId, self._curSceneLevel))
end

function GameSceneMgr:closeScene(nextSceneType, nextSceneId, nextLevelId, immediate)
	TaskDispatcher.cancelTask(self._onDelayStartScene, self)
	TaskDispatcher.cancelTask(self._onOtherDelayStartScene, self)

	self._nextSceneType = nextSceneType
	self._nextSceneId = nextSceneId
	self._nextLevelId = nextLevelId

	if not self._curSceneType or not self._curSceneId then
		return
	end

	self._isClosing = true
	self._preSceneType = self._curSceneType
	self._preSceneId = self._curSceneId
	self._preLevelId = self:getCurLevelId()

	if immediate then
		TaskDispatcher.cancelTask(self._delayCloseScene, self)
		self:_delayCloseScene()
	elseif self._nextSceneType == SceneType.Main or self._nextSceneType == SceneType.Room or self._nextSceneType == SceneType.Explore or self._nextSceneType == SceneType.Cachot then
		TaskDispatcher.runDelay(self._delayCloseScene, self, 0.5)
	else
		TaskDispatcher.cancelTask(self._delayCloseScene, self)
		self:_delayCloseScene()
	end
end

function GameSceneMgr:_delayCloseScene()
	local curScene = self:getCurScene()

	curScene:onClose()
	GameSceneMgr.instance:dispatchEvent(self._curSceneType, self._curSceneId, 0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.ExitScene, self._curSceneType, self._curSceneId, self._nextSceneType)

	local typeName = SceneType.NameDict[self._preSceneType]

	if not self._preSceneId then
		if not self._preLevelId then
			local levelId = -1

			logNormal(string.format("close scene: %s %d level_%d", typeName, self._preSceneId, levelId))

			self._curSceneType = nil
			self._curSceneId = nil
			self._isStarting = false
			self._isClosing = false
		end
	end
end

function GameSceneMgr:showLoading(sceneType)
	if not self._allScenes[sceneType] then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, sceneType)
end

function GameSceneMgr:hideLoading()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function GameSceneMgr:isLoading()
	return self._isStarting
end

function GameSceneMgr:isClosing()
	return self._isClosing
end

function GameSceneMgr:isSpScene()
	if FightGameMgr.sceneLevelMgr then
		if FightGameMgr.sceneLevelMgr and FightGameMgr.sceneLevelMgr == 11501 then
			return true
		end
	end
end

function GameSceneMgr:isFightScene()
	return self:getCurSceneType() == SceneType.Fight
end

function GameSceneMgr:isPushBoxScene()
	return self:getCurSceneType() == SceneType.PushBox
end

function GameSceneMgr:getNextSceneType()
	return self._nextSceneType
end

function GameSceneMgr:useDefaultScene()
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

GameSceneMgr.instance = GameSceneMgr.New()

return GameSceneMgr

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/AnswerScene.lua

module("logicscene.scene.impl.AnswerScene", package.seeall)

local AnswerScene = class("AnswerScene", CityScene)
local initPos = {
	default = {
		13,
		8.5
	},
	wanshengjie = {
		9.2,
		5.8
	}
}

function AnswerScene:_initComponents()
	self:_addComponent("unitFactory", CityUnitFactory)
	self:_addComponent("camera", CitySceneCameraEx)
	self:_addComponent("stage", AnswerSceneStage)
	self:_addComponent("pathFinder", ScenePathFinderEx)
	self:_addComponent("joystick", SceneJoystickListenerEx)
	self:_addComponent("picker", ScenePickerEx)
	self:_addComponent("otherPlayers", SceneOtherPlayers)
	self:_addComponent("monsterMgr", SceneMonsterMgr)
	self:_addComponent("bgm", SceneBgmMgr)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("npcUnlock", SceneCompNpcsUnlock)
	self:_addComponent("sceneTriggers", SceneCompAnswerSceneTrigger)
end

function AnswerScene:_getCurrFestival()
	local festival = self:getFestival()

	if string.nilorempty(festival) then
		festival = "default"
	end

	return festival
end

function AnswerScene:onEnter(sceneId, bornX, bornZ)
	NewChatController.instance:setShowChannel(GameEnum.ChatChannel.Nearby)

	local festival = self:_getCurrFestival()

	TilingSceneMgr.instance:enterAnswerScene(sceneId, festival)

	local initPosP = initPos[festival]

	AnswerScene.super.onEnter(self, sceneId, initPosP[1], initPosP[2])
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenStart, self._onViewOpenStart, self)
	GlobalDispatcher:addListener(GlobalNotify.OnStartNewQuestion, self._onStartNewQuestion, self)
	GlobalDispatcher:addListener(GlobalNotify.OnEndCurrQuestion, self._onEndCurrQuestion, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerAskForHelp, self._onAnswerAskForHelp, self)
end

function AnswerScene:isNeedMergePath()
	return false
end

function AnswerScene:isBreakPathFindingWhileHitAirwall()
	return true
end

function AnswerScene:onEnterFinished()
	AnswerScene.super.onEnterFinished(self)

	if not AnswerSceneModel.instance:isDoingQuestion() then
		self:_onEndCurrQuestion()
	end

	local festival = self:_getCurrFestival()

	self.camera._follower.enabled = festival == "default"

	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local initPosP = initPos[festival]
	local mainCamera = mainCameraTarget:getCamera()
	local posx, posy, posz = Framework.TransformUtil.GetPos(mainCamera.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(mainCamera.transform, initPosP[1], initPosP[2], posz)
end

function AnswerScene:update(deltaTime)
	AnswerScene.super.update(self, deltaTime)
	self.sceneTriggers:update()
end

function AnswerScene:createMainPlayerPet()
	return
end

function AnswerScene:createUnitPet(unit, itemId, avatarPetData, petName)
	return
end

function AnswerScene:getDefaultView()
	return ViewName.AnswerScene
end

function AnswerScene:onExitFinished()
	local sceneId = self:getSceneId()

	AnswerScene.super.onExitFinished(self)
	AnswerSceneController.instance:onReset()
	AnswerSceneModel.instance:onReset()
	TilingSceneMgr.instance:clearTilingSceneConfig(sceneId)
end

function AnswerScene:onExit()
	NewChatController.instance:setShowChannel(nil)

	if self._pausePlayer then
		self._pausePlayer = nil

		TaskController.instance:resume()
	end

	TaskController.instance:foreceClearState()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpenStart, self._onViewOpenStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnStartNewQuestion, self._onStartNewQuestion, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnEndCurrQuestion, self._onEndCurrQuestion, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerAskForHelp, self._onAnswerAskForHelp, self)
	AnswerScene.super.onExit(self)
end

function AnswerScene:_onStartNewQuestion()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		local festival = self:_getCurrFestival()
		local initPosP = initPos[festival]

		mainPlayer.transform:setPos(initPosP[1], initPosP[2], nil, true)
	end

	if self._pausePlayer then
		self._pausePlayer = nil

		TaskController.instance:resume()
	end

	self.sceneTriggers:onStartNewQuestion()
end

function AnswerScene:_onEndCurrQuestion()
	if not self._pausePlayer then
		self._pausePlayer = true

		TaskController.instance:pause()
		SceneMainPlayer.instance:forceMainPlayerIdle()
	end
end

function AnswerScene:_onTriggerEnter(sceneId, triggerId, enter)
	AnswerScene.super._onTriggerEnter(self, sceneId, triggerId, enter)
	self.sceneTriggers:onTriggerEnter(triggerId, enter)
end

function AnswerScene:_onAnswerAskForHelp(type)
	if type == AnswerSceneMO.HelpType_ExceptError then
		self.sceneTriggers:onAnswerAskForHelp(AnswerSceneModel.instance:getQuestionAnswerErrShowIndex())
	end
end

function AnswerScene:_onElementCreate(elementId, path, quality, pos)
	AnswerScene.super._onElementCreate(self, elementId, path, quality, pos)
	self.sceneTriggers:onElementCreate(elementId, pos)
end

function AnswerScene:_onElementDestroy(elementId, path, quality)
	AnswerScene.super._onElementDestroy(self, elementId, path, quality)
end

function AnswerScene:_onViewOpenStart(view)
	if view.viewName ~= ViewName.chat and view.viewName ~= ViewName.ChatEmoji and view.viewName ~= ViewName.playerInfo and ViewMgr.instance:isOpen(ViewName.chat) then
		ViewMgr.instance:close(ViewName.chat)
	end
end

return AnswerScene

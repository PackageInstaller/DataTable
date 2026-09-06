-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/controller/ColorfulEggsController.lua

module("logic.extensions.colorfuleggs.controller.ColorfulEggsController", package.seeall)

local ColorfulEggsController = class("ColorfulEggsController", BaseController)

function ColorfulEggsController:onInit()
	ColorfulEggsController.super.onInit(self)
	self.registerNotify(self, GlobalNotify.EnterSceneTrigger, self._onEnterSceneTrigger, self)
	self.registerNotify(self, GlobalNotify.LeaveSceneTrigger, self._onLeaveSceneTrigger, self)
	self.registerNotify(self, GlobalNotify.OnMofangLvUp, self._checkEggsTrigger, self)
	self.registerNotify(self, GlobalNotify.PlayerStrengthChange, self._checkEggsTrigger, self)
	self.registerNotify(self, GlobalNotify.TaskDataUpdate, self._checkEggsTrigger, self)
	self.registerNotify(self, GlobalNotify.EndStory, self._onStoryEnded, self)
end

function ColorfulEggsController:onReset()
	self._playingAnimEgg = nil
	self._trigger_eggsList = nil
	self._isTaskDataReady = nil
end

function ColorfulEggsController:onTaskListRespond()
	self._isTaskDataReady = true

	ColorfulEggsModel.instance:onTaskListRespond()
	self:_ensureTaskNpcAndTriggerCreated()
end

function ColorfulEggsController:_ensureTaskNpcAndTriggerCreated()
	if self._currCityScene and self._currCityScene.isReady then
		self:onSceneLoadedFinish(self._currCityScene:getSceneType(), self._currCityScene:getSceneId())
	else
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.isReady then
			self:onSceneLoadedFinish(scene:getSceneType(), scene:getSceneId())
		end
	end
end

function ColorfulEggsController:onSceneLoadedFinish(sceneType, sceneId)
	if sceneType ~= SceneType.City or not ColorfulEggsModel.instance.isReady then
		self._currCityScene = nil

		return
	else
		self._currCityScene = SceneMgr.instance:getCurScene()
	end

	ColorfulEggsModel.instance:onTaskListRespond()
	self:_handleEggsNpcsOnScene(sceneId)
	self:_handleEggsElementsOnScene(sceneId)
	self:_handleSceneTriggerOnScneLoaded(sceneId)
end

function ColorfulEggsController:onSelectNpc(npcId)
	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if v.eggCo.npcId and #v.eggCo.npcId > 0 and v.eggCo.npcId[1] == npcId then
			v:onSelectNpc()

			return
		end
	end
end

function ColorfulEggsController:onSelectElement(elementId)
	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if v.eggCo.element and #v.eggCo.element > 0 and v.eggCo.element[2] == elementId then
			v:onSelectElement()

			return
		end
	end
end

function ColorfulEggsController:playAnimation(egg)
	self:stopPlayingAnimEgg()

	if not string.find(egg.eggCo.scene_animation, "txt") then
		egg.eggCo.scene_animation = egg.eggCo.scene_animation .. ".txt"
	end

	local animationTarget = self:_getEggAnimationTarget(egg)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	egg.animPlayGo = egg.animPlayGo or UnityEngine.GameObject.New("animPlayGo")
	self._playingAnimEgg = egg

	return (AnimationPlayer.playWithGameObject(egg.animPlayGo, "storyconfig/animations/" .. egg.eggCo.scene_animation, egg._onAnimPlayFinish, egg._onAnimPlayStart, egg, 1, true, true, {
		mainPlayer.go,
		animationTarget
	}))
end

function ColorfulEggsController:playNpcEndEffect(egg)
	self:stopPlayingAnimEgg()

	if egg.unitNpc == nil then
		egg:_onAnimPlayFinish()

		return
	end

	local json = require("cjson")
	local effects = json.decode(egg.eggCo.endEffect)

	if effects then
		if not effects[1] then
			local info

			if info == nil or string.nilorempty(info.effPath) then
				egg:_onAnimPlayFinish()

				return
			end

			local strPos = string.nilorempty(info.effLocalPos) and "0,0,0" or info.effLocalPos
			local effLocalPos = string.split(strPos, ",")
			local effScale = checknumber(info.effScale) == 0 and 1 or tonumber(info.effScale)
			local hagPoint = egg.unitNpc:getMountPoint(info.mountPoint or 0)
			local effGo = GameEffectManager.instance:playEffect(info.effPath, false, nil, checknumber(effLocalPos[1]), checknumber(effLocalPos[2]), checknumber(effLocalPos[3]), egg._onAnimPlayFinish, egg._onAnimPlayStart, egg)

			effGo:setParent(hagPoint.transform)
			effGo:setScale(effScale)
			effGo:setLocalPos(checknumber(effLocalPos[1]), checknumber(effLocalPos[2]), checknumber(effLocalPos[3]))
			effGo:setLayer(egg.unitNpc:getLayer())

			self._playingAnimEgg = egg

			return effGo
		end
	end
end

function ColorfulEggsController:stopPlayingAnimEgg()
	if self._playingAnimEgg then
		if self._playingAnimEgg._npcEffect then
			self._playingAnimEgg:_onAnimPlayFinish()
		else
			self._playingAnimEgg:stopAnimation()
		end

		self._playingAnimEgg = nil
	end
end

function ColorfulEggsController:_getEggAnimationTarget(egg)
	local targetNpcId = checknumber(egg:getAnimationTargetNpc())
	local targetNpcGo

	if targetNpcId ~= 0 then
		local scene = SceneMgr.instance:getCurScene()
		local targetNpc = scene.unitFactory:getUnit(UnitTag.Npc, targetNpcId)

		if targetNpc then
			targetNpcGo = targetNpc.go
		end
	end

	if targetNpcGo then
		return targetNpcGo
	end

	if not egg.eggCo.trigger or not egg.eggCo.trigger[1] or not egg.eggCo.trigger[2] then
		return
	end

	local scene = SceneMgr.instance:getCurScene()
	local hasTrans, destX, destY = scene:getTriggerPos(egg.eggCo.trigger[2], nil, nil)

	if not hasTrans then
		return nil
	end

	egg.tempTargetGo = egg.tempTargetGo or UnityEngine.GameObject.New("eggTarget")

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local posx, post, posz = Framework.TransformUtil.GetPos(mainPlayer.go.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(egg.tempTargetGo.transform, destX, destY, posz)

	return egg.tempTargetGo
end

function ColorfulEggsController:clearAnimation()
	self._playingAnimEgg = nil
end

function ColorfulEggsController:triggerEgg(egg)
	ColorfulEggsModel.instance:triggerEgg(egg)
	self:_checkCreateEggNpc(egg)
	self:_checkCreateEggSceneTrigger(egg)
	self:_checkCreateEggElement(egg)
	GlobalDispatcher:dispatch(GlobalNotify.ColorfulEggTriggered, egg)
end

function ColorfulEggsController:startEgg(egg)
	egg:startColorfulEgg()
	self:_checkRemoveEggElement(egg)
end

function ColorfulEggsController:finishEgg(egg)
	ColorfulEggsModel.instance:finishEgg(egg)

	if not string.nilorempty(egg.eggCo.idle_strategy) then
		GlobalDispatcher:dispatch(GlobalNotify.ColorfulEggTriggered, egg)
	end

	if egg.eggCo.isKeep ~= 1 or not ColorfulEggsConst.shouldTriggered(egg.eggCo) then
		self:_checkRemoveEggNpc(egg)
	end

	self:_checkRemoveEggSceneTrigger(egg)
	self:_checkRemoveEggElement(egg)
	GlobalDispatcher:dispatch(GlobalNotify.ColorfulEggsData, egg:getEggId())
end

function ColorfulEggsController:closeEgg(egg)
	ColorfulEggsModel.instance:closeEgg(egg)
	self:_checkRemoveEggNpc(egg)
	self:_checkRemoveEggSceneTrigger(egg)
	self:_checkRemoveEggElement(egg)
end

function ColorfulEggsController:clearAllTriggeredEggs()
	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		self:closeEgg(v)
		v:triggerColorfulEgg()
	end
end

function ColorfulEggsController:checkTaskTriggered(taskId)
	local depencies = ColorfulEggConfig.instance:getTaskDepencies(taskId)

	if not depencies then
		return true
	end

	for i = 1, #depencies do
		if not ColorfulEggsModel.instance:isEggFinished(depencies[i]) then
			return false
		end
	end

	return true
end

function ColorfulEggsController:updateEggs(deltaTime)
	if not self._isTaskDataReady then
		return
	end

	if not self._trigger_eggsList then
		self._trigger_eggsList = {}

		local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

		for k, v in pairs(eggs) do
			table.insert(self._trigger_eggsList, v)
		end

		eggs = ColorfulEggsModel.instance:getUnavailableEggs()

		for k, v in pairs(eggs) do
			table.insert(self._trigger_eggsList, v)
		end

		self._trigger_tickIndex = 1
	end

	local startIdx = self._trigger_tickIndex
	local destIndex = startIdx + 50

	self._trigger_tickIndex = self._trigger_tickIndex + 51

	for i = startIdx, destIndex do
		local egg = self._trigger_eggsList[i]

		if not egg then
			self._trigger_tickIndex = 1

			break
		end

		egg:update(deltaTime)

		if egg:getState() == ColorfulEggsConst.States.UnTriggered and egg:shouldTriggered() then
			self:triggerEgg(egg)
		end
	end
end

function ColorfulEggsController:_handleEggsNpcsOnScene(sceneId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		self:_checkCreateEggNpc(v)
	end

	local eggs1 = ColorfulEggsModel.instance:getFinishEggs()

	for k, v in pairs(eggs1) do
		if v.eggCo.isKeep == 1 and ColorfulEggsConst.shouldTriggered(v.eggCo) then
			self:_checkCreateEggNpc(v)
		end
	end
end

function ColorfulEggsController:_checkCreateEggNpc(egg)
	if not self._currCityScene then
		return
	end

	if egg.eggCo.npcId and #egg.eggCo.npcId > 0 then
		local sceneId = self._currCityScene:getSceneId()
		local npcId = egg.eggCo.npcId[1]
		local npcCo = SceneConfig.instance:getNpcCo(npcId)

		if npcCo and npcCo.sceneId == sceneId and npcCo.funcType == UnitConst.NPC_TASK_TRIGGERD then
			egg.unitNpc = self._currCityScene.unitFactory:createNpcById(npcId)
		end
	end
end

function ColorfulEggsController:_checkRemoveEggNpc(egg)
	if not self._currCityScene then
		return
	end

	local state = egg:getState()

	if (state == ColorfulEggsConst.States.Finished or state == ColorfulEggsConst.States.UnTriggered) and egg.eggCo.npcId and #egg.eggCo.npcId > 0 then
		local sceneId = self._currCityScene:getSceneId()
		local npcId = egg.eggCo.npcId[1]
		local npcCo = SceneConfig.instance:getNpcCo(npcId)

		if npcCo and npcCo.sceneId == sceneId and npcCo.funcType == UnitConst.NPC_TASK_TRIGGERD then
			self._currCityScene.unitFactory:destroyNpcById(npcId)

			egg.unitNpc = nil
		end
	end
end

function ColorfulEggsController:_handleSceneTriggerOnScneLoaded(sceneId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		self:_checkCreateEggSceneTrigger(v)
	end
end

function ColorfulEggsController:_checkCreateEggSceneTrigger(egg)
	if not self._currCityScene then
		return
	end

	if egg.eggCo.trigger and #egg.eggCo.trigger > 0 then
		local sceneId = self._currCityScene:getSceneId()
		local tSceneId, tTriggerId = egg.eggCo.trigger[1], egg.eggCo.trigger[2]

		if tSceneId and tSceneId == sceneId and tTriggerId and tTriggerId ~= 0 then
			TriggersMgr.instance:createTrigger(tSceneId, tTriggerId)
		end
	end
end

function ColorfulEggsController:_checkRemoveEggSceneTrigger(egg)
	if not self._currCityScene then
		return
	end

	local state = egg:getState()

	if (state == ColorfulEggsConst.States.Finished or state == ColorfulEggsConst.States.UnTriggered) and egg.eggCo.trigger and #egg.eggCo.trigger > 0 then
		local tSceneId, tTriggerId = egg.eggCo.trigger[1], egg.eggCo.trigger[2]

		if tSceneId and tTriggerId then
			TriggersMgr.instance:removeTrigger(tSceneId, tTriggerId)
		end
	end
end

function ColorfulEggsController:_handleEggsElementsOnScene(sceneId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		self:_checkCreateEggElement(v)
	end
end

function ColorfulEggsController:_checkCreateEggElement(egg)
	if not self._currCityScene then
		return
	end

	local state = egg:getState()

	if state == ColorfulEggsConst.States.Triggered and egg.eggCo.element and #egg.eggCo.element > 0 then
		local sceneId = self._currCityScene:getSceneId()
		local tSceneId, tElemId = egg.eggCo.element[1], egg.eggCo.element[2]

		if tSceneId and tSceneId == sceneId then
			SceneElemsMgr.instance:createElem(tSceneId, tElemId, SceneLayer.InteractiveObject_Value)
		end
	end
end

function ColorfulEggsController:_checkRemoveEggElement(egg)
	if not self._currCityScene then
		return
	end

	local state = egg:getState()

	if state ~= ColorfulEggsConst.States.Triggered and egg.eggCo.element and #egg.eggCo.element > 0 then
		local tSceneId, tElemId = egg.eggCo.element[1], egg.eggCo.element[2]

		if tSceneId and tElemId then
			SceneElemsMgr.instance:removeElem(tSceneId, tElemId)
		end
	end
end

function ColorfulEggsController:_isSceneValid(sceneId)
	if not self._currCityScene then
		return
	end

	if not self._currCityScene.isReady then
		return
	end

	if self._currCityScene:getSceneType() ~= SceneType.City then
		return
	end

	if sceneId then
		return self._currCityScene:getSceneId() == sceneId
	end

	return true
end

function ColorfulEggsController:_onEnterSceneTrigger(sceneId, triggerId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if v.eggCo.trigger and #v.eggCo.trigger > 0 then
			local tSceneId, tTriggerId = v.eggCo.trigger[1], v.eggCo.trigger[2]

			if tSceneId == sceneId and tTriggerId == triggerId then
				v:onEnterTrigger()

				return
			end
		end
	end
end

function ColorfulEggsController:_onLeaveSceneTrigger(sceneId, triggerId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if v.eggCo.trigger and #v.eggCo.trigger > 0 then
			local tSceneId, tTriggerId = v.eggCo.trigger[1], v.eggCo.trigger[2]

			if tSceneId == sceneId and tTriggerId == triggerId then
				v:onLeaveTrigger()

				return
			end
		end
	end
end

function ColorfulEggsController:_checkEggsTrigger()
	return
end

function ColorfulEggsController:_checkEggsFinished()
	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if ColorfulEggsConst.isEggFinished(v.eggCo) then
			self:finishEgg(v)
		end
	end
end

function ColorfulEggsController:_onStoryEnded(storyId)
	local eggs = ColorfulEggsModel.instance:getTriggeredEggs()

	for k, v in pairs(eggs) do
		if v:getState() == ColorfulEggsConst.States.Running and v.eggCo.storyId == storyId then
			self:finishEgg(v)

			break
		end
	end
end

ColorfulEggsController.instance = ColorfulEggsController.New()

return ColorfulEggsController

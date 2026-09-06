-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/TriggersMgr.lua

module("logicscene.scene.TriggersMgr", package.seeall)

local TriggersMgr = class("TriggersMgr")

function TriggersMgr:ctor()
	self._triggers = {}
end

function TriggersMgr:createTrigger(sceneId, triggerId)
	if self:isTriggerExist(sceneId, triggerId) then
		return
	end

	self._triggers[sceneId] = self._triggers[sceneId] or {}

	local triggers = self._triggers[sceneId]

	triggers[triggerId] = true

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		scene:createTrigger(triggerId)
	end
end

function TriggersMgr:removeTrigger(sceneId, triggerId)
	if not self:isTriggerExist(sceneId, triggerId) then
		return
	end

	local triggers = self._triggers[sceneId]

	if triggers then
		triggers[triggerId] = nil
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		scene:removeTrigger(triggerId)
	end
end

function TriggersMgr:onEnterSceneFinished(sceneId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		local triggers = self._triggers[sceneId]

		if triggers then
			for k, v in pairs(triggers) do
				scene:createTrigger(k)
			end
		end
	end
end

function TriggersMgr:clear()
	self._triggers = {}
end

function TriggersMgr:isTriggerExist(sceneId, triggerId)
	local triggers = self._triggers[sceneId]

	if triggers then
		return triggers[triggerId]
	end
end

TriggersMgr.instance = TriggersMgr.New()

return TriggersMgr

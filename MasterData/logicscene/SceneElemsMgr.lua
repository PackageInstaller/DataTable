-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneElemsMgr.lua

module("logicscene.scene.SceneElemsMgr", package.seeall)

local SceneElemsMgr = class("SceneElemsMgr")

function SceneElemsMgr:ctor()
	self._elements = {}
end

function SceneElemsMgr:createElem(sceneId, elemId, layer)
	if self:isElemExist(sceneId, elemId) then
		return
	end

	layer = layer or -1

	if layer == 0 then
		layer = -1
	end

	self._elements[sceneId] = self._elements[sceneId] or {}

	local elems = self._elements[sceneId]

	elems[elemId] = layer

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId and scene.stage.wholeScene and scene.stage.wholeScene:GetElementCreateMode(elemId) == UnitConst.NPC_TASK_TRIGGERD then
		scene:createElement(elemId, layer)
	end
end

function SceneElemsMgr:removeElem(sceneId, elemId)
	if not self:isElemExist(sceneId, elemId) then
		return
	end

	local elems = self._elements[sceneId]

	if elems then
		elems[elemId] = nil
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId and scene.stage.wholeScene and scene.stage.wholeScene:GetElementCreateMode(elemId) == UnitConst.NPC_TASK_TRIGGERD then
		scene:removeElement(elemId)
	end
end

function SceneElemsMgr:onEnterSceneFinished(sceneId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		local elems = self._elements[sceneId]

		if elems then
			for k, v in pairs(elems) do
				if scene.stage.wholeScene:GetElementCreateMode(k) == UnitConst.NPC_TASK_TRIGGERD then
					scene:createElement(k, v)
				end
			end
		end
	end
end

function SceneElemsMgr:clear()
	self._elements = {}
end

function SceneElemsMgr:isElemExist(sceneId, elemId)
	local elems = self._elements[sceneId]

	if elems then
		return elems[elemId] ~= nil
	end
end

SceneElemsMgr.instance = SceneElemsMgr.New()

return SceneElemsMgr

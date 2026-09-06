-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneNpcsMgr.lua

module("logicscene.scene.SceneNpcsMgr", package.seeall)

local SceneNpcsMgr = class("SceneNpcsMgr")

function SceneNpcsMgr:ctor()
	self._npcs = {}
end

function SceneNpcsMgr:createNpc(npcId)
	if self:isNpcExist(npcId) then
		return
	end

	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if not npcCo then
		return
	end

	self._npcs[npcId] = true

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == npcCo.sceneId and npcCo.funcType ~= UnitConst.NPC_CREATE_ONENTERSCENE then
		scene.unitFactory:createNpcById(npcId)
	end
end

function SceneNpcsMgr:removeNpc(npcId)
	if not self._npcs[npcId] then
		return
	end

	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if not npcCo then
		return
	end

	self._npcs[npcId] = nil

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == npcCo.sceneId and npcCo.funcType ~= UnitConst.NPC_CREATE_ONENTERSCENE then
		scene.unitFactory:destroyNpcById(npcId)
	end
end

function SceneNpcsMgr:onEnterSceneFinished(sceneId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		for k, v in pairs(self._npcs) do
			if k and v then
				local npcCo = SceneConfig.instance:getNpcCo(k)

				if npcCo and npcCo.funcType ~= UnitConst.NPC_CREATE_ONENTERSCENE then
					scene.unitFactory:createNpcById(k)
				end
			end
		end
	end
end

function SceneNpcsMgr:clear()
	self._npcs = {}
end

function SceneNpcsMgr:isNpcExist(npcId)
	return self._npcs[npcId]
end

SceneNpcsMgr.instance = SceneNpcsMgr.New()

return SceneNpcsMgr

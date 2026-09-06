-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/BarriersMgr.lua

module("logicscene.scene.BarriersMgr", package.seeall)

local BarriersMgr = class("BarriersMgr")

function BarriersMgr:ctor()
	self._barriers = {}
end

function BarriersMgr:triggerBarrierGroup(sceneId, groupId, triggered)
	if triggered then
		self:_triggerBarrierGroup(sceneId, groupId)
	else
		self:_removeBarrierGroup(sceneId, groupId)
	end
end

function BarriersMgr:onEnterSceneFinished(sceneId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		local barriers = self._barriers[sceneId]

		if barriers then
			for k, v in pairs(barriers) do
				scene:triggerBarrierGroup(k, true)
			end
		end
	end
end

function BarriersMgr:clear()
	self._barriers = {}
end

function BarriersMgr:isBarrierGroupExist(sceneId, groupId)
	local barriers = self._barriers[sceneId]

	if barriers then
		return barriers[groupId]
	end
end

function BarriersMgr:_triggerBarrierGroup(sceneId, groupId)
	if self:isBarrierGroupExist(sceneId, groupId) then
		return
	end

	self._barriers[sceneId] = self._barriers[sceneId] or {}

	local barriers = self._barriers[sceneId]

	barriers[groupId] = true

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		scene:triggerBarrierGroup(groupId, true)
	end
end

function BarriersMgr:_removeBarrierGroup(sceneId, groupId)
	if not self:isBarrierGroupExist(sceneId, groupId) then
		return
	end

	local barriers = self._barriers[sceneId]

	if barriers then
		barriers[groupId] = nil
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.isReady and scene:getSceneId() == sceneId then
		scene:triggerBarrierGroup(groupId, false)
	end
end

BarriersMgr.instance = BarriersMgr.New()

return BarriersMgr

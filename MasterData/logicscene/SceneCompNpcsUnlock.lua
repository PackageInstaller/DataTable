-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneCompNpcsUnlock.lua

module("logicscene.scene.component.mainplayer.SceneCompNpcsUnlock", package.seeall)

local SceneCompNpcsUnlock = class("SceneCompNpcsUnlock", SceneComponentBase)

function SceneCompNpcsUnlock:onEnterSceneFinished()
	local allNpcs = SceneConfig.instance:getNpcCosBySceneId(self._scene:getSceneId())

	if allNpcs then
		for k, v in pairs(allNpcs) do
			if v.funcType == UnitConst.NPC_BYSERVEROPENDAYS or v.funcType == UnitConst.NPC_BYSERVERDATE then
				self._allNpcs = self._allNpcs or {}

				local npcMo = NpcUnlockMo.New(v, self._scene)

				table.insert(self._allNpcs, npcMo)
			end
		end
	end

	self:update()
end

function SceneCompNpcsUnlock:update()
	if not self._allNpcs then
		return
	end

	for i = 1, #self._allNpcs do
		self._allNpcs[i]:checkUnLock()
	end
end

function SceneCompNpcsUnlock:onExitScene()
	self._allNpcs = nil
end

return SceneCompNpcsUnlock

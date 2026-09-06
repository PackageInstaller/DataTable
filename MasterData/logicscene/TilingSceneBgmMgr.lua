-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/bgm/TilingSceneBgmMgr.lua

module("logicscene.scene.component.bgm.TilingSceneBgmMgr", package.seeall)

local TilingSceneBgmMgr = class("TilingSceneBgmMgr", SceneComponentBase)

function TilingSceneBgmMgr:ctor(scene)
	TilingSceneBgmMgr.super.ctor(self, scene)

	self._bgmId = 0
	self._cnt = 0
end

function TilingSceneBgmMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	local status = SceneStatusMgr.instance:topStatus()

	if not status then
		return
	end

	local sceneCo = SceneConfig.instance:getSceneCo(status.originSceneId)

	if sceneCo and TableUtil.isTableEmpty(sceneCo.bgmIds) == false then
		local numBgms = #sceneCo.bgmIds

		if numBgms > 1 then
			self._cnt = self._cnt + 1

			local idx = (self._bgmId + self._cnt) % numBgms + 1

			self._bgmId = sceneCo.bgmIds[idx]
		else
			self._bgmId = sceneCo.bgmIds[1]
		end

		AudioPlayerEx.instance:playMusic(self._bgmId)
	end
end

function TilingSceneBgmMgr:getBgmId()
	return self._bgmId
end

return TilingSceneBgmMgr

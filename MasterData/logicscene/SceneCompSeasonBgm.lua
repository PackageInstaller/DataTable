-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonBgm.lua

module("logicscene.scene.component.season.SceneCompSeasonBgm", package.seeall)

local SceneCompSeasonBgm = class("SceneCompSeasonBgm", TilingSceneBgmMgr)

function SceneCompSeasonBgm:onEnterSceneFinished(sceneId, bornX, bornZ)
	local status = SceneStatusMgr.instance:topStatus()

	if not status then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local sceneCo = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

	if sceneCo == nil or sceneCo.bgmIds == nil or #sceneCo.bgmIds == 0 then
		sceneCo = SceneConfig.instance:getSceneCo(status.originSceneId)
	end

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

return SceneCompSeasonBgm

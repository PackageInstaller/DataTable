-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/bgm/SceneBgmMgr.lua

module("logicscene.scene.component.bgm.SceneBgmMgr", package.seeall)

local SceneBgmMgr = class("SceneBgmMgr", SceneComponentBase)

function SceneBgmMgr:ctor(scene)
	SceneBgmMgr.super.ctor(self, scene)

	self._bgmId = 0
	self._cnt = 0
end

function SceneBgmMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	local bgmIds
	local festival = self._scene:getFestival()

	if festival then
		local festivalCo = SceneConfig.instance:getSceneFestivalCo(sceneId, festival)

		if festivalCo then
			bgmIds = festivalCo.bgmIds
		end
	end

	if not bgmIds then
		local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

		if sceneCo ~= nil then
			bgmIds = sceneCo.bgmIds
		end
	end

	if bgmIds and TableUtil.isTableEmpty(bgmIds) == false then
		local numBgms = #bgmIds

		if numBgms > 1 then
			self._cnt = self._cnt + 1

			local idx = (self._bgmId + self._cnt) % numBgms + 1

			self._bgmId = bgmIds[idx]

			printInfo("播放场景音乐，audio id:" .. self._bgmId .. ", random idx:" .. idx)
		else
			self._bgmId = bgmIds[1]
		end

		if not OpSummaryController.instance:isPlayingBgm() then
			AudioPlayerEx.instance:playMusic(self._bgmId)
		end
	else
		printError("当前场景未配置背景音乐,sceneId=", sceneId)
	end
end

function SceneBgmMgr:onExitSceneFinished()
	if self._bgmId ~= 0 then
		-- block empty
	end
end

function SceneBgmMgr:getBgmId()
	return self._bgmId
end

return SceneBgmMgr

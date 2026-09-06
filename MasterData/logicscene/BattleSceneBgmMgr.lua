-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/bgm/BattleSceneBgmMgr.lua

module("logicscene.scene.component.bgm.BattleSceneBgmMgr", package.seeall)

local BattleSceneBgmMgr = class("BattleSceneBgmMgr", SceneComponentBase)

function BattleSceneBgmMgr:ctor(scene)
	BattleSceneBgmMgr.super.ctor(self, scene)

	self._bgmId = 0
end

function BattleSceneBgmMgr:preInitBgmId()
	local configs = SceneConfig.instance:getBattleBgmConfigs()

	self._bgmId = 10001

	local mode = SystemSettingController.instance:getBattleBGMMode()
	local cfg = configs[mode == SystemSettingController.BGM_MODE_RAND and math.random(#configs) or mode]

	if cfg then
		self._bgmId = cfg.audio
	end

	return self._bgmId
end

function BattleSceneBgmMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	if self._bgmId > 0 then
		AudioPlayerEx.instance:playMusic(self._bgmId)
	end
end

function BattleSceneBgmMgr:onExitScene()
	if self._bgmId ~= 0 then
		-- block empty
	end
end

function BattleSceneBgmMgr:getBgmId()
	return self._bgmId
end

function BattleSceneBgmMgr:onEnterNextBattle()
	if self._bgmId ~= 0 then
		AudioPlayerEx.instance:playMusic(self._bgmId)
	end
end

return BattleSceneBgmMgr

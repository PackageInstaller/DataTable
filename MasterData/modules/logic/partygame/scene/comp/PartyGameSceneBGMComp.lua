-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneBGMComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneBGMComp", package.seeall)

local PartyGameSceneBGMComp = class("PartyGameSceneBGMComp", BaseSceneComp)

function PartyGameSceneBGMComp:onSceneStart()
	self._curSceneCo = nil

	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	local co = curGame:getGameConfig()

	if not co then
		return
	end

	self._curSceneCo = co

	local bgmId = co.bgmId
	local envMusic = co.envMusic

	if bgmId and bgmId > 0 then
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.PartyGame, bgmId)
	end

	if envMusic and envMusic > 0 then
		AudioMgr.instance:trigger(envMusic)
	end
end

function PartyGameSceneBGMComp:onSceneClose()
	if not self._curSceneCo then
		return
	end

	local envMusicStop = self._curSceneCo.envMusicStop

	if envMusicStop and envMusicStop > 0 then
		AudioMgr.instance:trigger(envMusicStop)
	else
		AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end

	self._curSceneCo = nil
end

return PartyGameSceneBGMComp

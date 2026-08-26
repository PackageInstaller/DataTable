-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneBgmComp.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneBgmComp", package.seeall)

local Rouge2_SceneBgmComp = class("Rouge2_SceneBgmComp", BaseSceneComp)

function Rouge2_SceneBgmComp:onScenePrepared(sceneId, levelId)
	self:changeBgm()
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onChangeMapInfo, self.changeBgm, self)
end

function Rouge2_SceneBgmComp:changeBgm()
	local layerCo = Rouge2_MapModel.instance:getLayerCo()
	local bgmId = AudioEnum.Bgm.Rouge2Main

	if layerCo and layerCo.bgm ~= 0 then
		bgmId = layerCo.bgm
	end

	local curPlayingId = AudioBgmManager.instance:getCurPlayingId()

	if curPlayingId and curPlayingId ~= 0 and curPlayingId == bgmId then
		return
	end

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Rouge2Scene, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function Rouge2_SceneBgmComp:onSceneClose(sceneId, levelId)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onChangeMapInfo, self.changeBgm, self)
end

return Rouge2_SceneBgmComp

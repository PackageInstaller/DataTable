-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneBgmComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneBgmComp", package.seeall)

local UdimoSceneBgmComp = class("UdimoSceneBgmComp", BaseSceneComp)

function UdimoSceneBgmComp:onScenePrepared(sceneId, levelId)
	self:refreshBgm()
	self:addEventListeners()
end

function UdimoSceneBgmComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnChangeBg, self._onChangeBg, self)
end

function UdimoSceneBgmComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnChangeBg, self._onChangeBg, self)
end

function UdimoSceneBgmComp:_onChangeBg()
	self:refreshBgm()
end

function UdimoSceneBgmComp:refreshBgm()
	local useBg = UdimoItemModel.instance:getUseBg()
	local bgmId = UdimoConfig.instance:getBgBgm(useBg)

	if not bgmId or self._curBgmId == bgmId then
		return
	end

	self._curBgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Udimo, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function UdimoSceneBgmComp:onSceneClose(sceneId, levelId)
	self:removeEventListeners()
end

return UdimoSceneBgmComp

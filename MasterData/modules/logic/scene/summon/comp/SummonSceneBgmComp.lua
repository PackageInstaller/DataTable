-- chunkname: @modules/logic/scene/summon/comp/SummonSceneBgmComp.lua

module("modules.logic.scene.summon.comp.SummonSceneBgmComp", package.seeall)

local SummonSceneBgmComp = class("SummonSceneBgmComp", BaseSceneComp)

function SummonSceneBgmComp:onSceneStart(sceneId, levelId)
	self._sceneLevelCO = lua_scene_level.configDict[levelId]

	if self._sceneLevelCO and self._sceneLevelCO.bgm and self._sceneLevelCO.bgm > 0 then
		self._bgmId = self._sceneLevelCO.bgm
	end

	if self._bgmId then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Summon, self._bgmId, AudioEnum.UI.Stop_UIMusic, nil, nil, AudioEnum.SwitchGroup.Summon, AudioEnum.SwitchState.SummonNormal)
	end
end

function SummonSceneBgmComp:Play(resultType)
	if resultType == SummonEnum.ResultType.Equip then
		if not AudioEnum.SwitchState.SummonEquip then
			local switchKey = AudioEnum.SwitchState.SummonChar

			AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonTab), AudioMgr.instance:getIdFromString(switchKey))
		end
	end
end

function SummonSceneBgmComp:onSceneClose()
	if self._bgmId then
		self._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.Summon)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function SummonSceneBgmComp:onSceneHide()
	self:onSceneClose()
end

return SummonSceneBgmComp

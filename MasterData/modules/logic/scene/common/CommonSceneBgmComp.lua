-- chunkname: @modules/logic/scene/common/CommonSceneBgmComp.lua

module("modules.logic.scene.common.CommonSceneBgmComp", package.seeall)

local CommonSceneBgmComp = class("CommonSceneBgmComp", BaseSceneComp)

function CommonSceneBgmComp:onInit()
	return
end

function CommonSceneBgmComp:onScenePrepared(sceneId, levelId)
	self._sceneLevelCO = lua_scene_level.configDict[levelId]

	if self._sceneLevelCO and self._sceneLevelCO.bgmId and self._sceneLevelCO.bgmId > 0 then
		AudioMgr.instance:trigger(self._sceneLevelCO.bgmId)
	end
end

function CommonSceneBgmComp:onSceneClose()
	return
end

return CommonSceneBgmComp

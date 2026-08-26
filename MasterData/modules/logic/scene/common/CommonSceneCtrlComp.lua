-- chunkname: @modules/logic/scene/common/CommonSceneCtrlComp.lua

module("modules.logic.scene.common.CommonSceneCtrlComp", package.seeall)

local CommonSceneCtrlComp = class("CommonSceneCtrlComp", BaseSceneComp)

CommonSceneCtrlComp.CtrlComp = {
	DynamicShadow = SceneLuaCompSpineDynamicShadow
}

function CommonSceneCtrlComp:onInit()
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function CommonSceneCtrlComp:onSceneStart(sceneId, levelId)
	return
end

function CommonSceneCtrlComp:onSceneClose()
	return
end

function CommonSceneCtrlComp:_onLevelLoaded(levelId)
	local levelComp = self:getCurScene().level
	local sceneGO = levelComp and levelComp:getSceneGo()
	local sceneLevelCO = levelId and lua_scene_level.configDict[levelId]
	local coDict = sceneLevelCO and lua_scene_ctrl.configDict[sceneLevelCO.resName]

	if coDict and not gohelper.isNil(sceneGO) then
		for _, ctrlCO in pairs(coDict) do
			local ctrlComp = CommonSceneCtrlComp.CtrlComp[ctrlCO.ctrlName]

			if ctrlComp then
				local ctorParam = {
					ctrlCO.param1,
					ctrlCO.param2,
					ctrlCO.param3,
					ctrlCO.param4
				}

				MonoHelper.addLuaComOnceToGo(sceneGO, ctrlComp, ctorParam)
			else
				logError("ctrlComp not exist: " .. ctrlCO.ctrlName)
			end
		end
	end
end

return CommonSceneCtrlComp

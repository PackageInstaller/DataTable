-- chunkname: @modules/logic/fight/mgr/FightDynamicShadowMgr.lua

module("modules.logic.fight.mgr.FightDynamicShadowMgr", package.seeall)

local FightDynamicShadowMgr = class("FightDynamicShadowMgr", FightBaseClass)

function FightDynamicShadowMgr:onConstructor()
	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
end

local CtroCompDic = {
	DynamicShadow = SceneLuaCompSpineDynamicShadow
}

function FightDynamicShadowMgr:onLevelLoaded(levelId)
	local levelComp = FightGameMgr.sceneLevelMgr
	local sceneGO = levelComp and levelComp:getSceneGo()
	local sceneLevelCO = levelId and lua_scene_level.configDict[levelId]
	local coDict = sceneLevelCO and lua_scene_ctrl.configDict[sceneLevelCO.resName]

	if coDict and not gohelper.isNil(sceneGO) then
		for _, ctrlCO in pairs(coDict) do
			local ctrlComp = CtroCompDic[ctrlCO.ctrlName]

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

function FightDynamicShadowMgr:onDestructor()
	return
end

return FightDynamicShadowMgr

-- chunkname: @modules/logic/fight/mgr/FightSceneLevelSceneEffectMgr.lua

module("modules.logic.fight.mgr.FightSceneLevelSceneEffectMgr", package.seeall)

local FightSceneLevelSceneEffectMgr = class("FightSceneLevelSceneEffectMgr", FightBaseClass)
local sceneEffectPath = "scenes/common/vx_prefabs/%s.prefab"

function FightSceneLevelSceneEffectMgr:onConstructor(sceneLevelMgr)
	self.sceneLevelMgr = sceneLevelMgr
	self.sceneEffectsObj = {}

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)
end

function FightSceneLevelSceneEffectMgr:_onLevelLoaded(levelId)
	self.levelId = levelId

	for i, v in ipairs(self.sceneEffectsObj) do
		gohelper.destroy(v)
	end

	self.sceneEffectsObj = {}

	if self.loaderComp then
		self.loaderComp:disposeSelf()
	end

	self.loaderComp = self:addComponent(FightLoaderComponent)

	local levelConfig = lua_scene_level.configDict[self.levelId]

	if levelConfig and not string.nilorempty(levelConfig.sceneEffects) then
		local effects = string.split(levelConfig.sceneEffects, "#")

		for i, v in ipairs(effects) do
			self.loaderComp:loadAsset(string.format(sceneEffectPath, v), self.onSceneEffectsLoaded, self)
		end
	end
end

function FightSceneLevelSceneEffectMgr:onSceneEffectsLoaded(success, assetItem)
	if not success then
		return
	end

	local effectObj = gohelper.clone(assetItem:GetResource(), self.sceneLevelMgr.sceneObj)

	table.insert(self.sceneEffectsObj, effectObj)
end

function FightSceneLevelSceneEffectMgr:onDestructor()
	return
end

return FightSceneLevelSceneEffectMgr

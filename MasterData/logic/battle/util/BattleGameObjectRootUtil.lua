-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleGameObjectRootUtil.lua

module("logic.battle.util.BattleGameObjectRootUtil", package.seeall)

local BattleGameObjectRootUtil = {}
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kUnitsRoot = goutil.create("BattleUnits", false)
local kSignsRoot = goutil.create("BattleSigns", false)
local kEffectsRoot = goutil.create("BattleEffects", false)

goutil.addChildToParent(kUnitsRoot, kSceneRoot)
goutil.addChildToParent(kSignsRoot, kSceneRoot)
goutil.addChildToParent(kEffectsRoot, kSceneRoot)

BattleGameObjectRootUtil.unitsRoot = kUnitsRoot
BattleGameObjectRootUtil.signsRoot = kSignsRoot
BattleGameObjectRootUtil.effectsRoot = kEffectsRoot

function BattleGameObjectRootUtil.addToSignsRoot(goChildren)
	goutil.addChildToParent(goChildren, kSignsRoot)
end

function BattleGameObjectRootUtil.addToUnitsRoot(goChildren)
	goutil.addChildToParent(goChildren, kUnitsRoot)
end

function BattleGameObjectRootUtil.addToEffectRoot(goChildren)
	goutil.addChildToParent(goChildren, kEffectsRoot)
end

function BattleGameObjectRootUtil.setVisibleForPerformance(visible)
	goutil.setActive(kUnitsRoot, visible)
	goutil.setActive(kSignsRoot, visible)
	goutil.setActive(kEffectsRoot, visible)
end

function BattleGameObjectRootUtil.setVisibleForSoloPerformance(visible)
	goutil.setActive(kSignsRoot, visible)
	goutil.setActive(kEffectsRoot, visible)
end

return BattleGameObjectRootUtil

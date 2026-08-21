-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleSceneGameObjectMgr.lua

module("logic.battle.battleflow.component.BattleSceneGameObjectMgr", package.seeall)

local BattleSceneGameObjectMgr = class("BattleSceneGameObjectMgr", IBattleFlowComp, AbstractGlobalReusable)

function BattleSceneGameObjectMgr:onInit()
	self._unitUIRootList = {}
end

function BattleSceneGameObjectMgr:onStart()
	local nameBarRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	if not self._unitUIRootList[UIFollowType.Top] then
		self._unitUIRootList[UIFollowType.Bottom] = self:_createAndSetParent("unitUITopBottom", nameBarRoot)
		self._unitUIRootList[UIFollowType.Center] = self:_createAndSetParent("unitUICenter", nameBarRoot)
		self._unitUIRootList[UIFollowType.Top] = self:_createAndSetParent("unitUITop", nameBarRoot)
	end

	self._effectUnits = {}
end

function BattleSceneGameObjectMgr:onClear(isRestart)
	for _, effectUnit in ipairs(self._effectUnits) do
		effectUnit:destroy()
	end

	BattleTableUtil.clearTable(self._effectUnits)

	if not isRestart then
		for i, rootGo in pairs(self._unitUIRootList) do
			goutil.destroy(rootGo)
		end

		table.clear(self._unitUIRootList)
	end
end

function BattleSceneGameObjectMgr:addSceneEffect(url)
	local effectUnit = EffectUnit:createInstance()

	table.insert(self._effectUnits, effectUnit)
	BattleGameObjectRootUtil.addToSignsRoot(effectUnit.mainGO)
	effectUnit.loader:load(url)
	effectUnit.transform:setPositionXYZ(0, 0, 0)
end

function BattleSceneGameObjectMgr:_createAndSetParent(name, parentGo)
	local go = goutil.create(name, false)

	goutil.addChildToParent(go, parentGo)

	return go
end

function BattleSceneGameObjectMgr:getUnitUIRoot(type)
	return self._unitUIRootList[type]
end

return BattleSceneGameObjectMgr

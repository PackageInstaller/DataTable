-- chunkname: @modules/logic/fight/mgr/FightSpineColorBySceneMgr.lua

module("modules.logic.fight.mgr.FightSpineColorBySceneMgr", package.seeall)

local FightSpineColorBySceneMgr = class("FightSpineColorBySceneMgr", FightBaseClass)

function FightSpineColorBySceneMgr:onConstructor()
	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
end

function FightSpineColorBySceneMgr:_setLevelCO(levelId)
	self._spineColor = nil

	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO.spineR ~= 0 or levelCO.spineG ~= 0 or levelCO.spineB ~= 0 then
		self._spineColor = Color.New(levelCO.spineR, levelCO.spineG, levelCO.spineB, 1)
	end
end

function FightSpineColorBySceneMgr:onLevelLoaded(levelId)
	self:_setLevelCO(levelId)
	self:_setAllSpineColor()
end

function FightSpineColorBySceneMgr:_onSpineLoaded(unitSpine)
	if self._spineColor and unitSpine then
		local entity = unitSpine.unitSpawn
		local entityExData = FightDataHelper.entityExMgr:getById(entity.id)

		if entityExData and entityExData.timelineTempEntitySign.donotsetcolor then
			return
		end

		local mat = unitSpine.unitSpawn.spineRenderer:getReplaceMat()

		MaterialUtil.setMainColor(mat, self._spineColor)
	end
end

function FightSpineColorBySceneMgr:_setAllSpineColor()
	if not self._spineColor then
		return
	end

	local entityList = FightHelper.getAllEntitysContainUnitNpc()

	for _, entity in ipairs(entityList) do
		if entity.spineRenderer and entity.spineRenderer:hasSkeletonAnim() then
			local mat = entity.spineRenderer:getReplaceMat()

			MaterialUtil.setMainColor(mat, self._spineColor)
		end
	end
end

function FightSpineColorBySceneMgr:onDestructor()
	return
end

return FightSpineColorBySceneMgr

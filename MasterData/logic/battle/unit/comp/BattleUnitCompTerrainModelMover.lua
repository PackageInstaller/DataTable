-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompTerrainModelMover.lua

module("logic.battle.unit.comp.BattleUnitCompTerrainModelMover", package.seeall)

local BattleUnitCompTerrainModelMover = class("BattleUnitCompTerrainModelMover", UnitComponentBase, IBattleUnitComponent)

function BattleUnitCompTerrainModelMover:onInit()
	self._trs = self._unit.go.transform
	self._position = Vector3.New()
	self._mover = self._unit.mover
	self._terrainModel = self._unit.terrainModel

	self._unit:addInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
end

function BattleUnitCompTerrainModelMover:onReset()
	return
end

function BattleUnitCompTerrainModelMover:onDestroy()
	self._trs = nil

	self._unit:removeInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
end

function BattleUnitCompTerrainModelMover:getPosXYZ()
	return self._position:Get()
end

function BattleUnitCompTerrainModelMover:_onPosChanged()
	local x, z = self._mover:getPos()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local y = boardMgr:calculateWorldYOffset(x, z)

	self._position:Set(x, y, z)
	Astral.TransformUtil.SetPos(self._trs, self._position:Get())
end

return BattleUnitCompTerrainModelMover

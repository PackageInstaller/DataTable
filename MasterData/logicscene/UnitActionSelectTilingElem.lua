-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionSelectTilingElem.lua

module("logicscene.scene.unit.action.UnitActionSelectTilingElem", package.seeall)

local UnitActionSelectTilingElem = class("UnitActionSelectTilingElem", UnitActionGotoUnit)

function UnitActionSelectTilingElem:ctor(mstInsId)
	local scene = SceneMgr.instance:getCurScene()
	local unitMst = scene.unitFactory:getUnit(UnitTag.TilingSceneElem, mstInsId)

	unitMst = unitMst or scene.unitFactory:getUnit(UnitTag.SceneElement, mstInsId)

	UnitActionSelectTilingElem.super.ctor(self, unitMst)

	self._mstInsId = mstInsId
end

function UnitActionSelectTilingElem:update(deltaTime)
	UnitActionSelectTilingElem.super.update(self, deltaTime)

	if self:isDone() and not self._toUnit.isDestroyed then
		self._unit:faceToUnit(self._toUnit)
		GlobalDispatcher:dispatch(GlobalNotify.SelectTilingElem, self._mstInsId)
	end
end

return UnitActionSelectTilingElem

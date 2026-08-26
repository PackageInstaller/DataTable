-- chunkname: @modules/common/unit/UnitMoverHandler.lua

module("modules.common.unit.UnitMoverHandler", package.seeall)

local UnitMoverHandler = class("UnitMoverHandler", LuaCompBase)
local MoverCls = {
	UnitMoverEase,
	UnitMoverParabola,
	UnitMoverBezier,
	UnitMoverCurve,
	UnitMoverMmo,
	UnitMoverBezier3
}

function UnitMoverHandler:init(go)
	self.go = go
	self._moverList = {}

	for _, moverCls in ipairs(MoverCls) do
		local mover = MonoHelper.getLuaComFromGo(self.go, moverCls)

		if mover then
			table.insert(self._moverList, mover)
		end
	end
end

function UnitMoverHandler:addEventListeners()
	for _, mover in ipairs(self._moverList) do
		mover:registerCallback(UnitMoveEvent.PosChanged, self._onPosChange, self)
	end
end

function UnitMoverHandler:removeEventListeners()
	for _, mover in ipairs(self._moverList) do
		mover:unregisterCallback(UnitMoveEvent.PosChanged, self._onPosChange, self)
	end
end

function UnitMoverHandler:_onPosChange(mover)
	local sceneRootTransform = CameraMgr.instance:getSceneTransform()
	local offsetX, offsetY, offsetZ = transformhelper.getPos(sceneRootTransform)
	local posX, posY, posZ = mover:getPos()

	transformhelper.setPos(self.go.transform, posX + offsetX, posY + offsetY, posZ + offsetZ)
end

return UnitMoverHandler

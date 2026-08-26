-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/comp/MaLiAnNaLineBaseComp.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaLineBaseComp", package.seeall)

local MaLiAnNaLineBaseComp = class("MaLiAnNaLineBaseComp", LuaCompBase)

function MaLiAnNaLineBaseComp:init(go)
	self.go = go
	self._tr = go.transform
end

function MaLiAnNaLineBaseComp:updateItem(beginX, beginY, endX, endY)
	transformhelper.setLocalPosXY(self._tr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setWidth(self._tr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(self._tr, 0, 0, angle)
end

return MaLiAnNaLineBaseComp

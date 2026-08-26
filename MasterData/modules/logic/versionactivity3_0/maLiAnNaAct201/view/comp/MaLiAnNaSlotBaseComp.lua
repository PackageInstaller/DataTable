-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/comp/MaLiAnNaSlotBaseComp.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaSlotBaseComp", package.seeall)

local MaLiAnNaSlotBaseComp = class("MaLiAnNaSlotBaseComp", LuaCompBase)

function MaLiAnNaSlotBaseComp:init(go)
	self.go = go
	self._tr = go.transform
end

function MaLiAnNaSlotBaseComp:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function MaLiAnNaSlotBaseComp:getLocalPos()
	return self._localPosX, self._localPosY
end

return MaLiAnNaSlotBaseComp

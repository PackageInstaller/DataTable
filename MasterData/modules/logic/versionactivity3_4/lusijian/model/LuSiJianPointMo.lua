-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianPointMo.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianPointMo", package.seeall)

local LuSiJianPointMo = class("LuSiJianPointMo")

function LuSiJianPointMo:ctor(mo)
	self._mo = mo
	self.id = mo.id
	self.typeId = mo.typeId
	self.posX = mo.posX
	self.posY = mo.posY
	self.state = LuSiJianEnum.StateType.Normal
	self.connected = false

	local dragSureRange, _, _, _ = LuSiJianConfig.instance:getPlaceRange()

	self._connectRaduisSq = dragSureRange * dragSureRange
end

function LuSiJianPointMo:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function LuSiJianPointMo:updateTypeId(typeId)
	self.typeId = typeId
end

function LuSiJianPointMo:getPosXY()
	return self.posX, self.posY
end

function LuSiJianPointMo:setState(state)
	self.state = state
end

function LuSiJianPointMo:getState()
	return self.state
end

function LuSiJianPointMo:setConnect()
	self.connected = true
end

function LuSiJianPointMo:getConnect()
	return self.connected
end

function LuSiJianPointMo:clearPoint()
	self.state = LuSiJianEnum.StateType.Normal
	self.connected = false
end

function LuSiJianPointMo:getId()
	return self.id
end

function LuSiJianPointMo:isInCanConnectionRange(posx, posy)
	local dx = self.posX - posx
	local dy = self.posY - posy
	local sq = dx * dx + dy * dy

	return sq <= self._connectRaduisSq
end

function LuSiJianPointMo:getStr()
	return string.format("id = %d, typeId = %d, posX = %d, posY = %d", self.id, self.typeId, self.posX, self.posY)
end

return LuSiJianPointMo

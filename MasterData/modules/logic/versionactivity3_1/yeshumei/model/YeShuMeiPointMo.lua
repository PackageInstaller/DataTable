-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiPointMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiPointMo", package.seeall)

local YeShuMeiPointMo = class("YeShuMeiPointMo")

function YeShuMeiPointMo:ctor(mo)
	self._mo = mo
	self.id = mo.id
	self.typeId = mo.typeId
	self.posX = mo.posX
	self.posY = mo.posY
	self.state = YeShuMeiEnum.StateType.Normal
	self.connected = false
end

function YeShuMeiPointMo:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function YeShuMeiPointMo:updateTypeId(typeId)
	self.typeId = typeId
end

function YeShuMeiPointMo:getPosXY()
	return self.posX, self.posY
end

function YeShuMeiPointMo:setState(state)
	self.state = state
end

function YeShuMeiPointMo:getState()
	return self.state
end

function YeShuMeiPointMo:setConnect()
	self.connected = true
end

function YeShuMeiPointMo:getConnect()
	return self.connected
end

function YeShuMeiPointMo:clearPoint()
	self.state = YeShuMeiEnum.StateType.Normal
	self.connected = false
end

function YeShuMeiPointMo:getId()
	return self.id
end

function YeShuMeiPointMo:isInCanConnectionRange(posx, posy)
	local dragSureRange, _, _, _ = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.ConnectRange)

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, posx, posy)
end

function YeShuMeiPointMo:getStr()
	return string.format("id = %d, typeId = %d, posX = %d, posY = %d", self.id, self.typeId, self.posX, self.posY)
end

return YeShuMeiPointMo

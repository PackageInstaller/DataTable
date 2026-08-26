-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiPointMo.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiPointMo", package.seeall)

local GMYeShuMeiPointMo = class("GMYeShuMeiPointMo")

function GMYeShuMeiPointMo:ctor(typeId, id)
	self.id = id
	self.typeId = typeId
	self.posX = 0
	self.posY = 0
end

function GMYeShuMeiPointMo:initMo(id, x, y)
	self.id = id
	self.x = x
	self.y = y
	self.state = YeShuMeiEnum.StateType.Noraml
	self.connected = false
end

function GMYeShuMeiPointMo:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function GMYeShuMeiPointMo:updateTypeId(typeId)
	self.typeId = typeId
end

function GMYeShuMeiPointMo:getPosXY()
	return self.posX, self.posY
end

function GMYeShuMeiPointMo:getId()
	return self.id
end

function GMYeShuMeiPointMo:getStr()
	return string.format("id = %d, typeId = %d, posX = %d, posY = %d", self.id, self.typeId, self.posX, self.posY)
end

return GMYeShuMeiPointMo

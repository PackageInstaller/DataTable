-- chunkname: @modules/logic/chessgame/model/ChessGameInteractMo.lua

module("modules.logic.chessgame.model.ChessGameInteractMo", package.seeall)

local ChessGameInteractMo = class("ChessGameInteractMo")

function ChessGameInteractMo:init(interactCo, interactmo)
	self:setCo(interactCo)
	self:setMo(interactmo)
end

function ChessGameInteractMo:setCo(interactCo)
	self.config = interactCo
	self.interactType = interactCo.interactType
	self.path = interactCo.path
	self.walkable = interactCo.walkable
	self.show = interactCo.show
	self.canMove = interactCo.canMove
	self.touchTrigger = interactCo.touchTrigger
	self.iconType = interactCo.iconType
	self.posX = interactCo.x
	self.posY = interactCo.y
	self.direction = interactCo.dir
end

function ChessGameInteractMo:setMo(interactmo)
	self.id = interactmo.id
	self.direction = interactmo.direction or interactmo.dir or self.config.dir
	self.show = interactmo.show
	self.triggerByClick = interactmo.triggerByclick
	self.mapIndex = interactmo.mapIndex
	self.posX = interactmo.posX or interactmo.x or self.config.x
	self.posY = interactmo.posY or interactmo.y or self.config.y

	if interactmo.attrMap then
		self:setIsFinsh(interactmo.attrMap)
	end

	self:setParamStr(interactmo.attrData)
end

function ChessGameInteractMo:isShow()
	return self.show
end

function ChessGameInteractMo:getConfig()
	return self.config
end

function ChessGameInteractMo:getId()
	return self.id or self:getConfig().id
end

function ChessGameInteractMo:getInteractTypeName()
	return ChessGameEnum.InteractTypeToName[self.interactType]
end

function ChessGameInteractMo:setDirection(dir)
	self.direction = dir
end

function ChessGameInteractMo:getDirection()
	return self.direction
end

function ChessGameInteractMo:setXY(x, y)
	self.posX = x
	self.posY = y
end

function ChessGameInteractMo:getXY()
	return self.posX, self.posY
end

function ChessGameInteractMo:setParamStr(param)
	if string.nilorempty(param) then
		return
	end

	local data = cjson.decode(param)

	if data then
		self.isFinish = data.Completed
	end
end

function ChessGameInteractMo:setIsFinsh(data)
	if data then
		self.isFinish = data.Completed
	end
end

function ChessGameInteractMo:CheckInteractFinish()
	return self.isFinish
end

function ChessGameInteractMo:isInCurrentMap()
	return self.mapIndex == ChessGameModel.instance:getNowMapIndex()
end

function ChessGameInteractMo:checkWalkable()
	return self.isWalkable and not self.show
end

function ChessGameInteractMo:getEffectType()
	return self.iconType
end

return ChessGameInteractMo

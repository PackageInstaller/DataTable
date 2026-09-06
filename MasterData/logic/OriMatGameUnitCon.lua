-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameUnitCon.lua

module("logic.extensions.orimatgame.model.OriMatGameUnitCon", package.seeall)

local OriMatGameUnitCon = class("OriMatGameUnitCon")

function OriMatGameUnitCon:ctor(container)
	self.container = container

	if not self.container then
		printError("OriMatGameUnitCon:ctor container is nil")

		return
	end

	self:buildUI()
end

function OriMatGameUnitCon:getContainer()
	return self.container
end

function OriMatGameUnitCon:setUnit(unit)
	self._unit = unit

	if self.container then
		self.container.name = unit:getName()

		self:updateUI()
	end
end

function OriMatGameUnitCon:buildUI()
	return
end

function OriMatGameUnitCon:getType()
	if self._unit then
		return self._unit:getType()
	end
end

function OriMatGameUnitCon:updateUI()
	if not self.container then
		return
	end

	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		goutil.setActive(self.container, true)
	else
		self:reset()
	end
end

function OriMatGameUnitCon:reset()
	goutil.setActive(self.container, false)

	self._unit = nil
end

function OriMatGameUnitCon:destroy()
	self:reset()
	goutil.destroy(self.container)
end

function OriMatGameUnitCon:updatePosition(x, y)
	GameUtil.setAnchoredPos(self.container, x, y)
end

function OriMatGameUnitCon:updateDirection(dir)
	if dir == 1 then
		GameUtil.setLocalScale(self.container, -1, 1, 1)
	else
		GameUtil.setLocalScale(self.container, 1, 1, 1)
	end
end

return OriMatGameUnitCon

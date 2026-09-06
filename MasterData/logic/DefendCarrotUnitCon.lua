-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotUnitCon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotUnitCon", package.seeall)

local DefendCarrotUnitCon = class("DefendCarrotUnitCon")

function DefendCarrotUnitCon:ctor(container)
	self.container = container

	if not self.container then
		printError("DefendCarrotUnitCon:ctor container is nil")

		return
	end

	self:buildUI()
end

function DefendCarrotUnitCon:getContainer()
	return self.container
end

function DefendCarrotUnitCon:setUnit(unit)
	self._unit = unit

	if self.container then
		self.container.name = unit:getName()

		self:updateUI()
	end
end

function DefendCarrotUnitCon:buildUI()
	return
end

function DefendCarrotUnitCon:getType()
	if self._unit then
		return self._unit:getType()
	end
end

function DefendCarrotUnitCon:updateUI()
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

function DefendCarrotUnitCon:reset()
	goutil.setActive(self.container, false)

	self._unit = nil
end

function DefendCarrotUnitCon:destroy()
	self:reset()
	goutil.destroy(self.container)
end

function DefendCarrotUnitCon:updatePosition(x, y)
	GameUtil.setAnchoredPos(self.container, x, y)
end

function DefendCarrotUnitCon:updateDirection(dir)
	if dir == 1 then
		GameUtil.setLocalScale(self.container, -1, 1, 1)
	else
		GameUtil.setLocalScale(self.container, 1, 1, 1)
	end
end

return DefendCarrotUnitCon

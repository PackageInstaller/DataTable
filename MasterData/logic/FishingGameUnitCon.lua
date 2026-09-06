-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameUnitCon.lua

module("logic.extensions.fishinggame.model.FishingGameUnitCon", package.seeall)

local FishingGameUnitCon = class("FishingGameUnitCon")

function FishingGameUnitCon:ctor(container)
	self.container = container

	if not self.container then
		printError("FishingGameUnitCon:ctor container is nil")

		return
	end

	self:buildUI()
end

function FishingGameUnitCon:getContainer()
	return self.container
end

function FishingGameUnitCon:setUnit(unit)
	self._unit = unit

	if self.container then
		self.container.name = unit:getName()

		self:_onSetUI()
		self:updateUI()
	end
end

function FishingGameUnitCon:buildUI()
	return
end

function FishingGameUnitCon:getType()
	return self._unit and self._unit:getType()
end

function FishingGameUnitCon:_onSetUI()
	if not self.container or not self._unit then
		return
	end

	if not string.nilorempty(self._unit.resPath) then
		local resPath = string.format("ui/bigbg/views/fishinggame/%s.png", self._unit.resPath)

		pcall(function()
			uGuiUtil.setSpriteToImage(self.container, uGuiUtil.SpriteType.BigBg, resPath)

			local image = self.container:GetComponent(goutil.Type_UIImage)

			if image then
				image:SetNativeSize()
			end
		end)
	end

	if checknumber(self._unit.width) > 0 then
		GameUtil.setWidth(self.container, self._unit.width)
	end

	if checknumber(self._unit.height) > 0 then
		GameUtil.setHeight(self.container, self._unit.height)
	end

	self:setGray(false)
end

function FishingGameUnitCon:updateUI()
	if not self.container then
		return
	end

	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		self:updateDirection(self._unit.rotationY, self._unit.rotationZ)
		goutil.setActive(self.container, self._unit:isActive())
	else
		self:reset()
	end
end

function FishingGameUnitCon:setVisible(visible)
	if self.container then
		goutil.setActive(self.container, visible)
	end
end

function FishingGameUnitCon:setGray(isGray)
	if self.container then
		GameUtil.SetGray(self.container, isGray)
	end
end

function FishingGameUnitCon:reset()
	if self.container then
		goutil.setActive(self.container, false)
		self:setGray(false)
	end

	self._unit = nil
end

function FishingGameUnitCon:destroy()
	self:reset()

	if self.container then
		goutil.destroy(self.container)

		self.container = nil
	end
end

function FishingGameUnitCon:updatePosition(x, y)
	GameUtil.setAnchoredPos(self.container, x, y)
end

function FishingGameUnitCon:updateDirection(rotationY, rotationZ)
	GameUtil.setLocalRotation(self.container, 0, rotationY or 0, rotationZ or 0)
end

return FishingGameUnitCon

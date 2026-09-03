-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneBullet.lua

require("dm.gameplay.miniGame.model.plane.PlaneMember")

PlaneBullet = class("PlaneBullet", PlaneMember, _M)

function PlaneBullet:initialize(owner, data, gameControl)
	self._gameController = gameControl
	self._stop = false

	super.initialize(self, data, owner)
end

function PlaneBullet:remove()
	self:getOwner():removeBullet(self)
	self:singleRemove()
end

function PlaneBullet:singleRemove()
	super.remove(self)
end

function PlaneBullet:pause()
	self._stop = true

	super.pause(self)
end

function PlaneBullet:resume()
	self._stop = false

	super.resume(self)
end

function PlaneBullet:move(config, func)
	local action = PlaneAction:getSinglePlaneAction(config, {
		owner = self:getView(),
		type = self:getType(),
		planeControl = self._gameController
	}, func)

	if action then
		self:getView():runAction(action)
	end
end

function PlaneBullet:split(config, data, splitData, func)
	local winSizeWidth = cc.Director:getInstance():getWinSize().width
	local winSizeHeight = cc.Director:getInstance():getWinSize().height

	if self._gameController then
		local playerNode = self._gameController:getPlayer():getView()
		local targetPos = splitData.targetPos
		local playerPosX = targetPos.x
		local playerPosY = targetPos.y
		local ownerX = self:getView():getPositionX()
		local ownerY = self:getView():getPositionY()
		local atanFactor = math.atan(math.abs(ownerY - playerPosY) / math.abs(ownerX - playerPosX))

		atanFactor = math.deg(atanFactor)

		local width = config.factor.speed
		local targetHeight = width * math.sin(math.rad(atanFactor))
		local targetWidth = width * math.cos(math.rad(atanFactor))
		local directionX = playerPosX < ownerX and -1 or 1
		local directionY = playerPosY < ownerY and -1 or 1

		self:getView():onUpdate(function(dt)
			if self._stop then
				return
			end

			self:getView():offset(targetWidth * directionX, targetHeight * directionY)

			local posX, posY = self:getView():getPositionX(), self:getView():getPositionY()
			local wFactor1 = -self:getView():getContentSize().width
			local wFactor2 = winSizeWidth + self:getView():getContentSize().width
			local hFactor1 = -self:getView():getContentSize().height
			local hFactor2 = winSizeHeight + self:getView():getContentSize().height

			if (posX < wFactor1 or wFactor2 < posX or posY < hFactor1 or hFactor2 < posY) and func() then
				func()
				self:getView():onUpdate(function(dt)
					return
				end)
			end
		end)
	end
end

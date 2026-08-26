-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/entity/V3a9BirdEntity.lua

module("modules.logic.versionactivity3_9.bird.view.game.entity.V3a9BirdEntity", package.seeall)

local V3a9BirdEntity = class("V3a9BirdEntity", LuaCompBase)

function V3a9BirdEntity:init(go)
	self._go = go
	self._transform = go.transform
end

function V3a9BirdEntity:addEventListeners()
	return
end

function V3a9BirdEntity:removeEventListeners()
	return
end

function V3a9BirdEntity:onStart()
	self._isAlive = true

	local screenWidth = gohelper.getUIScreenWidth()
	local x = -screenWidth / 2 + screenWidth / 6

	if self._mo then
		self._mo:setPosY(0)
		self._mo:setPosX(x)
	end

	recthelper.setAnchorX(self._transform, x)
end

function V3a9BirdEntity:onDestroy()
	return
end

function V3a9BirdEntity:setMo(mo)
	self._mo = mo
end

function V3a9BirdEntity:updateFrame(dt)
	if not self._mo then
		return
	end

	if self._isAlive == false then
		return
	end

	self._mo:updateFrame(dt)

	local screenHeight = V3a9BirdModel.instance:getScreenBound()
	local bound = screenHeight / 2
	local birdRect = self:getBirdRect()

	if birdRect and (bound < birdRect.top or birdRect.bottom < -bound) then
		self._isAlive = false

		V3a9BirdModel.instance:gameOver()
		AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_bulaochuan_bubble_burst)

		return
	end

	self:refreshPos()
end

function V3a9BirdEntity:flap()
	if not self._mo then
		return
	end

	self._mo:flap()
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_chongran_fly_up)
end

function V3a9BirdEntity:refreshPos()
	if not self._mo then
		return
	end

	recthelper.setAnchorY(self._transform, self._mo:getPosY())
end

function V3a9BirdEntity:isAlive()
	return self._isAlive ~= false
end

function V3a9BirdEntity:setAlive(alive)
	self._isAlive = alive
end

function V3a9BirdEntity:getBirdRect()
	if not self._mo then
		return nil
	end

	return self._mo:getBirdRect()
end

return V3a9BirdEntity

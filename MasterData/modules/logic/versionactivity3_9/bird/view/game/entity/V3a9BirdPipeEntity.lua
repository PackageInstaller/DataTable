-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/entity/V3a9BirdPipeEntity.lua

module("modules.logic.versionactivity3_9.bird.view.game.entity.V3a9BirdPipeEntity", package.seeall)

local V3a9BirdPipeEntity = class("V3a9BirdPipeEntity", LuaCompBase)

function V3a9BirdPipeEntity:init(go)
	self._go = go
	self._top = gohelper.findChild(go, "top")
	self._bottom = gohelper.findChild(go, "bottom")
end

function V3a9BirdPipeEntity:addEventListeners()
	return
end

function V3a9BirdPipeEntity:removeEventListeners()
	return
end

function V3a9BirdPipeEntity:onStart()
	return
end

function V3a9BirdPipeEntity:onDestroy()
	return
end

function V3a9BirdPipeEntity:setMo(mo)
	self._mo = mo
end

function V3a9BirdPipeEntity:refreshPos()
	if not self._mo then
		return
	end

	local posX = self._mo:getPosX()
	local topY, bottomY = self._mo:getTopBottomY()

	recthelper.setAnchorX(self._go.transform, posX)
	recthelper.setAnchorY(self._top.transform, topY)
	recthelper.setAnchorY(self._bottom.transform, bottomY)
end

function V3a9BirdPipeEntity:setActive(isActive)
	gohelper.setActive(self._go, isActive)
end

return V3a9BirdPipeEntity

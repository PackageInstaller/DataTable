-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlanePlayerFactory.lua

require("dm.gameplay.miniGame.model.plane.PlanePlayer")

PlanePlayerFactory = class("PlanePlayerFactory", objectlua.Object, _M)

PlanePlayerFactory:has("_player", {
	is = "r"
})

function PlanePlayerFactory:initialize(mainNode, gameController)
	super.initialize(self)

	self._mainNode = mainNode
	self._gameController = gameController
end

function PlanePlayerFactory:build(bulletActionConfig)
	self._player = PlanePlayer:new(self, bulletActionConfig, self._gameController)

	self._player:build(self._mainNode)
end

function PlanePlayerFactory:remove()
	if self._player then
		self._player:remove()

		self._player = nil
	end
end

function PlanePlayerFactory:removePlayer()
	return
end

function PlanePlayerFactory:pause()
	self._stop = true

	if self._player then
		self._player:pause()
	end
end

function PlanePlayerFactory:resume()
	self._stop = false

	if self._gameController:getIsGameOver() then
		return
	end

	if self._player then
		self._player:resume()
	end
end

-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxDataMgr.lua

module("modules.logic.scene.pushbox.logic.PushBoxDataMgr", package.seeall)

local PushBoxDataMgr = class("PushBoxDataMgr", UserDataDispose)

function PushBoxDataMgr:ctor(game_mgr)
	self:__onInit()

	self._game_mgr = game_mgr
	self._scene = game_mgr._scene
	self._scene_root = game_mgr._scene_root
end

function PushBoxDataMgr:init()
	self.warning = 0
end

function PushBoxDataMgr:setWarning(num)
	self.warning = num
end

function PushBoxDataMgr:getCurWarning()
	return self.warning
end

function PushBoxDataMgr:changeWarning(num)
	self.warning = self.warning + num
end

function PushBoxDataMgr:gameOver()
	return self.warning >= 100
end

function PushBoxDataMgr:releaseSelf()
	self:__onDispose()
end

return PushBoxDataMgr

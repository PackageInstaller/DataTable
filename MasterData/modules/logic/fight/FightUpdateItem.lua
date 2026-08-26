-- chunkname: @modules/logic/fight/FightUpdateItem.lua

module("modules.logic.fight.FightUpdateItem", package.seeall)

local FightUpdateItem = class("FightUpdateItem")
local xpcall = xpcall
local __G__TRACKBACK__ = __G__TRACKBACK__

function FightUpdateItem:ctor(func, handle, param)
	self.func = func
	self.handle = handle
	self.param = param
end

function FightUpdateItem:update(deltaTime)
	if self.isDone then
		return
	end

	xpcall(self.func, __G__TRACKBACK__, self.handle, deltaTime, self.param)
end

return FightUpdateItem

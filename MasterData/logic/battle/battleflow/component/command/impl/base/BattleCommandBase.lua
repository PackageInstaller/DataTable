-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/base/BattleCommandBase.lua

module("logic.battle.battleflow.component.command.impl.base.BattleCommandBase", package.seeall)

local BattleCommandBase = class("BattleCommandBase", AbstractGlobalReusable)

function BattleCommandBase:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function BattleCommandBase:onInit()
	return
end

function BattleCommandBase:onClear(interrupt)
	return
end

function BattleCommandBase:execute(battleFlow, runningContext)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleCommandBase:parseServerCommand(cmdParser, protoNO)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleCommandBase:toString()
	return "BattleCommandBase::not implemented toString"
end

function BattleCommandBase:ctor()
	self._cmdHandler = false
	self._isDestroyed = false

	self:onInit()
end

function BattleCommandBase:clear(interrupt)
	self._cmdHandler = false

	self:onClear(interrupt)
	self:returnSelf()
end

function BattleCommandBase:safeInterrupt()
	if self:isDestroyed() then
		return
	end

	self:clear(true)
end

function BattleCommandBase:safeFinish(success)
	if self:isDestroyed() then
		return
	end

	self:finish(success)
end

function BattleCommandBase:isDestroyed()
	return self._isDestroyed
end

function BattleCommandBase:reuse(...)
	self._isDestroyed = false

	BattleCommandBase.super.reuse(self, ...)
end

function BattleCommandBase:reset()
	self._isDestroyed = true

	BattleCommandBase.super.reset(self)
end

function BattleCommandBase:setCommandHandler(handler)
	self._cmdHandler = handler
end

function BattleCommandBase:stop()
	self:clear(true)
end

function BattleCommandBase:finish(success)
	local cmdHandler = self._cmdHandler

	self:clear(false)

	if cmdHandler then
		cmdHandler:onCommandFinish(self, success)
	end
end

return BattleCommandBase

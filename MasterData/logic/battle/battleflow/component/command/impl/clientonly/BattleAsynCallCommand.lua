-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAsynCallCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAsynCallCommand", package.seeall)

local BattleAsynCallCommand = class("BattleAsynCallCommand", BattleCommandBase)

function BattleAsynCallCommand:create(callback, callbackSelf)
	local cmd = BattleAsynCallCommand:createInstance()

	cmd:setFunction(callback, callbackSelf)

	return cmd
end

function BattleAsynCallCommand:createParam1(callback, callbackSelf, param)
	local cmd = BattleAsynCallCommand:createInstance()

	cmd:setFunction(callback, callbackSelf)
	cmd:addParam(param)

	return cmd
end

function BattleAsynCallCommand:onInit()
	self._callback = false
	self._callbackSelf = false
	self._params = {}
end

function BattleAsynCallCommand:onClear()
	self._callback = false
	self._callbackSelf = false

	BattleTableUtil.clearTable(self._params)
end

function BattleAsynCallCommand:execute(battleFlow)
	if #self._params <= 0 then
		Handler:executeCallback(self._callback, self._callbackSelf)
	else
		Handler:executeCallback(self._callback, self._callbackSelf, unpack(self._params))
	end

	self:finish(true)
end

function BattleAsynCallCommand:toString()
	return "asyn call"
end

function BattleAsynCallCommand:setFunction(callback, callbackSelf)
	self._callback = callback
	self._callbackSelf = callbackSelf

	return self
end

function BattleAsynCallCommand:addParam(param)
	table.insert(self._params, param)

	return self
end

return BattleAsynCallCommand

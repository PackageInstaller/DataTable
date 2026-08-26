-- chunkname: @modules/logic/fight/entity/pool/FightTLEventPool.lua

module("modules.logic.fight.entity.pool.FightTLEventPool", package.seeall)

local FightTLEventPool = class("FightTLEventPool")
local _poolDict = {}

function FightTLEventPool.getHandlerInst(type, typeCls)
	local pool = _poolDict[type]

	if not pool then
		pool = LuaObjPool.New(32, function()
			if typeCls then
				if typeCls.New then
					return typeCls.New()
				else
					logError("FightTLEvent class.ctor is nil: " .. type)
				end
			else
				logError("FightTLEvent class is nil: " .. type)
			end

			return FightTLEvent.New()
		end, FightTLEventPool._releaseFunc, FightTLEventPool._resetFunc)
		_poolDict[type] = pool
	end

	local handlerInst = pool:getObject()

	handlerInst.type = type

	return handlerInst
end

function FightTLEventPool.dispose()
	for _, pool in pairs(_poolDict) do
		pool:dispose()
	end

	_poolDict = {}
end

function FightTLEventPool.putHandlerInst(handlerInst)
	local pool = _poolDict[handlerInst.type]

	if pool then
		pool:putObject(handlerInst)
	else
		if handlerInst.reset then
			handlerInst:reset()
		end

		if handlerInst.dispose then
			handlerInst:dispose()
		end
	end
end

function FightTLEventPool._releaseFunc(inst)
	if inst.dispose then
		inst:dispose()
	end
end

function FightTLEventPool._resetFunc(inst)
	if inst.reset then
		inst:reset()
	end
end

return FightTLEventPool

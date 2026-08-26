-- chunkname: @modules/logic/fight/entity/pool/FightBuffHandlerPool.lua

module("modules.logic.fight.entity.pool.FightBuffHandlerPool", package.seeall)

local FightBuffHandlerPool = class("FightBuffHandlerPool")
local _poolDict = {}

function FightBuffHandlerPool.getHandlerInst(type, typeCls)
	if not type then
		logError("param of \"type\" = nil")
	end

	if not typeCls then
		logError("param of \"typeCls\" = nil")
	end

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

			return FightBuffHandler.New()
		end, FightBuffHandlerPool._releaseFunc, FightBuffHandlerPool._resetFunc)
		_poolDict[type] = pool
	end

	local handlerInst = pool:getObject()

	handlerInst.type = type

	return handlerInst
end

function FightBuffHandlerPool.putHandlerInst(handlerInst)
	local pool = _poolDict[handlerInst.type]

	pool:putObject(handlerInst)
end

function FightBuffHandlerPool._releaseFunc(inst)
	if inst.dispose then
		inst:dispose()
	end
end

function FightBuffHandlerPool._resetFunc(inst)
	if inst.reset then
		inst:reset()
	end
end

return FightBuffHandlerPool

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/model/DrawEquipmentsModel.lua

module("logic.extensions.drawequipments.model.DrawEquipmentsModel", package.seeall)

local DrawEquipmentsModel = class("DrawEquipmentsModel", BaseModel)

function DrawEquipmentsModel:onInit()
	return
end

function DrawEquipmentsModel:onReset()
	self._pools = nil
	self._poolsWithId = nil
end

function DrawEquipmentsModel:_createAllPools()
	if self._pools then
		return
	end

	self._pools = {}
	self._poolsWithId = {}

	local poolCos = DrawEquipmentsConfig.instance:getAllPools()

	for i = 1, #poolCos do
		local pool = EquipmentsPoolMO.New(poolCos[i])

		table.insert(self._pools, pool)

		self._poolsWithId[poolCos[i].poolId] = pool
	end
end

function DrawEquipmentsModel:getCurrOpenPools()
	self:_createAllPools()

	local pools = {}
	local now = ServerTime.now()

	for i = 1, #self._pools do
		if self._pools[i]:isOpenByFunction() then
			if self._pools[i]:isPoolInPeriodByNow(now) then
				table.insert(pools, self._pools[i])
			elseif self._pools[i]:isPoolPreheat() then
				table.insert(pools, self._pools[i])
			end
		end
	end

	if pools == nil or #pools == 0 then
		printError("卡池空，  @国敏")
	end

	if #pools > 1 then
		table.sort(pools, function(a, b)
			if a:isPoolPreheat() == b:isPoolPreheat() then
				return a:getPoolId() < b:getPoolId()
			end

			return not a:isPoolPreheat()
		end)
	end

	return pools
end

function DrawEquipmentsModel:getPoolById(poolId)
	return self._poolsWithId[poolId]
end

function DrawEquipmentsModel:onEquipmentPoolInfo(msg)
	for i = 1, #msg.pools do
		local pool = self:getPoolById(msg.pools[i].poolId)

		if pool then
			pool:onPoolData(msg.pools[i].times, msg.pools[i].lastSSR)
		end
	end
end

function DrawEquipmentsModel:onEquipmentPoolDraw(poolId, times, lastSSR)
	local pool = self:getPoolById(poolId)

	if pool then
		pool:onDrawPool(times, lastSSR)
	end
end

DrawEquipmentsModel.instance = DrawEquipmentsModel.New()

return DrawEquipmentsModel

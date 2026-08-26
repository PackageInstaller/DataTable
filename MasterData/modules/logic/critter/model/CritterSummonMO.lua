-- chunkname: @modules/logic/critter/model/CritterSummonMO.lua

module("modules.logic.critter.model.CritterSummonMO", package.seeall)

local CritterSummonMO = pureTable("CritterSummonMO")

function CritterSummonMO:init(info)
	self.id = info.id or info.poolId
	self.poolId = info.poolId
	self.hasSummonCritter = {}

	for i = 1, #info.hasSummonCritter do
		local mo = info.hasSummonCritter[i]
		local id = mo.materialId

		self.hasSummonCritter[id] = mo.quantity
	end

	self.critterMos = {}

	local poolCos = CritterConfig.instance:getCritterSummonPoolCfg(info.poolId)

	if poolCos then
		for _, co in pairs(poolCos) do
			local critterIds = GameUtil.splitString2(co.critterIds, true)

			for i, v in pairs(critterIds) do
				local mo = CritterSummonPoolMO.New()
				local id = v[1]
				local count = v[2]

				if not self.hasSummonCritter[id] then
					mo:init(co.rare, id, count, self.hasSummonCritter[id])
					table.insert(self.critterMos, mo)
				end
			end
		end
	end
end

function CritterSummonMO:onRefresh(hasSummonCritter)
	self.hasSummonCritter = {}

	for i = 1, #hasSummonCritter do
		local info = hasSummonCritter[i]
		local id = info.materialId
		local count = info.quantity

		self.hasSummonCritter[id] = count

		local mo = self:getCritterMoById(id)

		if mo then
			mo:onRefreshPoolCount(count)
		end
	end
end

function CritterSummonMO:getCritterMoById(id)
	for _, mo in ipairs(self.critterMos) do
		if mo.critterId == id then
			return mo
		end
	end
end

function CritterSummonMO:getCritterMos()
	return self.critterMos
end

function CritterSummonMO:getCritterCount()
	local count = 0

	for _, mo in ipairs(self.critterMos) do
		count = count + mo:getPoolCount()
	end

	return count
end

return CritterSummonMO

-- chunkname: @modules/logic/summon/model/SummonResultMO.lua

module("modules.logic.summon.model.SummonResultMO", package.seeall)

local SummonResultMO = pureTable("SummonResultMO")

function SummonResultMO:init(info)
	self.heroId = info.heroId
	self.duplicateCount = info.duplicateCount
	self.equipId = info.equipId
	self.luckyBagId = info.luckyBagId

	if info.returnMaterials then
		self.returnMaterials = {}

		for _, matData in ipairs(info.returnMaterials) do
			local matMO = MaterialDataMO.New()

			matMO:init(matData)
			table.insert(self.returnMaterials, matMO)
		end
	end

	self.soundOfLost = info.soundOfLost
	self.manySoundOfLost = info.manySoundOfLost
	self.isNew = info.isNew
	self._opened = false
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
end

function SummonResultMO:setOpen()
	self._opened = true
end

function SummonResultMO:isOpened()
	return self._opened
end

function SummonResultMO:isLuckyBag()
	return self.luckyBagId ~= nil and self.luckyBagId ~= 0
end

return SummonResultMO

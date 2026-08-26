-- chunkname: @modules/logic/versionactivity3_3/marsha/model/MarshaMapCo.lua

module("modules.logic.versionactivity3_3.marsha.model.MarshaMapCo", package.seeall)

local MarshaMapCo = pureTable("MarshaMapCo")

function MarshaMapCo:init(co)
	self.minPaperScraps = co.minPaperScraps
	self.maxPaperScraps = co.maxPaperScraps
	self.units = {}

	for index, unitCo in ipairs(co.units) do
		self.units[index] = MarshaUnitCo.New()

		self.units[index]:init(unitCo)
	end
end

return MarshaMapCo

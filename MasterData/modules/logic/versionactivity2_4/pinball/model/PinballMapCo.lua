-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballMapCo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballMapCo", package.seeall)

local PinballMapCo = pureTable("PinballMapCo")

function PinballMapCo:init(co)
	self.units = {}

	for index, unitCo in ipairs(co) do
		self.units[index] = PinballUnitCo.New()

		self.units[index]:init(unitCo)
	end
end

return PinballMapCo

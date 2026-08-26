-- chunkname: @modules/logic/herogroup/model/HeroGroupEquipMO.lua

module("modules.logic.herogroup.model.HeroGroupEquipMO", package.seeall)

local HeroGroupEquipMO = pureTable("HeroGroupEquipMO")

function HeroGroupEquipMO:init(info)
	self.index = info.index
	self.equipUid = {}

	for i = 1, 1 do
		table.insert(self.equipUid, "0")
	end

	if not info.equipUid then
		return
	end

	for i, v in ipairs(info.equipUid) do
		if i > 1 then
			break
		end

		self.equipUid[i] = v
	end
end

return HeroGroupEquipMO

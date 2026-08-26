-- chunkname: @modules/logic/herogroup/model/HeroGroupActivity104EquipMo.lua

module("modules.logic.herogroup.model.HeroGroupActivity104EquipMo", package.seeall)

local HeroGroupActivity104EquipMo = pureTable("HeroGroupActivity104EquipMo")

function HeroGroupActivity104EquipMo:init(info)
	self.index = info.index

	if self.index == 4 then
		local var_1_0 = self._mainCardNum or 1
	else
		var_1_0 = self._normalCardNum
	end

	if not self._normalCardNum then
		local cardNum = 2

		self.equipUid = {}

		for i = 1, cardNum do
			if info.equipUid then
				if not info.equipUid[i] then
					local equipUid = "0"

					table.insert(self.equipUid, equipUid)
				end
			end
		end
	end
end

function HeroGroupActivity104EquipMo:setLimitNum(mainCardNum, normalCardNum)
	self._mainCardNum, self._normalCardNum = mainCardNum, normalCardNum
end

function HeroGroupActivity104EquipMo:getEquipUID(slot)
	if not self.equipUid then
		return
	end

	return self.equipUid[slot]
end

return HeroGroupActivity104EquipMo

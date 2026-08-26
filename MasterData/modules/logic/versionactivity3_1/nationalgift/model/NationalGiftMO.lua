-- chunkname: @modules/logic/versionactivity3_1/nationalgift/model/NationalGiftMO.lua

module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftMO", package.seeall)

local NationalGiftMO = pureTable("NationalGiftMO")

function NationalGiftMO:ctor()
	self.actId = 0
	self.isActive = false
	self.bonuses = {}
	self.endTime = 0
end

function NationalGiftMO:init(info)
	self.actId = info.activityId
	self.isActive = info.isActive
	self.bonuses = self:setBonusList(info.bonuss)
	self.endTime = info.endTime
end

function NationalGiftMO:setBonusList(bonuses)
	local list = {}

	if bonuses then
		for _, bonus in ipairs(bonuses) do
			local mo = NationalGiftBonusMO.New()

			mo:init(bonus)

			list[mo.id] = mo
		end
	end

	return list
end

function NationalGiftMO:updateBonusStatus(bonusId, status)
	for _, bonus in pairs(self.bonuses) do
		if bonus.id == bonusId then
			bonus:updateStatus(status)
		end
	end
end

function NationalGiftMO:updateActActive(active)
	self.isActive = active
end

function NationalGiftMO:updateBonuses(bonuses)
	self.bonuses = self:setBonusList(bonuses)
end

function NationalGiftMO:isBonusGet(bonusId)
	return self.bonuses[bonusId] and self.bonuses[bonusId].status == NationalGiftEnum.Status.HasGet
end

function NationalGiftMO:isBonusCouldGet(bonusId)
	return self.bonuses[bonusId] and self.bonuses[bonusId].status == NationalGiftEnum.Status.CouldGet
end

return NationalGiftMO

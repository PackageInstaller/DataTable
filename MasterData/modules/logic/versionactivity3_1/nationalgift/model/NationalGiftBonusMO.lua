-- chunkname: @modules/logic/versionactivity3_1/nationalgift/model/NationalGiftBonusMO.lua

module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftBonusMO", package.seeall)

local NationalGiftBonusMO = pureTable("NationalGiftBonusMO")

function NationalGiftBonusMO:init(info)
	self.id = info.id
	self.status = info.status
end

function NationalGiftBonusMO:updateStatus(status)
	self.status = status
end

return NationalGiftBonusMO

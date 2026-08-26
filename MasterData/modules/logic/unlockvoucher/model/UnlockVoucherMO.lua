-- chunkname: @modules/logic/unlockvoucher/model/UnlockVoucherMO.lua

module("modules.logic.unlockvoucher.model.UnlockVoucherMO", package.seeall)

local UnlockVoucherMO = pureTable("UnlockVoucherMO")

function UnlockVoucherMO:ctor()
	self.id = 0
	self.getTime = 0
end

function UnlockVoucherMO:init(info)
	self.id = tonumber(info.voucherId)
	self.getTime = info.getTime
end

function UnlockVoucherMO:reset(info)
	self:init(info)
end

return UnlockVoucherMO

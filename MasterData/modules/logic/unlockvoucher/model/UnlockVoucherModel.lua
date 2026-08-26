-- chunkname: @modules/logic/unlockvoucher/model/UnlockVoucherModel.lua

module("modules.logic.unlockvoucher.model.UnlockVoucherModel", package.seeall)

local UnlockVoucherModel = class("UnlockVoucherModel", BaseModel)

function UnlockVoucherModel:onInit()
	self:clear()
end

function UnlockVoucherModel:reInit()
	return
end

function UnlockVoucherModel:getVoucher(id)
	return self:getById(id)
end

function UnlockVoucherModel:setVoucherInfos(infos)
	self:clear()

	for _, info in ipairs(infos) do
		self:addVoucher(info)
	end
end

function UnlockVoucherModel:addVoucher(info)
	local mo = UnlockVoucherMO.New()

	mo:init(info)
	self:addAtLast(mo)
end

function UnlockVoucherModel:updateVoucherInfos(infos)
	for _, info in ipairs(infos) do
		local mo = self:getVoucher(info.voucherId)

		if mo then
			mo:reset(info)
		else
			self:addVoucher(info)
		end
	end
end

UnlockVoucherModel.instance = UnlockVoucherModel.New()

return UnlockVoucherModel

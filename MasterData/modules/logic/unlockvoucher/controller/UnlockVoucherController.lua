-- chunkname: @modules/logic/unlockvoucher/controller/UnlockVoucherController.lua

module("modules.logic.unlockvoucher.controller.UnlockVoucherController", package.seeall)

local UnlockVoucherController = class("UnlockVoucherController", BaseController)

function UnlockVoucherController:onInit()
	return
end

function UnlockVoucherController:onInitFinish()
	return
end

function UnlockVoucherController:addConstEvents()
	return
end

function UnlockVoucherController:reInit()
	return
end

function UnlockVoucherController:onGetVoucherInfos(infos)
	UnlockVoucherModel.instance:setVoucherInfos(infos)
	self:dispatchEvent(UnlockVoucherEvent.OnUpdateUnlockVoucherInfo)
end

function UnlockVoucherController:onGetVoucherInfosPush(infos)
	UnlockVoucherModel.instance:updateVoucherInfos(infos)
	self:dispatchEvent(UnlockVoucherEvent.OnUpdateUnlockVoucherInfo)
end

UnlockVoucherController.instance = UnlockVoucherController.New()

return UnlockVoucherController

-- chunkname: @modules/logic/main/controller/work/MainUseExpireItemWork.lua

module("modules.logic.main.controller.work.MainUseExpireItemWork", package.seeall)

local MainUseExpireItemWork = class("MainUseExpireItemWork", BaseWork)

function MainUseExpireItemWork:onStart(context)
	ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
	self:onDone(true)
end

function MainUseExpireItemWork:clearWork()
	return
end

return MainUseExpireItemWork

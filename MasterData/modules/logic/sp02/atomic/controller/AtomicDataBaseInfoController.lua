-- chunkname: @modules/logic/sp02/atomic/controller/AtomicDataBaseInfoController.lua

module("modules.logic.sp02.atomic.controller.AtomicDataBaseInfoController", package.seeall)

local AtomicDataBaseInfoController = class("AtomicDataBaseInfoController", BaseController)

function AtomicDataBaseInfoController:onInit()
	return
end

function AtomicDataBaseInfoController:onInitFinish()
	return
end

function AtomicDataBaseInfoController:reInit()
	return
end

function AtomicDataBaseInfoController:onOpenView(param)
	self._isOpening = true

	AtomicDataBaseInfoViewModel.instance:initDatas(param)
end

function AtomicDataBaseInfoController:onCloseView()
	self._isOpening = false

	AtomicDataBaseInfoViewModel.instance:clear()
end

function AtomicDataBaseInfoController:notifyUpdateView()
	self:dispatchEvent(AtomicEvent.DataBaseInfoUpdate)
end

function AtomicDataBaseInfoController:tryPrevPage()
	if AtomicDataBaseInfoViewModel.instance:tryPrevPage() then
		self:notifyUpdateView()
	end
end

function AtomicDataBaseInfoController:tryNextPage()
	if AtomicDataBaseInfoViewModel.instance:tryNextPage() then
		self:notifyUpdateView()
	end
end

AtomicDataBaseInfoController.instance = AtomicDataBaseInfoController.New()

LuaEventSystem.addEventMechanism(AtomicDataBaseInfoController.instance)

return AtomicDataBaseInfoController

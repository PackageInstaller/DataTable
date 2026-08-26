-- chunkname: @modules/logic/sp02/atomic/controller/AtomicDataBaseController.lua

module("modules.logic.sp02.atomic.controller.AtomicDataBaseController", package.seeall)

local AtomicDataBaseController = class("AtomicDataBaseController", BaseController)

function AtomicDataBaseController:onInit()
	return
end

function AtomicDataBaseController:onInitFinish()
	return
end

function AtomicDataBaseController:reInit()
	return
end

function AtomicDataBaseController:onOpenView()
	self._isOpening = true

	AtomicDataBaseViewModel.instance:initDatas()
end

function AtomicDataBaseController:onCloseView()
	self._isOpening = false

	AtomicDataBaseViewModel.instance:clear()
end

function AtomicDataBaseController:notifyUpdateView(event)
	AtomicDataBaseViewModel.instance:onModelUpdate()
	self:dispatchEvent(event or AtomicEvent.DataBaseUpdate)
end

function AtomicDataBaseController:trySelectTab(dataType)
	if not AtomicDataBaseViewModel.instance:setCurDataType(dataType) then
		return
	end

	self:notifyUpdateView(AtomicEvent.DataBaseTabChange)
	AtomicDataBaseViewModel.instance:playScrollOpenAnim()
end

AtomicDataBaseController.instance = AtomicDataBaseController.New()

LuaEventSystem.addEventMechanism(AtomicDataBaseController.instance)

return AtomicDataBaseController

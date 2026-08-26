-- chunkname: @modules/logic/survival/controller/work/PopupViewFinishWork.lua

module("modules.logic.survival.controller.work.PopupViewFinishWork", package.seeall)

local PopupViewFinishWork = pureTable("PopupViewFinishWork", BaseWork)

function PopupViewFinishWork:ctor()
	return
end

function PopupViewFinishWork:onStart()
	PopupController.instance:registerCallback(PopupEvent.OnPopupFinish, self.onPopupFinish, self)
end

function PopupViewFinishWork:onPopupFinish()
	self:onDone(true)
end

function PopupViewFinishWork:clearWork()
	PopupController.instance:unregisterCallback(PopupEvent.OnPopupFinish, self.onPopupFinish, self)
end

return PopupViewFinishWork

-- chunkname: @modules/logic/sp02/dungeonmap/view/work/AtomicCheckDataBaseToastShowWork.lua

module("modules.logic.sp02.dungeonmap.view.work.AtomicCheckDataBaseToastShowWork", package.seeall)

local AtomicCheckDataBaseToastShowWork = class("AtomicCheckDataBaseToastShowWork", BaseWork)

function AtomicCheckDataBaseToastShowWork:ctor()
	AtomicDungeonController.instance:registerCallback(AtomicDungeonEvent.OnCloseDataBaseToast, self.onSetDone, self)
end

function AtomicCheckDataBaseToastShowWork:onStart()
	local isOpenView = ViewMgr.instance:isOpen(ViewName.AtomicDataBaseToastView)
	local isOpeningView = ViewMgr.instance:isOpening(ViewName.AtomicDataBaseToastView)

	if not isOpenView and not isOpeningView then
		local newUnlockDataBaseList = AtomicDungeonModel.instance:getNewUnlockDataBaseList()
		local dataBaseId = newUnlockDataBaseList[1]

		if dataBaseId > 0 then
			AtomicDungeonController.instance:showDataBaseToast(dataBaseId)
		else
			logError("解锁的资料库id异常，请检查")
			self:onSetDone()
		end
	end
end

function AtomicCheckDataBaseToastShowWork:onSetDone()
	self:onDone(true)
end

function AtomicCheckDataBaseToastShowWork:clearWork()
	AtomicDungeonController.instance:unregisterCallback(AtomicDungeonEvent.OnCloseDataBaseToast, self.onSetDone, self)
end

return AtomicCheckDataBaseToastShowWork

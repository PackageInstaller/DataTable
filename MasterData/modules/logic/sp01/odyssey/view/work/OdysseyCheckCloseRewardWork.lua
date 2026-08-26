-- chunkname: @modules/logic/sp01/odyssey/view/work/OdysseyCheckCloseRewardWork.lua

module("modules.logic.sp01.odyssey.view.work.OdysseyCheckCloseRewardWork", package.seeall)

local OdysseyCheckCloseRewardWork = class("OdysseyCheckCloseRewardWork", BaseWork)

function OdysseyCheckCloseRewardWork:ctor(nextElementId, isForceFocus)
	self.nextElementId = nextElementId
	self.isForceFocus = isForceFocus

	OdysseyDungeonController.instance:registerCallback(OdysseyEvent.OnCloseDungeonRewardView, self.onSetDone, self)
end

function OdysseyCheckCloseRewardWork:onStart()
	local needShowRewawrdView = OdysseyDungeonController.instance:checkNeedPopupRewardView()

	if not needShowRewawrdView then
		self:onSetDone()
	end
end

function OdysseyCheckCloseRewardWork:onSetDone()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, self.nextElementId, self.isForceFocus)
	self:onDone(true)
end

function OdysseyCheckCloseRewardWork:clearWork()
	OdysseyDungeonController.instance:unregisterCallback(OdysseyEvent.OnCloseDungeonRewardView, self.onSetDone, self)
end

return OdysseyCheckCloseRewardWork

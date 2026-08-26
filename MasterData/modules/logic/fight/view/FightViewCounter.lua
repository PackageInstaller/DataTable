-- chunkname: @modules/logic/fight/view/FightViewCounter.lua

module("modules.logic.fight.view.FightViewCounter", package.seeall)

local FightViewCounter = class("FightViewCounter", FightBaseView)

function FightViewCounter:onInitView()
	return
end

function FightViewCounter:initCounterHandleDict()
	if self.counterHandleDict then
		return
	end

	local counterId = FightCounterDataMgr.CounterId

	self.counterHandleDict = {
		[counterId.DeviceCostPower] = self.onCounterIdChange_62,
		[counterId.DeviceUseSkill] = self.onCounterIdChange_63
	}
end

function FightViewCounter:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnCounterChange, self.onCounterChange, self)
end

function FightViewCounter:onCounterChange(counterId, value)
	self:initCounterHandleDict()

	local handle = self.counterHandleDict[counterId]

	if not handle then
		return
	end

	handle(self, counterId, value)
end

function FightViewCounter:onCounterIdChange_62(counterId, value)
	self:openDeviceLvView()
end

function FightViewCounter:onCounterIdChange_63(counterId, value)
	self:openDeviceLvView()
end

function FightViewCounter:openDeviceLvView()
	if self.deviceLvView then
		return
	end

	local enum = FightRightElementEnum.Elements.DeviceLV

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, enum)

	local parentGo = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.deviceLvView = self:com_openSubView(FightDeviceLvView, "ui/viewres/fight/fight3_7devicelevelview.prefab", parentGo)
end

return FightViewCounter

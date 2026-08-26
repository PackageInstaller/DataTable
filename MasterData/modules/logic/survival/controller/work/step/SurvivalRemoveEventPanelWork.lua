-- chunkname: @modules/logic/survival/controller/work/step/SurvivalRemoveEventPanelWork.lua

module("modules.logic.survival.controller.work.step.SurvivalRemoveEventPanelWork", package.seeall)

local SurvivalRemoveEventPanelWork = class("SurvivalRemoveEventPanelWork", SurvivalStepBaseWork)

function SurvivalRemoveEventPanelWork:onStart2(context)
	local isIceSpEvent = false
	local source = self._stepMo.paramInt[1]

	if source == 1 then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		isIceSpEvent = sceneMo:isHaveIceEvent()
		sceneMo.panel = nil
	elseif source == 2 then
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()

		weekMo.panel = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalMapEventView)
	ViewMgr.instance:closeView(ViewName.SurvivalMapSearchView)
	ViewMgr.instance:closeView(ViewName.SurvivalDropSelectView)
	ViewMgr.instance:closeView(ViewName.SurvivalShopView)

	if isIceSpEvent then
		local entity = SurvivalMapHelper.instance:getEntity(0)

		if entity then
			entity:playAnim("down_out")
			TaskDispatcher.runDelay(self._delayDone, self, 1.2)
		else
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function SurvivalRemoveEventPanelWork:_delayDone()
	self:onDone(true)
end

function SurvivalRemoveEventPanelWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function SurvivalRemoveEventPanelWork:getRunOrder(params, flow)
	if params.havePanelUpdate then
		params.havePanelUpdate = false

		return SurvivalEnum.StepRunOrder.After
	else
		return SurvivalEnum.StepRunOrder.Before
	end
end

return SurvivalRemoveEventPanelWork

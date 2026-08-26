-- chunkname: @modules/logic/survival/controller/work/step/SurvivalShowEventPanelWork.lua

module("modules.logic.survival.controller.work.step.SurvivalShowEventPanelWork", package.seeall)

local SurvivalShowEventPanelWork = class("SurvivalShowEventPanelWork", SurvivalStepBaseWork)

function SurvivalShowEventPanelWork:ctor(stepMo)
	SurvivalShowEventPanelWork.super.ctor(self, stepMo)

	if self._stepMo.panel.type == SurvivalEnum.PanelType.Search then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local unitMo = sceneMo and sceneMo.unitsById[self._stepMo.panel.unitId]

		self.isFirst = unitMo and not unitMo:isSearched() or not unitMo
	end
end

function SurvivalShowEventPanelWork:onStart2(context)
	local source = self._stepMo.paramInt[1]
	local panel = self._stepMo.panel
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if source == 1 then
		sceneMo.panel = panel

		if not ViewMgr.instance:isOpen(ViewName.SurvivalMapEventView) and panel.type == SurvivalEnum.PanelType.TreeEvent then
			SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", panel.unitId)
		end
	elseif source == 2 then
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()

		weekMo.panel = panel
	end

	if not self.context.fastExecute then
		if panel.type == SurvivalEnum.PanelType.TreeEvent then
			if sceneMo:isHaveIceEvent() then
				local entity = SurvivalMapHelper.instance:getEntity(0)

				if entity then
					entity:playAnim("down_in")
				end

				UIBlockHelper.instance:startBlock("SurvivalShowEventPanelWork_Ice", 1.8)
				SurvivalMapHelper.instance:tweenToHeroPosIfNeed(0.2)
				TaskDispatcher.runDelay(self._delayOpenPanel, self, 1.8)

				return
			end

			local unitMo = sceneMo.unitsById[panel.unitId]

			if not unitMo then
				SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(panel.uid)
				logError(string.format("没有面板对应的事件ID，强制关闭掉,treeId:%s,unitId:%s,dialogueId:%s", panel.treeId, panel.unitId, panel.dialogueId))
				self:onDone(true)

				return
			end
		end

		panel.isFirstSearch = self.isFirst

		SurvivalMapHelper.instance:tryShowServerPanel(panel, source)
	end

	self:onDone(true)
end

function SurvivalShowEventPanelWork:_delayOpenPanel()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local panel = sceneMo.panel

	SurvivalMapHelper.instance:tryShowServerPanel(panel)
	self:onDone(true)
end

function SurvivalShowEventPanelWork:clearWork()
	TaskDispatcher.cancelTask(self._delayOpenPanel, self)
end

function SurvivalShowEventPanelWork:getRunOrder(params, flow, index, allStep)
	for i = index + 1, #allStep do
		local stepWork = allStep[i]
		local stepMo = stepWork and stepWork._stepMo

		if stepMo and stepMo.type == SurvivalEnum.StepType.RemoveEventPanel then
			local panelUid = stepMo.paramLong[1]

			if self._stepMo.panel.uid == panelUid then
				return SurvivalEnum.StepRunOrder.None
			end
		end
	end

	params.havePanelUpdate = true

	return SurvivalEnum.StepRunOrder.After
end

return SurvivalShowEventPanelWork

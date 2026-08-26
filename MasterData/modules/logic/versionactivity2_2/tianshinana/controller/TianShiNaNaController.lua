-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/TianShiNaNaController.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaController", package.seeall)

local TianShiNaNaController = class("TianShiNaNaController", BaseController)

function TianShiNaNaController:onInit()
	self._stepFlow = nil
end

function TianShiNaNaController:reInit()
	self:clearFlow()
end

function TianShiNaNaController:addConstEvents()
	self.registerCallback(self, TianShiNaNaEvent.ExitLevel, self.clearFlow, self)
end

function TianShiNaNaController:openMainView()
	Activity167Rpc.instance:sendGetAct167InfoRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, self._onRecvMsg, self)
end

function TianShiNaNaController:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.TianShiNaNaMainView)
	end
end

function TianShiNaNaController:buildFlow(steps)
	local haveFlow = self._stepFlow

	self._stepFlow = self._stepFlow or FlowSequence.New()

	local effectWork = TianShiNaNaPlayEffectWork.New()

	self._stepFlow:addWork(effectWork)

	local playerWalkPaths = {}

	for _, step in ipairs(steps) do
		local stepData = cjson.decode(step.param)

		if stepData.stepType == TianShiNaNaEnum.StepType.Move and stepData.id == TianShiNaNaModel.instance:getHeroMo().co.id then
			table.insert(playerWalkPaths, stepData)
		end

		local cls = _G[string.format("TianShiNaNa%sStep", TianShiNaNaEnum.StepTypeToName[stepData.stepType] or "")]

		if cls then
			local work = cls.New()

			work:initData(stepData)
			self._stepFlow:addWork(work)
		else
			logError("未处理步骤类型" .. stepData.stepType)
		end
	end

	effectWork:setWalkPath(playerWalkPaths)

	if not haveFlow then
		self._stepFlow:addWork(TianShiNaNaMapCollapseStep.New())
		self._stepFlow:registerDoneListener(self.flowDone, self)

		if TianShiNaNaModel.instance.sceneLevelLoadFinish then
			if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.DoStep then
				TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
			end

			self._stepFlow:start()
		else
			TianShiNaNaModel.instance.waitStartFlow = true
		end
	end
end

function TianShiNaNaController:checkBeginFlow()
	local waitFlow = TianShiNaNaModel.instance.waitStartFlow

	TianShiNaNaModel.instance.waitStartFlow = false

	if waitFlow and self._stepFlow then
		self._stepFlow:start()
	end
end

function TianShiNaNaController:flowDone(isSuccess)
	self:dispatchEvent(TianShiNaNaEvent.OnFlowEnd, isSuccess)

	self._stepFlow = nil
end

function TianShiNaNaController:clearFlow()
	TianShiNaNaModel.instance.waitStartFlow = false

	if self._stepFlow then
		self._stepFlow:onDestroyInternal()

		self._stepFlow = nil
	end
end

TianShiNaNaController.instance = TianShiNaNaController.New()

return TianShiNaNaController

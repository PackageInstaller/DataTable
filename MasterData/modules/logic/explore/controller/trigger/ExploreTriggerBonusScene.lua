-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerBonusScene.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerBonusScene", package.seeall)

local ExploreTriggerBonusScene = class("ExploreTriggerBonusScene", ExploreTriggerBase)

function ExploreTriggerBonusScene:handle(id, unit)
	local param = {}

	param.id = tonumber(unit.mo.specialDatas[1])
	param.unit = unit
	param.callBack = self.onFinish
	param.callBackObj = self

	ViewMgr.instance:openView(ViewName.ExploreBonusSceneView, param)
end

function ExploreTriggerBonusScene:onFinish(options)
	ExploreSimpleModel.instance:onGetBonus(tonumber(self._unit.mo.specialDatas[1]), options)

	local stepData = {
		stepType = ExploreEnum.StepType.BonusSceneClient
	}

	ExploreStepController.instance:insertClientStep(stepData, 1)
	self:sendTriggerRequest(table.concat(options, "#"))
end

function ExploreTriggerBonusScene:clearWork()
	ViewMgr.instance:closeView(ViewName.ExploreBonusSceneView)
end

return ExploreTriggerBonusScene

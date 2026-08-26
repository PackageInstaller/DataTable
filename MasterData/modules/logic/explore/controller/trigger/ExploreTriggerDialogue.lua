-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerDialogue.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerDialogue", package.seeall)

local ExploreTriggerDialogue = class("ExploreTriggerDialogue", ExploreTriggerBase)

function ExploreTriggerDialogue:handle(id, unit)
	id = tonumber(id)

	if self.isNoFirstDialog then
		local stepData = {
			alwaysLast = true,
			stepType = ExploreEnum.StepType.Dialogue,
			id = id
		}

		ExploreStepController.instance:insertClientStep(stepData)
		self:onDone(true)

		return
	end

	local param = {}

	param.id = id
	param.unit = unit
	param.callBack = self.dialogueAccept
	param.callBackObj = self
	param.refuseCallBack = self.dialogueRefuse
	param.refuseCallBackObj = self

	ViewMgr.instance:openView(ViewName.ExploreInteractView, param)
	ExploreController.instance:getMap():getHero():stopMoving(false)
end

function ExploreTriggerDialogue:dialogueAccept()
	self:onDone(true)
end

function ExploreTriggerDialogue:dialogueRefuse()
	self:onDone(false)
end

function ExploreTriggerDialogue:clearWork()
	ViewMgr.instance:closeView(ViewName.ExploreInteractView)
end

return ExploreTriggerDialogue

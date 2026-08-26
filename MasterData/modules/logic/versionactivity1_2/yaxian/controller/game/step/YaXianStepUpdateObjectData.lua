-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepUpdateObjectData.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepUpdateObjectData", package.seeall)

local YaXianStepUpdateObjectData = class("YaXianStepUpdateObjectData", YaXianStepBase)

function YaXianStepUpdateObjectData:start()
	local updateObjDict = self.originData.object

	self.interactId = updateObjDict.id

	local data = updateObjDict.data

	logNormal("start update object data : " .. self.interactId)

	local interactMo = YaXianGameModel.instance:getInteractMo(self.interactId)

	if interactMo then
		interactMo:updateDataByTableData(data)

		if interactMo.config.interactType == YaXianGameEnum.InteractType.Player then
			self:handleUpdateSkillInfo(data and data.skills)
			self:handleUpdateEffects(data and data.effects)
		end
	end

	self:finish()
end

function YaXianStepUpdateObjectData:handleUpdateSkillInfo(skills)
	local hasChange = YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(skills)

	if hasChange then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
	end
end

function YaXianStepUpdateObjectData:handleUpdateEffects(effects)
	local hasChange = YaXianGameModel.instance:updateEffectsAndCheckHasChange(effects)

	if hasChange then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
	end
end

function YaXianStepUpdateObjectData:dispose()
	return
end

return YaXianStepUpdateObjectData

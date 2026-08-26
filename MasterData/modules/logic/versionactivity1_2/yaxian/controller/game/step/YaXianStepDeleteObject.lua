-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepDeleteObject.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepDeleteObject", package.seeall)

local YaXianStepDeleteObject = class("YaXianStepDeleteObject", YaXianStepBase)

function YaXianStepDeleteObject:start()
	local playerMo = YaXianGameModel.instance:getPlayerInteractMo()

	if playerMo and playerMo.id == self.originData.id and self.originData.reason == YaXianGameEnum.DeleteInteractReason.Win then
		self:finish()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, self.originData.id)
	self:finish()
end

return YaXianStepDeleteObject

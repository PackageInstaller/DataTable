-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepInteractFinish.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepInteractFinish", package.seeall)

local YaXianStepInteractFinish = class("YaXianStepInteractFinish", YaXianStepBase)

function YaXianStepInteractFinish:start()
	local objId = self.originData.id

	YaXianGameModel.instance:addFinishInteract(objId)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractFinish)
	self:finish()
end

return YaXianStepInteractFinish

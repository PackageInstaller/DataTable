-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepNextRound.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepNextRound", package.seeall)

local YaXianStepNextRound = class("YaXianStepNextRound", YaXianStepBase)

function YaXianStepNextRound:start()
	local stateMgr = YaXianGameController.instance.state

	if stateMgr then
		stateMgr:setCurEvent(nil)
	end

	local curRound = self.originData.currentRound

	YaXianGameModel.instance:setRound(curRound)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.UpdateRound)
	self:finish()
end

return YaXianStepNextRound

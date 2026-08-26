-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepGameFinish.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepGameFinish", package.seeall)

local YaXianStepGameFinish = class("YaXianStepGameFinish", YaXianStepBase)

function YaXianStepGameFinish:start()
	YaXianGameController.instance:setSelectObj(nil)
	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianGameEnum.ActivityId)
	YaXianGameController.instance:updateAllPosInteractActive()
	TaskDispatcher.runDelay(self.openResultView, self, YaXianGameEnum.StepFinishDelay)
end

function YaXianStepGameFinish:openResultView()
	if self.originData.win then
		logNormal("game victory!")
		YaXianGameController.instance:gameVictory()
	else
		logNormal("game over!")
		YaXianGameController.instance:gameOver()
	end

	self:finish()
end

function YaXianStepGameFinish:dispose()
	TaskDispatcher.cancelTask(self.openResultView, self)
end

return YaXianStepGameFinish

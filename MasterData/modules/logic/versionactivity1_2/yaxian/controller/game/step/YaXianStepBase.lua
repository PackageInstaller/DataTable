-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepBase.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepBase", package.seeall)

local YaXianStepBase = class("YaXianStepBase")

function YaXianStepBase:init(stepData, index)
	self.originData = stepData
	self.index = index
	self.originData.index = index
	self.stepType = self.originData.stepType
end

function YaXianStepBase:start()
	return
end

function YaXianStepBase:finish()
	local stepMgr = YaXianGameController.instance.stepMgr

	if stepMgr then
		stepMgr:nextStep()
	end
end

function YaXianStepBase:dispose()
	return
end

return YaXianStepBase

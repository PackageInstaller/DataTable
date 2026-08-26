-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepCreateObject.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCreateObject", package.seeall)

local YaXianStepCreateObject = class("YaXianStepCreateObject", YaXianStepBase)

function YaXianStepCreateObject:start()
	local objId = self.originData.id

	YaXianGameModel.instance:removeObjectById(objId)
	YaXianGameController.instance:deleteInteractObj(objId)

	local mo = YaXianGameModel.instance:addObject(self.originData)

	YaXianGameController.instance:addInteractObj(mo)
	logNormal("create object finish !" .. tostring(mo.id))
	self:finish()
end

return YaXianStepCreateObject

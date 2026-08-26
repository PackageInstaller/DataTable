-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepPickUpItem.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepPickUpItem", package.seeall)

local YaXianStepPickUpItem = class("YaXianStepPickUpItem", YaXianStepBase)

function YaXianStepPickUpItem:start()
	self:finish()
	logError("un handle Pick Up type")
end

function YaXianStepPickUpItem:dispose()
	return
end

return YaXianStepPickUpItem

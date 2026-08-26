-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateNormal.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateNormal", package.seeall)

local YaXianStateNormal = class("YaXianStateNormal", YaXianStateBase)

function YaXianStateNormal:start()
	logNormal("YaXianStateNormal start")

	self.stateType = YaXianGameEnum.GameStateType.Normal
end

function YaXianStateNormal:onClickPos(x, y)
	local interactItem = YaXianGameController.instance:getSelectedInteractItem()

	if interactItem and not interactItem.delete and interactItem:getHandler() then
		interactItem:getHandler():onSelectPos(x, y)
	else
		logError("select obj missing!")
	end
end

return YaXianStateNormal

-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateLock.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateLock", package.seeall)

local YaXianStateLock = class("YaXianStateLock", YaXianStateBase)

function YaXianStateLock:start()
	logNormal("YaXianStateLock start")

	self.stateType = YaXianGameEnum.GameStateType.Lock
end

function YaXianStateLock:onClickPos(x, y)
	logNormal("status YaXianStateLock")
end

return YaXianStateLock

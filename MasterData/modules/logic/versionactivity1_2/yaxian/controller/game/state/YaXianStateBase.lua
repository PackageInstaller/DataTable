-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateBase.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateBase", package.seeall)

local YaXianStateBase = class("YaXianStateBase")

function YaXianStateBase:init(originData)
	self.originData = originData
end

function YaXianStateBase:start()
	self.stateType = nil
end

function YaXianStateBase:onClickPos(x, y)
	return
end

function YaXianStateBase:getStateType()
	return self.stateType
end

function YaXianStateBase:dispose()
	return
end

return YaXianStateBase

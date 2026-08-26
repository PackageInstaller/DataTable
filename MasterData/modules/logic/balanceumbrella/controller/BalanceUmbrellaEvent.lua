-- chunkname: @modules/logic/balanceumbrella/controller/BalanceUmbrellaEvent.lua

module("modules.logic.balanceumbrella.controller.BalanceUmbrellaEvent", package.seeall)

local BalanceUmbrellaEvent = _M
local _get = GameUtil.getUniqueTb()

BalanceUmbrellaEvent.ClueUpdate = _get()
BalanceUmbrellaEvent.GuideClueViewClose = _get()
BalanceUmbrellaEvent.ShowGetEffect = _get()

return BalanceUmbrellaEvent

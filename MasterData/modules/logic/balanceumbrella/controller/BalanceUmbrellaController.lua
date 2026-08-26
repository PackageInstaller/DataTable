-- chunkname: @modules/logic/balanceumbrella/controller/BalanceUmbrellaController.lua

module("modules.logic.balanceumbrella.controller.BalanceUmbrellaController", package.seeall)

local BalanceUmbrellaController = class("BalanceUmbrellaController", BaseController)

function BalanceUmbrellaController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onLoginEnd, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function BalanceUmbrellaController:_onLoginEnd()
	BalanceUmbrellaModel.instance:refreshUnlock(true)
end

function BalanceUmbrellaController:_onUpdateDungeonInfo()
	BalanceUmbrellaModel.instance:refreshUnlock()
end

BalanceUmbrellaController.instance = BalanceUmbrellaController.New()

return BalanceUmbrellaController

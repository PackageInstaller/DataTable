-- chunkname: @modules/logic/balanceumbrella/config/BalanceUmbrellaConfig.lua

module("modules.logic.balanceumbrella.config.BalanceUmbrellaConfig", package.seeall)

local BalanceUmbrellaConfig = class("BalanceUmbrellaConfig", BaseConfig)

function BalanceUmbrellaConfig:reqConfigNames()
	return {
		"balance_umbrella"
	}
end

BalanceUmbrellaConfig.instance = BalanceUmbrellaConfig.New()

return BalanceUmbrellaConfig

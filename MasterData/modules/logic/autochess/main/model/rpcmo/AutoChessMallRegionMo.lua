-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMallRegionMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMallRegionMo", package.seeall)

local AutoChessMallRegionMo = pureTable("AutoChessMallRegionMo")

function AutoChessMallRegionMo:init(data)
	self.mallId = data.mallId
	self.items = GameUtil.rpcInfosToList(data.items, AutoChessItemMo)
	self.selectItems = data.selectItems

	table.sort(self.items, function(a, b)
		return a.config.order < b.config.order
	end)

	self.config = AutoChessConfig.instance:getMallCfg(self.mallId)
end

return AutoChessMallRegionMo

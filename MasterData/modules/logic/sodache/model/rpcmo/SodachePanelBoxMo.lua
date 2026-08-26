-- chunkname: @modules/logic/sodache/model/rpcmo/SodachePanelBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodachePanelBoxMo", package.seeall)

local SodachePanelBoxMo = pureTable("SodachePanelBoxMo")

function SodachePanelBoxMo:init(data)
	self.currPanel = GameUtil.rpcInfoToMo(data.currPanel, SodachePanelMo, self.currPanel)
end

return SodachePanelBoxMo

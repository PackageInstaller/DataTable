-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessBuffContainerMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessBuffContainerMo", package.seeall)

local AutoChessBuffContainerMo = pureTable("AutoChessBuffContainerMo")

function AutoChessBuffContainerMo:init(data)
	self.buffs = GameUtil.rpcInfosToList(data.buffs, AutoChessBuffMo)

	table.sort(self.buffs, function(a, b)
		return a.uid < b.uid
	end)
end

function AutoChessBuffContainerMo:addBuff(buff)
	self.buffs[#self.buffs + 1] = buff

	table.sort(self.buffs, function(a, b)
		return a.uid < b.uid
	end)
end

return AutoChessBuffContainerMo

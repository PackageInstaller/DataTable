-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheStepMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheStepMo", package.seeall)

local SodacheStepMo = pureTable("SodacheStepMo")

function SodacheStepMo:init(data)
	self.type = data.type
	self.units = data.units
	self.paramInt = data.paramInt
	self.paramLong = data.paramLong
	self.paramStr = data.paramStr
	self.battleInfo = data.battleInfo
	self.panel = data.panel
	self.items = data.items
	self.tasks = data.tasks
	self.insideProp = data.insideProp
	self.diceResults = data.diceResults
	self.patrolBox = data.patrolBox
	self.itemRewards = data.itemRewards
end

return SodacheStepMo

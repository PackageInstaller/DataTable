-- chunkname: @IQIGame\\Module\\GhostGame\\GhostGameBuff.lua

local m = {}

function m.New(buffCid)
	local obj = Clone(m)

	obj:Init(buffCid)

	return obj
end

function m:Init(buffCid)
	self.buffCfg = CfgGhostGameBuffTable[buffCid]
	self.strength = self.buffCfg.TriggerParams
	self.startTime = os.time()
	self.duration = self.buffCfg.DurationTime
	self.type = self.buffCfg.Type
	self.UniqueID = PlayerModule.GetServerTimeByMs()

	if self.type == Constant.GhostGameBuffType.ChangeAttackPower then
		self.effect = GhostGameBuffManager.AttackBoostEffect
	elseif self.type == Constant.GhostGameBuffType.ChangeAttackInterval then
		self.effect = GhostGameBuffManager.AttackIntervalEffect
	elseif self.type == Constant.GhostGameBuffType.ChangeAttackNum then
		self.effect = GhostGameBuffManager.AttackAddNumEffect
	elseif self.type == Constant.GhostGameBuffType.SlowDown then
		self.effect = GhostGameBuffManager.SlowEffect
	elseif self.type == Constant.GhostGameBuffType.Frozen then
		self.effect = GhostGameBuffManager.FrozenEffect
	end
end

function m:Dispose()
	return
end

return m

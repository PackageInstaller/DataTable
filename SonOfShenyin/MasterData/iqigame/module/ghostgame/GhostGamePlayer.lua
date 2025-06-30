-- chunkname: @IQIGame\\Module\\GhostGame\\GhostGamePlayer.lua

local ghostGameBuff = require("IQIGame.Module.GhostGame.GhostGameBuff")
local m = {
	buffs = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local discreteCfg = CfgDiscreteDataTable[12003]

	self.normalAttackPower = discreteCfg.Data[2]
	self.normalAttackNum = discreteCfg.Data[1]
	self.normalAttackInterval = discreteCfg.Data[3] / 1000
	self.attackPower = self.normalAttackPower
	self.attackNum = self.normalAttackNum
	self.attackInterval = self.normalAttackInterval
end

function m:UpdateAttackNum(param, apply)
	self.attackNum = self.attackNum + param

	EventDispatcher.Dispatch(EventID.GhostAttackNumChange, self.attackNum)
end

function m:UpdateAttackPower(param, apply)
	if apply then
		self.attackPower = self.normalAttackPower * (1 + param)
	else
		self.attackPower = self.normalAttackPower
	end

	log("攻击力变更" .. self.attackPower)
end

function m:UpdateAttackInterval(param, apply)
	if apply then
		self.attackInterval = self.normalAttackInterval * (1 - param)
	else
		self.attackInterval = self.normalAttackInterval
	end
end

function m:IsCanAttack()
	return self.attackNum > 0
end

function m:Update()
	if GhostGameModule.IsPause then
		self:UpdateBuffStartTimeByPause()

		return
	end

	self:ResumeBuffs()
	self:UpdateBuffs()
end

function m:AddBuff(buff)
	for _, existingBuff in pairs(self.buffs) do
		if existingBuff.type == buff.type and buff.type ~= Constant.GhostGameBuffType.ChangeAttackNum then
			existingBuff.startTime = os.time()

			return true
		end
	end

	self.buffs[buff.type] = buff

	buff.effect(self, buff.strength, true)

	return true
end

function m:UpdateBuffs()
	for i, buff in pairs(self.buffs) do
		if os.time() - buff.startTime >= buff.duration then
			self.buffs[buff.type] = nil

			buff.effect(self, buff.strength, false)
		end
	end
end

function m:UpdateBuffStartTimeByPause()
	for i, buff in pairs(self.buffs) do
		if not buff.pauseTime then
			buff.pauseTime = os.time()
		end
	end
end

function m:ResumeBuffs()
	for i, buff in pairs(self.buffs) do
		if buff.pauseTime then
			local pauseDuration = os.time() - buff.pauseTime

			buff.startTime = buff.startTime + pauseDuration
			buff.pauseTime = nil
		end
	end
end

function m:GetBuff(type)
	for k, v in pairs(self.buffs) do
		if v.type == type then
			return v
		end
	end

	return nil
end

function m:Dispose()
	return
end

return m

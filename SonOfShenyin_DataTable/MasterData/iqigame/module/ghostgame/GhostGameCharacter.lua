-- chunkname: @IQIGame\\Module\\GhostGame\\GhostGameCharacter.lua

local ghostGameBuff = require("IQIGame.Module.GhostGame.GhostGameBuff")
local m = {
	isReady = false,
	buffs = {}
}

function m.New(controller, enemyData, parent)
	local obj = Clone(controller)

	obj:Init(parent, enemyData)

	return obj
end

function m:Init(parent, enemyData)
	self.enemyData = enemyData
	self.originalMoveSpeed = self.enemyData.monsterCfg.MonsterSpeed
	self.moveSpeed = self.originalMoveSpeed
	self.buffs = {}

	self:_Init(parent, enemyData)
end

function m:Update()
	if GhostGameModule.IsPause then
		self:UpdateBuffStartTimeByPause()

		return
	end

	self:ResumeBuffs()
	self:UpdateBuffs()
	self:_Update()
end

function m:AddBuff(buff)
	for _, existingBuff in pairs(self.buffs) do
		if existingBuff.type == buff.type then
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
			GhostGameBuffManager.RemoveEnemyBuff(buff)
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

function m:SaveServerTime(serverTime)
	self:_SaveServerTime(serverTime)
end

function m:Dispose()
	self:_Dispose()
end

function m:_Init(parent, enemyData)
	return
end

function m:_Update()
	return
end

function m:_SaveServerTime(serverTime)
	return
end

function m:_Dispose()
	return
end

return m

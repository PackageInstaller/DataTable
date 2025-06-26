-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattlePODData.lua

local BattleBuffData = require("IQIGame.Module.Battle.BattleData.BattleBuffData")
local BattlePODData = {
	isFriendly = false,
	battlePos = 0,
	battleUnitID = 0,
	troopType = 0,
	buffsData = {}
}

function BattlePODData:__InitPODData(pod)
	self.PODData = pod
	self.battleUnitID = self.PODData.ID
	self.troopType = self.PODData.TroopType
	self.isFriendly = self.troopType == BattleModule.attackBattleTroopType
	self.battlePos = self.PODData.BattlePos

	self:__InitBuffsData(self.PODData.Buffs)
end

function BattlePODData:__InitBuffsData(buffs)
	self.buffsData = {}

	for _, _buffData in pairs(buffs) do
		local ext = ""

		ForPairs(_buffData.CustomParams, function(k, _argValue)
			local arg = ValueToFloat(_argValue, 3, true)

			if not LuaUtility.StrIsNullOrEmpty(ext) then
				ext = ext .. ","
			end

			ext = ext .. arg
		end)

		local buffData = BattleBuffData.New(_buffData.Cid, _buffData.Stack, _buffData.LeftTime, ext)

		self.buffsData[buffData.cid] = buffData
	end
end

function BattlePODData:GetBuffData(buffCid)
	return self.buffsData[buffCid]
end

function BattlePODData:AddBuff(buffCid, stack, leftCount, broadcast, ext)
	if self.buffsData[buffCid] ~= nil then
		warning("战斗单位 {0} 添加一个已经存在的buff {1}", self.battleUnitID, buffCid)

		return
	end

	self.buffsData[buffCid] = BattleBuffData.New(buffCid, stack, leftCount, ext)

	BattleModule.Log("战斗单位 {0} 添加一个BUFF Cid:{1} stack:{2} leftCount:{3}", self.battleUnitID, buffCid, stack, leftCount)

	if broadcast == false then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitAddBuff, self.battleUnitID, buffCid)
end

function BattlePODData:UpdateBuff(buffCid, stack, leftCount, broadcast, ext)
	local buffData = self.buffsData[buffCid]

	if buffData == nil then
		warning("战斗单位 {0} 更新一个不存在的buff {1}", self.battleUnitID, buffCid)

		return
	end

	local stackDifference = buffData.stack - stack
	local roundDifference = buffData.leftCount - leftCount

	buffData:Update(stack, leftCount, ext)
	BattleModule.Log("战斗单位 {0} 更新一个BUFF Cid:{1} stack:{2} leftCount:{3}", self.battleUnitID, buffCid, stack, leftCount)

	if broadcast == false then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitUpdateBuff, self.battleUnitID, buffCid, stackDifference, roundDifference)
end

function BattlePODData:TriggerBuff(buffCid, broadcast)
	BattleModule.Log("战斗单位 {0} 触发BUFF Cid:{1} ", self.battleUnitID, buffCid)

	if broadcast == false then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitTriggerBuff, self.battleUnitID, buffCid)
end

function BattlePODData:RemoveBuff(buffCid, broadcast)
	if self.buffsData[buffCid] == nil then
		warning("战斗单位 {0} 删除一个不存在的buff {1}", self.battleUnitID, buffCid)

		return
	end

	self.buffsData[buffCid] = nil

	BattleModule.Log("战斗单位 {0} 移除BUFF Cid:{1} ", self.battleUnitID, buffCid)

	if broadcast == false then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitRemoveBuff, self.battleUnitID, buffCid)
end

function BattlePODData:OnPosChanged(tilePos)
	self.PODData.BattlePos = tilePos
	self.battlePos = tilePos

	EventDispatcher.Dispatch(EventID.BattleUnitChangePos, self.battleUnitID)
end

function BattlePODData:OnAITypeChange(aiType)
	self.PODData.AI_TYPE = aiType

	EventDispatcher.Dispatch(EventID.BattleUnitAITypeChange, self.battleUnitID, aiType)
end

function BattlePODData:GetAIType()
	if self.PODData.AI_TYPE == nil then
		self.PODData.AI_TYPE = 0
	end

	return self.PODData.AI_TYPE
end

function BattlePODData:GetHeroCid()
	return self.PODData.HeroCid
end

return BattlePODData

-- chunkname: @modules/logic/fight/entity/FightEntityBuffObject.lua

module("modules.logic.fight.entity.FightEntityBuffObject", package.seeall)

local FightEntityBuffObject = class("FightEntityBuffObject", FightBaseClass)

function FightEntityBuffObject:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
end

local buffId2EffectClass = {
	[104342520] = FightBuffIdEffect104342520
}
local buffActId2Class = {
	[1125] = FightBuffActIdEffect1125,
	[1139] = FightBuffActIdEffect1139
}

function FightEntityBuffObject:onAddBuff()
	local buffId = self.buffId

	self:showAddEffect()

	if lua_fight_gao_si_niao_buffeffect_electric_level.configDict[buffId] then
		self:newClass(FightGaoSiNiaoBuffEffectWithElectricLevel, self.buffData)
	end

	local dicActivity128Const = lua_activity128_const.configDict

	if buffId == dicActivity128Const[7].value1 then
		self:newClass(FightZongMaoWillEnterEyeWitnessRound, self.buffData)
	elseif buffId == dicActivity128Const[8].value1 then
		self:newClass(FightZongMaoEyeWitnessRound, self.buffData)
	elseif buffId == dicActivity128Const[9].value1 then
		self:newClass(FightZongMaoEyeWitnessEnd, self.buffData)
	end

	local effectClass = buffId2EffectClass[buffId]

	if effectClass then
		self:newClass(effectClass, self.buffData)
	end

	local actInfo = self.buffData.actInfo

	for i, v in ipairs(actInfo) do
		local effectClass = buffActId2Class[v.actId]

		if effectClass then
			self:newClass(effectClass, self.buffData, v)
		end
	end

	FightMsgMgr.sendMsg(FightMsgId.OnAddBuff, self.buffData)
end

function FightEntityBuffObject:showAddEffect()
	return
end

function FightEntityBuffObject:onRemoveBuff()
	self:showRemoveEffect()
	FightMsgMgr.sendMsg(FightMsgId.OnRemoveBuff, self.buffData)
end

function FightEntityBuffObject:showRemoveEffect()
	return
end

function FightEntityBuffObject:onUpdateBuff()
	FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self.buffData)
end

function FightEntityBuffObject:onDestructor()
	return
end

return FightEntityBuffObject

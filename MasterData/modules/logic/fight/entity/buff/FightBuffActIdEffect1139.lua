-- chunkname: @modules/logic/fight/entity/buff/FightBuffActIdEffect1139.lua

module("modules.logic.fight.entity.buff.FightBuffActIdEffect1139", package.seeall)

local FightBuffActIdEffect1139 = class("FightBuffActIdEffect1139", FightBaseClass)

function FightBuffActIdEffect1139:onConstructor(buffData, actInfo)
	self.buffData = buffData
	self.buffUid = buffData.uid
	self.actInfo = actInfo

	FightMsgMgr.sendMsg(FightMsgId.OnAddMeiLeiErCharge, self.buffData, self.actInfo)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
end

function FightBuffActIdEffect1139:onRemoveBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnRemoveMeiLeiErCharge, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1139:onUpdateBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnUpdateMeiLeiErCharge, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1139:onDestructor()
	return
end

return FightBuffActIdEffect1139

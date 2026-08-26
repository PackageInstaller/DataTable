-- chunkname: @modules/logic/fight/entity/buff/FightBuffActIdEffect1125.lua

module("modules.logic.fight.entity.buff.FightBuffActIdEffect1125", package.seeall)

local FightBuffActIdEffect1125 = class("FightBuffActIdEffect1125", FightBaseClass)

function FightBuffActIdEffect1125:onConstructor(buffData, actInfo)
	self.buffData = buffData
	self.buffUid = buffData.uid
	self.actInfo = actInfo

	FightMsgMgr.sendMsg(FightMsgId.OnAddYaMiShield, self.buffData, self.actInfo)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
end

function FightBuffActIdEffect1125:onRemoveBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnRemoveYaMiShield, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1125:onUpdateBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnUpdateYaMiShield, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1125:onDestructor()
	return
end

return FightBuffActIdEffect1125

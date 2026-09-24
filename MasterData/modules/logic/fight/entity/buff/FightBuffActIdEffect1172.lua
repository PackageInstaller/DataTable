-- chunkname: @modules/logic/fight/entity/buff/FightBuffActIdEffect1172.lua

module("modules.logic.fight.entity.buff.FightBuffActIdEffect1172", package.seeall)

local FightBuffActIdEffect1172 = class("FightBuffActIdEffect1172", FightBaseClass)

function FightBuffActIdEffect1172:onConstructor(buffData, actInfo)
	self.buffData = buffData
	self.buffUid = buffData.uid
	self.actInfo = actInfo

	FightMsgMgr.sendMsg(FightMsgId.AddDeLeiKeSlider1172, self.buffData, self.actInfo)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
end

function FightBuffActIdEffect1172:onRemoveBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.RemoveDeLeiKeSlider1172, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1172:onUpdateBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.UpdateDeLeiKeSlider1172, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1172:onDestructor()
	return
end

return FightBuffActIdEffect1172

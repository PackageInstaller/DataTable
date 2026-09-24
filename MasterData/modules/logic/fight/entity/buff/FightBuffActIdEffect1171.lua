-- chunkname: @modules/logic/fight/entity/buff/FightBuffActIdEffect1171.lua

module("modules.logic.fight.entity.buff.FightBuffActIdEffect1171", package.seeall)

local FightBuffActIdEffect1171 = class("FightBuffActIdEffect1171", FightBaseClass)

function FightBuffActIdEffect1171:onConstructor(buffData, actInfo)
	self.buffData = buffData
	self.buffUid = buffData.uid
	self.actInfo = actInfo

	FightMsgMgr.sendMsg(FightMsgId.AddDeLeiKeSlider1171, self.buffData, self.actInfo)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
end

function FightBuffActIdEffect1171:onRemoveBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.RemoveDeLeiKeSlider1171, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1171:onUpdateBuff(buffData)
	if buffData.uid ~= self.buffUid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.UpdateDeLeiKeSlider1171, self.buffData, self.actInfo)
end

function FightBuffActIdEffect1171:onDestructor()
	return
end

return FightBuffActIdEffect1171

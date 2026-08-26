-- chunkname: @modules/logic/fight/view/FightViewBuffId2Behaviour.lua

module("modules.logic.fight.view.FightViewBuffId2Behaviour", package.seeall)

local FightViewBuffId2Behaviour = class("FightViewBuffId2Behaviour", BaseView)

function FightViewBuffId2Behaviour:onInitView()
	self.existBuffBehaviourDict = {}
end

function FightViewBuffId2Behaviour:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
end

function FightViewBuffId2Behaviour:removeEvents()
	return
end

FightViewBuffId2Behaviour.BehaviourId2Behaviour = {
	FightBuffBehaviour_ForceAuto,
	FightBuffBehaviour_HideCard,
	FightBuffBehaviour_500M_RemoveActPoint,
	FightBuffBehaviour_500M_BGMask,
	FightBuffBehaviour_500M_DeepScore,
	FightBuffBehaviour_BulletTime,
	FightBuffBehaviour_3_3Dream,
	FightBuffBehaviour_3_3PaoPao
}

function FightViewBuffId2Behaviour:onOpen()
	self:checkRunBuffBehaviour()
end

function FightViewBuffId2Behaviour:checkRunBuffBehaviour()
	local entityDict = FightDataHelper.entityMgr:getAllEntityMO()

	for _, entityMo in pairs(entityDict) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			local co = lua_fight_buff2special_behaviour.configDict[buffMo.buffId]

			if co then
				self:addBuffBehaviour(co, entityMo.uid, buffMo.buffId, buffMo)
			end
		end
	end
end

function FightViewBuffId2Behaviour:onDestroyView()
	for buffId, behaviour in pairs(self.existBuffBehaviourDict) do
		self:destroyBehaviour(buffId, behaviour)
	end
end

function FightViewBuffId2Behaviour:onBuffUpdate(entityId, effectType, buffId, buffUid, configEffect, buffMo)
	local co = lua_fight_buff2special_behaviour.configDict[buffId]

	if not co then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self:addBuffBehaviour(co, entityId, buffId, buffMo)
	elseif effectType == FightEnum.EffectType.BUFFUPDATE then
		self:updateBehaviour(co, entityId, buffId, buffMo)
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		self:removeBuffBehaviour(co, entityId, buffId, buffMo)
	else
		logError("not handle effectType : " .. tostring(effectType))
	end
end

function FightViewBuffId2Behaviour:addBuffBehaviour(co, entityId, buffId, buffMo)
	if self.existBuffBehaviourDict[buffId] then
		return
	end

	local behaviourCls = FightViewBuffId2Behaviour.BehaviourId2Behaviour[co.behaviour]

	if not behaviourCls then
		logError(string.format("不支持的behaviour : %s, buffId : %s", co.behaviour, buffId))

		return
	end

	local behaviour = behaviourCls.New()

	behaviour:init(self.viewGO, self.viewContainer, co)
	behaviour:onAddBuff(entityId, buffId, buffMo)

	self.existBuffBehaviourDict[buffId] = behaviour
end

function FightViewBuffId2Behaviour:updateBehaviour(co, entityId, buffId, buffMo)
	local behavior = self.existBuffBehaviourDict[buffId]

	if behavior then
		behavior:onUpdateBuff(entityId, buffId, buffMo)
	end
end

function FightViewBuffId2Behaviour:removeBuffBehaviour(co, entityId, buffId, buffMo)
	local behavior = self.existBuffBehaviourDict[buffId]

	if behavior then
		behavior:onRemoveBuff(entityId, buffId, buffMo)
		self:destroyBehaviour(buffId, behavior)
	end
end

function FightViewBuffId2Behaviour:destroyBehaviour(buffId, behaviour)
	behaviour:onDestroy()

	self.existBuffBehaviourDict[buffId] = nil
end

return FightViewBuffId2Behaviour

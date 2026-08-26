-- chunkname: @modules/logic/fight/entity/comp/skinCustomComp/FightSkinSM_630305CustomComp.lua

module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinSM_630305CustomComp", package.seeall)

local FightSkinSM_630305CustomComp = class("FightSkinSM_630305CustomComp", FightSkinCustomCompBase)
local Action = {
	Add = 1,
	Remove = 2
}

function FightSkinSM_630305CustomComp:ctor(entity)
	self.entity = entity
	self.skinId = entity:getMO().skin
	self.entityId = entity.id
	self.spine = self.entity.spine
end

function FightSkinSM_630305CustomComp:init(go)
	self.go = go

	for _, smCo in ipairs(lua_fight_sp_sm.configList) do
		if smCo.skinId == self.skinId then
			self.handleBuffId = smCo.buffId

			break
		end
	end

	self:switchToIdle()
	self.entity.spine:addAnimEventCallback(self.onAnimEvent, self)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)
end

function FightSkinSM_630305CustomComp:removeEventListeners()
	self.entity.spine:removeAnimEventCallback(self.onAnimEvent, self)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)
end

function FightSkinSM_630305CustomComp:onUpdateBuff(entityId, effectType, buffId, buffUid, effect, buff)
	if entityId ~= self.entityId then
		return
	end

	if buffId ~= self.handleBuffId then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self:onAddBuff(buffId)
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		self:onRemoveBuff(buffId)
	end
end

function FightSkinSM_630305CustomComp:onAddBuff(buffId)
	local smCo = lua_fight_sp_sm.configDict[self.skinId]

	smCo = smCo and smCo[buffId]
	smCo = smCo and smCo[Action.Add]

	if not smCo then
		return
	end

	local actionName = smCo.actionName

	self.spine:play(actionName, false, true)

	local curAnimDuration = self:getCurAnimDuration()
	local duration = smCo.duration

	duration = duration > 0 and math.min(duration, curAnimDuration) or curAnimDuration

	TaskDispatcher.runDelay(self.switchToIdle, self, duration)

	FightWorkStepBuff.updateWaitTime = duration

	local audioId = smCo.audioId

	if audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightSkinSM_630305CustomComp:onRemoveBuff(buffId)
	local smCo = lua_fight_sp_sm.configDict[self.skinId]

	smCo = smCo and smCo[buffId]
	smCo = smCo and smCo[Action.Remove]

	if not smCo then
		return
	end

	local actionName = smCo.actionName

	self.spine:play(actionName, false, true)

	local curAnimDuration = self:getCurAnimDuration()
	local duration = smCo.duration

	duration = duration > 0 and math.min(duration, curAnimDuration) or curAnimDuration

	TaskDispatcher.runDelay(self.switchToIdle, self, duration)

	FightWorkStepBuff.updateWaitTime = duration

	local audioId = smCo.audioId

	if audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightSkinSM_630305CustomComp:onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		TaskDispatcher.cancelTask(self.switchToIdle, self)
		self:switchToIdle()
	end
end

function FightSkinSM_630305CustomComp:hasSpecialBuff()
	local buffDict = self.entity:getMO():getBuffDic()

	for _, buffMo in pairs(buffDict) do
		if buffMo.buffId == self.handleBuffId then
			return true
		end
	end

	return false
end

function FightSkinSM_630305CustomComp:switchToIdle()
	local smCo = lua_fight_sp_sm.configDict[self.skinId]

	smCo = smCo and smCo[self.handleBuffId]

	if not smCo then
		return
	end

	smCo = self:hasSpecialBuff() and smCo[Action.Add] or smCo[Action.Remove]

	if not smCo then
		return
	end

	self.spine:play(smCo.nextActionName, true, true)
end

local rejectAnimStates = {
	"hit",
	"freeze",
	"sleep"
}

function FightSkinSM_630305CustomComp:canPlayAnimState(aniState)
	if not self:hasSpecialBuff() then
		return true
	end

	for _, rejectAnimState in ipairs(rejectAnimStates) do
		if aniState == rejectAnimState then
			return false
		end
	end

	return true
end

function FightSkinSM_630305CustomComp:replaceAnimState(aniState)
	if aniState == SpineAnimState.idle1 or aniState == SpineAnimState.idle2 then
		if self:hasSpecialBuff() then
			return SpineAnimState.idle2
		else
			return SpineAnimState.idle1
		end
	end

	return aniState
end

function FightSkinSM_630305CustomComp:getCurAnimDuration()
	local skeletonAnim = self.spine:getSkeletonAnim()

	return skeletonAnim:GetCurAnimDuration() or 0
end

function FightSkinSM_630305CustomComp:onDestroy()
	TaskDispatcher.cancelTask(self.switchToIdle, self)
end

return FightSkinSM_630305CustomComp

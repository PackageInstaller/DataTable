-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightRoleEffect.lua

module("modules.logic.matchgame.fight.view.MatchGameFightRoleEffect", package.seeall)

local MatchGameFightRoleEffect = class("MatchGameFightRoleEffect", LuaCompBase)

function MatchGameFightRoleEffect:ctor(param)
	self.param = param
	self.fightView = param.fightView
	self.goEffectContent = param.goEffectContent
	self.roleAnim = param.roleAnim
end

function MatchGameFightRoleEffect:init(go)
	self:__onInit()

	self.go = go

	self:loadEffect()
end

function MatchGameFightRoleEffect:loadEffect()
	self.heavyDamageEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.HeavyDamage], self.goEffectContent, MatchGameFightEnum.RoleEffectType.HeavyDamage)
	self.normalDamageEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.NormalDamage], self.goEffectContent, MatchGameFightEnum.RoleEffectType.NormalDamage)
	self.cleanEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.Clean], self.goEffectContent, MatchGameFightEnum.RoleEffectType.Clean)
	self.healEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.Heal], self.goEffectContent, MatchGameFightEnum.RoleEffectType.Heal)
	self.lockEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.Lock], self.goEffectContent, MatchGameFightEnum.RoleEffectType.Lock)
	self.poisonEffect = self.fightView.viewContainer:getResInst(self.fightView.viewContainer:getSetting().otherRes[MatchGameFightEnum.RoleEffectType.Poison], self.goEffectContent, MatchGameFightEnum.RoleEffectType.Poison)

	gohelper.setActive(self.heavyDamageEffect, false)
	gohelper.setActive(self.normalDamageEffect, false)
	gohelper.setActive(self.cleanEffect, false)
	gohelper.setActive(self.healEffect, false)
	gohelper.setActive(self.lockEffect, false)
	gohelper.setActive(self.poisonEffect, false)

	self.lockEffectAnim = self.lockEffect:GetComponent(typeof(UnityEngine.Animator))
end

function MatchGameFightRoleEffect:addEventListeners()
	return
end

function MatchGameFightRoleEffect:removeEventListeners()
	return
end

function MatchGameFightRoleEffect:playRoleAnim(animName)
	self.roleAnim:Play(animName, 0, 0)
	self.roleAnim:Update(0)
end

function MatchGameFightRoleEffect:showRoleStateEffect(stateEffect)
	local func = self["show" .. stateEffect .. "Effect"]

	if func then
		func(self)
	end
end

function MatchGameFightRoleEffect:closeRoleStateEffect(stateEffect)
	local func = self["close" .. stateEffect .. "Effect"]

	if func then
		func(self)
	end
end

function MatchGameFightRoleEffect:hideRoleStateEffect(stateEffect)
	local func = self["hide" .. stateEffect .. "Effect"]

	if func then
		func(self)
	end
end

function MatchGameFightRoleEffect:showHeavyDamageEffect()
	TaskDispatcher.cancelTask(self.hideHeavyDamageEffect, self)
	gohelper.setActive(self.heavyDamageEffect, false)
	gohelper.setActive(self.heavyDamageEffect, true)
	TaskDispatcher.runDelay(self.hideHeavyDamageEffect, self, MatchGameFightEnum.RoleEffectTime)
end

function MatchGameFightRoleEffect:hideHeavyDamageEffect()
	gohelper.setActive(self.heavyDamageEffect, false)
end

function MatchGameFightRoleEffect:showNormalDamageEffect()
	TaskDispatcher.cancelTask(self.hideNormalDamageEffect, self)
	gohelper.setActive(self.normalDamageEffect, false)
	gohelper.setActive(self.normalDamageEffect, true)
	TaskDispatcher.runDelay(self.hideNormalDamageEffect, self, MatchGameFightEnum.RoleEffectTime)
end

function MatchGameFightRoleEffect:hideNormalDamageEffect()
	gohelper.setActive(self.normalDamageEffect, false)
end

function MatchGameFightRoleEffect:showCleanEffect()
	TaskDispatcher.cancelTask(self.hideCleanEffect, self)
	gohelper.setActive(self.cleanEffect, false)
	gohelper.setActive(self.cleanEffect, true)
	TaskDispatcher.runDelay(self.hideCleanEffect, self, 1)
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_purify)
end

function MatchGameFightRoleEffect:hideCleanEffect()
	gohelper.setActive(self.cleanEffect, false)
end

function MatchGameFightRoleEffect:showHealEffect()
	TaskDispatcher.cancelTask(self.hideHealEffect, self)
	gohelper.setActive(self.healEffect, false)
	gohelper.setActive(self.healEffect, true)
	TaskDispatcher.runDelay(self.hideHealEffect, self, MatchGameFightEnum.RoleEffectTime)
end

function MatchGameFightRoleEffect:hideHealEffect()
	gohelper.setActive(self.healEffect, false)
end

function MatchGameFightRoleEffect:showLockEffect()
	TaskDispatcher.cancelTask(self.hideLockEffect, self)
	gohelper.setActive(self.lockEffect, false)
	gohelper.setActive(self.lockEffect, true)
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_seal)
end

function MatchGameFightRoleEffect:closeLockEffect()
	self.lockEffectAnim:Play("close", 0, 0)
	self.lockEffectAnim:Update(0)
	TaskDispatcher.runDelay(self.hideLockEffect, self, MatchGameFightEnum.RoleEffectTime)
end

function MatchGameFightRoleEffect:hideLockEffect()
	gohelper.setActive(self.lockEffect, false)
end

function MatchGameFightRoleEffect:showPoisonEffect()
	TaskDispatcher.cancelTask(self.hidePoisonEffect, self)
	gohelper.setActive(self.poisonEffect, false)
	gohelper.setActive(self.poisonEffect, true)
	TaskDispatcher.runDelay(self.hidePoisonEffect, self, MatchGameFightEnum.RoleEffectTime)
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_role_poisoning)
end

function MatchGameFightRoleEffect:hidePoisonEffect()
	gohelper.setActive(self.poisonEffect, false)
end

function MatchGameFightRoleEffect:onDestroy()
	TaskDispatcher.cancelTask(self.hideHeavyDamageEffect, self)
	TaskDispatcher.cancelTask(self.hideNormalDamageEffect, self)
	TaskDispatcher.cancelTask(self.hideCleanEffect, self)
	TaskDispatcher.cancelTask(self.hideHealEffect, self)
	TaskDispatcher.cancelTask(self.hideLockEffect, self)
	TaskDispatcher.cancelTask(self.hidePoisonEffect, self)
end

return MatchGameFightRoleEffect

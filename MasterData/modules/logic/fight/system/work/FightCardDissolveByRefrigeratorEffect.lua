-- chunkname: @modules/logic/fight/system/work/FightCardDissolveByRefrigeratorEffect.lua

module("modules.logic.fight.system.work.FightCardDissolveByRefrigeratorEffect", package.seeall)

local FightCardDissolveByRefrigeratorEffect = class("FightCardDissolveByRefrigeratorEffect", FightWorkItem)

function FightCardDissolveByRefrigeratorEffect:onConstructor(obj)
	self.obj = obj
end

function FightCardDissolveByRefrigeratorEffect:onStart()
	local url = "ui/viewres/fight/fightcardfresheffect.prefab"

	self:com_loadAsset(url, self.onLoadAsset)
	self:cancelFightWorkSafeTimer()
end

function FightCardDissolveByRefrigeratorEffect:onLoadAsset(success, assetItem)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local effect = gohelper.clone(resObj, self.obj.transform.parent.gameObject)

	self.effect = effect

	local effect_out = gohelper.findChild(effect, "effect_out")

	gohelper.setActive(effect_out, true)
	self:com_registTimer(self.hideCard, 0.467)
	self:com_registTimer(self.finishWork, 1.4)
end

function FightCardDissolveByRefrigeratorEffect:hideCard()
	gohelper.setActive(self.obj, false)
end

function FightCardDissolveByRefrigeratorEffect:onDestructor()
	if self.effect then
		gohelper.destroy(self.effect)
	end
end

return FightCardDissolveByRefrigeratorEffect

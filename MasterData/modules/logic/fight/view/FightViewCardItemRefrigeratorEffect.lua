-- chunkname: @modules/logic/fight/view/FightViewCardItemRefrigeratorEffect.lua

module("modules.logic.fight.view.FightViewCardItemRefrigeratorEffect", package.seeall)

local FightViewCardItemRefrigeratorEffect = class("FightViewCardItemRefrigeratorEffect", FightBaseClass)

function FightViewCardItemRefrigeratorEffect:onConstructor(enchantData, viewCardItem)
	self.enchantData = enchantData
	self.viewCardItem = viewCardItem
	self.effectList = {}

	local url = "ui/viewres/fight/fightcardfreshfumo.prefab"

	self:com_loadAsset(url, self.onEffectLoaded)
	self:com_registMsg(FightMsgId.CardRemoveRefrieratorEffect, self.onRemoveEffect)
	self:com_registMsg(FightMsgId.CheckCardRemoveRefrieratorEffect, self.onCheckRemoveEffect)
end

function FightViewCardItemRefrigeratorEffect:onEffectLoaded(success, assetItem)
	if not success then
		return
	end

	if self.initedEffect then
		return
	end

	AudioMgr.instance:trigger(385010)

	local resObj = assetItem:GetResource()

	if self.viewCardItem._lvGOs then
		for level, obj in pairs(self.viewCardItem._lvGOs) do
			local clone = gohelper.clone(resObj, gohelper.findChild(obj, "#cardeffect"))
			local animator = gohelper.onceAddComponent(clone, gohelper.Type_Animator)

			table.insert(self.effectList, animator)

			animator.speed = FightModel.instance:getUISpeed()

			animator:Play("idle", 0, 0)
		end
	end

	self.initedEffect = true
end

function FightViewCardItemRefrigeratorEffect:onCheckRemoveEffect()
	local hasRefrigerator = false

	if self.viewCardItem._cardInfoMO and self.viewCardItem._cardInfoMO.enchants then
		for i, v in ipairs(self.viewCardItem._cardInfoMO.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Refrigerator then
				hasRefrigerator = true
			end
		end
	end

	if hasRefrigerator then
		return
	end

	FightMsgMgr.replyMsg(FightMsgId.CheckCardRemoveRefrieratorEffect, true)
end

function FightViewCardItemRefrigeratorEffect:onRemoveEffect()
	AudioMgr.instance:trigger(385011)

	for _, animator in ipairs(self.effectList) do
		animator.speed = FightModel.instance:getUISpeed()

		animator:Play("close", 0, 0)
	end
end

function FightViewCardItemRefrigeratorEffect:onDestructor()
	for _, animator in ipairs(self.effectList) do
		gohelper.destroy(animator.gameObject)
	end
end

return FightViewCardItemRefrigeratorEffect

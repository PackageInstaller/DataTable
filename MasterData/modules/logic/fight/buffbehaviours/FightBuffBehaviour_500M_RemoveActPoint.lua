-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_500M_RemoveActPoint.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_RemoveActPoint", package.seeall)

local FightBuffBehaviour_500M_RemoveActPoint = class("FightBuffBehaviour_500M_RemoveActPoint", FightBuffBehaviourBase)

function FightBuffBehaviour_500M_RemoveActPoint:onAddBuff(entityId, buffId, buffMo)
	FightModel.instance:setNeedPlay500MRemoveActEffect(true)
	loadAbAsset(self.co.param, true, self.onLoadFinish, self)
end

function FightBuffBehaviour_500M_RemoveActPoint:onLoadFinish(assetItem)
	if not assetItem.IsLoadSuccess then
		return
	end

	local oldAsstet = self.assetItem

	self.assetItem = assetItem

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.goRemoveEffect = gohelper.clone(assetItem:GetResource(self.co.param), self.viewGo)

	gohelper.setActive(self.goRemoveEffect, false)
	FightModel.instance:setRemoveActEffectObj(self)
end

function FightBuffBehaviour_500M_RemoveActPoint:onRemoveBuff(entityId, buffId, buffMo)
	FightModel.instance:setRemoveActEffectObj(nil)
	FightModel.instance:setNeedPlay500MRemoveActEffect(nil)
end

function FightBuffBehaviour_500M_RemoveActPoint:getRemoveEffectGo()
	return self.goRemoveEffect
end

function FightBuffBehaviour_500M_RemoveActPoint:onDestroy()
	if self.assetItem then
		self.assetItem:Release()

		self.assetItem = nil
	end

	removeAssetLoadCb(self.co.param, self.onLoadFinish, self)
	FightModel.instance:setRemoveActEffectObj(nil)
	FightModel.instance:setNeedPlay500MRemoveActEffect(nil)
	FightBuffBehaviour_500M_RemoveActPoint.super.onDestroy(self)
end

return FightBuffBehaviour_500M_RemoveActPoint

-- chunkname: @modules/logic/fight/view/FightToughnessBreakEffect.lua

module("modules.logic.fight.view.FightToughnessBreakEffect", package.seeall)

local FightToughnessBreakEffect = class("FightToughnessBreakEffect", FightBaseClass)

function FightToughnessBreakEffect:onConstructor(viewGO)
	self.viewGO = viewGO
	self.root = gohelper.create2d(viewGO, "FightToughnessBreakEffect")

	self:com_registMsg(FightMsgId.ToughnessBreakEffect, self.onToughnessBreakEffect)
end

function FightToughnessBreakEffect:onToughnessBreakEffect()
	local url = "ui/viewres/fight/fightbreakview.prefab"

	self:com_loadAsset(url, self.onLoadAssetFinish)
end

function FightToughnessBreakEffect:onLoadAssetFinish(success, assetItem)
	if not success then
		return
	end

	local obj = assetItem:GetResource()
	local go = gohelper.clone(obj, self.root)

	AudioMgr.instance:trigger(350043)
	self:com_registTimer(self.releaseEffect, 1, go)
end

function FightToughnessBreakEffect:releaseEffect(go)
	if not go then
		return
	end

	gohelper.destroy(go)
end

function FightToughnessBreakEffect:onDestructor()
	gohelper.destroy(self.root)
end

return FightToughnessBreakEffect

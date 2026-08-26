-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_500M_Progress.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_Progress", package.seeall)

local FightBuffBehaviour_500M_Progress = class("FightBuffBehaviour_500M_Progress", FightBuffBehaviourBase)
local resPath = "ui/viewres/fight/fighttower/fightprogressview.prefab"

function FightBuffBehaviour_500M_Progress:onAddBuff(entityId, buffId, buffMo)
	self.goRoot = gohelper.findChild(self.viewGo, "root/topLeftContent")

	loadAbAsset(resPath, true, self.onLoadFinish, self)
end

function FightBuffBehaviour_500M_Progress:onLoadFinish(assetItem)
	if not assetItem.IsLoadSuccess then
		return
	end

	local oldAsstet = self.assetItem

	self.assetItem = assetItem

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.goProgress = gohelper.clone(assetItem:GetResource(resPath), self.goRoot)
end

function FightBuffBehaviour_500M_Progress:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.goProgress)
end

function FightBuffBehaviour_500M_Progress:onDestroy()
	if self.assetItem then
		self.assetItem:Release()

		self.assetItem = nil
	end

	removeAssetLoadCb(resPath, self.onLoadFinish, self)
	FightBuffBehaviour_500M_Progress.super.onDestroy(self)
end

return FightBuffBehaviour_500M_Progress

-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_500M_BGMask.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_BGMask", package.seeall)

local FightBuffBehaviour_500M_BGMask = class("FightBuffBehaviour_500M_BGMask", FightBuffBehaviourBase)
local bgMaskPath = "ui/viewres/fight/fighttower/fightmaskview.prefab"

function FightBuffBehaviour_500M_BGMask:onAddBuff(entityId, buffId, buffMo)
	self.root = gohelper.findChild(self.viewGo, "root")

	loadAbAsset(bgMaskPath, true, self.onLoadFinish, self)
end

function FightBuffBehaviour_500M_BGMask:onLoadFinish(assetItem)
	if not assetItem.IsLoadSuccess then
		return
	end

	local oldAsstet = self.assetItem

	self.assetItem = assetItem

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.bgMask = gohelper.clone(assetItem:GetResource(bgMaskPath), self.root)
	self.animator = self.bgMask:GetComponent(gohelper.Type_Animator)
	self.simageBg = gohelper.findChildSingleImage(self.bgMask, "stage")

	gohelper.setAsFirstSibling(self.bgMask)
	self:refreshStage()
	self.addEventCb(self, FightController.instance, FightEvent.OnMonsterChange, self.onMonsterChange, self)
end

function FightBuffBehaviour_500M_BGMask:onMonsterChange()
	self:refreshStage()
end

function FightBuffBehaviour_500M_BGMask:refreshStage()
	local curCo = FightHelper.getBossCurStageCo_500M()

	if curCo == self.preCo then
		return
	end

	self.preCo = curCo

	gohelper.setActive(self.bgMask, curCo ~= nil)

	if curCo then
		self.simageBg:UnLoadImage()
		self.simageBg:LoadImage(string.format("singlebg/fight/tower/%s", curCo.param2))
		self.animator:Play("open", 0, 0)
		AudioMgr.instance:trigger(310009)
	end
end

function FightBuffBehaviour_500M_BGMask:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.bgMask)
end

function FightBuffBehaviour_500M_BGMask:onDestroy()
	if self.simageBg then
		self.simageBg:UnLoadImage()
	end

	if self.assetItem then
		self.assetItem:Release()

		self.assetItem = nil
	end

	removeAssetLoadCb(bgMaskPath, self.onLoadFinish, self)
	FightBuffBehaviour_500M_BGMask.super.onDestroy(self)
end

return FightBuffBehaviour_500M_BGMask

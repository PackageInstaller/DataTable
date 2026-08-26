-- chunkname: @modules/logic/fight/view/FightPaTaComposeScoreComp.lua

module("modules.logic.fight.view.FightPaTaComposeScoreComp", package.seeall)

local FightPaTaComposeScoreComp = class("FightPaTaComposeScoreComp", UserDataDispose)
local prefabPath = "ui/viewres/fight/fighttower/fighttowercomposescore.prefab"

function FightPaTaComposeScoreComp:init(goContainer)
	self:__onInit()

	self.goContainer = goContainer
	self.loadDone = false
	self.indicatorId = FightEnum.IndicatorId.TowerCompose
	self.tweenValue = 0

	loadAbAsset(prefabPath, false, self.onLoadCallback, self)
end

function FightPaTaComposeScoreComp:onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self.loadDone = true
		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.instanceGo = gohelper.clone(self._assetItem:GetResource(prefabPath), self.goContainer)
		self.animator = self.instanceGo:GetComponent(gohelper.Type_Animator)
		self.goBg1 = gohelper.findChild(self.instanceGo, "bg1")
		self.goBg2 = gohelper.findChild(self.instanceGo, "bg2")
		self.txtScore = gohelper.findChildText(self.instanceGo, "#num")
		self.simageBg1 = gohelper.findChildSingleImage(self.instanceGo, "bg1")
		self.simageBg2 = gohelper.findChildSingleImage(self.instanceGo, "bg2")

		self:initBg()
		self:refreshBg()
		self:refreshScore()
		self.addEventCb(self, FightController.instance, FightEvent.OnIndicatorChangeByOffset, self.onIndicatorChange, self)
	end
end

function FightPaTaComposeScoreComp:onIndicatorChange(indicatorId, offset)
	if self.indicatorId ~= indicatorId then
		return
	end

	self:tweenScore(offset)
end

function FightPaTaComposeScoreComp:initBg()
	self.simageBg1:LoadImage("singlebg/tower2_singlebg/result/tower_new_igplanesscorebg1.png")
	self.simageBg2:LoadImage("singlebg/tower2_singlebg/result/tower_new_igplanesscorebg2.png")
end

function FightPaTaComposeScoreComp:refreshBg()
	gohelper.setActive(self.goBg1, false)
	gohelper.setActive(self.goBg2, true)
end

function FightPaTaComposeScoreComp:refreshScore()
	local logicValue = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	self:directSetIndicatorValue(logicValue)
end

function FightPaTaComposeScoreComp:directSetIndicatorValue(value)
	self.tweenValue = value
	self.txtScore.text = value
end

function FightPaTaComposeScoreComp:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

FightPaTaComposeScoreComp.TweenDuration = 0.3

function FightPaTaComposeScoreComp:tweenScore(offset)
	self:clearTween()

	local animName = offset > 0 and "leveup" or "sub"

	self.animator:Play(animName, 0, 0)

	local logicValue = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenValue, logicValue, FightPaTaComposeScoreComp.TweenDuration, self.frameCallback, self.doneCallback, self)
end

function FightPaTaComposeScoreComp:frameCallback(value)
	value = math.floor(value)

	self:directSetIndicatorValue(value)
end

function FightPaTaComposeScoreComp:doneCallback()
	self:refreshScore()

	self.tweenId = nil
end

function FightPaTaComposeScoreComp:destroy()
	removeAssetLoadCb(prefabPath, self._onLoadCallback, self)

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	if self.simageBg1 then
		self.simageBg1:UnLoadImage()
	end

	if self.simageBg2 then
		self.simageBg2:UnLoadImage()
	end

	self:clearTween()
	self:__onDispose()
end

return FightPaTaComposeScoreComp

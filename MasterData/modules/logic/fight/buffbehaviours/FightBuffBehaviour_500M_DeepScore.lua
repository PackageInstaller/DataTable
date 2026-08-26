-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_500M_DeepScore.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_DeepScore", package.seeall)

local FightBuffBehaviour_500M_DeepScore = class("FightBuffBehaviour_500M_DeepScore", FightBuffBehaviourBase)
local deepScorePath = "ui/viewres/fight/fighttower/fightdepthview.prefab"

function FightBuffBehaviour_500M_DeepScore:onAddBuff(entityId, buffId, buffMo)
	self.indicatorId = FightEnum.IndicatorId.TowerDeep
	self.loaded = false
	self.goRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DeepScore_500M)

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.DeepScore_500M)

	self.loader = PrefabInstantiate.Create(self.goRoot)

	self.loader:startLoad(deepScorePath, self.onLoadFinish, self)
end

function FightBuffBehaviour_500M_DeepScore:onLoadFinish()
	self.loaded = true
	self.goDeepScore = self.loader:getInstGO()
	self.imageBg = gohelper.findChildImage(self.goDeepScore, "#image_bg")
	self.txtScore = gohelper.findChildText(self.goDeepScore, "#txt_depth")
	self.animLine = gohelper.findChildComponent(self.goDeepScore, "ani_line", gohelper.Type_Animation)
	self.animSwitchBg = gohelper.findChildComponent(self.goDeepScore, "#ani_switch", gohelper.Type_Animation)

	self:refreshScore()
	self.addEventCb(self, FightController.instance, FightEvent.OnTowerDeepChange, self.onTowerDeepChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnMonsterChange, self.onMonsterChange, self)
end

function FightBuffBehaviour_500M_DeepScore:onMonsterChange()
	self:refreshBg()
	self.animSwitchBg:Play()
	self.animLine:Play()
	AudioMgr.instance:trigger(310008)
end

FightBuffBehaviour_500M_DeepScore.Duration = 0.5

function FightBuffBehaviour_500M_DeepScore:onTowerDeepChange(beforeDeep, curDeep)
	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(beforeDeep, curDeep, FightAssistBossScoreView.Duration, self.onFrameCallback, self.onTweenDone, self, nil, EaseType.Linear)
end

function FightBuffBehaviour_500M_DeepScore:onFrameCallback(value)
	self.txtScore.text = string.format("%dM", value)
end

function FightBuffBehaviour_500M_DeepScore:onTweenDone()
	self.tweenId = nil

	self:refreshScore()
end

function FightBuffBehaviour_500M_DeepScore:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function FightBuffBehaviour_500M_DeepScore:refreshBg()
	local co = FightHelper.getBossCurStageCo_500M()

	UISpriteSetMgr.instance:setFightTowerSprite(self.imageBg, co.param3)
end

function FightBuffBehaviour_500M_DeepScore:refreshScore()
	if not self.loaded then
		return
	end

	local data = FightDataHelper.fieldMgr.indicatorDict[self.indicatorId]

	if data then
		if not data.num then
			local curDeep = 0

			self.txtScore.text = string.format("%dM", curDeep)
		end
	end
end

function FightBuffBehaviour_500M_DeepScore:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.goDeepScore)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.DeepScore_500M)
end

function FightBuffBehaviour_500M_DeepScore:onDestroy()
	self:killTween()

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightBuffBehaviour_500M_DeepScore.super.onDestroy(self)
end

return FightBuffBehaviour_500M_DeepScore

-- chunkname: @modules/logic/fight/view/cardeffect/FightCardUniversalAppearEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardUniversalAppearEffect", package.seeall)

local FightCardUniversalAppearEffect = class("FightCardUniversalAppearEffect", BaseWork)
local DownEffectPath = "ui/viewres/fight/ui_effect_dna_a.prefab"

function FightCardUniversalAppearEffect:onStart(context)
	FightCardUniversalAppearEffect.super.onStart(self, context)

	local animTime = 1.2 / FightModel.instance:getUISpeed()
	local cards = FightDataHelper.handCardMgr.handCard
	local handCardItem = context.handCardItemList[#cards]
	local downEffectGO = gohelper.findChild(handCardItem.go, "downEffect") or gohelper.create2d(handCardItem.go, "downEffect")

	self._forAnimGO = gohelper.findChild(handCardItem.go, "foranim")
	self._canvasGroup = gohelper.onceAddComponent(self._forAnimGO, typeof(UnityEngine.CanvasGroup))
	self._canvasGroup.alpha = 0
	self._downEffectLoader = PrefabInstantiate.Create(downEffectGO)

	self._downEffectLoader:startLoad(DownEffectPath, function(_)
		self._tweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._forAnimGO, 0, 1, animTime)
	end)
	TaskDispatcher.runDelay(self._delayDone, self, animTime)
end

function FightCardUniversalAppearEffect:_delayDone()
	self:onDone(true)
end

function FightCardUniversalAppearEffect:clearWork()
	self._forAnimGO = nil

	if not gohelper.isNil(self._canvasGroup) then
		self._canvasGroup.alpha = 1
	end

	self._canvasGroup = nil

	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._downEffectLoader then
		self._downEffectLoader:dispose()
	end

	self._downEffectLoader = nil

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = nil
end

return FightCardUniversalAppearEffect

-- chunkname: @modules/logic/fight/view/cardeffect/FightMyActPointBreakEffect.lua

module("modules.logic.fight.view.cardeffect.FightMyActPointBreakEffect", package.seeall)

local FightMyActPointBreakEffect = class("FightMyActPointBreakEffect", BaseWork)
local removeEffectContainerName = "removeEffectContainer"

function FightMyActPointBreakEffect:onStart(context)
	FightMyActPointBreakEffect.super.onStart(self, context)

	if FightModel.instance:isFinish() then
		self:onDone(true)

		return
	end

	if context.myBreakActPoint == 0 then
		self:onDone(true)

		return
	end

	if not context.myHasDeadEntity then
		local needPlay = FightModel.instance:getNeedPlay500MRemoveActEffect()

		if not needPlay then
			self:onDone(true)

			return
		end

		local cardCount = context.myNowActPoint + context.myBreakActPoint

		for i = 1, cardCount do
			local go = gohelper.findChild(context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. i)

			if go then
				local posX, posY = FightViewPlayCard.calcCardPosX(i, cardCount)

				recthelper.setAnchor(go.transform, posX, posY)
			end
		end

		for i = context.myNowActPoint + 1, cardCount do
			local go = gohelper.findChild(context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. i)

			if go then
				gohelper.setActive(go, true)
				gohelper.setActive(gohelper.findChild(go, "imgEmpty"), false)
				gohelper.setActive(gohelper.findChild(go, "imgMove"), false)
				gohelper.setActive(gohelper.findChild(go, "conversion"), false)

				local removeEffectObj = FightModel.instance:getRemoveActEffectObj()

				if removeEffectObj then
					::label_1_0::

					local var_1_1 = removeEffectObj.getRemoveEffectGo

					if removeEffectObj.getRemoveEffectGo then
						local effectGo = removeEffectObj:getRemoveEffectGo()

						if effectGo then
							local removeEffectContainer = gohelper.findChild(go, removeEffectContainerName)

							removeEffectContainer = removeEffectContainer or gohelper.create2d(go, removeEffectContainerName)

							gohelper.setActive(removeEffectContainer, true)

							effectGo = gohelper.clone(effectGo, removeEffectContainer)

							gohelper.setActive(effectGo, true)

							local curStageCo = FightHelper.getBossCurStageCo_500M()

							if curStageCo then
								if not curStageCo.level then
									local stage = 1

									effectGo = gohelper.findChild(effectGo, string.format("#%s", stage))

									gohelper.setActive(effectGo, true)
									recthelper.setAnchor(effectGo.transform, 0, 0)
								end
							end
						else
							gohelper.setActive(gohelper.findChild(go, "die"), true)

							local effectTimeScale = gohelper.onceAddComponent(go, typeof(ZProj.EffectTimeScale))

							effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())

							local dieAnimation = go:GetComponent(typeof(UnityEngine.Animation))

							if dieAnimation then
								dieAnimation:Play()
							end
						end
					end
				end
			end
		end

		if FightModel.instance:getNeedPlay500MRemoveActEffect() then
			AudioMgr.instance:trigger(310007)
		end

		TaskDispatcher.runDelay(self._delayDone, self, 0.8 / FightModel.instance:getUISpeed())
	end
end

function FightMyActPointBreakEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightMyActPointBreakEffect:_delayDone()
	for i = self.context.myNowActPoint + 1, self.context.myNowActPoint + self.context.myBreakActPoint do
		local go = gohelper.findChild(self.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. i)

		if go then
			gohelper.setActive(gohelper.findChild(go, "die"), false)

			local dieAnimation = go:GetComponent(typeof(UnityEngine.Animation))

			if dieAnimation then
				dieAnimation:Stop()
			end

			gohelper.setActive(go, false)

			local removeEffectContainer = gohelper.findChild(go, removeEffectContainerName)

			gohelper.setActive(removeEffectContainer, false)
			gohelper.destroyAllChildren(removeEffectContainer)
		end
	end

	local cardCount = self.context.myNowActPoint

	for i = 1, cardCount do
		local go = gohelper.findChild(self.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. i)

		if go then
			local posX, posY = FightViewPlayCard.calcCardPosX(i, cardCount)

			recthelper.setAnchor(go.transform, posX, posY)
		end
	end

	self:onDone(true)
end

return FightMyActPointBreakEffect

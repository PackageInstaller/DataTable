-- chunkname: @modules/logic/fight/system/work/FightWorkPlayHideCardCloseAnim.lua

module("modules.logic.fight.system.work.FightWorkPlayHideCardCloseAnim", package.seeall)

local FightWorkPlayHideCardCloseAnim = class("FightWorkPlayHideCardCloseAnim", FightWorkItem)

function FightWorkPlayHideCardCloseAnim:onLogicEnter(cardEndEffectWork)
	self.cardEndEffectWork = cardEndEffectWork
end

FightWorkPlayHideCardCloseAnim.CloseAnimLen = 1
FightWorkPlayHideCardCloseAnim.WaitRefreshCardIconLen = 0.03

function FightWorkPlayHideCardCloseAnim:onStart()
	self.cloneItemList = self.cardEndEffectWork and self.cardEndEffectWork._cloneOperateItemList

	if not self.cloneItemList then
		self:onDone(true)

		return
	end

	local hadAnim = false

	for _, item in ipairs(self.cloneItemList) do
		local go = item.viewGo
		local cardGo = gohelper.findChild(go, "card")
		local hideCardGo = cardGo and gohelper.findChild(cardGo, FightViewCardItem.HideCardVxGoName)

		if hideCardGo and hideCardGo.activeInHierarchy then
			hadAnim = true

			local normal = gohelper.findChild(hideCardGo, "normal")

			if normal and normal.activeInHierarchy then
				local animator = gohelper.findChildComponent(normal, "ani", gohelper.Type_Animator)

				animator:Play("close")
			end

			local bigSkill = gohelper.findChild(hideCardGo, "ultimate")

			if bigSkill and bigSkill.activeInHierarchy then
				local animator = gohelper.findChildComponent(bigSkill, "ani", gohelper.Type_Animator)

				animator:Play("close")
			end
		end
	end

	if not hadAnim then
		self:onDone(true)

		return
	end

	AudioMgr.instance:trigger(310006)
	self:com_registTimer(self.delayRefreshCardIcon, FightWorkPlayHideCardCloseAnim.WaitRefreshCardIconLen)
	self:com_registTimer(self.finishWork, FightWorkPlayHideCardCloseAnim.CloseAnimLen)
end

function FightWorkPlayHideCardCloseAnim:delayRefreshCardIcon()
	for _, item in ipairs(self.cloneItemList) do
		item:refreshCardIcon()
	end
end

return FightWorkPlayHideCardCloseAnim

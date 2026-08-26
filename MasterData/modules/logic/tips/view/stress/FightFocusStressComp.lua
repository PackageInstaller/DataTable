-- chunkname: @modules/logic/tips/view/stress/FightFocusStressComp.lua

module("modules.logic.tips.view.stress.FightFocusStressComp", package.seeall)

local FightFocusStressComp = class("FightFocusStressComp", FightFocusStressCompBase)

function FightFocusStressComp:getUiType()
	return FightNameUIStressMgr.UiType.Normal
end

function FightFocusStressComp:initUI()
	self.stressText = gohelper.findChildText(self.instanceGo, "#txt_stress")
	self.goBlue = gohelper.findChild(self.instanceGo, "blue")
	self.goRed = gohelper.findChild(self.instanceGo, "red")
	self.goBroken = gohelper.findChild(self.instanceGo, "broken")
	self.goStaunch = gohelper.findChild(self.instanceGo, "staunch")
	self.click = gohelper.findChildClickWithDefaultAudio(self.instanceGo, "#go_clickarea")

	self.click:AddClickListener(self.onClickStress, self)
	self:resetGo()

	self.statusDict = self:getUserDataTb_()
	self.statusDict[FightEnum.Status.Positive] = self.goBlue
	self.statusDict[FightEnum.Status.Negative] = self.goRed
end

function FightFocusStressComp:resetGo()
	gohelper.setActive(self.goBlue, false)
	gohelper.setActive(self.goRed, false)
	gohelper.setActive(self.goBroken, false)
	gohelper.setActive(self.goStaunch, false)
end

function FightFocusStressComp:onClickStress()
	if not self.entityMo then
		return
	end

	if self.entityMo.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(self.entityMo:getCO())
	else
		StressTipController.instance:openMonsterStressTip(self.entityMo:getCO())
	end
end

function FightFocusStressComp:refreshStress(entityMo)
	if not self.loaded then
		self.cacheEntityMo = entityMo

		return
	end

	if not entityMo then
		self:hide()

		return
	end

	if not entityMo:hasStress() then
		self:hide()

		return
	end

	self:show()
	self:resetGo()

	self.entityMo = entityMo

	local powerInfo = entityMo:getPowerInfo(FightEnum.PowerType.Stress)

	if powerInfo then
		if not powerInfo.num then
			local curStress = 0

			self.stressText.text = curStress

			local thresholdDict = FightEnum.MonsterId2StressThresholdDict[self.entityMo.modelId]

			self.status = FightHelper.getStressStatus(curStress, thresholdDict)

			if self.status then
				gohelper.setActive(self.status, true)
			end
		end
	end
end

function FightFocusStressComp:destroy()
	self.click:RemoveClickListener()

	self.click = nil

	FightFocusStressComp.super.destroy(self)
end

return FightFocusStressComp

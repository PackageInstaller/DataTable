-- chunkname: @modules/logic/tips/view/stress/FightFocusAct183StressComp.lua

module("modules.logic.tips.view.stress.FightFocusAct183StressComp", package.seeall)

local FightFocusAct183StressComp = class("FightFocusAct183StressComp", FightFocusStressCompBase)

FightFocusAct183StressComp.PrefabPath = FightNameUIStressMgr.PrefabPath

function FightFocusAct183StressComp:getUiType()
	return FightNameUIStressMgr.UiType.Act183
end

function FightFocusAct183StressComp:initUI()
	self.stressText = gohelper.findChildText(self.instanceGo, "#txt_stress")
	self.goYellow = gohelper.findChild(self.instanceGo, "yellow")
	self.goBroken = gohelper.findChild(self.instanceGo, "broken")
	self.click = gohelper.findChildClickWithDefaultAudio(self.instanceGo, "#go_clickarea")

	self.click:AddClickListener(self.onClickStress, self)
end

function FightFocusAct183StressComp:onClickStress()
	if not self.entityMo then
		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if customData then
		local identityList = customData.stressIdentity[self.entityMo.id]

		if identityList then
			StressTipController.instance:openAct183StressTip(identityList)

			return
		end
	end

	local co = self.entityMo:getCO()
	local monsterTemplateCo = co and lua_monster_skill_template.configDict[co.skillTemplate]
	local identityId = monsterTemplateCo and monsterTemplateCo.identity

	if not identityId then
		return
	end

	StressTipController.instance:openAct183StressTip({
		identityId
	})
end

function FightFocusAct183StressComp:refreshStress(entityMo)
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

	self.entityMo = entityMo

	local powerInfo = entityMo:getPowerInfo(FightEnum.PowerType.Stress)

	if powerInfo then
		if not powerInfo.num then
			local curStress = 0

			self.stressText.text = curStress

			gohelper.setActive(self.goYellow, curStress <= StressAct183Behavior.StressThreshold)
			gohelper.setActive(self.goBroken, curStress > StressAct183Behavior.StressThreshold)
		end
	end
end

function FightFocusAct183StressComp:destroy()
	self.click:RemoveClickListener()

	self.click = nil

	FightFocusAct183StressComp.super.destroy(self)
end

return FightFocusAct183StressComp

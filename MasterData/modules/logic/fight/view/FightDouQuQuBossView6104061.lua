-- chunkname: @modules/logic/fight/view/FightDouQuQuBossView6104061.lua

module("modules.logic.fight.view.FightDouQuQuBossView6104061", package.seeall)

local FightDouQuQuBossView6104061 = class("FightDouQuQuBossView6104061", FightBaseView)

function FightDouQuQuBossView6104061:onConstructor(entityData)
	self.entityData = entityData
	self.powerData = self.entityData:getPowerInfo(FightEnum.PowerType.Act191Boss)
end

function FightDouQuQuBossView6104061:onInitView()
	self.normalRoot = gohelper.findChild(self.viewGO, "root/nomal")
	self.rechargeRoot = gohelper.findChild(self.viewGO, "root/recharge")
	self.releasingRoot = gohelper.findChild(self.viewGO, "root/releasing")
	self.numText = gohelper.findChildText(self.viewGO, "root/go_totalTimes/#txt_energy")
	self.numAnimator = gohelper.findChildComponent(self.viewGO, "root/go_totalTimes", gohelper.Type_Animator)
	self.numAddRoot = gohelper.findChild(self.viewGO, "root/go_addNum")
	self.numAddText = gohelper.findChildText(self.viewGO, "root/go_addNum/#txt_num")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#btn_clickarea")
end

function FightDouQuQuBossView6104061:addEvents()
	self:com_registClick(self.click, self.onClick)
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
end

function FightDouQuQuBossView6104061:onClick()
	if not self.config then
		return
	end

	local screenPos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	FightCommonTipController.instance:openCommonView("", self.config.bossDesc, screenPos, nil, nil, -600)
end

function FightDouQuQuBossView6104061:onPowerChange(targetId, powerId, oldValue, newValue)
	if not self.config then
		return
	end

	if powerId ~= FightEnum.PowerType.Act191Boss then
		return
	end

	if targetId ~= self.entityData.id then
		return
	end

	self:refreshUI(newValue - oldValue)
end

function FightDouQuQuBossView6104061:onOpen()
	transformhelper.setLocalScale(self.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchor(self.viewGO.transform, 54, -90)

	local configList = lua_activity191_assist_boss.configList

	self.config = lua_activity191_assist_boss.configList[1]

	for k, config in pairs(configList) do
		if config.skinId == self.entityData.skin then
			self.config = config

			break
		end
	end

	if not self.config then
		self:closeThis()

		return
	end

	self.numAddText.text = ""

	self:refreshUI()
end

function FightDouQuQuBossView6104061:refreshUI(offset)
	self.numText.text = GameUtil.getSubPlaceholderLuaLangTwoParam("▩1%s/▩2%s", self.powerData.num, self.powerData.max)

	if offset then
		gohelper.setActive(self.numAddRoot, true)

		local prefix = offset > 0 and "+" or ""

		self.numAddText.text = prefix .. offset

		self:com_registSingleTimer(self.hideAddNum, 1)
		AudioMgr.instance:trigger(380043)
	end

	local isMax = self.powerData.num >= self.powerData.max

	if not self.lastIsMax and isMax then
		-- block empty
	end

	self.lastIsMax = isMax

	gohelper.setActive(self.normalRoot, not isMax)
	gohelper.setActive(self.rechargeRoot, false)
	gohelper.setActive(self.releasingRoot, isMax)

	if isMax then
		AudioMgr.instance:trigger(380044)
	end
end

function FightDouQuQuBossView6104061:hideAddNum()
	gohelper.setActive(self.numAddRoot, false)
end

return FightDouQuQuBossView6104061

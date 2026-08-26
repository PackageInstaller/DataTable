-- chunkname: @modules/logic/fight/view/FightDouQuQuBossView.lua

module("modules.logic.fight.view.FightDouQuQuBossView", package.seeall)

local FightDouQuQuBossView = class("FightDouQuQuBossView", FightBaseView)

function FightDouQuQuBossView:onInitView()
	self.style1 = gohelper.findChild(self.viewGO, "root/1")
	self.style2 = gohelper.findChild(self.viewGO, "root/2")
	self.style3 = gohelper.findChild(self.viewGO, "root/3")
	self.max1 = gohelper.findChild(self.viewGO, "root/1/max")
	self.max2 = gohelper.findChild(self.viewGO, "root/2/max")
	self.max3 = gohelper.findChild(self.viewGO, "root/3/max")
	self.fill1 = gohelper.findChildImage(self.viewGO, "root/1/#go_progress")
	self.fill2 = gohelper.findChildImage(self.viewGO, "root/2/#go_progress")
	self.fill1.fillAmount = 1
	self.fill2.fillAmount = 1
	self.energyText = gohelper.findChildText(self.viewGO, "root/#txt_energy")
	self.addGO = gohelper.findChild(self.viewGO, "root/go_addNum")
	self.addText = gohelper.findChildText(self.viewGO, "root/go_addNum/#txt_num")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#btn_clickarea")
	self.switch = gohelper.findChild(self.viewGO, "root/switch")

	gohelper.setActive(self.addGO, false)
	gohelper.setActive(self.switch, false)
end

function FightDouQuQuBossView:addEvents()
	self:com_registClick(self.click, self.onClick)
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
end

function FightDouQuQuBossView:onClick()
	if not self.config then
		return
	end

	local screenPos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	FightCommonTipController.instance:openCommonView("", self.config.bossDesc, screenPos, nil, nil, -600)
end

function FightDouQuQuBossView:onPowerChange(targetId, powerId, oldValue, newValue)
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

function FightDouQuQuBossView:onConstructor(entityData)
	self.entityData = entityData
	self.powerData = self.entityData:getPowerInfo(FightEnum.PowerType.Act191Boss)
end

function FightDouQuQuBossView:onOpen()
	transformhelper.setLocalScale(self.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchor(self.viewGO.transform, 54, -90)

	local configList = lua_activity191_assist_boss.configList

	self.config = nil

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

	gohelper.setActive(self.style1, self.config.uiForm == 1)
	gohelper.setActive(self.style2, self.config.uiForm == 2)
	gohelper.setActive(self.style3, self.config.uiForm == 3)

	self.addText.text = ""

	self:refreshUI()
end

function FightDouQuQuBossView:refreshUI(offset)
	self.energyText.text = GameUtil.getSubPlaceholderLuaLangTwoParam("▩1%s/▩2%s", self.powerData.num, self.powerData.max)

	if offset then
		gohelper.setActive(self.addGO, true)

		local prefix = offset > 0 and "+" or ""

		self.addText.text = prefix .. offset

		self:com_registSingleTimer(self.hideAddNum, 1)

		if offset < 0 then
			gohelper.setActive(self.switch, true)
			self:com_registSingleTimer(self.hideSwitch, 2)
			AudioMgr.instance:trigger(411000019)
		else
			AudioMgr.instance:trigger(411000018)
		end
	end

	local isMax = self.powerData.num >= self.powerData.max

	gohelper.setActive(self.max1, isMax)
	gohelper.setActive(self.max2, isMax)
	gohelper.setActive(self.max3, isMax)
end

function FightDouQuQuBossView:hideSwitch()
	gohelper.setActive(self.switch, false)
end

function FightDouQuQuBossView:hideAddNum()
	gohelper.setActive(self.addGO, false)
end

return FightDouQuQuBossView

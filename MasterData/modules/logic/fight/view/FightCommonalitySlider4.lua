-- chunkname: @modules/logic/fight/view/FightCommonalitySlider4.lua

module("modules.logic.fight.view.FightCommonalitySlider4", package.seeall)

local FightCommonalitySlider4 = class("FightCommonalitySlider4", FightBaseView)

function FightCommonalitySlider4:onInitView()
	self.normal = gohelper.findChild(self.viewGO, "normal")
	self.boss = gohelper.findChild(self.viewGO, "boss")
	self.lowRoot = gohelper.findChild(self.viewGO, "boss/unreleased_low")
	self.highRoot = gohelper.findChild(self.viewGO, "boss/unreleased_high")
	self.text = gohelper.findChildText(self.viewGO, "boss/#txt_time")
	self.ani = gohelper.onceAddComponent(self.boss, typeof(UnityEngine.Animator))
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")

	gohelper.setActive(self.normal, false)
	gohelper.setActive(self.boss, true)
end

function FightCommonalitySlider4:onConstructor(root)
	self.fightRoot = root
end

function FightCommonalitySlider4:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.FightProgressValueChange, self._refreshData)
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self._refreshData)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._refreshData)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnInvokeSkill, self.onInvokeSkill)
	self:com_registClick(self.click, self.onClick)
end

function FightCommonalitySlider4:_refreshData()
	local progress = FightDataHelper.fieldMgr.progress
	local max = FightDataHelper.fieldMgr.progressMax
	local curValue = max - progress

	self.text.text = curValue

	if self.lastValue ~= curValue then
		self.ani:Play("refresh", 0, 0)
		AudioMgr.instance:trigger(20280007)
	end

	if self.lastValue == 0 and curValue > 0 then
		self.text.text = 0
	end

	self.lastValue = curValue

	self:switchHighLow()
end

function FightCommonalitySlider4:switchHighLow()
	local isHigh = false
	local vertin = FightDataHelper.entityMgr:getMyVertin()

	if vertin then
		local buffDic = vertin:getBuffDic()

		for k, v in pairs(buffDic) do
			if v.buffId == 110500302 then
				isHigh = true

				break
			end
		end
	end

	gohelper.setActive(self.lowRoot, not isHigh)
	gohelper.setActive(self.highRoot, isHigh)
end

function FightCommonalitySlider4:onSkillPlayStart(entity, skillId, fightStepData, timelineName)
	if timelineName == "610408_fengxue" then
		self.ani:Play("play", 0, 0)
		self:_refreshData()
	end

	if skillId == 110240103 or skillId == 110240104 then
		self:switchHighLow()
	end
end

function FightCommonalitySlider4:onInvokeSkill(fightStepData)
	if fightStepData.skillId == 110240103 or fightStepData.skillId == 110240104 then
		self:switchHighLow()
	end
end

function FightCommonalitySlider4:onClick()
	local skillConfig = lua_skill.configDict[FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]]

	if not skillConfig then
		return
	end

	local title = skillConfig.name
	local desc = FightConfig.instance:getSkillEffectDesc(nil, skillConfig)
	local screenPos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	FightCommonTipController.instance:openCommonView(title, desc, screenPos, nil, nil, -150, -50)
end

function FightCommonalitySlider4:onClose()
	return
end

return FightCommonalitySlider4

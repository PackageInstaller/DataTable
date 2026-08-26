-- chunkname: @modules/logic/fight/view/FightCommonalitySlider3.lua

module("modules.logic.fight.view.FightCommonalitySlider3", package.seeall)

local FightCommonalitySlider3 = class("FightCommonalitySlider3", FightBaseView)

function FightCommonalitySlider3:onInitView()
	self.normal = gohelper.findChild(self.viewGO, "normal")
	self.boss = gohelper.findChild(self.viewGO, "boss")
	self.text = gohelper.findChildText(self.viewGO, "normal/#txt_time")
	self.ani = gohelper.onceAddComponent(self.normal, typeof(UnityEngine.Animator))
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")

	gohelper.setActive(self.normal, true)
	gohelper.setActive(self.boss, false)
end

function FightCommonalitySlider3:onConstructor(root)
	self.fightRoot = root
end

function FightCommonalitySlider3:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.FightProgressValueChange, self._refreshData)
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self._refreshData)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._refreshData)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registClick(self.click, self.onClick)
end

function FightCommonalitySlider3:_refreshData()
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
end

function FightCommonalitySlider3:onSkillPlayStart(entity, skillId, fightStepData, timelineName)
	if timelineName == "buff_hanqiruti" then
		self.ani:Play("play", 0, 0)
		self:_refreshData()
	end
end

function FightCommonalitySlider3:onClick()
	local skillConfig = lua_skill.configDict[FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]]

	if not skillConfig then
		return
	end

	local title = skillConfig.name
	local desc = FightConfig.instance:getSkillEffectDesc(nil, skillConfig)
	local screenPos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	FightCommonTipController.instance:openCommonView(title, desc, screenPos, nil, nil, -150, -50)
end

function FightCommonalitySlider3:onClose()
	return
end

return FightCommonalitySlider3

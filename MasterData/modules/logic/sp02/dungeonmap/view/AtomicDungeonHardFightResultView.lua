-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonHardFightResultView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonHardFightResultView", package.seeall)

local AtomicDungeonHardFightResultView = class("AtomicDungeonHardFightResultView", BaseView)

function AtomicDungeonHardFightResultView:onInitView()
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeView")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Rank")
	self._goalarm = gohelper.findChild(self.viewGO, "#go_alarm")
	self._imagereduceAlarm = gohelper.findChildImage(self.viewGO, "#go_alarm/alarmBar/#image_reduceAlarm")
	self._imagecurAlarm = gohelper.findChildImage(self.viewGO, "#go_alarm/alarmBar/#image_curAlarm")
	self._goconditions = gohelper.findChild(self.viewGO, "#scroll_conditions/Viewport/#go_conditions")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_conditions/Viewport/#go_conditions/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonHardFightResultView:addEvents()
	self._btncloseView:AddClickListener(self._btncloseViewOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
end

function AtomicDungeonHardFightResultView:removeEvents()
	self._btncloseView:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function AtomicDungeonHardFightResultView:_btncloseViewOnClick()
	self:closeThis()
	FightController.onResultViewClose()
end

function AtomicDungeonHardFightResultView:_btnRankOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function AtomicDungeonHardFightResultView:_editableInitView()
	gohelper.setActive(self._txtDesc.gameObject, false)
end

function AtomicDungeonHardFightResultView:onUpdateParam()
	return
end

function AtomicDungeonHardFightResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_death_open)
	NavigateMgr.instance:addEscape(ViewName.AtomicDungeonHardFightResultView, self._onClickClose, self)

	self.fightParam = FightModel.instance:getFightParam()
	self.episodeId = self.fightParam.episodeId
	self.episodeCo = lua_episode.configDict[self.episodeId]
	self.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	self:refreshCondition()
end

function AtomicDungeonHardFightResultView:refreshCondition()
	local conditionCoList = {}
	local additionRule = self.battleCo.additionRule

	if not string.nilorempty(additionRule) then
		for _, rule in ipairs(GameUtil.splitString2(additionRule, true, "|", "#")) do
			table.insert(conditionCoList, rule)
		end
	end

	if self.episodeCo.chapterId == AtomicDungeonEnum.TalentChapterId or self.episodeCo.chapterId == AtomicDungeonEnum.TalentChapterId2 then
		local alarmRuleList = AtomicDungeonModel.instance:getAlarmRuleList()

		tabletool.addValues(conditionCoList, alarmRuleList)
	end

	for i, rule in ipairs(conditionCoList) do
		local targetId = rule[1]
		local ruleId = rule[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			local itemGo = gohelper.clone(self._txtDesc.gameObject, self._goconditions, "item" .. i)
			local txt = itemGo:GetComponent(gohelper.Type_TextMesh)
			local srcDesc = ruleCo.desc
			local descContent = SkillHelper.buildDesc(srcDesc, "#FFFFFF", "#FFFFFF")
			local langStr = luaLang("dungeon_add_rule_target_" .. targetId)

			txt.text = string.format("[%s]%s", langStr, descContent)

			gohelper.setActive(itemGo, true)
		end
	end
end

function AtomicDungeonHardFightResultView:onClose()
	return
end

function AtomicDungeonHardFightResultView:onCloseFinish()
	FightStatModel.instance:clear()
end

function AtomicDungeonHardFightResultView:onDestroyView()
	return
end

return AtomicDungeonHardFightResultView

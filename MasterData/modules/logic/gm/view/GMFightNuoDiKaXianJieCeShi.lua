-- chunkname: @modules/logic/gm/view/GMFightNuoDiKaXianJieCeShi.lua

module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShi", package.seeall)

local GMFightNuoDiKaXianJieCeShi = class("GMFightNuoDiKaXianJieCeShi", FightBaseView)

function GMFightNuoDiKaXianJieCeShi:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnClose")
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnStart")
	self.intputTimeline = gohelper.findChildTextMeshInputField(self.viewGO, "root/inputTimeline")
	self.inputCount = gohelper.findChildTextMeshInputField(self.viewGO, "root/inputCount")
end

function GMFightNuoDiKaXianJieCeShi:addEvents()
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registClick(self.btnClose, self.closeThis)
	self:com_registClick(self.btnStart, self.onClickStart)
	self.intputTimeline:AddOnValueChanged(self.onIntputTimelineChange, self)
	self.inputCount:AddOnValueChanged(self.onInputCountChange, self)
end

function GMFightNuoDiKaXianJieCeShi:onIntputTimelineChange(value)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline, value)
end

function GMFightNuoDiKaXianJieCeShi:onInputCountChange(value)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount, value)
end

function GMFightNuoDiKaXianJieCeShi:onClickStart()
	local entity = FightHelper.getEntity(SkillEditorMgr.instance.cur_select_entity_id)

	if not entity then
		return
	end

	local fightStepData = FightStepData.New(FightDef_pb.FightStep())

	fightStepData.fromId = entity.id
	fightStepData.toId = "0"
	fightStepData.actType = FightEnum.ActType.SKILL
	fightStepData.actId = 0

	if entity:getSide() == FightEnum.EntitySide.MySide then
		if not FightEnum.EntitySide.EnemySide then
			local oppositeSide = FightEnum.EntitySide.MySide
			local enemyList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

			if #enemyList > 0 then
				fightStepData.toId = enemyList[1].id

				local operCount = tonumber(self.inputCount:GetText()) or 0

				for i = 1, operCount do
					local actEffectData = FightActEffectData.New(FightDef_pb.ActEffect())

					actEffectData.targetId = enemyList[math.random(1, #enemyList)].id
					actEffectData.effectType = FightEnum.EffectType.NUODIKARANDOMATTACK
					actEffectData.effectNum = 100
					actEffectData.effectNum1 = FightEnum.EffectType.DAMAGE
					actEffectData.reserveStr = "0#" .. operCount

					table.insert(fightStepData.actEffect, actEffectData)
				end

				for i, v in ipairs(enemyList) do
					local actEffectData = FightActEffectData.New(FightDef_pb.ActEffect())

					actEffectData.targetId = v.id
					actEffectData.effectType = FightEnum.EffectType.NUODIKATEAMATTACK
					actEffectData.effectNum = 200
					actEffectData.effectNum1 = FightEnum.EffectType.DAMAGE

					table.insert(fightStepData.actEffect, actEffectData)
				end
			end

			self:com_sendFightEvent(FightEvent.SetGMViewVisible, false)

			self.fightStepData = fightStepData

			entity.skill:playTimeline(self.intputTimeline:GetText(), fightStepData)
			gohelper.setActive(self.viewGO, false)
		end
	end
end

function GMFightNuoDiKaXianJieCeShi:onSkillPlayFinish(entity, skillId, fightStepData)
	if fightStepData == self.fightStepData then
		self:com_sendFightEvent(FightEvent.SetGMViewVisible, true)
		gohelper.setActive(self.viewGO, true)
	end
end

function GMFightNuoDiKaXianJieCeShi:onOpen()
	PlayerPrefsKey.GMNuoDiKaCeShiTimeline = "GMNuoDiKaCeShiTimeline"
	PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount = "GMNuoDiKaCeShiTimelineEffectCount"

	self.intputTimeline:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline))
	self.inputCount:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount))
end

function GMFightNuoDiKaXianJieCeShi:onDestructor()
	self.intputTimeline:RemoveOnValueChanged()
	self.inputCount:RemoveOnValueChanged()
end

return GMFightNuoDiKaXianJieCeShi

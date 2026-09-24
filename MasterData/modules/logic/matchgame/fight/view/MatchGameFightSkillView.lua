-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightSkillView.lua

module("modules.logic.matchgame.fight.view.MatchGameFightSkillView", package.seeall)

local MatchGameFightSkillView = class("MatchGameFightSkillView", BaseView)

function MatchGameFightSkillView:onInitView()
	self._goTest = gohelper.findChild(self.viewGO, "Test")
	self._inputSkill = gohelper.findChildTextMeshInputField(self.viewGO, "Test/#input_skill")
	self._btnSkillTest1 = gohelper.findChildButtonWithAudio(self.viewGO, "Test/#btn_test1")
	self._btnSkillTest2 = gohelper.findChildButtonWithAudio(self.viewGO, "Test/#btn_test2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameFightSkillView:addEvents()
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnSkillNoneCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnSkillCastCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnMatchCountMoreThanCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnFeverEnterCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnBattleStartCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnTurnStartCondition, self.checkAndExecuteSkill, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnTurnEndCondition, self.onTurnEndCondition, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnRemoveSkillBuff, self.removeSkillBuff, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnChainNumAdd, self.onChainNumAdd, self)
	self._btnSkillTest1:AddClickListener(self._btnSkillTestClick1, self)
	self._btnSkillTest2:AddClickListener(self._btnSkillTestClick2, self)
end

function MatchGameFightSkillView:removeEvents()
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnSkillNoneCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnSkillCastCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnMatchCountMoreThanCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnFeverEnterCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnBattleStartCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnTurnStartCondition, self.checkAndExecuteSkill, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnTurnEndCondition, self.onTurnEndCondition, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnRemoveSkillBuff, self.removeSkillBuff, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.OnChainNumAdd, self.onChainNumAdd, self)
	self._btnSkillTest1:RemoveClickListener()
	self._btnSkillTest2:RemoveClickListener()
end

function MatchGameFightSkillView:_btnSkillTestClick1()
	local textStr = self._inputSkill:GetText() or ""
	local skillId = tonumber(textStr)
	local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(skillId)
	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()
	local curHeroFightMo

	for posIndex, heroFightMo in pairs(heroFightInfoMap) do
		if heroFightMo then
			curHeroFightMo = heroFightMo

			break
		end
	end

	MatchGameFightModel.instance:addPendingSkill(skillConfig, curHeroFightMo)

	local skillExcuteMap = MatchGameFightModel.instance:getSkillExcuteMap()
	local hasExcuteSkillMap = {}

	for skillId, skillData in pairs(skillExcuteMap) do
		for _, skillEffectData in ipairs(skillData.skillEffectList) do
			self:executeSkillEffect(skillEffectData, skillData)

			if skillData.config.skillType == MatchGameFightEnum.SkillActiveType.Active then
				hasExcuteSkillMap[skillId] = true
			end
		end
	end

	for skillId, hasExcute in pairs(hasExcuteSkillMap) do
		if hasExcute then
			MatchGameFightModel.instance:removeExcutedSkill(skillId)
		end
	end
end

function MatchGameFightSkillView:_btnSkillTestClick2()
	local textStr = self._inputSkill:GetText() or ""
	local skillId = tonumber(textStr)
	local skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)

	MatchGameFightModel.instance:addPendingSkill(skillConfig, self.fightView.enemyInfoMo)

	local skillExcuteMap = MatchGameFightModel.instance:getSkillExcuteMap()
	local hasExcuteSkillMap = {}

	for skillId, skillData in pairs(skillExcuteMap) do
		for _, skillEffectData in ipairs(skillData.skillEffectList) do
			self:executeSkillEffect(skillEffectData, skillData)
			logError("执行技能" .. skillId .. "效果：" .. skillData.config.desc)

			if skillData.config.skillType == MatchGameFightEnum.SkillActiveType.Active then
				hasExcuteSkillMap[skillId] = true
			end
		end
	end

	for skillId, hasExcute in pairs(hasExcuteSkillMap) do
		if hasExcute then
			MatchGameFightModel.instance:removeExcutedSkill(skillId)
		end
	end
end

function MatchGameFightSkillView:_editableInitView()
	self.skillBuffMap = self:getUserDataTb_()
	self.pendingEnemyNextRoundBuffList = self:getUserDataTb_()

	gohelper.setActive(self._goTest, false)
end

function MatchGameFightSkillView:onUpdateParam()
	return
end

function MatchGameFightSkillView:onOpen()
	self.fightView = self.viewContainer:getFightView()
	self.sceneView = self.viewContainer:getSceneView()
	self.viewContent = {
		fightView = self.fightView,
		sceneView = self.sceneView,
		skillView = self
	}

	if self.viewParam then
		self.isGM = self.viewParam.isGM or false
	end

	gohelper.setActive(self._goTest, self.isGM)
end

function MatchGameFightSkillView:onOpenFinish()
	return
end

function MatchGameFightSkillView:onTurnEndCondition(params)
	self:checkBuffDurationData(MatchGameFightEnum.BuffDurationType.Round)
	self:removeSecondDurationBuff()
	self:executePendingEnemyNextRoundBuff()
	self:checkAndExecuteSkill(params)
end

function MatchGameFightSkillView:onChainNumAdd()
	self:checkBuffDurationData(MatchGameFightEnum.BuffDurationType.Match)
end

function MatchGameFightSkillView:removeSecondDurationBuff()
	for buffUid, skillBuffMo in pairs(self.skillBuffMap) do
		if skillBuffMo.durationType == MatchGameFightEnum.BuffDurationType.Second then
			skillBuffMo:removeBuff()
		end
	end
end

function MatchGameFightSkillView:checkBuffDurationData(durationType)
	for buffUid, skillBuffMo in pairs(self.skillBuffMap) do
		local removeEnemyRoundBuffAtZero = durationType == MatchGameFightEnum.BuffDurationType.Round and MatchGameFightEnum.EnemyNextRoundBuffEffectIdMap[skillBuffMo.buffEffectId]

		skillBuffMo:setBuffDurationData(durationType, removeEnemyRoundBuffAtZero)
	end
end

function MatchGameFightSkillView:checkAndExecuteSkill(params)
	local hasExcuteSkillMap = {}
	local skillExcuteMap = MatchGameFightModel.instance:getSkillExcuteMap()

	for skillId, skillData in pairs(skillExcuteMap) do
		for skillIndex, skillEffectData in ipairs(skillData.skillEffectList) do
			local isTargetSkillUser = not params.skillUserMo or params.skillUserMo == skillData.skillUserMo

			if isTargetSkillUser and self:checkSkillCondition(skillEffectData.conditionCoDataList, params) then
				local isUseActiveSkill = params.conditionId == MatchGameFightEnum.SkillConditionType.None

				self:executeSkillEffect(skillEffectData, skillData, skillIndex, isUseActiveSkill)

				if skillData.config.skillType == MatchGameFightEnum.SkillActiveType.Active then
					hasExcuteSkillMap[skillId] = true
				end
			end
		end
	end

	for skillId, hasExcute in pairs(hasExcuteSkillMap) do
		if hasExcute then
			MatchGameFightModel.instance:removeExcutedSkill(skillId)
		end
	end
end

function MatchGameFightSkillView:checkSkillCondition(conditionCoDataList, params)
	local canExecute = true

	for _, conditionCoData in ipairs(conditionCoDataList) do
		local conditionId = tonumber(conditionCoData[1])

		if params.conditionId ~= conditionId then
			return false
		end

		if not MatchGameSkillConditionHandler.instance:checkConditionSatisfy(conditionId, conditionCoData, params, self.viewContent) then
			canExecute = false

			break
		end
	end

	return canExecute
end

function MatchGameFightSkillView:getSkillTargetList(targetCoDataList, skillData, skillIndex)
	local targetInfoList = {}

	for index, targetCoData in ipairs(targetCoDataList) do
		if not targetInfoList[index] then
			local targetInfo = {}

			targetInfoList[index].index = index
			targetInfo.targetId, targetInfo.targetData = MatchGameSkillTargetHandler.instance:handleSkillTarget(targetCoData, skillData, self.viewContent, skillIndex)
			targetInfoList[index] = targetInfoList[index]
		end
	end

	return targetInfoList
end

function MatchGameFightSkillView:executeSkillEffect(skillEffectData, skillData, skillIndex, isUseActiveSkill)
	for index, effectCoData in ipairs(skillEffectData.effectCoDataList) do
		if isUseActiveSkill and self:isEnemyNextRoundBuffEffect(effectCoData, skillData) then
			self.pendingEnemyNextRoundBuffList[#self.pendingEnemyNextRoundBuffList + 1] = {
				effectCoData = effectCoData,
				targetCoDataList = skillEffectData.targetCoDataList,
				skillData = skillData,
				skillIndex = skillIndex
			}
		else
			self:executeSingleSkillEffect(effectCoData, skillEffectData.targetCoDataList, skillData, skillIndex)
		end
	end
end

function MatchGameFightSkillView:isEnemyNextRoundBuffEffect(effectCoData, skillData)
	if effectCoData[1] ~= MatchGameFightEnum.SkillEffectType.AddBuff or skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy then
		return false
	end

	local buffConfig = MatchGameFightConfig.instance:getMonsterBuffConfig(effectCoData[2])

	if not buffConfig then
		return false
	end

	local buffEffectId = string.splitToNumber(buffConfig.buffEffect, "#")[1]

	return MatchGameFightEnum.EnemyNextRoundBuffEffectIdMap[buffEffectId]
end

function MatchGameFightSkillView:executeSingleSkillEffect(effectCoData, targetCoDataList, skillData, skillIndex)
	local targetInfoList = self:getSkillTargetList(targetCoDataList, skillData, skillIndex)

	if targetInfoList and #targetInfoList > 0 then
		MatchGameSkillEffectHandler.instance:handleSkillEffect(effectCoData, targetInfoList, skillData, self.viewContent)
	end
end

function MatchGameFightSkillView:executePendingEnemyNextRoundBuff()
	local pendingBuffList = self.pendingEnemyNextRoundBuffList

	self.pendingEnemyNextRoundBuffList = self:getUserDataTb_()

	for _, skillEffectParam in ipairs(pendingBuffList) do
		self:executeSingleSkillEffect(skillEffectParam.effectCoData, skillEffectParam.targetCoDataList, skillEffectParam.skillData, skillEffectParam.skillIndex)
	end
end

function MatchGameFightSkillView:addAndGetSkillBuff(skillData, buffId)
	local skillUserType = skillData.skillUserMo.skillUserType
	local skillUserId = skillData.skillUserMo.id
	local skillId = skillData.skillId
	local skillBuffMo = MatchGameSkillBuffMo.New()
	local initData = {
		skillUserType = skillUserType,
		skillUserId = skillUserId,
		skillId = skillId,
		buffId = buffId
	}

	skillBuffMo:init(initData)

	self.skillBuffMap[skillBuffMo:getBuffUid()] = skillBuffMo

	return skillBuffMo
end

function MatchGameFightSkillView:removeSkillBuff(param)
	local buffUid = param.buffUid
	local skillBuffMo = self.skillBuffMap[buffUid]

	if skillBuffMo then
		MatchGameSkillBuffHandler.instance:revertBuffEffect(skillBuffMo, self.viewContent)
		skillBuffMo:onDestroy()

		self.skillBuffMap[buffUid] = nil
	end
end

function MatchGameFightSkillView:removeAllSkillBuff()
	local skillBuffMap = self.skillBuffMap

	self.skillBuffMap = self:getUserDataTb_()

	for buffUid, skillBuffMo in pairs(skillBuffMap) do
		MatchGameSkillBuffHandler.instance:revertBuffEffect(skillBuffMo, self.viewContent)
		skillBuffMo:onDestroy()
	end
end

function MatchGameFightSkillView:restartGame()
	self:removeAllSkillBuff()

	self.pendingEnemyNextRoundBuffList = self:getUserDataTb_()
end

function MatchGameFightSkillView:onClose()
	self:removeAllSkillBuff()
end

function MatchGameFightSkillView:onDestroyView()
	return
end

return MatchGameFightSkillView

-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightView.lua

module("modules.logic.matchgame.fight.view.MatchGameFightView", package.seeall)

local MatchGameFightView = class("MatchGameFightView", BaseView)

function MatchGameFightView:onInitView()
	self._txtremainRound = gohelper.findChildText(self.viewGO, "root/topInfo/remainRound/#txt_remainRound")
	self._gotargetContent = gohelper.findChild(self.viewGO, "root/topInfo/#go_targetContent")
	self._gotarget1 = gohelper.findChild(self.viewGO, "root/topInfo/#go_targetContent/#go_target1")
	self._gotarget2 = gohelper.findChild(self.viewGO, "root/topInfo/#go_targetContent/#go_target2")
	self._gotarget3 = gohelper.findChild(self.viewGO, "root/topInfo/#go_targetContent/#go_target3")
	self._gotargetItem = gohelper.findChild(self.viewGO, "root/topInfo/#go_targetContent/#go_targetItem")
	self._gochallenge = gohelper.findChild(self.viewGO, "root/topInfo/#go_challenge")
	self._txtchallengeScore = gohelper.findChildText(self.viewGO, "root/topInfo/#go_challenge/#txt_challengeScore")
	self._btninfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/topInfo/#btn_info")
	self._goenemyMesh = gohelper.findChild(self.viewGO, "root/enemy/enemy/ani/#go_enemyMesh")
	self._goenemyFlyEffectPos = gohelper.findChild(self.viewGO, "root/enemy/enemy/ani/#go_enemyFlyEffectPos")
	self._simageenemy = gohelper.findChildSingleImage(self.viewGO, "root/enemy/enemy/ani/#simage_enemy")
	self._imageenemy = gohelper.findChildImage(self.viewGO, "root/enemy/enemy/ani/#simage_enemy")
	self._imageenemyHp = gohelper.findChildImage(self.viewGO, "root/enemy/info/#image_enemyHp")
	self._txtenemyHp = gohelper.findChildText(self.viewGO, "root/enemy/info/#txt_enemyHp")
	self._imageenemyCareer = gohelper.findChildImage(self.viewGO, "root/enemy/info/#image_enemyCareer")
	self._goenemyHurt = gohelper.findChild(self.viewGO, "root/enemy/#go_enemyHurt")
	self._txtenemyHurt = gohelper.findChildText(self.viewGO, "root/enemy/#go_enemyHurt/#txt_enemyHurt")
	self._txtenemyWave = gohelper.findChildText(self.viewGO, "root/enemy/enemyWave/#txt_enemyWave")
	self._goenemyWaveContent = gohelper.findChild(self.viewGO, "root/enemy/enemyWave/#go_enemyWaveContent")
	self._goenemyWaveItem = gohelper.findChild(self.viewGO, "root/enemy/enemyWave/#go_enemyWaveContent/#go_enemyWaveItem")
	self._imageheroHp = gohelper.findChildImage(self.viewGO, "root/hero/hp/#image_heroHp")
	self._txtheroHp = gohelper.findChildText(self.viewGO, "root/hero/hp/#txt_heroHp")
	self._gochain = gohelper.findChild(self.viewGO, "root/hero/#go_chain")
	self._txtchainNum = gohelper.findChildText(self.viewGO, "root/hero/#go_chain/#txt_chainNum")
	self._goheroFightItem = gohelper.findChild(self.viewGO, "root/hero/#go_heroFightItem")
	self._goheroHurt = gohelper.findChild(self.viewGO, "root/hero/#go_heroHurt")
	self._txtheroHurt = gohelper.findChildText(self.viewGO, "root/hero/#go_heroHurt/#txt_heroHurt")
	self._goheroInfoContent = gohelper.findChild(self.viewGO, "root/#go_heroInfoContent")
	self._goheroInfoItem = gohelper.findChild(self.viewGO, "root/#go_heroInfoContent/#go_heroInfoItem")
	self._gograde = gohelper.findChild(self.viewGO, "root/#go_grade")
	self._godamageRate = gohelper.findChild(self.viewGO, "root/#go_damageRate")
	self._txtdamageRate = gohelper.findChildText(self.viewGO, "root/#go_damageRate/#txt_damageRate")
	self._goskillDesc = gohelper.findChild(self.viewGO, "root/#go_skillDesc")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "root/#go_skillDesc/#txt_skillDesc")
	self._goskillDropRate = gohelper.findChild(self.viewGO, "root/#go_skillDropRate")
	self._imageDropRateItem = gohelper.findChildImage(self.viewGO, "root/#go_skillDropRate/#image_item")
	self._goskillFeverDesc = gohelper.findChild(self.viewGO, "root/#go_skillFeverDesc")
	self._txtskillFeverDesc = gohelper.findChildText(self.viewGO, "root/#go_skillFeverDesc/#txt_skillDesc")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._gorestartAnim = gohelper.findChild(self.viewGO, "#go_restartAnim")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameFightView:addEvents()
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.HeroAttackStart, self.heroAttackStart, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.EnemyAttackStart, self.enemyAttackStart, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.RefreshTargetGoal, self.refreshTargetGoal, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.RefreshChallengeScore, self.refreshChallenge, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameFightEvent.RestartGame, self.restartGame, self)
	self._btninfo:AddClickListener(self.onInfoClick, self)
end

function MatchGameFightView:removeEvents()
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.HeroAttackStart, self.heroAttackStart, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.EnemyAttackStart, self.enemyAttackStart, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.RefreshTargetGoal, self.refreshTargetGoal, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.RefreshChallengeScore, self.refreshChallenge, self)
	self.removeEventCb(self, MatchGameController.instance, MatchGameFightEvent.RestartGame, self.restartGame, self)
	self._btninfo:RemoveClickListener()
end

function MatchGameFightView:onInfoClick()
	if self.isHeroSkillShowing then
		return
	end

	local param = {}
	local sceneView = self.viewContainer:getSceneView()
	local gameInfoMo = sceneView and sceneView:getGameInfoMo()

	param.fightData = {
		enemyInfoMo = self.enemyInfoMo,
		curFeverNum = gameInfoMo.curFeverNum,
		maxFeverNum = gameInfoMo.maxFeverNum,
		curHeroTotalHp = self.curHeroTotalHp,
		maxHeroTotalHp = self.maxHeroTotalHp
	}
	param.matchLevelId = self.viewParam.matchLevelId
	param.memberTag = MatchGameFightEnum.MemberInfoTag.Hero

	MatchGameController.instance:openMatchGameMemberInfoView(param)
	sceneView:pauseGame()
end

function MatchGameFightView:_editableInitView()
	self.enemyWaveItemMap = self:getUserDataTb_()
	self.heroInfoItemMap = self:getUserDataTb_()
	self.heroFightItemMap = self:getUserDataTb_()
	self.enemyFightMoList = self:getUserDataTb_()
	self.targetItemMap = self:getUserDataTb_()
	self.gradeItemList = self:getUserDataTb_()
	self.enemyTypeItemList = self:getUserDataTb_()
	self.elementEffectItemList = self:getUserDataTb_()

	gohelper.setActive(self._goenemyWaveItem, false)
	gohelper.setActive(self._goheroInfoItem, false)
	gohelper.setActive(self._goheroFightItem, false)
	gohelper.setActive(self._gochain, false)
	gohelper.setActive(self._gograde, false)
	gohelper.setActive(self._godamageRate, false)
	gohelper.setActive(self._gotargetItem, false)
	gohelper.setActive(self._goenemyHurt, false)
	gohelper.setActive(self._goheroHurt, false)
	gohelper.setActive(self._goskillDesc, false)
	gohelper.setActive(self._goskillDropRate, false)
	gohelper.setActive(self._goskillFeverDesc, false)

	for index = 1, 5 do
		local gradeItem = {}

		gradeItem.go = gohelper.findChild(self._gograde, index)
		gradeItem.anim = gradeItem.go:GetComponent(typeof(UnityEngine.Animator))
		self.gradeItemList[index] = gradeItem
	end

	for career = 1, 6 do
		self.enemyTypeItemList[career] = gohelper.findChild(self.viewGO, "root/enemy/enemy/ani/#enemy_type/" .. career)
	end

	self._goenemyEffectContent = gohelper.findChild(self.viewGO, "root/enemy/enemy/go_effectContent")
	self._enemyAnim = gohelper.findChild(self.viewGO, "root/enemy/enemy"):GetComponent(typeof(UnityEngine.Animator))
	self._goattackFlyItemContent = gohelper.findChild(self.viewGO, "root/#go_attackFlyItemContent")
	self._goattackFlyItem = gohelper.findChild(self.viewGO, "root/#go_attackFlyItemContent/#go_attackFlyItem")
	self._goItemEffectContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_itemEffectContent")
	self._chainAnim = self._gochain:GetComponent(typeof(UnityEngine.Animator))
	self._skillDescAnim = self._goskillDesc:GetComponent(typeof(UnityEngine.Animator))
	self._skillDropRateAnim = self._goskillDropRate:GetComponent(typeof(UnityEngine.Animator))
	self._skillFeverDescAnim = self._goskillFeverDesc:GetComponent(typeof(UnityEngine.Animator))
	self._damageRateAnim = self._godamageRate:GetComponent(typeof(UnityEngine.Animator))
end

function MatchGameFightView:restartGame()
	gohelper.setActive(self._gorestartAnim, false)
	gohelper.setActive(self._gorestartAnim, true)
	TaskDispatcher.cancelTask(self.doRestartGame, self)
	TaskDispatcher.cancelTask(self.hideRestartAnim, self)
	TaskDispatcher.runDelay(self.doRestartGame, self, 0.5)
	TaskDispatcher.runDelay(self.hideRestartAnim, self, 1)
end

function MatchGameFightView:doRestartGame()
	local sceneView = self.viewContainer:getSceneView()
	local skillView = self.viewContainer:getSkillView()

	self:cleanRestartRuntime()

	if sceneView then
		sceneView:cleanRestartRuntime()
	end

	if skillView then
		skillView:restartGame()
	end

	self:clearHeroItems()
	MatchGameFightModel.instance:restartGame(self.viewParam.episodeId)
	self:initData()

	if sceneView then
		sceneView:restartGame()
	end

	self:refreshUI()
	self:initHeroStartBattleSkill()
	self:dispatchBattleStartCondition()
end

function MatchGameFightView:hideRestartAnim()
	gohelper.setActive(self._gorestartAnim, false)
end

function MatchGameFightView:onUpdateParam()
	return
end

function MatchGameFightView:onOpen()
	self:initData()
end

function MatchGameFightView:onOpenFinish()
	self:refreshUI()
	self:initHeroStartBattleSkill()
	TaskDispatcher.cancelTask(self.dispatchBattleStartCondition, self)
	TaskDispatcher.runDelay(self.dispatchBattleStartCondition, self, MatchGameFightEnum.DelayExcuteTalentSkill)
end

function MatchGameFightView:initData()
	self.actId = MatchGameModel.instance:getCurActId()
	self.cureElementCureRate = tonumber(MatchGameConfig.instance:getConstValue(self.actId, MatchGameFightEnum.ConstId.CureElementCureRate))
	self.gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	self.totalRoundCount = self.gameInfoData.gameConfig.maxRound
	self.curRoundCount = 1
	self.totalWaveCount = #self.gameInfoData.enemyCoDataList
	self.curWaveCount = 1
	self.heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()
	self.heroFightInfoList = {}

	for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
		table.insert(self.heroFightInfoList, heroFightMo)
	end

	table.sort(self.heroFightInfoList, function(a, b)
		return a.posIndex < b.posIndex
	end)

	self.curHeroTotalHp = nil
	self.enemyFightMoList = self:getUserDataTb_()

	for waveCount, enemyCoData in ipairs(self.gameInfoData.enemyCoDataList) do
		local enemyFightMo = MatchGameEnemyFightMo.New()

		enemyFightMo:initData(enemyCoData)
		table.insert(self.enemyFightMoList, enemyFightMo)
	end

	self.isChallenge = self.viewParam and self.viewParam.isChallenge
	self.curChallengeScore = 0
	self.maxRoundDamage = 0
	self.roleMaterial = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes[2])
	self.enemyMat = self.enemyMat or UnityEngine.GameObject.Instantiate(self.roleMaterial)
	self.isHeroSkillShowing = false
	self.useSkillInfo = nil
end

function MatchGameFightView:initCurEnemyCoData()
	self.enemyInfoMo = self.enemyFightMoList[self.curWaveCount]
	self.enemyCoData = self.gameInfoData.enemyCoDataList[self.curWaveCount]

	self:initEnemyStartBattleSkill()
end

function MatchGameFightView:getCurEnemyInfoMo()
	return self.enemyInfoMo
end

function MatchGameFightView:initEnemyStartBattleSkill()
	local enemySkillTemplateConfig = self.enemyCoData.skillTemplateConfig
	local enemyActiveSkillList = not string.nilorempty(enemySkillTemplateConfig.activeSkill) and string.splitToNumber(enemySkillTemplateConfig.activeSkill, "#") or {}
	local passiveSkillList = not string.nilorempty(enemySkillTemplateConfig.passiveSkill) and string.splitToNumber(enemySkillTemplateConfig.passiveSkill, "#") or {}

	for _, skillId in ipairs(enemyActiveSkillList) do
		local isContainCondition = MatchGameFightConfig.instance:checkSkillContainCondition(skillId, MatchGameFightEnum.SkillUserType.Enemy, MatchGameFightEnum.SkillConditionType.OnBattleStart)

		if isContainCondition then
			local skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)

			MatchGameFightModel.instance:addPendingSkill(skillConfig, self.enemyInfoMo)
		end
	end

	for _, skillId in ipairs(passiveSkillList) do
		local skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)

		MatchGameFightModel.instance:addPendingSkill(skillConfig, self.enemyInfoMo)
	end
end

function MatchGameFightView:initHeroStartBattleSkill()
	self.firstHeroFightMo = nil

	for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
		if heroFightMo.id ~= 0 and heroFightMo.config then
			local skillId = not string.nilorempty(heroFightMo.config.activeSkillId) and tonumber(heroFightMo.config.activeSkillId) or 0
			local isContainCondition = MatchGameFightConfig.instance:checkSkillContainCondition(skillId, MatchGameFightEnum.SkillUserType.Hero, MatchGameFightEnum.SkillConditionType.OnBattleStart)

			if isContainCondition then
				local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(skillId)

				MatchGameFightModel.instance:addPendingSkill(skillConfig, heroFightMo)
			end

			self.firstHeroFightMo = self.firstHeroFightMo or heroFightMo
		end
	end

	local activeTalentList = MatchGameFightModel.instance:getActiveTalentNodeList()

	for index, nodeConfig in ipairs(activeTalentList) do
		if self:checkTeamCondition(nodeConfig.skillId) then
			local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(nodeConfig.skillId)

			MatchGameFightModel.instance:addPendingSkill(skillConfig, self.firstHeroFightMo)
		end
	end
end

function MatchGameFightView:dispatchBattleStartCondition(skillUserMo)
	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.OnBattleStart,
		skillUserMo = skillUserMo
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnBattleStartCondition, params)
end

function MatchGameFightView:checkTeamCondition(skillId)
	local teamConditionDataList = MatchGameConfig.instance:getTeamConditionData(skillId)

	if teamConditionDataList and next(teamConditionDataList) then
		local heroCareerMap = {}

		for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
			if heroFightMo.id ~= 0 and heroFightMo.config then
				heroCareerMap[heroFightMo.career] = heroCareerMap[heroFightMo.career] or 0
				heroCareerMap[heroFightMo.career] = heroCareerMap[heroFightMo.career] + 1
			end
		end

		for index, teamConditionData in ipairs(teamConditionDataList) do
			if teamConditionData[1] == 0 then
				return true
			end

			local careerNum = teamConditionData[2]
			local careerType = teamConditionData[3]

			if heroCareerMap[careerType] and careerNum <= heroCareerMap[careerType] then
				return true
			end
		end
	end

	return false
end

function MatchGameFightView:refreshUI()
	gohelper.setActive(self._gochallenge, self.isChallenge)
	gohelper.setActive(self._gotargetContent, not self.isChallenge)
	self:refreshHeroFight()
	self:refreshHeroInfo()
	self:refreshWaveUI()
	self:refreshChallenge()
	self:refreshTargetGoal()
	self:refreshRoundInfo()
end

function MatchGameFightView:refreshTargetGoal()
	if self.isChallenge then
		return
	end

	local goalData = MatchGameFightModel.instance:getFightGoalData(self.gameInfoData.mapLevelId)

	if goalData and #goalData.goalList > 0 then
		for index, goalInfo in ipairs(goalData.goalList) do
			local goalTargetItem = self.targetItemMap[index]

			if not goalTargetItem then
				goalTargetItem = {
					goalInfo = goalInfo,
					index = index,
					pos = self["_gotarget" .. index]
				}
				goalTargetItem.go = gohelper.clone(self._gotargetItem, goalTargetItem.pos, "targetItem" .. index)
				goalTargetItem.type = goalInfo[1]
				goalTargetItem.root = gohelper.findChild(goalTargetItem.go, MatchGameFightEnum.TargetGoalTypeNode[goalTargetItem.type])
				goalTargetItem.txtTarget = gohelper.findChildText(goalTargetItem.root, "txt_target")
				goalTargetItem.goStarNormal = gohelper.findChild(goalTargetItem.root, "go_star/go_starNormal")
				goalTargetItem.goStarFinish = gohelper.findChild(goalTargetItem.root, "go_star/go_starFinish")
				goalTargetItem.imageElement = gohelper.findChildImage(goalTargetItem.go, "go_match/image_element")
				goalTargetItem.rootList = {}

				for type, rootNodeName in ipairs(MatchGameFightEnum.TargetGoalTypeNode) do
					local rootNode = gohelper.findChild(goalTargetItem.go, rootNodeName)

					gohelper.setActive(rootNode, type == goalTargetItem.type)
				end

				self.targetItemMap[index] = goalTargetItem
			end

			gohelper.setActive(goalTargetItem.go, true)

			if goalTargetItem.type == MatchGameFightEnum.FightTargetType.MatchElementNum then
				local elementConfig = MatchGameFightConfig.instance:getElementConfig(goalInfo[2])

				UISpriteSetMgr.instance:setMatchGameSprite(goalTargetItem.imageElement, elementConfig.icon)

				local elementNum = MatchGameFightModel.instance:getMatchElementNum(goalTargetItem.goalInfo[2])

				goalTargetItem.txtTarget.text = Mathf.Max(0, goalInfo[3] - elementNum)
			elseif goalTargetItem.type == MatchGameFightEnum.FightTargetType.KillAll then
				goalTargetItem.txtTarget.text = luaLang("matchgame_fight_goal_killAll")
			elseif goalTargetItem.type == MatchGameFightEnum.FightTargetType.RoundNum then
				goalTargetItem.txtTarget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_roundNum"), {
					goalInfo[2]
				})
			end

			self:checkIsGetTargetGoal(goalTargetItem)
			gohelper.setActive(goalTargetItem.goStarFinish, goalTargetItem.isGet)
			gohelper.setActive(goalTargetItem.goStarNormal, not goalTargetItem.isGet)
		end
	end

	for index = #goalData.goalList + 1, #self.targetItemMap do
		if self.targetItemMap[index] and self.targetItemMap[index].go then
			gohelper.setActive(self.targetItemMap[index].go, false)
		end
	end
end

function MatchGameFightView:checkIsGetTargetGoal(goalTargetItem)
	if goalTargetItem.type == MatchGameFightEnum.FightTargetType.KillAll then
		goalTargetItem.isGet = self.enemyInfoMo.hp <= 0 and self.curWaveCount >= self.totalWaveCount
	elseif goalTargetItem.type == MatchGameFightEnum.FightTargetType.RoundNum then
		goalTargetItem.isGet = self.curRoundCount <= goalTargetItem.goalInfo[2]
	elseif goalTargetItem.type == MatchGameFightEnum.FightTargetType.MatchElementNum then
		local elementNum = MatchGameFightModel.instance:getMatchElementNum(goalTargetItem.goalInfo[2])

		goalTargetItem.isGet = elementNum >= goalTargetItem.goalInfo[3]
	end
end

function MatchGameFightView:getTargetGoalData()
	local goalData = {}

	goalData.enemyHp = self.enemyInfoMo.hp
	goalData.curWaveCount = self.curWaveCount
	goalData.totalWaveCount = self.totalWaveCount
	goalData.curRoundCount = self.curRoundCount

	return goalData
end

function MatchGameFightView:getTargetGoalFinishIndexList()
	local finishIndexList = {}

	for index, goalTargetItem in pairs(self.targetItemMap) do
		if goalTargetItem.isGet then
			table.insert(finishIndexList, goalTargetItem.index)
		end
	end

	table.sort(finishIndexList, function(a, b)
		return a < b
	end)

	return finishIndexList
end

function MatchGameFightView:refreshChallenge()
	if not self.isChallenge then
		return
	end

	self.curChallengeScore = 0

	local maxChain = MatchGameFightModel.instance:getMaxChainNum()
	local weakAttackNum = MatchGameFightModel.instance:getWeakAttackNum()
	local totalCureNum = MatchGameFightModel.instance:getTotalCureNum()
	local totalSkillUseNum = MatchGameFightModel.instance:getTotalSkillUseNum()

	self.curChallengeScore = maxChain * MatchGameFightEnum.ScoreRate.MaxChain + weakAttackNum * MatchGameFightEnum.ScoreRate.WeakAttack + totalCureNum * MatchGameFightEnum.ScoreRate.Cure + totalSkillUseNum * MatchGameFightEnum.ScoreRate.SkillUse
	self._txtchallengeScore.text = self.curChallengeScore
end

function MatchGameFightView:refreshWaveUI()
	for index = 1, self.totalWaveCount do
		local item = self.enemyWaveItemMap[index]

		if not item then
			item = {
				go = gohelper.clone(self._goenemyWaveItem, self._goenemyWaveContent, "enemyWaveItem" .. index)
			}
			item.goFinish = gohelper.findChild(item.go, "go_finish")
			item.goNormal = gohelper.findChild(item.go, "go_normal")
			item.goFinal = gohelper.findChild(item.go, "go_final")
			self.enemyWaveItemMap[index] = item
		end

		gohelper.setActive(item.go, true)
		gohelper.setActive(self.enemyWaveItemMap[index].goFinish, index < self.curWaveCount)
		gohelper.setActive(self.enemyWaveItemMap[index].goNormal, index >= self.curWaveCount and index < self.totalWaveCount)
		gohelper.setActive(self.enemyWaveItemMap[index].goFinal, index >= self.totalWaveCount)
	end

	self._txtenemyWave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgame_fight_wave"), GameUtil.getNum2Chinese(self.curWaveCount))

	self:initCurEnemyCoData()
	self:refreshEnemyInfo()
end

function MatchGameFightView:refreshRoundInfo()
	self._txtremainRound.text = string.format("%d/%d", Mathf.Min(self.curRoundCount, self.totalRoundCount), self.totalRoundCount)
end

function MatchGameFightView:setCurRoundCount(roundCount)
	self.curRoundCount = roundCount

	self:refreshRoundInfo()
end

function MatchGameFightView:refreshEnemyInfo()
	self._imageenemyHp.fillAmount = Mathf.Min(self.enemyInfoMo.hp, self.enemyInfoMo.maxHp) / self.enemyInfoMo.maxHp
	self._txtenemyHp.text = self.enemyInfoMo.hp

	UISpriteSetMgr.instance:setMatchGameSprite(self._imageenemyCareer, "icon_career" .. self.enemyInfoMo.career)
	self._simageenemy:LoadImage(self.enemyInfoMo.enemyCoData.config.image, self.setEnemyImageSize, self)

	for index, enemyTypeItem in pairs(self.enemyTypeItemList) do
		gohelper.setActive(enemyTypeItem, index == self.enemyInfoMo.career)
	end

	self.enemyMeshComp = self.enemyMeshComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._goenemyMesh, MatchGameFightRoleMesh)

	self.enemyMeshComp:refreshMesh(self.enemyInfoMo.enemyCoData.config, true)

	self._imageenemy.material = self.enemyMat

	local paramData = {
		fightView = self,
		goEffectContent = self._goenemyEffectContent,
		roleAnim = self._enemyAnim
	}

	self.enemyEffectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goenemyMesh, MatchGameFightRoleEffect, paramData)

	if self.curWaveCount > 1 then
		self:playRoleAnim("born", self.enemyInfoMo.id, true)
	else
		self:playRoleAnim("idle", self.enemyInfoMo.id, true)
	end
end

function MatchGameFightView:setEnemyImageSize()
	ZProj.UGUIHelper.SetImageSize(self._simageenemy.gameObject)
end

function MatchGameFightView:refreshHeroInfo()
	for index, heroFightMo in ipairs(self.heroFightInfoList) do
		local heroInfoItem = self.heroInfoItemMap[index]

		if not heroInfoItem then
			heroInfoItem = {
				go = gohelper.clone(self._goheroInfoItem, self._goheroInfoContent, "heroInfoItem" .. heroFightMo.posIndex),
				heroFightMo = heroFightMo,
				posIndex = heroFightMo.posIndex
			}
			heroInfoItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(heroInfoItem.go, MatchGameFightHeroInfoItem, {
				posIndex = heroFightMo.posIndex,
				fightView = self
			})
			self.heroInfoItemMap[index] = heroInfoItem
		end

		heroInfoItem.heroFightMo = heroFightMo

		heroInfoItem.comp:refreshUI(heroFightMo)
	end
end

function MatchGameFightView:refreshHeroFight(isResetRoundData)
	local needInitHeroTotalHp = self.curHeroTotalHp == nil

	self.maxHeroTotalHp = 0
	self.curHeroTotalHp = self.curHeroTotalHp or 0

	for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
		self.maxHeroTotalHp = self.maxHeroTotalHp + heroFightMo.maxHp

		local heroFightItem = self.heroFightItemMap[posIndex]

		if not heroFightItem then
			heroFightItem = {
				pos = gohelper.findChild(self.viewGO, "root/hero/heroPos/go_pos" .. posIndex)
			}
			heroFightItem.go = gohelper.clone(self._goheroFightItem, heroFightItem.pos, "heroInfoItem" .. posIndex)
			heroFightItem.heroFightMo = heroFightMo
			heroFightItem.posIndex = posIndex
			heroFightItem.goAttackFlyItem = self:createAttackFlyItem()

			local startFlyPos = recthelper.rectToRelativeAnchorPos(heroFightItem.pos.transform.position, self._goattackFlyItemContent.transform)
			local endFlyPos = recthelper.rectToRelativeAnchorPos(self._goenemyFlyEffectPos.transform.position, self._goattackFlyItemContent.transform)
			local paramData = {
				posIndex = posIndex,
				fightView = self,
				goAttackFlyItem = heroFightItem.goAttackFlyItem,
				startFlyPos = startFlyPos,
				endFlyPos = endFlyPos,
				roleMaterial = self.roleMaterial
			}

			heroFightItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(heroFightItem.go, MatchGameFightHeroItem, paramData)
			self.heroFightItemMap[posIndex] = heroFightItem
		end

		heroFightItem.heroFightMo = heroFightMo

		if needInitHeroTotalHp then
			self.curHeroTotalHp = self.curHeroTotalHp + heroFightMo.hp
		end

		heroFightItem.comp:refreshUI(heroFightMo, isResetRoundData)
	end

	self._imageheroHp.fillAmount = Mathf.Min(self.curHeroTotalHp, self.maxHeroTotalHp) / self.maxHeroTotalHp
	self._txtheroHp.text = self.curHeroTotalHp
end

function MatchGameFightView:createAttackFlyItem()
	local flyEffectItem = {}

	flyEffectItem.go = gohelper.clone(self._goattackFlyItem, self._goattackFlyItemContent)
	flyEffectItem.compGO = gohelper.findChild(flyEffectItem.go, "#fly")
	flyEffectItem.comp = flyEffectItem.compGO:GetComponent(typeof(UnityEngine.UI.UIFlying))
	flyEffectItem.flyGO = gohelper.findChild(flyEffectItem.go, "fly_item")

	flyEffectItem.comp:SetFlyItemObj(flyEffectItem.flyGO)

	return flyEffectItem
end

function MatchGameFightView:showChainNum(showState)
	if not showState then
		self._chainAnim:Play("close", 0, 0)
		self._chainAnim:Update(0)
		TaskDispatcher.cancelTask(self.doHideChainNumUI, self)
		TaskDispatcher.runDelay(self.doHideChainNumUI, self, MatchGameFightEnum.HideChainNumUITime)

		return
	end

	if self.lastChainState == nil then
		self.lastChainState = showState
	end

	local lastChainNum = not string.nilorempty(self._txtchainNum.text) and tonumber(self._txtchainNum.text) or 0
	local curChainNum = self:getCurChainNum()

	if not self.lastChainState and showState then
		self._chainAnim:Play("open", 0, 0)
		self._chainAnim:Update(0)
	elseif lastChainNum < curChainNum then
		self._chainAnim:Play("add", 0, 0)
		self._chainAnim:Update(0)
	else
		self._chainAnim:Play("idle", 0, 0)
		self._chainAnim:Update(0)
	end

	self.lastChainState = showState

	gohelper.setActive(self._gochain, true)
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnChainNumAdd)

	self._txtchainNum.text = self:getCurChainNum()
end

function MatchGameFightView:doHideChainNumUI()
	gohelper.setActive(self._gochain, false)
end

function MatchGameFightView:resetRoundData()
	gohelper.setActive(self._gochain, false)
	gohelper.setActive(self._gograde, false)
	gohelper.setActive(self._godamageRate, false)

	for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
		if heroFightMo.id ~= 0 then
			heroFightMo:updateFightInfo({
				damage = 0
			})
		end
	end

	self:refreshHeroFight(true)
end

function MatchGameFightView:heroAttackStart()
	self:cleanEnemyHpBarTween()
	self:cleanHeroAttackSequence()

	self.heroAttackSequence = FlowSequence.New()

	local chainNum = self:getCurChainNum()
	local chainRate, chainIndex = MatchGameFightConfig.instance:getChainRate(self.actId, chainNum)

	gohelper.setActive(self._goattackFlyItemContent, true)

	local originTotalDamage = self:setOriginHeroDamage()

	if chainRate >= 1 and originTotalDamage > 0 then
		self:showDamageRate()

		for index = 1, chainIndex do
			self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.doMultiHeroChainAttack, {
				self,
				index
			}))
			self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.DoMultiHeroChainAttackTime))
		end

		self.heroAttackSequence:addWork(TimerWork.New(Mathf.Max(MatchGameFightEnum.ShowDamageRateTime - chainIndex * MatchGameFightEnum.DoMultiHeroChainAttackTime, 0)))
		self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.doCloseDamageRateAnim, {
			self
		}))
		self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.HideDamageRateTime))
		self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.hideDamageRate, {
			self
		}))
	end

	self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.showGrade, {
		self,
		chainIndex
	}))
	self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.ShowGradeTime))
	self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.doCloseGradeAnim, {
		self,
		chainIndex
	}))
	self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.HideGradeTime))
	self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.hideGrade, {
		self
	}))
	self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.WaitHeroAttackTime))

	for posIndex, heroFightMo in ipairs(self.heroFightInfoList) do
		if heroFightMo.id ~= 0 and heroFightMo.damage > 0 and not heroFightMo.giddyState then
			self.heroAttackSequence:addWork(FunctionWork.New(MatchGameFightView.doHeroAttack, {
				self,
				heroFightMo
			}))
			self.heroAttackSequence:addWork(TimerWork.New(MatchGameFightEnum.EachHeroAttackTime))
		end
	end

	self.heroAttackSequence:registerDoneListener(self.doHeroAttackFinish, self)
	self.heroAttackSequence:start()
end

function MatchGameFightView:setOriginHeroDamage()
	local totalDamage = 0

	for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
		if heroFightItem.heroFightMo.id ~= 0 then
			heroFightItem.originDamage = heroFightItem.heroFightMo.damage
			totalDamage = totalDamage + heroFightItem.originDamage
		end
	end

	return totalDamage
end

function MatchGameFightView:showDamageRate()
	gohelper.setActive(self._godamageRate, true)
end

function MatchGameFightView.doCloseDamageRateAnim(params)
	local self = params[1]

	self._damageRateAnim:Play("close", 0, 0)
	self._damageRateAnim:Update(0)
end

function MatchGameFightView.hideDamageRate(params)
	local self = params[1]

	gohelper.setActive(self._godamageRate, false)
end

function MatchGameFightView.showGrade(params)
	local self, chainIndex = params[1], params[2]

	gohelper.setActive(self._gograde, true)

	for index, gradeItem in pairs(self.gradeItemList) do
		gohelper.setActive(gradeItem.go, index == chainIndex)
	end

	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_comment)
end

function MatchGameFightView.doMultiHeroChainAttack(params)
	local self, chainIndex = params[1], params[2]
	local chainRateDataList = MatchGameFightConfig.instance:getChainRateDataList()

	if chainRateDataList[chainIndex] then
		if not chainRateDataList[chainIndex].rate then
			local chainRate = 0
			local totalHeroDamage = 0

			self._txtdamageRate.text = chainRate

			self._damageRateAnim:Play("add", 0, 0)
			self._damageRateAnim:Update(0)

			for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
				if heroFightItem.heroFightMo.id ~= 0 then
					local damage = heroFightItem.originDamage * chainRate

					damage = self:getTargetDamage(damage)

					heroFightItem.heroFightMo:updateFightInfo({
						damage = damage
					})

					totalHeroDamage = totalHeroDamage + damage
				end
			end

			self.maxRoundDamage = Mathf.Max(self.maxRoundDamage, totalHeroDamage)

			self:refreshHeroFight()
			AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_comment)
		end
	end
end

function MatchGameFightView.doCloseGradeAnim(params)
	local self, chainIndex = params[1], params[2]
	local gradeItem = self.gradeItemList[chainIndex]

	gradeItem.anim:Play("close", 0, 0)
	gradeItem.anim:Update(0)
end

function MatchGameFightView.hideGrade(params)
	local self = params[1]

	gohelper.setActive(self._gograde, false)

	for index, gradeItem in pairs(self.gradeItemList) do
		gohelper.setActive(gradeItem.go, false)
	end
end

function MatchGameFightView:getMatchBeadItemNumMap(elementItemMap, needCheckLock)
	local matchBeadItemNumMap = {}

	for posXIndex, elementMap in pairs(elementItemMap) do
		for posYIndex, elementItem in pairs(elementMap) do
			if elementItem and elementItem.comp and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				local itemCareer = elementItem.comp.itemParam

				if needCheckLock then
					if not elementItem.comp.lockState then
						matchBeadItemNumMap[itemCareer] = matchBeadItemNumMap[itemCareer] or 0
						matchBeadItemNumMap[itemCareer] = matchBeadItemNumMap[itemCareer] + 1
					end
				else
					matchBeadItemNumMap[itemCareer] = matchBeadItemNumMap[itemCareer] or 0
					matchBeadItemNumMap[itemCareer] = matchBeadItemNumMap[itemCareer] + 1
				end
			end
		end
	end

	return matchBeadItemNumMap
end

function MatchGameFightView:updateHeroEnergy(elementItemMap)
	local matchBeadItemNumMap = self:getMatchBeadItemNumMap(elementItemMap, true)

	for itemCareer, matchItemNum in pairs(matchBeadItemNumMap) do
		for posIndex, heroInfoItem in pairs(self.heroInfoItemMap) do
			if heroInfoItem.heroFightMo.id ~= 0 and heroInfoItem.heroFightMo.career == itemCareer then
				local energy = matchItemNum

				heroInfoItem.comp:refreshEnergy(energy)
			end
		end
	end
end

function MatchGameFightView:getCurDragMatchDamage(elementItemMap)
	local totalDamage = 0
	local matchBeadItemNumMap = self:getMatchBeadItemNumMap(elementItemMap, true)

	for itemCareer, matchItemNum in pairs(matchBeadItemNumMap) do
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			if heroFightItem.heroFightMo.id ~= 0 and heroFightItem.heroFightMo.career == itemCareer then
				local damage = self:calculateHeroDamage(heroFightItem.heroFightMo, matchItemNum)

				damage = self:getTargetDamage(damage)
				totalDamage = totalDamage + damage
			end
		end
	end

	return totalDamage
end

function MatchGameFightView:updateHeroDamage(elementItemMap)
	local matchBeadItemNumMap = self:getMatchBeadItemNumMap(elementItemMap, true)

	for itemCareer, matchItemNum in pairs(matchBeadItemNumMap) do
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			if heroFightItem.heroFightMo.id ~= 0 and heroFightItem.heroFightMo.career == itemCareer then
				local damage = self:calculateHeroDamage(heroFightItem.heroFightMo, matchItemNum)

				damage = self:getTargetDamage(damage)

				heroFightItem.heroFightMo:updateFightInfo({
					damage = heroFightItem.heroFightMo.damage + damage
				})
			end
		end
	end

	self:refreshHeroFight()
end

function MatchGameFightView:calculateHeroDamage(heroFightMo, matchItemNum)
	local matchRate = 1 + 0.1 * (matchItemNum - 1)
	local counterRate = MatchGameFightConfig.instance:getCounterRate(heroFightMo.career, self.enemyInfoMo.career)
	local damage = Mathf.Max(1, heroFightMo.attack * (heroFightMo.attackRate + heroFightMo.skillAttackRate) - self.enemyInfoMo.def) * counterRate * matchRate

	damage = self:getTargetDamage(damage)

	return damage
end

function MatchGameFightView:getTargetDamage(damage)
	local targetDamage = damage

	targetDamage = targetDamage > 0 and targetDamage < 1 and 1 or targetDamage <= 0 and 0 or Mathf.Floor(targetDamage)

	return targetDamage
end

function MatchGameFightView:getCurChainNum()
	local sceneView = self.viewContainer:getSceneView()

	return sceneView and sceneView:getCurChainNum() or 0
end

function MatchGameFightView.doHeroAttack(params)
	local self, heroFightMo = params[1], params[2]
	local attack = heroFightMo.damage
	local counterRate = MatchGameFightConfig.instance:getCounterRate(heroFightMo.career, self.enemyInfoMo.career)

	if counterRate > 1 then
		MatchGameFightModel.instance:addWeakAttackNum(1)
	end

	self:playRoleAnim("hit_normal", heroFightMo.id, false)

	local heroFightItem = self.heroFightItemMap[heroFightMo.posIndex]

	heroFightItem.comp:playEffectFlying(attack)
	MatchGameFightModel.instance:addTotalHeroDamage(attack)
end

function MatchGameFightView:doEnemyRealHurt(attack)
	self:cleanEnemyHpBarTween()

	local enemyHurtAnimName = attack >= MatchGameFightEnum.HeroHeavyDamage and "damage_heavy" or "damage_light"

	self:playRoleAnim(enemyHurtAnimName, self.enemyInfoMo.id, true)

	if attack >= MatchGameFightEnum.HeroHeavyDamage then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_hit_critical)
	else
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_hit_ordinary)
	end

	local lastEnemyHp = self.enemyInfoMo.hp

	self.enemyInfoMo.hp = Mathf.Max(0, self.enemyInfoMo.hp - attack)
	self._txtenemyHurt.text = -attack

	self:showEnemyHurt()

	self.enemyHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastEnemyHp, self.enemyInfoMo.hp, MatchGameFightEnum.HpBarChangeTime, self.setEnemyHpAnim, self.doSetEnemyHpAnimFinish, self, nil, EaseType.Linear)
end

function MatchGameFightView:setEnemyHpAnim(value)
	local curEnemyHp = value or self.enemyInfoMo.hp

	self._imageenemyHp.fillAmount = Mathf.Min(curEnemyHp, self.enemyInfoMo.maxHp) / self.enemyInfoMo.maxHp
	self._txtenemyHp.text = Mathf.Ceil(curEnemyHp)
end

function MatchGameFightView:doSetEnemyHpAnimFinish()
	self._imageenemyHp.fillAmount = Mathf.Min(self.enemyInfoMo.hp, self.enemyInfoMo.maxHp) / self.enemyInfoMo.maxHp
	self._txtenemyHp.text = self.enemyInfoMo.hp
end

function MatchGameFightView:doHeroAttackFinish()
	gohelper.setActive(self._goattackFlyItemContent, false)
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.HeroAttackFinish)
end

function MatchGameFightView:showEnemyHurt()
	TaskDispatcher.cancelTask(self.hideEnemyHurt, self)
	gohelper.setActive(self._goenemyHurt, false)
	gohelper.setActive(self._goenemyHurt, true)
	TaskDispatcher.runDelay(self.hideEnemyHurt, self, MatchGameFightEnum.HurtTxtTime)
end

function MatchGameFightView:hideEnemyHurt()
	gohelper.setActive(self._goenemyHurt, false)
end

function MatchGameFightView:showSkillDesc(skillConfig)
	TaskDispatcher.cancelTask(self.hideSkillDesc, self)
	TaskDispatcher.cancelTask(self.playSkillDescCloseAnim, self)

	if skillConfig.skillTextType == MatchGameFightEnum.SkillToastType.SkillDesc then
		gohelper.setActive(self._goskillDesc, true)
		gohelper.setActive(self._goskillDropRate, false)
		gohelper.setActive(self._goskillFeverDesc, false)

		self._txtskillDesc.text = skillConfig.skillText
	elseif skillConfig.skillTextType == MatchGameFightEnum.SkillToastType.DropRate then
		gohelper.setActive(self._goskillDesc, false)
		gohelper.setActive(self._goskillFeverDesc, false)
		gohelper.setActive(self._goskillDropRate, true)
		UISpriteSetMgr.instance:setMatchGameSprite(self._imageDropRateItem, "icon_career" .. skillConfig.skillText)
	elseif skillConfig.skillTextType == MatchGameFightEnum.SkillToastType.FeverDesc then
		gohelper.setActive(self._goskillDesc, false)
		gohelper.setActive(self._goskillDropRate, false)
		gohelper.setActive(self._goskillFeverDesc, true)

		self._txtskillFeverDesc.text = skillConfig.skillText
	else
		gohelper.setActive(self._goskillDesc, false)
		gohelper.setActive(self._goskillDropRate, false)
		gohelper.setActive(self._goskillFeverDesc, false)
	end

	if skillConfig.skillTextType == MatchGameFightEnum.SkillToastType.SkillDesc then
		if not MatchGameFightEnum.SkillDescShowTime then
			local descShowTime = MatchGameFightEnum.DropSkillDescShowTime

			TaskDispatcher.runDelay(self.playSkillDescCloseAnim, self, descShowTime - MatchGameFightEnum.CloseSkillDescTime)
			TaskDispatcher.runDelay(self.hideSkillDesc, self, descShowTime)

			local sceneView = self.viewContainer:getSceneView()

			sceneView:pauseGame()
			AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_bonus)

			self.isHeroSkillShowing = true
		end
	end
end

function MatchGameFightView:playSkillDescCloseAnim()
	if self._goskillDesc.activeSelf then
		self._skillDescAnim:Play("close", 0, 0)
		self._skillDescAnim:Update(0)
	end

	if self._goskillDropRate.activeSelf then
		self._skillDropRateAnim:Play("close", 0, 0)
		self._skillDropRateAnim:Update(0)
	end

	if self._goskillFeverDesc.activeSelf then
		self._skillFeverDescAnim:Play("close", 0, 0)
		self._skillFeverDescAnim:Update(0)
	end
end

function MatchGameFightView:hideSkillDesc()
	gohelper.setActive(self._goskillDesc, false)
	gohelper.setActive(self._goskillDropRate, false)
	gohelper.setActive(self._goskillFeverDesc, false)

	local sceneView = self.viewContainer:getSceneView()

	sceneView:continueGame()

	self.isHeroSkillShowing = false
end

function MatchGameFightView:getHeroSkillShowingState()
	return self.isHeroSkillShowing
end

function MatchGameFightView:enemyAttackStart()
	if self.enemyInfoMo.hp <= 0 then
		self:playRoleAnim("die", self.enemyInfoMo.id, true)
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_death)

		self.curWaveCount = self.curWaveCount + 1

		TaskDispatcher.runDelay(self.finishCurEnemyWave, self, MatchGameFightEnum.RefreshNextWaveTime)

		return
	end

	self.useSkillInfo = self:getCanUseEnemySkill()

	if self.useSkillInfo then
		self.useSkillInfo.curSkillCD = self.useSkillInfo.skillConfig.skillCD

		local skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(self.useSkillInfo.skillId)

		MatchGameFightModel.instance:addPendingSkill(skillConfig, self.enemyInfoMo)

		if not string.nilorempty(skillConfig.skillText) then
			self:showSkillDesc(skillConfig)
			self:playRoleAnim("hit_skill", self.enemyInfoMo.id, true)
			TaskDispatcher.runDelay(self.doEnemySkillAttack, self, MatchGameFightEnum.SkillDescShowTime)
		else
			self:playRoleAnim("hit_skill", self.enemyInfoMo.id, true)
			self:doEnemySkillAttack()
		end
	else
		self:enemyNormalAttack()
	end
end

function MatchGameFightView:finishCurEnemyWave()
	if self.curWaveCount > self.totalWaveCount then
		local sceneView = self.viewContainer:getSceneView()

		sceneView:setGameFightResult(MatchGameFightEnum.FightResult.Succ)
	else
		self:refreshWaveUI()
		self:dispatchBattleStartCondition(self.enemyInfoMo)
	end

	self:doEnemyAttackFinish()
end

function MatchGameFightView:doEnemySkillAttack()
	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.None
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnSkillNoneCondition, params)

	local hasAttackEffect = self:checkSkillHasAttackEffect(self.useSkillInfo.skillConfig)

	if not hasAttackEffect then
		self:doEnemyAttackFinish()
	end
end

function MatchGameFightView:checkSkillHasAttackEffect(skillConfig)
	for index = 1, MatchGameFightEnum.MaxSkillIndex do
		local effectStr = skillConfig["effect" .. index]

		if not string.nilorempty(effectStr) then
			local effectList = GameUtil.splitString2(effectStr, true)

			for _, effectData in ipairs(effectList) do
				if effectData[1] == MatchGameFightEnum.SkillEffectType.Attack then
					return true
				end
			end
		end
	end

	return false
end

function MatchGameFightView:getCanUseEnemySkill()
	local canUseSkillList = {}

	for index, skillInfo in ipairs(self.enemyInfoMo.enemySkillInfoList) do
		if skillInfo.curSkillCD <= 0 then
			table.insert(canUseSkillList, skillInfo)
		end

		if skillInfo.curSkillCD > 0 then
			skillInfo.curSkillCD = skillInfo.curSkillCD - 1
		end
	end

	if canUseSkillList and #canUseSkillList > 0 then
		table.sort(canUseSkillList, function(a, b)
			return a.index < b.index
		end)

		return canUseSkillList[1]
	end
end

function MatchGameFightView:enemyNormalAttack()
	self:playRoleAnim("hit_skill", self.enemyInfoMo.id, true)

	local enemyDamage = self:getEnemyDamage(self:getHeroAverDef())

	self:doEnemyHurtHero(enemyDamage)
end

function MatchGameFightView:onSkillAttackHero(needAttackHeroList, attackRate)
	self.enemyInfoMo:updateFightInfo({
		attackRate = attackRate
	})

	local enemyDamage = self:getEnemyDamage(self:getHeroAverDef(needAttackHeroList))

	self:doEnemyHurtHero(enemyDamage)
end

function MatchGameFightView:getEnemyDamage(averHeroDef)
	local enemyDamage = self.enemyInfoMo.attack * (self.enemyInfoMo.attackRate + self.enemyInfoMo.skillAttackRate) - averHeroDef

	return self:getTargetDamage(enemyDamage)
end

function MatchGameFightView:getHeroAverDef(heroFightMoList)
	local totalHeroDef = 0
	local heroCount = 0

	if heroFightMoList then
		for _, heroFightMo in ipairs(heroFightMoList) do
			if heroFightMo.id ~= 0 then
				totalHeroDef = totalHeroDef + heroFightMo.def
				heroCount = heroCount + 1
			end
		end
	else
		for _, heroFightItem in pairs(self.heroFightItemMap) do
			if heroFightItem.heroFightMo.id ~= 0 then
				totalHeroDef = totalHeroDef + heroFightItem.heroFightMo.def
				heroCount = heroCount + 1
			end
		end
	end

	return (heroCount > 0 or nil) and (totalHeroDef / heroCount or 0)
end

function MatchGameFightView:doEnemyHurtHero(enemyDamage)
	self:cleanHeroHpBarTween()

	local lastHeroTotalHp = self.curHeroTotalHp

	self.curHeroTotalHp = Mathf.Max(0, self.curHeroTotalHp - enemyDamage)

	local heroHurtAnimName = enemyDamage >= MatchGameFightEnum.EnemyHeavyDamage and "damage_heavy" or "damage_light"

	if enemyDamage >= MatchGameFightEnum.EnemyHeavyDamage then
		if not MatchGameFightEnum.RoleEffectType.HeavyDamage then
			local enemyHurtEffectName = MatchGameFightEnum.RoleEffectType.NormalDamage

			if enemyDamage >= MatchGameFightEnum.EnemyHeavyDamage then
				AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_hit_critical)
			else
				AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_hit_ordinary)
			end

			for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
				heroFightItem.comp.roleEffectComp:playRoleAnim(heroHurtAnimName)
				heroFightItem.comp.roleEffectComp:showRoleStateEffect(enemyHurtEffectName)
			end

			self._txtheroHurt.text = self.curHeroTotalHp - lastHeroTotalHp

			self:showHeroHurt()

			self.heroHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastHeroTotalHp, self.curHeroTotalHp, MatchGameFightEnum.HpBarChangeTime, self.doSetHeroHpAnim, self.doSetHeroHpAnimFinish, self, nil, EaseType.Linear)
		end
	end
end

function MatchGameFightView:doSetHeroHpAnim(value)
	local curTotalHeroHp = value or self.curHeroTotalHp

	self._imageheroHp.fillAmount = Mathf.Min(curTotalHeroHp, self.maxHeroTotalHp) / self.maxHeroTotalHp
	self._txtheroHp.text = Mathf.Ceil(curTotalHeroHp)
end

function MatchGameFightView:doSetHeroHpAnimFinish()
	self._imageheroHp.fillAmount = Mathf.Min(self.curHeroTotalHp, self.maxHeroTotalHp) / self.maxHeroTotalHp
	self._txtheroHp.text = self.curHeroTotalHp

	if self.curHeroTotalHp <= 0 then
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			heroFightItem.comp.roleEffectComp:playRoleAnim("die")
		end

		local sceneView = self.viewContainer:getSceneView()

		sceneView:setGameFightResult(MatchGameFightEnum.FightResult.Fail)
		TaskDispatcher.runDelay(self.doEnemyAttackFinish, self, MatchGameFightEnum.HeroAttackTime)
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_death)
	else
		self:doEnemyAttackFinish()
	end
end

function MatchGameFightView:doEnemyAttackFinish()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.EnemyAttackFinish)
	TaskDispatcher.cancelTask(self.checkNotMatchConvertElement, self)
	TaskDispatcher.runDelay(self.checkNotMatchConvertElement, self, MatchGameFightEnum.SkillFinishCheckNotMatchtTime)
end

function MatchGameFightView:checkNotMatchConvertElement()
	local sceneView = self.viewContainer:getSceneView()

	sceneView:checkNotMatchConvertElement(true)
end

function MatchGameFightView:showHeroHurt()
	TaskDispatcher.cancelTask(self.hideHeroHurt, self)
	gohelper.setActive(self._goheroHurt, false)
	gohelper.setActive(self._goheroHurt, true)
	TaskDispatcher.runDelay(self.hideHeroHurt, self, MatchGameFightEnum.HurtTxtTime)
end

function MatchGameFightView:hideHeroHurt()
	gohelper.setActive(self._goheroHurt, false)
end

function MatchGameFightView:doHeroDebuffHurtAnim(elementItemMap)
	local debuffHurtList = {}

	self:cleanHeroDebuffHurtSequence()

	self.heroDebuffHurtSequence = FlowSequence.New()

	for posXIndex, elementMap in pairs(elementItemMap) do
		for posYIndex, elementItem in pairs(elementMap) do
			if elementItem and elementItem.comp and elementItem.comp.poisonState and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				table.insert(debuffHurtList, elementItem.comp.poisonDamageRate)
			end
		end
	end

	for _, damageRate in ipairs(debuffHurtList) do
		self.heroDebuffHurtSequence:addWork(FunctionWork.New(MatchGameFightView.doHeroDebuffHurt, {
			self,
			damageRate
		}))
		self.heroDebuffHurtSequence:addWork(TimerWork.New(MatchGameFightEnum.DebuffHurtTime))
	end

	self.heroDebuffHurtSequence:registerDoneListener(self.doHeroDebuffHurtFinish, self)
	self.heroDebuffHurtSequence:start()
end

function MatchGameFightView.doHeroDebuffHurt(params)
	local self, damageRate = params[1], params[2]
	local poisonDamage = Mathf.Floor(self:getCurHeroTotalHp() * damageRate)

	self:setHeroDebuffHurt(poisonDamage)
end

function MatchGameFightView:doHeroDebuffHurtFinish()
	return
end

function MatchGameFightView:setHeroDebuffHurt(debuffDamage)
	self:cleanHeroHpBarTween()

	local lastHeroTotalHp = self.curHeroTotalHp

	self.curHeroTotalHp = Mathf.Max(0, self.curHeroTotalHp - debuffDamage)

	if debuffDamage > 0 then
		self.heroHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastHeroTotalHp, self.curHeroTotalHp, MatchGameFightEnum.DebuffHurtTime, self.doSetHeroHpAnim, self.doSetHeroDebuffHurtFinish, self, nil, EaseType.Linear)
	end

	for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
		heroFightItem.comp.roleEffectComp:playRoleAnim("hurt")
		heroFightItem.comp.roleEffectComp:showRoleStateEffect(MatchGameFightEnum.RoleEffectType.Poison)
	end

	self._txtheroHurt.text = self.curHeroTotalHp - lastHeroTotalHp

	self:showHeroHurt()
end

function MatchGameFightView:doSetHeroDebuffHurtFinish()
	self._imageheroHp.fillAmount = Mathf.Min(self.curHeroTotalHp, self.maxHeroTotalHp) / self.maxHeroTotalHp
	self._txtheroHp.text = self.curHeroTotalHp
end

function MatchGameFightView:onSkillCureHero(needCureHeroList, cureRate)
	self:cleanHeroHpBarTween()

	local totalHeal = 0

	for posIndex, heroFightMo in ipairs(needCureHeroList) do
		totalHeal = totalHeal + heroFightMo.heal
	end

	local healHp = Mathf.Floor(totalHeal * cureRate)

	MatchGameFightModel.instance:addTotalCureNum(healHp)

	local lastHeroTotalHp = self.curHeroTotalHp

	self.curHeroTotalHp = Mathf.Min(self.maxHeroTotalHp, self.curHeroTotalHp + healHp)
	self.heroHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastHeroTotalHp, self.curHeroTotalHp, MatchGameFightEnum.HpBarChangeTime, self.doSetHeroHpAnim, self.doCureHeroHpAnimFinish, self, nil, EaseType.Linear)

	for index, heroFightMo in pairs(needCureHeroList) do
		local heroFightItem = self.heroFightItemMap[heroFightMo.posIndex]

		heroFightItem.comp.roleEffectComp:showRoleStateEffect(MatchGameFightEnum.RoleEffectType.Heal)
	end

	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_treat)
end

function MatchGameFightView:onCureElementCureHero()
	self:cleanHeroHpBarTween()

	local totalHeal = 0

	for posIndex, heroFightMo in pairs(self.heroFightInfoMap) do
		totalHeal = totalHeal + heroFightMo.heal
	end

	local healHp = Mathf.Floor(totalHeal * self.cureElementCureRate)

	MatchGameFightModel.instance:addTotalCureNum(healHp)

	local lastHeroTotalHp = self.curHeroTotalHp

	self.curHeroTotalHp = Mathf.Min(self.maxHeroTotalHp, self.curHeroTotalHp + healHp)
	self.heroHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastHeroTotalHp, self.curHeroTotalHp, MatchGameFightEnum.HpBarChangeTime, self.doSetHeroHpAnim, self.doCureHeroHpAnimFinish, self, nil, EaseType.Linear)

	for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
		heroFightItem.comp.roleEffectComp:showRoleStateEffect(MatchGameFightEnum.RoleEffectType.Heal)
	end
end

function MatchGameFightView:doCureHeroHpAnimFinish()
	self._imageheroHp.fillAmount = Mathf.Min(self.curHeroTotalHp, self.maxHeroTotalHp) / self.maxHeroTotalHp
	self._txtheroHp.text = self.curHeroTotalHp
end

function MatchGameFightView:doCureEnemy(enemyInfoMo, cureRate)
	if enemyInfoMo.id ~= self.enemyInfoMo.id then
		return
	end

	self:cleanEnemyHpBarTween()
	self:showRoleEffect(MatchGameFightEnum.RoleEffectType.Heal, self.enemyInfoMo.id, true)

	local healHp = Mathf.Floor(self.enemyInfoMo.heal * cureRate)
	local lastEnemyHp = self.enemyInfoMo.hp

	self.enemyInfoMo.hp = Mathf.Min(self.enemyInfoMo.maxHp, self.enemyInfoMo.hp + healHp)
	self.enemyHpBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastEnemyHp, self.enemyInfoMo.hp, MatchGameFightEnum.HpBarChangeTime, self.setEnemyHpAnim, self.doSetEnemyHpAnimFinish, self, nil, EaseType.Linear)

	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_treat)
end

function MatchGameFightView:showRoleEffect(effectName, roleId, isEnemy)
	if isEnemy then
		if roleId == self.enemyInfoMo.id then
			self.enemyEffectComp:showRoleStateEffect(effectName)
		end
	else
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			if roleId == heroFightItem.heroFightMo.id then
				heroFightItem.comp.roleEffectComp:showRoleStateEffect(effectName)
			end
		end
	end
end

function MatchGameFightView:closeRoleEffect(effectName, roleId, isEnemy)
	if isEnemy then
		if roleId == self.enemyInfoMo.id then
			self.enemyEffectComp:closeRoleStateEffect(effectName)
		end
	else
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			if roleId == heroFightItem.heroFightMo.id then
				heroFightItem.comp.roleEffectComp:closeRoleStateEffect(effectName)
			end
		end
	end
end

function MatchGameFightView:playRoleAnim(animName, roleId, isEnemy)
	if isEnemy then
		if roleId == self.enemyInfoMo.id then
			self.enemyEffectComp:playRoleAnim(animName)
		end
	else
		for posIndex, heroFightItem in pairs(self.heroFightItemMap) do
			if roleId == heroFightItem.heroFightMo.id then
				heroFightItem.comp.roleEffectComp:playRoleAnim(animName)
			end
		end
	end
end

function MatchGameFightView:playHeroInfoItemLockAnim(roleId)
	for posIndex, heroFightItem in pairs(self.heroInfoItemMap) do
		if roleId == heroFightItem.heroFightMo.id then
			heroFightItem.comp:playLockAnim()
		end
	end
end

function MatchGameFightView:closeHeroInfoItemLockAnim(roleId)
	for posIndex, heroFightItem in pairs(self.heroInfoItemMap) do
		if roleId == heroFightItem.heroFightMo.id then
			heroFightItem.comp:closeLockAnim()
		end
	end
end

function MatchGameFightView:getEffectItem()
	for index, effectItem in ipairs(self.elementEffectItemList) do
		if not effectItem.isActive then
			effectItem.isActive = true

			return effectItem
		end
	end

	local effectItem = self:createEffectItem()

	effectItem.isActive = true

	return effectItem
end

function MatchGameFightView:createEffectItem()
	local effectItem = {}

	effectItem.go = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], self._goItemEffectContent, "ItemEffect")
	effectItem.effectMap = {}

	for effectType, type in pairs(MatchGameFightEnum.ItemMatchEffect) do
		local effectGO = gohelper.findChild(effectItem.go, type)

		if effectGO then
			effectItem.effectMap[type] = effectGO
		end
	end

	effectItem.isActive = false

	function effectItem.recycleCb()
		self:recycleEffectItem(effectItem)
	end

	table.insert(self.elementEffectItemList, effectItem)

	return effectItem
end

function MatchGameFightView:showElementEffect(effectType, posXIndex, posYIndex, scale)
	local effectItem = self:getEffectItem()

	gohelper.setActive(effectItem.go, true)

	for type, effectGO in pairs(effectItem.effectMap) do
		gohelper.setActive(effectGO, false)

		local canShow = type == effectType

		gohelper.setActive(effectGO, canShow)
	end

	if effectType == MatchGameFightEnum.ItemMatchEffect.Heal then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_treat)
	elseif effectType == MatchGameFightEnum.ItemMatchEffect.Cleanse then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_purify)
	elseif effectType == MatchGameFightEnum.ItemMatchEffect.Bomb then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_explode)
	elseif effectType == MatchGameFightEnum.ItemMatchEffect.MatchAoe then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_xiaochu_bubble)
	elseif effectType == MatchGameFightEnum.ItemMatchEffect.MatchLine then
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_xiaochu_ribbon)
	end

	local posX, posY = MatchGameFightModel.instance:getPlaneItemAnchorPos(posXIndex, posYIndex)

	recthelper.setAnchor(effectItem.go.transform, posX, posY)

	local effectScale = scale or 1

	transformhelper.setLocalScale(effectItem.go.transform, effectScale, effectScale, effectScale)
	TaskDispatcher.cancelTask(effectItem.recycleCb, effectItem)
	TaskDispatcher.runDelay(effectItem.recycleCb, effectItem, (effectType == MatchGameFightEnum.ItemMatchEffect.SkillAoe or effectType == MatchGameFightEnum.ItemMatchEffect.SkillLineH or effectType == MatchGameFightEnum.ItemMatchEffect.SkillLineV or nil) and MatchGameFightEnum.ElementItemRangeEffectRecycleTime)

	return effectItem
end

function MatchGameFightView:recycleEffectItem(effectItem)
	TaskDispatcher.cancelTask(effectItem.recycleCb, effectItem)

	effectItem.isActive = false

	for type, effectGO in pairs(effectItem.effectMap) do
		gohelper.setActive(effectGO, false)
	end

	gohelper.setActive(effectItem.go, false)
end

function MatchGameFightView:recycleAllEffectItem()
	for index, effectItem in ipairs(self.elementEffectItemList) do
		self:recycleEffectItem(effectItem)
	end
end

function MatchGameFightView:getCurHeroTotalHp()
	return self.curHeroTotalHp
end

function MatchGameFightView:skillAddCurHeroTotalHp(value)
	self.curHeroTotalHp = self.curHeroTotalHp + value
end

function MatchGameFightView:getIsRoundEnding()
	local sceneView = self.viewContainer:getSceneView()

	return sceneView:getIsRoundEnding()
end

function MatchGameFightView:cleanEnemyHpBarTween()
	if self.enemyHpBarTweenId then
		ZProj.TweenHelper.KillById(self.enemyHpBarTweenId)

		self.enemyHpBarTweenId = nil
	end
end

function MatchGameFightView:cleanHeroAttackSequence()
	if self.heroAttackSequence then
		self.heroAttackSequence:unregisterDoneListener(self.doHeroAttackFinish, self)
		self.heroAttackSequence:destroy()

		self.heroAttackSequence = nil
	end
end

function MatchGameFightView:cleanHeroHpBarTween()
	if self.heroHpBarTweenId then
		ZProj.TweenHelper.KillById(self.heroHpBarTweenId)

		self.heroHpBarTweenId = nil
	end
end

function MatchGameFightView:cleanHeroDebuffHurtSequence()
	if self.heroDebuffHurtSequence then
		self.heroDebuffHurtSequence:unregisterDoneListener(self.doHeroDebuffHurtFinish, self)
		self.heroDebuffHurtSequence:destroy()

		self.heroDebuffHurtSequence = nil
	end
end

function MatchGameFightView:cleanRestartRuntime()
	self:cleanHeroAttackSequence()
	self:cleanEnemyHpBarTween()
	self:cleanHeroHpBarTween()
	self:cleanHeroDebuffHurtSequence()
	TaskDispatcher.cancelTask(self.doHideChainNumUI, self)
	TaskDispatcher.cancelTask(self.hideEnemyHurt, self)
	TaskDispatcher.cancelTask(self.hideHeroHurt, self)
	TaskDispatcher.cancelTask(self.hideSkillDesc, self)
	TaskDispatcher.cancelTask(self.doEnemySkillAttack, self)
	TaskDispatcher.cancelTask(self.doEnemyAttackFinish, self)
	TaskDispatcher.cancelTask(self.finishCurEnemyWave, self)
	TaskDispatcher.cancelTask(self.playSkillDescCloseAnim, self)
	TaskDispatcher.cancelTask(self.dispatchBattleStartCondition, self)
	TaskDispatcher.cancelTask(self.doRestartGame, self)
	TaskDispatcher.cancelTask(self.hideRestartAnim, self)
	TaskDispatcher.cancelTask(self.checkNotMatchConvertElement, self)
	self:recycleAllEffectItem()
	gohelper.setActive(self._goattackFlyItemContent, false)
	gohelper.setActive(self._gochain, false)
	gohelper.setActive(self._gograde, false)
	gohelper.setActive(self._godamageRate, false)
	gohelper.setActive(self._goenemyHurt, false)
	gohelper.setActive(self._goheroHurt, false)
	gohelper.setActive(self._goskillDesc, false)
	gohelper.setActive(self._goskillDropRate, false)
	gohelper.setActive(self._goclickMask, false)

	self.lastChainState = nil
	self.useSkillInfo = nil
	self.firstHeroFightMo = nil
	self.isHeroSkillShowing = false
end

function MatchGameFightView:clearHeroItems()
	for _, heroInfoItem in pairs(self.heroInfoItemMap) do
		if heroInfoItem.go then
			gohelper.destroy(heroInfoItem.go)
		end
	end

	for _, heroFightItem in pairs(self.heroFightItemMap) do
		if heroFightItem.goAttackFlyItem and heroFightItem.goAttackFlyItem.go then
			gohelper.destroy(heroFightItem.goAttackFlyItem.go)
		end

		if heroFightItem.go then
			gohelper.destroy(heroFightItem.go)
		end
	end

	self.heroInfoItemMap = self:getUserDataTb_()
	self.heroFightItemMap = self:getUserDataTb_()
end

function MatchGameFightView:onClose()
	self:cleanRestartRuntime()
	self._simageenemy:UnLoadImage()
end

function MatchGameFightView:onDestroyView()
	self:recycleAllEffectItem()

	if self.enemyMat then
		UnityEngine.Object.Destroy(self.enemyMat)
	end
end

return MatchGameFightView

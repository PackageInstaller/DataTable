-- chunkname: @modules/logic/fight/view/preview/SkillEditorSideView.lua

module("modules.logic.fight.view.preview.SkillEditorSideView", package.seeall)

local SkillEditorSideView = class("SkillEditorSideView", BaseView)

SkillEditorSideView.isCrit = false

function SkillEditorSideView:ctor(side)
	self._side = side

	if side == FightEnum.EntitySide.MySide then
		self._oppositeSide = FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	end

	if self._side == FightEnum.EntitySide.MySide then
		self._attackerTag = SceneTag.UnitPlayer or SceneTag.UnitMonster
	end

	if self._side == FightEnum.EntitySide.MySide then
		self._oppositeTag = SceneTag.UnitMonster or SceneTag.UnitPlayer
	end

	self._isPlayingSkill = false
end

function SkillEditorSideView:onInitView()
	local goPath = self._side == FightEnum.EntitySide.MySide and "right" or "left"
	local go = gohelper.findChild(self.viewGO, goPath)

	self._toggleCrit = gohelper.findChildToggle(self.viewGO, "scene/goToggleRoot/toggleCrit")
	self._txtToggleCrit = gohelper.findChildText(self.viewGO, "scene/goToggleRoot/toggleCrit/Text")
	self._btnSelectSkill = SLFramework.UGUI.ButtonWrap.GetWithPath(go, "btnSelectSkill")
	self._btnFight = SLFramework.UGUI.ButtonWrap.GetWithPath(go, "btnFight")
	self._txtHero = gohelper.findChildText(go, "btnSelectHero/Text")
	self._skillSelectView = SkillEditorSkillSelectView.New()

	self._skillSelectView:init(go)
	self._skillSelectView:hide()

	self._scene = GameSceneMgr.instance:getCurScene()

	local attacker = FightGameMgr.entityMgr:getEntityByPosId(self._attackerTag, 1)

	if attacker then
		self._skillSelectView:setAttacker(attacker.id)
	end

	self:_updateBtnName()
end

function SkillEditorSideView:onDestroyView()
	self._skillSelectView:dispose()
end

function SkillEditorSideView:addEvents()
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSelectEntity, self._onSelectEntity, self)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSubHeroEnter, self._onSubheroEnter, self)
	self._toggleCrit:AddOnValueChanged(self._onToggleChanged, self)
	self._btnSelectSkill:AddClickListener(self._onClickSelectSkill, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
end

function SkillEditorSideView:removeEvents()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSelectEntity, self._onSelectEntity, self)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSubHeroEnter, self._onSubheroEnter, self)
	self._toggleCrit:RemoveOnValueChanged()
	self._btnSelectSkill:RemoveClickListener()
	self._btnFight:RemoveClickListener()
end

function SkillEditorSideView:_onToggleChanged(param, isOn)
	SkillEditorSideView.isCrit = isOn
	self._txtToggleCrit.text = isOn and "暴击" or "普攻"
end

function SkillEditorSideView:_onSelectEntity(side, target_id)
	if side == self._side then
		self:_onPlayFinish()

		local entityMOs = FightDataHelper.entityMgr:getNormalList(self._side)
		local change = target_id or entityMOs and entityMOs[1]

		if change then
			self._skillSelectView:setAttacker(target_id or entityMOs[1].id)
		end
	end

	self:_updateBtnName()
end

function SkillEditorSideView:_onSubheroEnter(target_id)
	self:_onSelectEntity(FightEnum.EntitySide.MySide, target_id)
end

function SkillEditorSideView:_updateBtnName()
	local type, info = SkillEditorMgr.instance:getTypeInfo(self._side)

	if type == SkillEditorMgr.SelectType.Hero then
		if info then
			::label_9_0::

			local var_9_0 = info.ids

			if info.ids then
				local co = lua_character.configDict[info.ids[1]]

				self._txtHero.text = co and co.name
			end
		end
	elseif type == SkillEditorMgr.SelectType.Monster then
		if info then
			::label_9_1::

			local var_9_1 = info.ids

			if info.ids then
				local skin_config = FightConfig.instance:getSkinCO(info.skinIds[1])

				if skin_config.name then
					if not skin_config.name then
						local show_name

						self._txtHero.text = show_name
					end
				end
			end
		end
	elseif type == SkillEditorMgr.SelectType.Group then
		self._txtHero.text = "怪物组-" .. info.groupId
	elseif type == SkillEditorMgr.SelectType.MonsterId then
		if info then
			::label_9_2::

			local var_9_3 = info.ids

			if info.ids then
				local co = lua_monster.configDict[info.ids[1]]
				local name

				self._txtHero.text = "怪物-" .. tostring((co or nil) and (not string.nilorempty(co.highPriorityName) and co.highPriorityName or co.name))
			end
		end
	end
end

function SkillEditorSideView:_onClickSelectSkill()
	self._skillSelectView:show()
end

function SkillEditorSideView:_onClickFight()
	local skillId = self._skillSelectView:getSelectSkillId()
	local skillCO = lua_skill.configDict[skillId]

	if not skillCO then
		logError("技能配置不存在，id = " .. skillId)

		return
	end

	if self._isPlayingSkill then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.ForceReleasePlayFlow)

	self._isPlayingSkill = true

	TaskDispatcher.runDelay(self._onPlayFinish, self, 60)

	local attackerId = FightGameMgr.entityMgr:getEntityByPosId(self._attackerTag, SkillEditorView.selectPosId[self._side]).id
	local targetId = FightGameMgr.entityMgr:getEntityByPosId(self._oppositeTag, SkillEditorView.selectPosId[self._oppositeSide]).id
	local targetLimit = FightHelper.getTargetLimits(self._side, skillId)

	if targetLimit and #targetLimit > 0 and not tabletool.indexOf(targetLimit, targetId) then
		targetId = FightGameMgr.entityMgr:getEntityByPosId(self._attackerTag, SkillEditorView.prevSelectPosId[self._side]).id
	end

	local attacker = FightHelper.getEntity(attackerId)

	if attacker.skill then
		gohelper.setActive(self.viewGO, false)

		local proto = FightDef_pb.FightRound()
		local roundData = FightRoundData.New(proto)

		FightDataHelper.roundMgr:setRoundData(roundData)

		local fightStepDataList = SkillEditorStepBuilder.buildFightStepDataList(skillId, attackerId, targetId)

		tabletool.addValues(roundData.fightStep, fightStepDataList)

		local stepWorkList, skillFlowList = FightStepBuilder.buildStepWorkList(roundData.fightStep)

		self._playSkillsFlow = FlowSequence.New()

		for _, step in ipairs(stepWorkList) do
			self._playSkillsFlow:addWork(step)
		end

		self._playSkillsFlow:registerDoneListener(self._onPlayFinish, self)
		self._playSkillsFlow:start()
		gohelper.setActive(self.viewGO, false)
	else
		self._isPlayingSkill = false

		logError("所选对象没有技能")
	end
end

function SkillEditorSideView:_onPlayFinish()
	self._isPlayingSkill = false

	if self._playSkillsFlow then
		self._playSkillsFlow:unregisterDoneListener(self._onPlayFinish, self)
		self._playSkillsFlow:stop()

		self._playSkillsFlow = nil
	end

	TaskDispatcher.cancelTask(self._onPlayFinish, self)

	if GMController.instance:getIsShowEditorFightUI() then
		gohelper.setActive(self.viewGO, true)
	else
		gohelper.setActive(self.viewGO, false)
	end

	self:_checkResetEntityHp()
end

function SkillEditorSideView._checkResetEntityHp()
	local all = FightHelper.getAllEntitys()

	for _, entity in ipairs(all) do
		local entityMO = entity:getMO()

		if entity.nameUI and entityMO and entityMO.currentHp <= 0 then
			entity.nameUI:addHp(entityMO.attrMO.hp)
			entity.nameUI:setActive(true)
		end
	end
end

return SkillEditorSideView

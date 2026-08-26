-- chunkname: @modules/logic/fight/view/preview/SkillEditorMulSkillView.lua

module("modules.logic.fight.view.preview.SkillEditorMulSkillView", package.seeall)

local SkillEditorMulSkillView = class("SkillEditorMulSkillView", BaseView)

function SkillEditorMulSkillView:onInitView()
	self._infos = {}
	self._btnMulSkill = gohelper.findChildButton(self.viewGO, "scene/Grid/btnMulSkill")
	self._btnClose = gohelper.findChildButton(self.viewGO, "mulSkill/btnGroup/btnClose")
	self._btnStart = gohelper.findChildButton(self.viewGO, "mulSkill/btnGroup/btnStart")
	self._toggleParallel = gohelper.findChildToggle(self.viewGO, "mulSkill/btnGroup/toggleParallel")
	self._toggleNoSpeedUp = gohelper.findChildToggle(self.viewGO, "mulSkill/btnGroup/toggleNoSpeedUp")
	self._toggleHideAllUI = gohelper.findChildToggle(self.viewGO, "mulSkill/btnGroup/toggleHideAllUI")
	self._toggleDelay = gohelper.findChildToggle(self.viewGO, "mulSkill/btnGroup/toggleDelay")
	self._inputDelay = gohelper.findChildTextMeshInputField(self.viewGO, "mulSkill/btnGroup/toggleDelay/#input_delay")
	self._mulSkillViewGO = gohelper.findChild(self.viewGO, "mulSkill")
	self._items = {
		gohelper.findChild(self.viewGO, "mulSkill/content/item")
	}

	gohelper.setActive(self._mulSkillViewGO, false)
end

function SkillEditorMulSkillView:addEvents()
	self.addClickCb(self, self._btnMulSkill, self._showThis, self)
	self.addClickCb(self, self._btnClose, self._hideThis, self)
	self.addClickCb(self, self._btnStart, self._onClickStart, self)
end

function SkillEditorMulSkillView:removeEvents()
	self.removeClickCb(self, self._btnMulSkill, self._showThis, self)
	self.removeClickCb(self, self._btnClose, self._hideThis, self)
	self.removeClickCb(self, self._btnStart, self._onClickStart, self)

	for _, item in ipairs(self._items) do
		local removeClick = gohelper.findChildButtonWithAudio(item, "imgRemove")

		removeClick:RemoveClickListener()
	end
end

function SkillEditorMulSkillView:_showThis()
	gohelper.setActive(self._mulSkillViewGO, true)
	self:_updateItems()
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSelectSkill, self._onSelectSkill, self)
end

function SkillEditorMulSkillView:_hideThis()
	gohelper.setActive(self._mulSkillViewGO, false)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSelectSkill, self._onSelectSkill, self)
end

function SkillEditorMulSkillView:_onSelectSkill(entityMO, skillId)
	local info = {}
	local side = entityMO.side

	if side == FightEnum.EntitySide.EnemySide then
		if not FightEnum.EntitySide.MySide then
			local oppoSide = FightEnum.EntitySide.EnemySide

			info.side = side
			info.stancePos = SkillEditorView.selectPosId[side]
			info.modelId = entityMO.modelId
			info.skillId = skillId

			local entityMgr = FightGameMgr.entityMgr

			if side == FightEnum.EntitySide.MySide then
				if not SceneTag.UnitMonster then
					local oppositeTag = SceneTag.UnitPlayer

					info.targetId = entityMgr:getEntityByPosId(oppositeTag, SkillEditorView.selectPosId[oppoSide]).id

					table.insert(self._infos, info)
					self:_updateItems()
				end
			end
		end
	end
end

function SkillEditorMulSkillView:_updateItems()
	for i, info in ipairs(self._infos) do
		local item = self._items[i]

		if not item then
			item = gohelper.cloneInPlace(self._items[1], "item" .. i)

			table.insert(self._items, item)
		end

		gohelper.setActive(item, true)

		local entityMO = FightDataHelper.entityMgr:getByPosId(info.side, info.stancePos)

		if entityMO then
			local text = gohelper.findChildText(item, "Text")
			local entityName = entityMO:getEntityName()
			local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, info.skillId)
			local temp = string.split(timeline, "_")
			local timelineSurfix = temp[#temp]

			text.text = string.format("%s-%s", entityName, timelineSurfix)
		end

		local removeClick = gohelper.findChildButtonWithAudio(item, "imgRemove")

		removeClick:AddClickListener(self._onClickRemoveInfo, self, i)
	end

	for i = #self._infos + 1, #self._items do
		gohelper.setActive(self._items[i], false)
	end
end

function SkillEditorMulSkillView:_onClickRemoveInfo(index)
	table.remove(self._infos, index)
	self:_updateItems()
end

function SkillEditorMulSkillView:_onClickStart()
	if not self._infos or #self._infos == 0 then
		GameFacade.showToast(ToastEnum.IconId, "未添加技能")

		return
	end

	FightDataHelper.stateMgr:setAutoState(self._toggleParallel.isOn)

	if self._toggleNoSpeedUp.isOn then
		-- block empty
	else
		FightDataHelper.stateMgr.isReplay = true

		FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end

	local roundData = FightRoundData.New(FightDef_pb.FightRound())

	FightDataHelper.roundMgr:setRoundData(roundData)

	for _, info in ipairs(self._infos) do
		local skillId = info.skillId
		local entityMO = FightDataHelper.entityMgr:getByPosId(info.side, info.stancePos)

		if entityMO then
			local attackerId = entityMO.id
			local targetId = info.targetId
			local side = info.side

			if side == FightEnum.EntitySide.MySide then
				if not FightEnum.EntitySide.EnemySide then
					local targetLimit = FightHelper.getTargetLimits(side, skillId)

					if targetLimit and #targetLimit > 0 and not tabletool.indexOf(targetLimit, targetId) then
						targetId = targetLimit[1]
					end

					local fightStepList = SkillEditorStepBuilder.buildFightStepDataList(skillId, attackerId, targetId)

					tabletool.addValues(roundData.fightStep, fightStepList)
				end
			end
		end
	end

	local delay = self._inputDelay:GetText()

	delay = tonumber(delay) or 0
	self._playSkillsFlow = FlowSequence.New()

	if self._toggleDelay.isOn and delay > 0 then
		self._playSkillsFlow:addWork(WorkWaitSeconds.New(delay))
	end

	local stepWorkList, skillFlowList = FightStepBuilder.buildStepWorkList(roundData.fightStep)

	for _, step in ipairs(stepWorkList) do
		self._playSkillsFlow:addWork(step)
	end

	if self._toggleDelay.isOn and delay > 0 then
		self._playSkillsFlow:addWork(WorkWaitSeconds.New(delay))
	end

	self._playSkillsFlow:registerDoneListener(self._onPlaySkillsEnd, self)
	self._playSkillsFlow:start()
	gohelper.setActive(self.viewGO, false)

	if self._toggleHideAllUI.isOn then
		self:hideAllUI()
	end
end

function SkillEditorMulSkillView:hideAllUI()
	self:setNameUIActive(false)
	self:setViewActive(false)
	self:setFrameActive(false)
end

function SkillEditorMulSkillView:showAllUI()
	self:setNameUIActive(true)
	self:setViewActive(true)
	self:setFrameActive(true)
end

function SkillEditorMulSkillView:setNameUIActive(active)
	local entityMgr = FightGameMgr.entityMgr

	for entityId, entity in pairs(entityMgr.entityDic) do
		local nameUi = entity.nameUI

		if nameUi then
			gohelper.setActive(nameUi:getGO(), active)
		end
	end
end

function SkillEditorMulSkillView:setViewActive(active)
	local viewContainer = ViewMgr.instance:getContainer(ViewName.SkillEffectStatView)

	if viewContainer then
		gohelper.setActive(viewContainer.viewGO, active)
	end
end

function SkillEditorMulSkillView:setFrameActive(active)
	local uiRoot = ViewMgr.instance:getUIRoot()
	local go = gohelper.findChild(uiRoot, "Text")

	gohelper.setActive(go, active)
end

function SkillEditorMulSkillView:_onPlaySkillsEnd()
	self._playSkillsFlow:unregisterDoneListener(self._onPlaySkillsEnd, self)
	gohelper.setActive(self.viewGO, true)

	FightDataHelper.stateMgr.isReplay = false

	FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	self:showAllUI()
end

return SkillEditorMulSkillView

-- chunkname: @modules/logic/fight/view/preview/SkillEditorActionSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorActionSelectView", package.seeall)

local SkillEditorActionSelectView = class("SkillEditorActionSelectView", BaseView)

function SkillEditorActionSelectView:onInitView()
	self._itemGOs = self:getUserDataTb_()
	self._actionViewGO = gohelper.findChild(self.viewGO, "selectAction")
	self._btnActionPreviewL = gohelper.findChildButtonWithAudio(self.viewGO, "scene/Grid/btnActionPreview")
	self._itemGOParent = gohelper.findChild(self.viewGO, "selectAction/scroll/content")
	self._itemGOPrefab = gohelper.findChild(self.viewGO, "selectAction/scroll/item")

	gohelper.setActive(self._itemGOPrefab, false)

	self._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectAction/btnClose")
	self._btnMulti = gohelper.findChildButtonWithAudio(self.viewGO, "selectAction/btnMulti")
	self._txtMulti = gohelper.findChildText(self.viewGO, "selectAction/btnMulti/image/txtMulti")
	self._toggleLoop = gohelper.findChildToggle(self.viewGO, "selectAction/toggleLoop")
	self._toggleMulti = gohelper.findChildToggle(self.viewGO, "selectAction/toggleMulti")
	self._multiImgTr = gohelper.findChild(self.viewGO, "selectAction/btnMulti/image").transform
	self._toggleLoop.isOn = false
	self._toggleMulti.isOn = false

	gohelper.setActive(self._btnMulti.gameObject, false)

	self._multiList = {}
end

function SkillEditorActionSelectView:addEvents()
	self._btnActionPreviewL:AddClickListener(self._showThis, self)
	self._btnClose:AddClickListener(self._hideThis, self)
	self._btnMulti:AddClickListener(self._onClickMulti, self)
	self._toggleMulti:AddOnValueChanged(self._onToggleMultiChange, self)
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):AddClickListener(self._hideThis, self)
end

function SkillEditorActionSelectView:removeEvents()
	self._btnActionPreviewL:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMulti:RemoveClickListener()
	self._toggleMulti:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):RemoveClickListener()
end

function SkillEditorActionSelectView:_showThis(side)
	self._attacker = SkillEditorMgr.instance.cur_select_entity_id and FightGameMgr.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id) or FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])

	if not self._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	self._skinId = self._attacker:getMO().skin

	gohelper.setActive(self._actionViewGO, true)
	self:_updateItems()
end

function SkillEditorActionSelectView:_hideThis()
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	gohelper.setActive(self._actionViewGO, false)
end

function SkillEditorActionSelectView:_updateItems()
	local actionNameList = self:_getActionNameList()

	for i, actionName in ipairs(actionNameList) do
		local itemGO = self._itemGOs[i]

		if not itemGO then
			itemGO = gohelper.clone(self._itemGOPrefab, self._itemGOParent, "item" .. i)

			self.addClickCb(self, SLFramework.UGUI.UIClickListener.Get(itemGO), self._onClickItem, self, i)
			table.insert(self._itemGOs, itemGO)
		end

		gohelper.setActive(itemGO, true)

		local text = gohelper.findChildText(itemGO, "Text")
		local hasAnimation = self._attacker.spine:hasAnimation(actionName)

		text.text = actionName .. (hasAnimation and "" or "(缺)")
	end

	for i = #actionNameList + 1, #self._itemGOs do
		gohelper.setActive(self._itemGOs[i], false)
	end

	local height = (#actionNameList / 6 + 1) * 100

	recthelper.setHeight(self._itemGOParent.transform, height)
end

function SkillEditorActionSelectView:_onClickMulti()
	if #self._multiList > 0 then
		self._multiIndex = 1

		self:_playMultiAction()
	else
		GameFacade.showToast(ToastEnum.IconId, "未选择动作")
	end
end

function SkillEditorActionSelectView:_onToggleMultiChange(isOn)
	gohelper.setActive(self._btnMulti.gameObject, self._toggleMulti.isOn)

	if not isOn then
		tabletool.clear(self._multiList)

		self._txtMulti.text = ""

		recthelper.setWidth(self._multiImgTr, 0)
	end
end

function SkillEditorActionSelectView:_playMultiAction()
	local actionName = self._multiList[self._multiIndex]

	if actionName then
		self._attacker.spine:removeAnimEventCallback(self._onMultiAnimEvent, self)
		self._attacker.spine:addAnimEventCallback(self._onMultiAnimEvent, self)

		local unitSpine = self._attacker.spine.super

		unitSpine.play(self._attacker.spine, actionName, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, self._attacker)
	else
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)
		self._attacker:resetAnimState()
	end

	local str = ""

	for i, name in ipairs(self._multiList) do
		local linkStr = i == #self._multiList and "" or "->"

		str = i == self._multiIndex and string.format("%s<color=red>%s</color>%s", str, name, linkStr) or string.format("%s%s%s", str, name, linkStr)
	end

	self._txtMulti.text = str
end

function SkillEditorActionSelectView:_onMultiAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		self._multiIndex = self._multiIndex + 1

		self:_playMultiAction()
	end
end

function SkillEditorActionSelectView:_onClickItem(index)
	local actionNameList = self:_getActionNameList()
	local actionName = actionNameList[index]

	if self._toggleMulti.isOn then
		table.insert(self._multiList, actionName)

		self._txtMulti.text = table.concat(self._multiList, "->")

		recthelper.setWidth(self._multiImgTr, self._txtMulti.preferredWidth)
	elseif self._toggleLoop.isOn then
		self._attacker.spine:play(actionName, true, true)
	else
		local entityData = FightDataHelper.entityMgr:getById(self._attacker.id)
		local skinId = entityData and entityData.skin
		local config = lua_fight_skin_entity_enter_timeline.configDict[skinId]

		if actionName == "born" and config and self._attacker.skill then
			local fightStepData = FightStepData.New(FightDef_pb.FightStep())

			fightStepData.fromId = entityData.id
			fightStepData.toId = entityData.id

			local timelineWork = self._attacker.skill:registTimelineWork(config.timeline, fightStepData)

			timelineWork:start()

			return
		end

		self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)
		TaskDispatcher.cancelTask(self._delayResetAnim, self)

		local spineActionDict = FightConfig.instance:getSkinSpineActionDict(self._skinId)
		local spineActionCO = spineActionDict and spineActionDict[actionName]

		if spineActionCO and spineActionCO.effectRemoveTime > 0 then
			local animDuration = spineActionCO.effectRemoveTime / FightModel.instance:getSpeed()

			TaskDispatcher.runDelay(self._delayResetAnim, self, animDuration)
		else
			self._ani_need_transition, self._transition_ani = FightHelper.needPlayTransitionAni(self._attacker, actionName)

			self._attacker.spine:addAnimEventCallback(self._onAnimEvent, self)
		end

		self._attacker.spine:play(actionName, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, self._attacker)
	end
end

function SkillEditorActionSelectView:_delayResetAnim()
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)
	self._attacker:resetAnimState()
end

function SkillEditorActionSelectView:_onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		if self._ani_need_transition and self._transition_ani == actionName then
			return
		end

		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		self._attacker.spine:removeAnimEventCallback(self._onAnimEvent, self)
		self._attacker:resetAnimState()
	end
end

local NeedActions = {
	"die",
	"hit",
	"idle",
	"sleep",
	"freeze"
}

function SkillEditorActionSelectView:_getActionNameList()
	local actionList = {}

	for _, actionName in pairs(SpineAnimState) do
		if type(actionName) == "string" and self._attacker.spine:hasAnimation(actionName) then
			table.insert(actionList, actionName)
		end
	end

	for _, needAction in ipairs(NeedActions) do
		if not tabletool.indexOf(actionList, needAction) then
			table.insert(actionList, needAction)
		end
	end

	return actionList
end

return SkillEditorActionSelectView

-- chunkname: @modules/logic/fight/view/FightViewBossHpMgr.lua

module("modules.logic.fight.view.FightViewBossHpMgr", package.seeall)

local FightViewBossHpMgr = class("FightViewBossHpMgr", FightBaseView)

function FightViewBossHpMgr:onInitView()
	self.viewRoot = gohelper.findChild(self.viewGO, "root")
	self.hpRootObj = gohelper.findChild(self.viewGO, "root/bossHpRoot")
	self._bossHpRoot = self.hpRootObj.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewBossHpMgr:addEvents()
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, self.onSetBossHpVisibleWhenHidingFightView)
end

function FightViewBossHpMgr:removeEvents()
	return
end

function FightViewBossHpMgr:_editableInitView()
	self._hpItem = gohelper.findChild(self.viewGO, "root/bossHpRoot/bossHp")

	SLFramework.AnimatorPlayer.Get(self._hpItem):Play("idle", nil, nil)
	gohelper.setActive(gohelper.findChild(self.viewGO, "root/bossHpRoot/bossHp/Alpha/bossHp"), false)
end

FightViewBossHpMgr.BossHpType = {
	ScrollHp_Survival = 1,
	ScrollHp_500M = 2
}
FightViewBossHpMgr.BossHpType2Cls = {
	[FightViewBossHpMgr.BossHpType.ScrollHp_Survival] = FightViewSurvivalBossHp,
	[FightViewBossHpMgr.BossHpType.ScrollHp_500M] = FightViewScrollBossHp_500M
}

function FightViewBossHpMgr:_onBeforeEnterStepBehaviour()
	if not GMFightShowState.bossHp then
		return
	end

	local type = FightHelper.getCurBattleIdBossHpType()
	local class = type and FightViewBossHpMgr.BossHpType2Cls[type]

	if class then
		self:com_openSubView(class, self._hpItem)

		return
	end

	if FightDataHelper.fieldMgr:isShelter() then
		self:com_openSubView(FightViewSurvivalBossHp, self._hpItem)

		return
	end

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		self:com_openSubView(BossRushFightViewBossHp, self._hpItem)

		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if customData and customData.bloodReward then
		gohelper.setActive(self._hpItem, false)
		self:com_openSubView(FightViewBossHpBloodReward, "ui/viewres/fight/fight_act191bosshpview.prefab", self._bossHpRoot.gameObject, customData)

		return
	end

	local buttonCount = 3

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		buttonCount = buttonCount + 1
	end

	if FightView.canShowSpecialBtn() then
		buttonCount = buttonCount + 1
	end

	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local isRouge = episode_config and episode_config.type == DungeonEnum.EpisodeType.Rouge

	if isRouge then
		buttonCount = buttonCount + 1
	end

	if buttonCount >= 6 then
		recthelper.setAnchorX(self._bossHpRoot, -90)
	end

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	local count = 0
	local bossId = FightHelper.getCurBossId()
	local bossUidList = {}

	for i, v in ipairs(entityList) do
		local entityMO = v:getMO()

		if entityMO and FightHelper.isBossId(bossId, entityMO.modelId) then
			count = count + 1

			table.insert(bossUidList, v.id)
		end
	end

	if count == 2 then
		for i, entityId in ipairs(bossUidList) do
			local obj = gohelper.cloneInPlace(self._hpItem, "bossHp" .. i)

			gohelper.setActive(obj, true)

			local width = buttonCount >= 5 and 400 or 450

			recthelper.setWidth(obj.transform, width)

			local posX = buttonCount >= 5 and 240 or 295

			recthelper.setAnchorX(obj.transform, (i == 1 or nil) and (-posX or posX))
			self:com_openSubView(FightViewMultiBossHp, obj, nil, entityId)
		end

		gohelper.setActive(self._hpItem, false)
	else
		self:com_openSubView(FightViewBossHp, self._hpItem)
	end
end

function FightViewBossHpMgr:onSetBossHpVisibleWhenHidingFightView(state)
	if not self.originRootPosX then
		self.originRootPosX = recthelper.getAnchorX(self._bossHpRoot)
		self.siblingIndex = gohelper.getSibling(self.hpRootObj) - 1

		local var_6_0

		if state then
			var_6_0 = self.viewGO or self.viewRoot
		end
	end

	gohelper.addChild(var_6_0, self.hpRootObj)
	recthelper.setAnchorX(self._bossHpRoot, self.originRootPosX)
	gohelper.setSibling(self.hpRootObj, self.siblingIndex)
end

function FightViewBossHpMgr:onOpen()
	return
end

function FightViewBossHpMgr:onClose()
	return
end

function FightViewBossHpMgr:onDestroyView()
	return
end

return FightViewBossHpMgr

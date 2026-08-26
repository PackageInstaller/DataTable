-- chunkname: @modules/logic/fight/view/FightSurvivalTalentView.lua

module("modules.logic.fight.view.FightSurvivalTalentView", package.seeall)

local FightSurvivalTalentView = class("FightSurvivalTalentView", FightBaseView)

FightSurvivalTalentView.Status = {
	CanUse = 2,
	CantUse = 1
}

function FightSurvivalTalentView:onInitView()
	self.iconImage = gohelper.findChildSingleImage(self.viewGO, "root/#skill/#image_skill")
	self.txtSkillName = gohelper.findChildText(self.viewGO, "root/#txt_skill")
	self.goVxNormal = gohelper.findChild(self.viewGO, "root/#skill/#normal")
	self.goVxActive = gohelper.findChild(self.viewGO, "root/#skill/#active")
	self.goVxGray = gohelper.findChild(self.viewGO, "root/#skill/#gray")

	local goClick = gohelper.findChild(self.viewGO, "root/#btn_click")

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(goClick)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	gohelper.setActive(self.goVxNormal, false)
	gohelper.setActive(self.goVxActive, false)
	gohelper.setActive(self.goVxGray, false)

	self.status2Vx = {
		[FightSurvivalTalentView.Status.CantUse] = self.goVxGray,
		[FightSurvivalTalentView.Status.CanUse] = self.goVxActive
	}

	self:initData()
end

function FightSurvivalTalentView:addEvents()
	self.longPress:AddClickListener(self.onClickTalent, self)
	self.longPress:AddLongPressListener(self.onLongPressTalent, self)
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self.onCancelOperation, self)
end

function FightSurvivalTalentView:onCancelOperation()
	self:refreshVX()
end

function FightSurvivalTalentView:onPowerChange(entityId, powerId, oldValue, newValue)
	if entityId ~= self.entityId then
		return
	end

	if powerId ~= FightEnum.PowerType.PlayerFinisherSkill then
		return
	end

	self:refreshVX()
end

function FightSurvivalTalentView:onClickTalent()
	if not self.skillCo then
		return
	end

	local curStage = FightDataMgr.instance.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if not FightDataHelper.operationDataMgr.survivalTalentSkillUsedCount then
		local usedCount = 0

		if usedCount > FightDataHelper.fieldMgr.playerFinisherInfo.roundUseLimit then
			return
		end

		local entityMO = FightDataHelper.entityMgr:getById(self.entityId)

		if not entityMO then
			return
		end

		local powerInfo = entityMO:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

		if not powerInfo then
			return
		end

		local info = FightDataHelper.fieldMgr.playerFinisherInfo
		local skillData = info and info.skills[1]

		if not skillData then
			return
		end

		local curPower = powerInfo.num - usedCount * self.needPower

		if curPower < self.needPower then
			return
		end

		if self.skillCo and FightEnum.ShowLogicTargetView[self.skillCo.logicTarget] and self.skillCo.targetLimit == FightEnum.TargetLimit.MySide then
			local mySideList = FightDataHelper.entityMgr:getMyNormalList()
			local len = #mySideList

			if len <= 0 then
				return
			end

			if #mySideList > 1 then
				ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
					skillId = self.skillId,
					callback = self._playSkill,
					callbackObj = self
				})
			else
				self:_playSkill(mySideList[1].id)
			end
		else
			self:_playSkill(FightDataHelper.operationDataMgr.curSelectEntityId)
		end
	end
end

function FightSurvivalTalentView:_playSkill(targetId)
	FightDataHelper.operationDataMgr:addSurvivalTalentSkillUsedCount(1)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playPlayerFinisherSkill(self.skillId, targetId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, op)
	self:refreshVX()
end

function FightSurvivalTalentView:onLongPressTalent()
	local curStage = FightDataMgr.instance.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if not self.skillCo then
		return
	end

	self.tempInfo = self.tempInfo or {}

	tabletool.clear(self.tempInfo)

	self.tempSkillIdList = self.tempSkillIdList or {}
	self.tempSkillIdList[1] = self.skillId
	self.tempInfo.super = self.skillCo.isBigSkill == 1
	self.tempInfo.skillIdList = self.tempSkillIdList
	self.tempInfo.skillIndex = 1
	self.tempInfo.userSkillId = self.skillId
	self.tempInfo.monsterName = ""

	if self.tempInfo.super then
		ViewMgr.instance:openView(ViewName.TowerSkillTipView, self.tempInfo)
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, self.tempInfo)
	end
end

function FightSurvivalTalentView:onOpen()
	if not self.skillCo then
		return
	end

	if self.skillCo then
		self.txtSkillName.text = self.skillCo.name or ""
	end

	self:refreshVX()
end

function FightSurvivalTalentView:refreshVX()
	local curStatus = self:getStatus()

	for key, vx in ipairs(self.status2Vx) do
		gohelper.setActive(vx, key == curStatus)
	end
end

function FightSurvivalTalentView:getStatus()
	if not FightDataHelper.operationDataMgr.survivalTalentSkillUsedCount then
		local usedCount = 0
		local entityMO = FightDataHelper.entityMgr:getById(self.entityId)

		if not entityMO then
			return FightSurvivalTalentView.Status.CantUse
		end

		local powerInfo = entityMO:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

		if not powerInfo then
			return FightSurvivalTalentView.Status.CantUse
		end

		local info = FightDataHelper.fieldMgr.playerFinisherInfo
		local skillData = info and info.skills[1]

		if not skillData then
			return FightSurvivalTalentView.Status.CantUse
		end

		local curPower = powerInfo.num - usedCount * self.needPower

		if curPower < self.needPower then
			return FightSurvivalTalentView.Status.CantUse
		end

		return FightSurvivalTalentView.Status.CanUse
	end
end

function FightSurvivalTalentView:initData()
	self.entityId = FightEntityScene.MySideId

	if FightDataHelper.fieldMgr.customData then
		if not FightDataHelper.fieldMgr.customData then
			return
		end

		self.talentGroupId = FightDataHelper.fieldMgr.customData.talentGroupId

		local info = FightDataHelper.fieldMgr.playerFinisherInfo
		local skillData = info and info.skills[1]

		if info then
			self.useLimit = info.roundUseLimit or 0
		end

		self.skillId = skillData and skillData.skillId

		if skillData then
			self.needPower = skillData.needPower or 0
		end

		self.skillCo = self.skillId and lua_skill.configDict[self.skillId]

		self:updateTalentIcon()
	end
end

function FightSurvivalTalentView:updateTalentIcon()
	return
end

function FightSurvivalTalentView:onDestroyView()
	self.longPress:RemoveClickListener()
	self.longPress:RemoveLongPressListener()

	self.longPress = nil
end

return FightSurvivalTalentView

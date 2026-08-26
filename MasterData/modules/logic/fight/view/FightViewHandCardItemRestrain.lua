-- chunkname: @modules/logic/fight/view/FightViewHandCardItemRestrain.lua

module("modules.logic.fight.view.FightViewHandCardItemRestrain", package.seeall)

local FightViewHandCardItemRestrain = class("FightViewHandCardItemRestrain", LuaCompBase)

FightViewHandCardItemRestrain.RestrainMvStatus = {
	Restrain = 2,
	BeRestrain = 3,
	None = 1
}

function FightViewHandCardItemRestrain:ctor(subViewInst)
	self._subViewInst = subViewInst
end

function FightViewHandCardItemRestrain:init(go)
	self.go = go
	self.tr = go.transform

	gohelper.setActive(gohelper.findChild(self.go, "foranim/restrain"), true)

	self._restrainGO = gohelper.findChild(self.go, "foranim/restrain/restrain")
	self._beRestrainGO = gohelper.findChild(self.go, "foranim/restrain/beRestrain")
	self._restrainAnimator = self._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	self._beRestrainAnimator = self._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
end

function FightViewHandCardItemRestrain:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self._onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._updateRestrain, self)
end

function FightViewHandCardItemRestrain:removeEventListeners()
	self.removeEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StageChanged, self._onStageChange, self)
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._updateRestrain, self)
end

function FightViewHandCardItemRestrain:updateItem(cardInfoMO)
	self.cardInfoMO = cardInfoMO or self.cardInfoMO

	local skillCO = lua_skill.configDict[cardInfoMO.skillId]

	if not skillCO then
		logError("skill not exist: " .. cardInfoMO.skillId)

		return
	end

	self:_updateRestrain()
	self:_playNonAnimation()
end

function FightViewHandCardItemRestrain:_onSelectSkillTarget(entityId)
	self:_updateRestrain()
	self:_playAnimation()
end

function FightViewHandCardItemRestrain:_onStageChange(stage)
	self:_updateRestrain()
	self:_playAnimation()
end

function FightViewHandCardItemRestrain:_updateRestrain()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local newRestrainStatus = self:_getNewRestrainStatus()
		local gmHandCardRestrain = GMFightShowState.handCardRestrain

		gohelper.setActive(self._restrainGO, newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain and gmHandCardRestrain)
		gohelper.setActive(self._beRestrainGO, newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and gmHandCardRestrain)
	else
		gohelper.setActive(self._restrainGO, false)
		gohelper.setActive(self._beRestrainGO, false)
	end
end

function FightViewHandCardItemRestrain:_playAnimation()
	local newRestrainStatus = self:_getNewRestrainStatus()

	if newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain then
		if self._restrainAnimator.gameObject.activeInHierarchy then
			self._restrainAnimator:Play("fight_restrain_all_in", 0, 0)
			self._restrainAnimator:Update(0)
		end
	elseif newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and self._beRestrainAnimator.gameObject.activeInHierarchy then
		self._beRestrainAnimator:Play("fight_restrain_all_in", 0, 0)
		self._beRestrainAnimator:Update(0)
	end
end

function FightViewHandCardItemRestrain:_playNonAnimation()
	local newRestrainStatus = self:_getNewRestrainStatus()

	if newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain then
		if self._restrainAnimator.gameObject.activeInHierarchy then
			self._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			self._restrainAnimator:Update(0)
		end
	elseif newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and self._beRestrainAnimator.gameObject.activeInHierarchy then
		self._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
		self._beRestrainAnimator:Update(0)
	end
end

function FightViewHandCardItemRestrain.getNewRestrainStatus(uid, skillId)
	local isUserCardStage = FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate
	local selectEntity = FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId)
	local skillCO = lua_skill.configDict[skillId]
	local showTag = skillCO and skillCO.showTag
	local needShowRestrain = showTag and FightEnum.NeedShowRestrainTag[showTag]
	local notAuto = not FightDataHelper.stateMgr:getIsAuto()
	local notSelectZero = FightDataHelper.operationDataMgr.curSelectEntityId ~= 0
	local isOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightRestrainTag)
	local isForbidRestrainTag = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRestrainTag)

	if isUserCardStage and isOpen and notAuto and notSelectZero and selectEntity and needShowRestrain and not isForbidRestrainTag then
		local cardEntityMO = FightDataHelper.entityMgr:getById(uid)
		local selectEntityMO = selectEntity:getMO()

		if cardEntityMO and selectEntityMO then
			local weakCareers = selectEntityMO.weakCareers

			for i, v in ipairs(weakCareers) do
				if v == cardEntityMO.career then
					return FightViewHandCardItemRestrain.RestrainMvStatus.Restrain
				end
			end
		end

		if FightBuffHelper.notRestrainAll(uid) then
			return FightViewHandCardItemRestrain.RestrainMvStatus.None
		end

		if FightBuffHelper.restrainAll(uid) then
			return FightViewHandCardItemRestrain.RestrainMvStatus.Restrain
		end

		local selectEntityCO = selectEntityMO and selectEntityMO:getCO()
		local cardEntityCO = cardEntityMO and cardEntityMO:getCO()

		if cardEntityCO then
			if not cardEntityCO.career then
				local career1 = 0

				if selectEntityCO then
					if not selectEntityCO.career then
						local career2 = 0
						local version = FightModel.instance:getVersion()

						if version >= 2 then
							career1 = cardEntityMO and cardEntityMO.career or career1
							career2 = selectEntityMO and selectEntityMO.career or career2
						end

						local restrainValue = FightConfig.instance:getRestrain(career1, career2) or 1000

						if restrainValue > 1000 then
							return FightViewHandCardItemRestrain.RestrainMvStatus.Restrain
						elseif restrainValue < 1000 then
							return FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain
						else
							return FightViewHandCardItemRestrain.RestrainMvStatus.None
						end
					end
				end
			end
		end
	else
		return FightViewHandCardItemRestrain.RestrainMvStatus.None
	end
end

function FightViewHandCardItemRestrain:_getNewRestrainStatus()
	return FightViewHandCardItemRestrain.getNewRestrainStatus(self.cardInfoMO.uid, self.cardInfoMO.skillId)
end

return FightViewHandCardItemRestrain

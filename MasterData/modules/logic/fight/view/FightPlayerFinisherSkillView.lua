-- chunkname: @modules/logic/fight/view/FightPlayerFinisherSkillView.lua

module("modules.logic.fight.view.FightPlayerFinisherSkillView", package.seeall)

local FightPlayerFinisherSkillView = class("FightPlayerFinisherSkillView", FightBaseView)

function FightPlayerFinisherSkillView:onInitView()
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "skill/btn_skill")
	self._longPress = SLFramework.UGUI.UILongPressListener.Get(self._click.gameObject)
	self._used = gohelper.findChild(self.viewGO, "used")
	self._power = gohelper.findChild(self.viewGO, "power")
	self._noPower = gohelper.findChild(self.viewGO, "noPower")
	self._powerList = {}
	self._aniList = {}

	local findRoot = gohelper.findChild(self.viewGO, "skill/go_energy").transform

	for i = 0, 4 do
		local obj = findRoot:GetChild(i).gameObject

		table.insert(self._powerList, obj)

		local ani = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator))

		table.insert(self._aniList, ani)
	end

	self._tips = gohelper.findChild(self.viewGO, "skill/#go_skilltip")
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "skill/#go_skilltip/#btn_close")
	self._title = gohelper.findChildText(self.viewGO, "skill/#go_skilltip/bg/#txt_title")
	self._desc = gohelper.findChildText(self.viewGO, "skill/#go_skilltip/bg/#txt_dec")
end

function FightPlayerFinisherSkillView:addEvents()
	self:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, self._onRefreshPlayerFinisherSkill)
	self:com_registFightEvent(FightEvent.PowerChange, self._onPowerChange)
	self:com_registFightEvent(FightEvent.PowerInfoChange, self._onPowerInfoChange)
	self:com_registFightEvent(FightEvent.StageChanged, self._onStageChanged)
	self:com_registFightEvent(FightEvent.CancelOperation, self._onCancelOperation)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
	self:com_registClick(self._click, self._onClick)
	self:com_registLongPress(self._longPress, self._onLongPress)
	self:com_registClick(self._btnClose, self._onBtnClose)
end

function FightPlayerFinisherSkillView:_onTouchFightViewScreen()
	gohelper.setActive(self._tips, false)
end

function FightPlayerFinisherSkillView:_onBtnClose()
	gohelper.setActive(self._tips, false)
end

function FightPlayerFinisherSkillView:_onLongPress()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	gohelper.setActive(self._tips, true)
end

function FightPlayerFinisherSkillView:_onCancelOperation()
	self:_refreshPower()
end

function FightPlayerFinisherSkillView:_onStageChanged()
	self:_refreshPower()
end

function FightPlayerFinisherSkillView:_canUse()
	local skillData = self:_getSkillData()

	if skillData then
		local entityMO = FightDataHelper.entityMgr:getById(FightEntityScene.MySideId)

		if not entityMO then
			return
		end

		local powerInfo = entityMO:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

		if not powerInfo then
			return
		end

		self._curSkillId = skillData.skillId

		if not FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount then
			local usedCount = 0

			if usedCount >= FightDataHelper.fieldMgr.playerFinisherInfo.roundUseLimit then
				return
			end

			local needPower = skillData.needPower
			local curPower = powerInfo.num - usedCount * needPower

			if curPower < needPower then
				return
			end

			return true, skillData
		end
	end

	return false
end

function FightPlayerFinisherSkillView:_onClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	local canUse, skillData = self:_canUse()

	if canUse then
		local skillId = skillData.skillId

		self._curSkillId = skillId

		local skillCO = lua_skill.configDict[skillId]
		local mySideList = FightDataHelper.entityMgr:getMyNormalList()
		local mySideSpList = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
		local mySideEntityCount = #mySideList + #mySideSpList

		if skillCO and FightEnum.ShowLogicTargetView[skillCO.logicTarget] and skillCO.targetLimit == FightEnum.TargetLimit.MySide then
			if mySideEntityCount > 1 then
				ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
					fromId = FightEntityScene.MySideId,
					skillId = skillId,
					callback = self._useSkill,
					callbackObj = self
				})

				return
			end

			if mySideEntityCount == 1 then
				self:_useSkill(mySideList[1].id)

				return
			end
		end

		self:_useSkill(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function FightPlayerFinisherSkillView:_useSkill(toId)
	self:_playAudio(20249031)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playPlayerFinisherSkill(self._curSkillId, toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, op)

	FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount = (FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount or 0) + 1

	self:_refreshPower()
end

function FightPlayerFinisherSkillView:_onRefreshPlayerFinisherSkill()
	self:_initSkill()
	self:_refreshPower()
	self:_playChangeAudio()
end

function FightPlayerFinisherSkillView:onOpen()
	self:_initSkill()
	self:_refreshPower()
	self:_playChangeAudio()
end

function FightPlayerFinisherSkillView:_playChangeAudio()
	local curState = self:_canUse()

	if curState ~= self._lastCanUse then
		self._lastCanUse = curState

		self:_playAudio(self._lastCanUse and 20249032 or 20249030)
	end
end

function FightPlayerFinisherSkillView:_initSkill()
	local skillData = self:_getSkillData()

	if skillData then
		local config = lua_skill.configDict[skillData.skillId]

		self._title.text = config.name

		local desc = FightConfig.instance:getEntitySkillDesc(FightEntityScene.MySideId, config, skillData.skillId)

		self._desc.text = HeroSkillModel.instance:skillDesToSpot(desc, "#c56131", "#7c93ad")
	end
end

function FightPlayerFinisherSkillView:_getSkillData()
	local info = FightDataHelper.fieldMgr.playerFinisherInfo

	return info and info.skills[1]
end

function FightPlayerFinisherSkillView:_refreshPower()
	local skillData = self:_getSkillData()
	local entityMO = FightDataHelper.entityMgr:getById(FightEntityScene.MySideId)
	local powerInfo = entityMO and entityMO:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

	if powerInfo then
		gohelper.setActive(self.viewGO, true)

		if not FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount then
			local usedCount = 0

			if skillData then
				if not skillData.needPower then
					local needPower = 0
					local maxPower = powerInfo.max
					local curPower = powerInfo.num
					local finalPower = curPower - usedCount * needPower

					gohelper.setActive(self._used, usedCount > 0)
					gohelper.setActive(self._power, usedCount <= 0 and finalPower > 0)
					gohelper.setActive(self._noPower, usedCount <= 0 and finalPower <= 0)

					for i, powerObj in ipairs(self._powerList) do
						gohelper.setActive(powerObj, i <= maxPower)
						gohelper.setActive(gohelper.findChild(powerObj, "light"), i <= curPower)

						local aniName = i <= finalPower and "idle" or "flash"

						self._aniList[i]:Play(aniName, -1, 0)
					end
				end
			end
		end
	else
		gohelper.setActive(self.viewGO, false)
	end
end

function FightPlayerFinisherSkillView:_playAudio(id)
	AudioMgr.instance:trigger(id)
end

function FightPlayerFinisherSkillView:_onPowerChange(entityId, powerId, oldNum, newNum)
	if entityId == FightEntityScene.MySideId and powerId == FightEnum.PowerType.PlayerFinisherSkill then
		self:_refreshPower()

		if oldNum < newNum then
			for i = oldNum + 1, newNum do
				self._aniList[i]:Play("add")
			end

			self:_playAudio(20249033)
		end

		self:_playChangeAudio()
	end
end

function FightPlayerFinisherSkillView:_onPowerInfoChange(entityId, powerId)
	if entityId == FightEntityScene.MySideId and powerId == FightEnum.PowerType.PlayerFinisherSkill then
		self:_refreshPower()
		self:_playChangeAudio()
	end
end

return FightPlayerFinisherSkillView

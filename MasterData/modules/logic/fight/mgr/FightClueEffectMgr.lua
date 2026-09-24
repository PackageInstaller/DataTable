-- chunkname: @modules/logic/fight/mgr/FightClueEffectMgr.lua

module("modules.logic.fight.mgr.FightClueEffectMgr", package.seeall)

local FightClueEffectMgr = class("FightClueEffectMgr", FightBaseClass)

FightClueEffectMgr.ExistEffect = "buff/buff_weiyi_zhishi"
FightClueEffectMgr.ConsumeEffect = "buff/buff_weiyi_zhishi_jihuo"
FightClueEffectMgr.RemoveDelay = 0.3

function FightClueEffectMgr:onConstructor()
	self.effectDic = {}

	self:com_registFightEvent(FightEvent.OnClueAdd, self._onClueAdd)
	self:com_registFightEvent(FightEvent.OnClueDel, self._onClueDel)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.QTE_BeforeEnterQte, self.onBeforeEnterQte)
	self:com_registFightEvent(FightEvent.QTE_AfterExitQte, self.onAfterExitQte)

	self.focusViewOpen = false

	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish)
	self:com_registMsg(FightMsgId.OnTimelineWorkCreated, self.onTimelineWorkCreated)
	self:com_registMsg(FightMsgId.OnTimelineWorkDestroyed, self.onTimelineWorkDestroyed)
end

function FightClueEffectMgr:_getEffectKey(teamType, position)
	return teamType .. "_" .. position
end

function FightClueEffectMgr:onBeforeEnterQte()
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(false, FightWorkEnterQTE.ActiveKey)
	end
end

function FightClueEffectMgr:onAfterExitQte()
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(true, FightWorkEnterQTE.ActiveKey)
	end
end

function FightClueEffectMgr:_getPositionStandPos(teamType, position)
	local myVertin = FightDataHelper.entityMgr:getMyVertin()
	local stanceId = FightHelper.getEntityStanceId(myVertin)
	local stanceCO = lua_stance.configDict[stanceId]

	if not stanceCO then
		return
	end

	local pos = stanceCO["pos" .. position]

	if not pos or not pos[1] or not pos[2] or not pos[3] then
		return
	end

	return pos[1], pos[2], pos[3]
end

function FightClueEffectMgr:_addEffect(effectName, posX, posY, posZ)
	local vertin = FightGameMgr.entityMgr:getById(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	local effectWrap = vertin.effect:addGlobalEffect(effectName)

	effectWrap:setLocalPos(posX, posY, posZ)

	if self.focusViewOpen then
		effectWrap:setActive(false, "FightClueEffectMgrFightFocusView")
	end

	if effectName == FightClueEffectMgr.ConsumeEffect then
		AudioMgr.instance:trigger(411000046)
	elseif effectName == FightClueEffectMgr.ExistEffect then
		AudioMgr.instance:trigger(411000045)
	end

	return effectWrap
end

function FightClueEffectMgr:_removeEffect(effectWrap)
	local vertin = FightGameMgr.entityMgr:getById(FightEntityScene.MySideId)

	if not vertin or not effectWrap then
		return
	end

	vertin.effect:removeEffect(effectWrap)
end

function FightClueEffectMgr:_onClueAdd(cluePosition, teamType)
	if not cluePosition then
		return
	end

	local key = self:_getEffectKey(teamType, cluePosition.position)

	if self.effectDic[key] then
		return
	end

	local clueArea = FightDataHelper.getClueArea(teamType)
	local positionData = clueArea and clueArea:getPositionData(cluePosition.position)

	if not positionData or positionData:getClueCount() <= 0 then
		return
	end

	local posX, posY, posZ = self:_getPositionStandPos(teamType, cluePosition.position)

	if not posX then
		return
	end

	self.effectDic[key] = self:_addEffect(FightClueEffectMgr.ExistEffect, posX, posY, posZ)
end

function FightClueEffectMgr:_onClueDel(cluePosition, teamType)
	if not cluePosition then
		return
	end

	local posX, posY, posZ = self:_getPositionStandPos(teamType, cluePosition.position)

	if not posX then
		return
	end

	local jihuoWrap = self:_addEffect(FightClueEffectMgr.ConsumeEffect, posX, posY, posZ)
	local key = self:_getEffectKey(teamType, cluePosition.position)
	local clueArea = FightDataHelper.getClueArea(teamType)
	local positionData = clueArea and clueArea:getPositionData(cluePosition.position)

	if positionData and positionData:getClueCount() > 0 then
		return
	end

	local existWrap = self.effectDic[key]

	self.effectDic[key] = nil

	self:com_registTimer(self._removeConsumeEffect, FightClueEffectMgr.RemoveDelay, {
		existWrap = existWrap,
		jihuoWrap = jihuoWrap
	})
end

function FightClueEffectMgr:_removeConsumeEffect(tab)
	self:_removeEffect(tab.existWrap)
	self:_removeEffect(tab.jihuoWrap)
end

function FightClueEffectMgr:_buildFromSnapshot()
	self:_releaseAllEffect()

	local teamTypeList = {
		FightEnum.TeamType.MySide,
		FightEnum.TeamType.EnemySide
	}

	for _, teamType in ipairs(teamTypeList) do
		local clueArea = FightDataHelper.getClueArea(teamType)

		if clueArea then
			for _, positionData in ipairs(clueArea.cluePositions) do
				if positionData:getClueCount() > 0 then
					local posX, posY, posZ = self:_getPositionStandPos(teamType, positionData.position)

					if posX then
						local key = self:_getEffectKey(teamType, positionData.position)

						self.effectDic[key] = self:_addEffect(FightClueEffectMgr.ExistEffect, posX, posY, posZ)
					end
				end
			end
		end
	end
end

function FightClueEffectMgr:_releaseAllEffect()
	for key, effectWrap in pairs(self.effectDic) do
		self:_removeEffect(effectWrap)
	end

	self.effectDic = {}
end

function FightClueEffectMgr:_onFightReconnectLastWork()
	self:_buildFromSnapshot()
end

function FightClueEffectMgr:_onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self.focusViewOpen = true

		for key, effectWrap in pairs(self.effectDic) do
			if effectWrap then
				effectWrap:setActive(false, "FightClueEffectMgrFightFocusView")
			end
		end
	end
end

function FightClueEffectMgr:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightFocusView then
		self.focusViewOpen = false

		for key, effectWrap in pairs(self.effectDic) do
			if effectWrap then
				effectWrap:setActive(true, "FightClueEffectMgrFightFocusView")
			end
		end
	end
end

function FightClueEffectMgr:onTimelineWorkCreated(entityId, skillId, fightStepData, timelineName)
	if FightCardDataHelper.isBigSkill(skillId) then
		for key, effectWrap in pairs(self.effectDic) do
			if effectWrap then
				effectWrap:setActive(false, "FightClueEffectMgrFightFocusView" .. fightStepData.stepUid)
			end
		end
	end
end

function FightClueEffectMgr:onTimelineWorkDestroyed(entityId, skillId, fightStepData, timelineName)
	if FightCardDataHelper.isBigSkill(skillId) then
		for key, effectWrap in pairs(self.effectDic) do
			if effectWrap then
				effectWrap:setActive(true, "FightClueEffectMgrFightFocusView" .. fightStepData.stepUid)
			end
		end
	end
end

function FightClueEffectMgr:onDestructor()
	return
end

return FightClueEffectMgr

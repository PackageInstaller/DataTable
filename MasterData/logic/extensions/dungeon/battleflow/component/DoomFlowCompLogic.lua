-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/component/DoomFlowCompLogic.lua

module("logic.extensions.dungeon.battleflow.component.DoomFlowCompLogic", package.seeall)

local DoomFlowCompLogic = class("DoomFlowCompLogic", IBattleFlowComp, AbstractGlobalReusable)
local kDoomForecastAction = "DoomForecast"

function DoomFlowCompLogic:onInit()
	self._sourceEntityId = false
	self._doomSkillId = false
	self._selectedTargetIndex = false
	self._selectedActionIndex = false
	self._selectedDoomActionIndex = false
	self._selectedTargetEntityIds = false
	self._targetDescriptionList = false
	self._actionDescriptionList = false
end

function DoomFlowCompLogic:onStart()
	self._sourceEntityId = false
	self._doomSkillId = false
	self._selectedTargetEntityIds = {}
	self._targetDescriptionList = {}
	self._actionDescriptionList = {}
	self._selectedTargetIndex = false
	self._selectedActionIndex = false
	self._selectedDoomActionIndex = false
	self._selectedEffectIndex = false
end

function DoomFlowCompLogic:onEnterDone()
	self:_parseForecastInfo()
end

function DoomFlowCompLogic:onClear()
	self._sourceEntityId = false
	self._doomSkillId = false
	self._selectedTargetIndex = false
	self._selectedActionIndex = false
	self._selectedDoomActionIndex = false
	self._selectedEffectIndex = false
	self._selectedTargetEntityIds = false
	self._targetDescriptionList = false
	self._actionDescriptionList = false
end

function DoomFlowCompLogic:setRandomInfo(selectEffectIndex, selectedActionIndex, selectedTargetIndex, selectedDoomActionIndex, selectedTargetEntityIds)
	self._selectedTargetIndex = selectedTargetIndex
	self._selectedActionIndex = selectedActionIndex
	self._selectedEffectIndex = selectEffectIndex
	self._selectedDoomActionIndex = selectedDoomActionIndex

	BattleTableUtil.clearTable(self._selectedTargetEntityIds)
	BattleTableUtil.insertto(self._selectedTargetEntityIds, selectedTargetEntityIds)
end

function DoomFlowCompLogic:getSelectedTargetIndex()
	return self._selectedTargetIndex
end

function DoomFlowCompLogic:getSelectedEffectIndex()
	return self._selectedEffectIndex
end

function DoomFlowCompLogic:getSelectedActionIndex()
	return self._selectedActionIndex
end

function DoomFlowCompLogic:getSelectedDoomActionIndex()
	return self._selectedDoomActionIndex
end

function DoomFlowCompLogic:getSelectedTargetEntityIds()
	return self._selectedTargetEntityIds
end

function DoomFlowCompLogic:getTargetDescription(effectIndex, actionIndex, index)
	local idx = self:_calculateIndex(effectIndex, actionIndex, index)
	local unitMgr = BattleMgr.instance:getUnitMgr()

	if #self._selectedTargetEntityIds > 1 then
		return self._targetDescriptionList[idx] or false
	end

	local unit = unitMgr:getUnit(self._selectedTargetEntityIds[1])

	if not unit then
		return false
	end

	local characterNameCO = DungeonConfig.instance:getDoomForecastCharacterNameCO(unit.property:getEntityCode())
	local names = BattleTableUtil.getTempList()

	if characterNameCO then
		BattleTableUtil.insertto(names, characterNameCO.characterNames)
	end

	if self._targetDescriptionList[idx] then
		table.insert(names, self._targetDescriptionList[idx])
	end

	table.insert(names, unit.property:getName())

	local nameIndex = math.random(#names)
	local showName = names[nameIndex]

	BattleTableUtil.releaseTempList(names)

	return showName
end

function DoomFlowCompLogic:getActionDescription(effectIndex, actionIndex, index)
	local idx = self:_calculateIndex(effectIndex, actionIndex, index)

	return self._actionDescriptionList[idx]
end

function DoomFlowCompLogic:getSourceEntityId()
	return self._sourceEntityId
end

function DoomFlowCompLogic:getDoomSkillId()
	return self._doomSkillId
end

function DoomFlowCompLogic:_parseForecastInfo()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		local skillMOList = unit.skill:getActiveSkillList()

		for _, skillMO in ipairs(skillMOList) do
			if self:_parseDoomSkill(skillMO) then
				self._sourceEntityId = unit.property:getEntityId()
				self._doomSkillId = skillMO:getSkillId()

				return
			end
		end
	end

	if BattleLog.enableError then
		BattleLog.error("Cannot find a valid doom forecast skill")
	end
end

function DoomFlowCompLogic:_parseDoomSkill(skillMO)
	local skillCO = skillMO:getSkillCO()
	local subConfig = skillCO.normalConfig
	local skillEffectList = subConfig.skillEffectList
	local hasDoomForecast = false

	for effectIdx, skillEffect in ipairs(skillEffectList) do
		local actionList = skillEffect.actionList

		for actionIdx, action in ipairs(actionList) do
			local actionCO = ActiveSkillConfig.instance:getSkillEffectActionCO(action.code)

			if actionCO.programming == kDoomForecastAction then
				self:_parseTargetList(effectIdx, actionIdx, action.targetCollectors)
				self:_parseActionList(effectIdx, actionIdx, action.actions)

				hasDoomForecast = true
			end
		end
	end

	return hasDoomForecast
end

function DoomFlowCompLogic:_parseTargetList(effectIdx, actionIdx, targetCollectors)
	for i, targetCO in ipairs(targetCollectors) do
		if targetCO.selected then
			local index = self:_calculateIndex(effectIdx, actionIdx, i)

			self._targetDescriptionList[index] = targetCO.desc
		end
	end
end

function DoomFlowCompLogic:_parseActionList(effectIdx, actionIdx, actions)
	for i, actionCO in ipairs(actions) do
		if actionCO.selected then
			local index = self:_calculateIndex(effectIdx, actionIdx, i)

			self._actionDescriptionList[index] = actionCO.desc
		end
	end
end

function DoomFlowCompLogic:_calculateIndex(effectIdx, actionIdx, index)
	return effectIdx * 1000 + actionIdx * 100 + index
end

return DoomFlowCompLogic

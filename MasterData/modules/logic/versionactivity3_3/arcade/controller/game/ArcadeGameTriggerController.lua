-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameTriggerController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameTriggerController", package.seeall)

local ArcadeGameTriggerController = class("ArcadeGameTriggerController", BaseController)
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall

function ArcadeGameTriggerController:onInit()
	return
end

function ArcadeGameTriggerController:onInitFinish()
	return
end

function ArcadeGameTriggerController:addConstEvents()
	return
end

function ArcadeGameTriggerController:reInit()
	return
end

function ArcadeGameTriggerController:resetTriggerCount()
	if self._triggerCount and self._outSizeMaxSkillIdList then
		local outSkillIdList = self._outSizeMaxSkillIdList

		if self._triggerCount > ArcadeGameEnum.MaxSkillTriggerCount and outSkillIdList and #outSkillIdList > 0 then
			logError(string.format("【街机秀】回合累计触发技能效果已达上限===(%s/%s) 超出技能id列表:%s", self._triggerCount, ArcadeGameEnum.MaxSkillTriggerCount, table.concat(outSkillIdList, "\n")))
		end
	end

	self._triggerCount = 0

	if not self._outSizeMaxSkillIdList or #self._outSizeMaxSkillIdList > 0 then
		self._outSizeMaxSkillIdList = {}
	end
end

function ArcadeGameTriggerController:addTriggerCount()
	self._triggerCount = self._triggerCount + 1

	return self._triggerCount
end

function ArcadeGameTriggerController:addOutSizeSkillId(skillId)
	self._outSizeMaxSkillIdList[#self._outSizeMaxSkillIdList + 1] = skillId

	return self._outSizeMaxSkillIdList
end

local function _clearTargetTempAttrFun(target)
	local attrSetMO = target:getAttrSetMO()

	attrSetMO:clearTempVal()
end

function ArcadeGameTriggerController:_clearTargetTempAttr(target)
	if target then
		xpcall(_clearTargetTempAttrFun, __G__TRACKBACK__, target)
	end
end

function ArcadeGameTriggerController:clearTargetTempAttr(target)
	self:_clearTargetTempAttr(target)
end

function ArcadeGameTriggerController:clearTargetListTempAttr(targetList)
	if not targetList or #targetList <= 0 then
		return
	end

	for i, target in ipairs(targetList) do
		self:_clearTargetTempAttr(target)
	end
end

function ArcadeGameTriggerController:_onTriggerTarget(triggerPoint, target, context)
	local skillList = target:getSkillList()

	if not skillList or #skillList <= 0 then
		return
	end

	context = context or {}
	context.target = target

	local tempList = {}

	tabletool.addValues(tempList, skillList)

	for _, skill in ipairs(tempList) do
		local isActive = skill and skill:getIsActive()

		if isActive then
			skill:trigger(triggerPoint, context)
		end
	end
end

function ArcadeGameTriggerController:triggerTarget(triggerPoint, target, context)
	if self:isOpenLog() then
		logNormal(string.format("ArcadeGameTriggerController:triggerTarget triggerPoint:%s", triggerPoint))
	end

	if self:_isLiveByUnitMO(target) then
		self:_onTriggerTarget(triggerPoint, target, context)
	end
end

function ArcadeGameTriggerController:triggerTargetList(triggerPoint, targetList, context)
	if not targetList or #targetList <= 0 then
		return
	end

	local tempList = {}

	tabletool.addValues(tempList, targetList)

	local sortFunc = self:_getUnitSortFuncByPoint(triggerPoint)

	if sortFunc and #targetList > 1 then
		table.sort(tempList, sortFunc)
	end

	if self:isOpenLog() then
		logNormal(string.format("ArcadeGameTriggerController:triggerTargetList triggerPoint:%s count:%s", triggerPoint, #targetList))
	end

	for _, target in ipairs(tempList) do
		if self:_isLiveByUnitMO(target) then
			self:_onTriggerTarget(triggerPoint, target, context)
		end
	end
end

function ArcadeGameTriggerController:atkTriggerTarget(triggerPoint, attackType, atker, hiterList)
	if self:isOpenLog() then
		logNormal(string.format("ArcadeGameTriggerController:atkTriggerTarget triggerPoint:%s attackType:%s", triggerPoint, attackType))
	end

	local context = {
		attackType = attackType,
		atker = atker,
		hiterList = hiterList
	}

	if self:_isLiveByUnitMO(atker) then
		self:_onTriggerTarget(triggerPoint, atker, context)
	end
end

function ArcadeGameTriggerController:hitTriggerTargetList(triggerPoint, attackType, atker, hiterList)
	if not hiterList or #hiterList <= 0 then
		return
	end

	if self:isOpenLog() then
		logNormal(string.format("ArcadeGameTriggerController:hitTriggerTargetList triggerPoint:%s attackType:%s", triggerPoint, attackType))
	end

	local context = {
		attackType = attackType,
		atker = atker,
		hiterList = hiterList
	}

	for _, target in ipairs(hiterList) do
		if self:_isLiveByUnitMO(target) then
			self:_onTriggerTarget(triggerPoint, target, context)
		end
	end
end

function ArcadeGameTriggerController:deathTriggerTarget(triggerPoint, target, atker)
	if self:isOpenLog() then
		logNormal(string.format("ArcadeGameTriggerController:deathTriggerTarget triggerPoint:%s", triggerPoint))
	end

	local context = {}

	if atker then
		context.atker = atker
	end

	self:_onTriggerTarget(triggerPoint, target, context)
end

function ArcadeGameTriggerController:_isLiveByUnitMO(unitMO)
	if unitMO then
		if unitMO:getIsCanDead() and unitMO:getHp() <= 0 then
			return false
		end

		return true
	end

	return false
end

function ArcadeGameTriggerController:_getUnitSortFuncByPoint(triggerPoint)
	local sortType = ArcadeGameEnum.TriggerPoint2SortType[triggerPoint]

	if not sortType then
		return nil
	end

	if not self._sortFuncMap then
		self._sortFuncMap[ArcadeGameEnum.SortType.DownUpLiftRight] = function(aUnitMO, bUnitMO)
			local ax, ay = aUnitMO:getGridPos()
			local bx, by = bUnitMO:getGridPos()

			if ay ~= by then
				return ay < by
			end

			if ax ~= bx then
				return ax < by
			end
		end
	end

	return self._sortFuncMap[sortType]
end

function ArcadeGameTriggerController:isOpenLog()
	if ArcadeGameEnum.PrintLog or GameResMgr.IsFromEditorDir then
		return true
	end

	return false
end

ArcadeGameTriggerController.instance = ArcadeGameTriggerController.New()

ArcadeGameTriggerController.instance:resetTriggerCount()

return ArcadeGameTriggerController

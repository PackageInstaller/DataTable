-- chunkname: @modules/logic/fight/view/preview/SkillEditorPlayTimelineWork.lua

module("modules.logic.fight.view.preview.SkillEditorPlayTimelineWork", package.seeall)

local SkillEditorPlayTimelineWork = class("SkillEditorPlayTimelineWork", BaseWork)

function SkillEditorPlayTimelineWork:ctor()
	return
end

function SkillEditorPlayTimelineWork:onStart()
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow1, self._stopFlow, self)

	self._completeList = {}
	self._skillCount = 0

	local canplay = false

	self.flow = FlowSequence.New()

	local entityMOs = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)
	local entityMgr = FightGameMgr.entityMgr

	if entityMOs and #entityMOs > 0 then
		for _, entityMO in ipairs(entityMOs) do
			local skillList = self:_getEntitySkillCOList(entityMO)

			if #skillList > 0 then
				for index, skillId in ipairs(skillList) do
					local attackerId = entityMO.id
					local targetId = entityMgr:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id
					local side = FightEnum.EntitySide.MySide
					local targetLimit = FightHelper.getTargetLimits(side, skillId)

					if targetLimit and #targetLimit > 0 and not tabletool.indexOf(targetLimit, targetId) then
						targetId = targetLimit[1]
					end

					local fightStepDataList = SkillEditorStepBuilder.buildFightStepDataList(skillId, attackerId, targetId)

					for _, fightStepData in ipairs(fightStepDataList) do
						self.flow:addWork(FunctionWork.New(function()
							local skillCO = lua_skill.configDict[skillId]
							local name = skillCO.name
							local str = skillId .. "\n" .. string.format("当前技能\n%s\n剩余技能%s/%s", name, #skillList - index, #skillList)

							SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
								skillstr = str
							})
						end, self))
						self.flow:addWork(FightSkillEditorFlow.New(fightStepData))
					end

					self.flow:addWork(FunctionWork.New(function()
						self._skillCount = self._skillCount + 1
					end, self))
					self.flow:addWork(FunctionWork.New(self._checkSkillDone, self, {
						count = #skillList,
						id = entityMO.id
					}))
				end

				canplay = true

				self.flow:addWork(FunctionWork.New(self._checkSkillDone, self, {
					count = #entityMOs
				}))
			end
		end

		if canplay then
			self.flow:start()
		else
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function SkillEditorPlayTimelineWork:_getEntitySkillCOList(entityMO)
	local list = {}
	local nameDict = {}

	for i, skillId in ipairs(entityMO.skillIds) do
		local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, skillId)
		local temp = string.split(timeline, "_")

		if skillId and not string.nilorempty(timeline) and not nameDict[temp[#temp]] then
			nameDict[temp[#temp]] = true

			table.insert(list, skillId)
		end
	end

	local modelIdStr = tostring(entityMO.modelId)

	for _, skillCO in ipairs(lua_skill.configList) do
		local skillIdStr = tostring(skillCO.id)
		local timeline = skillCO.timeline

		if string.find(skillIdStr, modelIdStr) == 1 and not string.nilorempty(timeline) then
			local temp = string.split(timeline, "_")

			if skillCO.id and not string.nilorempty(timeline) and not nameDict[temp[#temp]] then
				nameDict[temp[#temp]] = true

				table.insert(list, skillCO.id)
			end
		end
	end

	return list
end

function SkillEditorPlayTimelineWork:_stopFlow()
	if self.flow and self.flow.status == WorkStatus.Running then
		local workList = self.flow:getWorkList()
		local curWorkIdx = self.flow._curIndex

		for i = curWorkIdx, #workList do
			local work = workList[i]

			work:onDone(true)
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow2, self)
		self:onDone(true)
	end
end

function SkillEditorPlayTimelineWork:_checkSkillDone(param)
	local count = param.count
	local id = param.id

	if not id then
		if #self._completeList == count then
			self:onDone(true)
		end
	elseif self._skillCount == count then
		table.insert(self._completeList, id)

		self._skillCount = 0
	end
end

function SkillEditorPlayTimelineWork:clearWork()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow1, self._stopFlow, self)
end

return SkillEditorPlayTimelineWork

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffTriggerTransPosition.lua

module("logicscene.scene.battle.skills.buffs.BuffTriggerTransPosition", package.seeall)

local BuffTriggerTransPosition = class("BuffTriggerTransPosition", BuffBase)

function BuffTriggerTransPosition:ctor(buffCo, unit, skillId, targetTeamId, changes)
	self.skillId = skillId
	self.targetTeamId = targetTeamId
	self.changes = changes

	local skillCo = BattleConfig.instance:getSkillCo(skillId, unit.modelId)

	if skillCo then
		local take, female = BattleConfig.instance:getSkillAnimTake(skillId, unit.modelId)

		if take then
			local curTake = #take > 0 and take or female

			if curTake then
				self._skillCfgPath = curTake[1]
			end
		end
	end

	BuffTriggerTransPosition.super.ctor(self, buffCo, unit)
end

function BuffTriggerTransPosition:onBuffBegin()
	self._unit.attrs:setTriggerTransPosition(true)

	if string.nilorempty(self._skillCfgPath) then
		self:_onSkillReourcesLoaded()
	else
		local scene = SceneMgr.instance:getCurScene()

		if AMPlayer.IsTakeResLoaded(self._skillCfgPath) then
			scene.resPreLoad:preloadSkill(self.skillId, self._unit.modelId, self._onSkillReourcesLoaded, self)
		else
			local resList = {
				self._skillCfgPath
			}

			scene.resQueue:pushResources(resList, function(loader)
				scene.stage:onSkillResourcesLoaded(loader)
				scene.resPreLoad:preloadSkill(self.skillId, self._unit.modelId, self._onSkillReourcesLoaded, self)
			end)
		end
	end

	BuffTriggerTransPosition.super.onBuffBegin(self)
end

function BuffTriggerTransPosition:_onSkillReourcesLoaded()
	self._isReady = true

	self:_tryTriggerTransPosition()
end

function BuffTriggerTransPosition:_tryTriggerTransPosition()
	if self._isReady and not self._hasPlayedSkill and self:_isAllIdle() and self._unit.battleFlow:isIdle(self._unit) then
		self._hasPlayedSkill = true

		if not string.nilorempty(self._skillCfgPath) then
			local skill = self._unit.skillList:getSkill(self.skillId)

			skill:addListener(self._onPlayEvent, self)
			skill:setAnimEventHandler(self._onHandleAnimEvent, self)
			skill:setSupportEmptyTargets(true)
			self._unit:useSkill(skill, GameEnum.SkillExecuteState.CanExecute, false)
		else
			self:_doTransformPosition()

			self._isDone = true
		end
	end
end

function BuffTriggerTransPosition:_isAllIdle()
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	if units then
		for k, v in pairs(units) do
			for k1, v1 in pairs(v) do
				if v1:isPerformingHuds() then
					return
				end

				if not self._unit.battleFlow:isIdle(v1) and not v1:isDead() then
					return
				end
			end
		end
	end

	return true
end

function BuffTriggerTransPosition:_doTransformPosition()
	local scene = SceneMgr.instance:getCurScene()

	for i = 1, #self.changes do
		local unit = scene.unitFactory:getUnit(self.targetTeamId, checknumber(self.changes[i].id))

		if unit then
			unit:onTransPosition(self.changes[i].newX, self.changes[i].newY)
		end
	end
end

function BuffTriggerTransPosition:update(deltaTime)
	self:_tryTriggerTransPosition()
end

function BuffTriggerTransPosition:onBuffEnd()
	self._unit.attrs:setTriggerTransPosition(false)
	BuffTriggerTransPosition.super.onBuffEnd(self)
end

function BuffTriggerTransPosition:pause()
	if self._isPause then
		return
	end

	self._isPause = true

	self._unit.skillPlayer:pauseAnimation()
end

function BuffTriggerTransPosition:resume()
	if not self._isPause then
		return
	end

	self._isPause = false

	self._unit.skillPlayer:resumeAnimation()
end

function BuffTriggerTransPosition:isDone()
	return self._isDone
end

function BuffTriggerTransPosition:_onPlayEvent(evt)
	if evt == "stop" or evt == "break" then
		self._isDone = true
	end
end

function BuffTriggerTransPosition:_onHandleAnimEvent(evtName, go, param1, param2, param3, param4, param5, param6)
	if evtName == "bullet" or evtName == "hurt" then
		self:_doTransformPosition()

		return
	elseif evtName == "playfmodaudio" then
		return (BattleAnimEvevts.onFmodAudioPlay(go, param1, param2))
	end
end

function BuffTriggerTransPosition:getBuffId()
	return UnitCompBuffList.TriggerTransPosition
end

function BuffTriggerTransPosition:isCustomBuff()
	return true
end

return BuffTriggerTransPosition

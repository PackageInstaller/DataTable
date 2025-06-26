-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleCastSkillComponent.lua

local BattleSkillHit_None = require("IQIGame/Module/Battle/Skill/BattleSkillHit_None")
local BattleSkillHit_MainMultiple = require("IQIGame/Module/Battle/Skill/BattleSkillHit_MainMultiple")
local BattleSkillHit_MainOnce = require("IQIGame/Module/Battle/Skill/BattleSkillHit_MainOnce")
local BattleSkillHit_SubMultiple = require("IQIGame/Module/Battle/Skill/BattleSkillHit_SubMultiple")
local BattleSkillHit_SubOnce = require("IQIGame/Module/Battle/Skill/BattleSkillHit_SubOnce")
local BattleSkillHit_ChangeSkin = require("IQIGame/Module/Battle/Skill/BattleSkillHit_ChangeSkin")
local BattleSkillHit_MainHitAndSub = require("IQIGame/Module/Battle/Skill/BattleSkillHit_MainHitAndSub")
local m = {
	IsComplete = false,
	timelineHitType = 0,
	totalDmg = 0,
	timelineHitShowType = 0,
	hitListenerInstanceID = 0
}

function m.New(castSkills)
	local obj = Clone(m)

	obj:__Init(castSkills)

	return obj
end

function m:__Init(castSkills)
	self.mainSkillQueue = Queue.New()
	self.subSkillDicQueue = {}

	function self.delegateOnTimelineHit(sender, args)
		self:__OnTimelineHit(args)
	end

	GameEntry.LuaEvent:Subscribe(BattleTimelineHitEventArgs.EventId, self.delegateOnTimelineHit)

	if castSkills == nil then
		return
	end

	ForArray(castSkills, function(key, castSkillPOD)
		if castSkillPOD.SkillID <= 0 and castSkillPOD.MainSkillID == 0 then
			return
		end

		if castSkillPOD.MainSkillID == 0 then
			self.mainSkillQueue:Enqueue(castSkillPOD)

			return
		end

		local queue = self.subSkillDicQueue[castSkillPOD.MainSkillID]

		if queue == nil then
			queue = Queue.New()
			self.subSkillDicQueue[castSkillPOD.MainSkillID] = queue
		end

		queue:Enqueue(castSkillPOD)
	end)
end

function m:Play(callback)
	if self.mainSkillQueue.Size == 0 then
		if callback ~= nil then
			callback()
		end

		return
	end

	self.completeCallback = callback

	self:__CastSkill()
end

function m:__CastSkill()
	if self.mainSkillQueue.Size == 0 then
		if self.completeCallback ~= nil then
			self.completeCallback()
		end

		return
	end

	BattleModule.ExecuteDelayDie(function()
		self:__PrepareCastSkill()
	end)
end

function m:__PrepareCastSkill()
	self.curMainSkill = self.mainSkillQueue:Dequeue()

	local subSkillQueue = self.subSkillDicQueue[self.curMainSkill.SkillID]
	local casterUnitData = BattleModule.GetBattleUnitDataByUnitID(self.curMainSkill.CasterID)
	local timelineCid = casterUnitData:GetSkillTimelineCid(self.curMainSkill.SkillID)

	if timelineCid == 0 or timelineCid == nil then
		self:__DoEmptyDisplaySkill(self.curMainSkill, subSkillQueue, function()
			self:__CastSkill()
		end)

		return
	end

	local timelineCfg = CfgTimelineTable[timelineCid]

	if timelineCfg == nil then
		logError("Timeline 配置错误，技能施法者 {2} 找不到 技能 {0} 的 timelineCid {1} 的配置", self.curMainSkill.SkillID, timelineCid, self.curMainSkill.CasterID)

		return
	end

	if timelineCfg.IsHideTile then
		EventDispatcher.Dispatch(EventID.SetBattleTileActiveWithTimelinePlay, false)
	end

	if timelineCfg.ForceHitTarget and not self:__HasShillHitUnit(self.curMainSkill) then
		self.completeCallback()

		return
	end

	self.battleSkillHit = self.__CreateSkillHitComponent(self.curMainSkill, subSkillQueue, timelineCfg)

	self.battleSkillHit:OnSkillPrepare(function()
		self:__DoCastSkill()
	end)
end

function m:__DoEmptyDisplaySkill(mainSkill, subSkillQueue, handler)
	self:__UpdateBattleUnitsDataWithCastSkillPOD(mainSkill)

	if subSkillQueue ~= nil then
		for _ = 1, subSkillQueue.Size do
			local subSkill = subSkillQueue:Dequeue()

			self:__UpdateBattleUnitsDataWithCastSkillPOD(subSkill)
		end
	end

	if handler ~= nil then
		handler()
	end
end

function m:__UpdateBattleUnitsDataWithCastSkillPOD(castSkillPOD)
	if castSkillPOD == nil then
		return
	end

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, castSkillPOD.BeforeUpdateUnits, nil, function()
		return
	end)
	ForPairs(castSkillPOD.SkillHits, function(_, _castSkillPOD)
		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillHit, _castSkillPOD.UpdateUnits, nil, function()
			return
		end)
	end)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, castSkillPOD.AfterUpdateUnits, nil, function()
		return
	end)
end

function m:__DoCastSkill()
	local casterUnitData = BattleModule.GetBattleUnitDataByUnitID(self.curMainSkill.CasterID)
	local skillCfgData = CfgSkillTable[self.curMainSkill.SkillID]

	if BattleTeamActionModule.isCutinOn and casterUnitData.isFriendly and skillCfgData.Cutin then
		EventDispatcher.Dispatch(EventID.BattleShowPlaySkillCutin, self.curMainSkill.CasterID, self.curMainSkill.SkillID, function()
			self:__PlaySkillTimeline()
		end)

		return
	end

	EventDispatcher.Dispatch(EventID.BattleShowPlaySkillNotify, casterUnitData.troopType, self.curMainSkill.SkillID)
	self:__PlaySkillTimeline()
end

function m:__PlaySkillTimeline()
	local skillHitUnits = self:__GetAllSkillHitUnitIDs(self.curMainSkill)

	self.hitListenerInstanceID = BattleTimelineModule.PlaySkillTimeline(self.curMainSkill.CasterID, self.curMainSkill.SkillID, skillHitUnits, function()
		self:__OnTimelineEnd()
	end)
end

function m:__HasShillHitUnit(castSkillPOD)
	for _, hit in pairs(castSkillPOD.SkillHits) do
		if hit.Scope == Constant.UpdateScope.BattleUnit then
			return true
		end
	end

	local subSkillQueue = self.subSkillDicQueue[castSkillPOD.SkillID]

	if subSkillQueue == nil then
		return false
	end

	for i = 1, #subSkillQueue.__list do
		local pod = subSkillQueue.__list[i]

		for _, hit in pairs(pod.SkillHits) do
			if hit.Scope == Constant.UpdateScope.BattleUnit then
				return true
			end
		end
	end

	return false
end

function m:__GetAllSkillHitUnitIDs(castSkillPOD)
	local hits = {}

	for _, hit in pairs(castSkillPOD.SkillHits) do
		if hit.Scope == Constant.UpdateScope.BattleUnit then
			if hits[hit.UnitID] ~= nil then
				hits[hit.UnitID] = hits[hit.UnitID] + 1
			else
				hits[hit.UnitID] = 1
			end
		end
	end

	local subSkillQueue = self.subSkillDicQueue[castSkillPOD.SkillID]

	if subSkillQueue ~= nil then
		for i = 1, #subSkillQueue.__list do
			local pod = subSkillQueue.__list[i]

			for _, hit in pairs(pod.SkillHits) do
				if hit.Scope == Constant.UpdateScope.BattleUnit then
					if hits[hit.UnitID] ~= nil then
						hits[hit.UnitID] = hits[hit.UnitID] + 1
					else
						hits[hit.UnitID] = 1
					end
				end
			end
		end
	end

	return hits
end

function m:__OnTimelineHit(hitEventArgs)
	if hitEventArgs.AttackerEntityID ~= self.hitListenerInstanceID then
		return
	end

	self.battleSkillHit:OnHit(hitEventArgs)
end

function m:__OnTimelineEnd()
	BattleModule.ExecuteDelayDie(function()
		self.battleSkillHit:OnSkillEnd(function()
			self:__CastSkill()
		end)
	end)
end

function m.__CreateSkillHitComponent(mainSkill, subSkillQueue, timelineCfg)
	if timelineCfg.HitType == 1 then
		return BattleSkillHit_MainOnce.New(mainSkill, subSkillQueue, timelineCfg)
	elseif timelineCfg.HitType == 2 then
		return BattleSkillHit_MainMultiple.New(mainSkill, subSkillQueue, timelineCfg)
	elseif timelineCfg.HitType == 3 then
		return BattleSkillHit_SubOnce.New(mainSkill, subSkillQueue, timelineCfg)
	elseif timelineCfg.HitType == 4 then
		return BattleSkillHit_SubMultiple.New(mainSkill, subSkillQueue, timelineCfg)
	elseif timelineCfg.HitType == 5 then
		return BattleSkillHit_ChangeSkin.New(mainSkill, subSkillQueue, timelineCfg)
	elseif timelineCfg.HitType == 6 then
		return BattleSkillHit_MainHitAndSub.New(mainSkill, subSkillQueue, timelineCfg)
	else
		return BattleSkillHit_None.New(mainSkill, subSkillQueue, timelineCfg)
	end
end

function m:Dispose()
	GameEntry.LuaEvent:Unsubscribe(BattleTimelineHitEventArgs.EventId, self.delegateOnTimelineHit)
	EventDispatcher.Dispatch(EventID.SetBattleTileActiveWithTimelinePlay, true)
end

return m

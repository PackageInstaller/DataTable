-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_SubOnce.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_SubOnce = Clone(BattleSkillHitBase)

function BattleSkillHit_SubOnce.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_SubOnce)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_SubOnce:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)
end

function BattleSkillHit_SubOnce:OnHit(hitEventArgs)
	self.hitIndex = self.hitIndex + 1

	if self.hitIndex > 1 then
		logError("Skill {0} Timeline 有多个打击点，和配置不符合", self.mainSkill.SkillID)

		return
	end

	for i = 1, #self.mainSkill.SkillHits do
		self:__DoHitWithBattleSkillHitPOD(hitEventArgs, self.mainSkill.CasterID, self.mainSkill.SkillHits[i])
	end

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, self.mainSkill.AfterUpdateUnits, nil, function()
		return
	end)

	for _ = 1, self.subSkillQueue.Size do
		local subSkill = self.subSkillQueue:Dequeue()

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, subSkill.BeforeUpdateUnits, nil, function()
			return
		end)

		for j = 1, #subSkill.SkillHits do
			self:__DoHitWithBattleSkillHitPOD(hitEventArgs, subSkill.CasterID, subSkill.SkillHits[j])
		end

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, subSkill.AfterUpdateUnits, nil, function()
			return
		end)
	end
end

function BattleSkillHit_SubOnce:OnSkillEnd(callback)
	BattleModule.WaitAllBattleUnitReady(function()
		if callback ~= nil then
			callback()
		end
	end)
end

return BattleSkillHit_SubOnce

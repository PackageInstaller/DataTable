-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_ChangeSkin.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_ChangeSkin = Clone(BattleSkillHitBase)

BattleSkillHit_ChangeSkin.casterID = 0

function BattleSkillHit_ChangeSkin.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_ChangeSkin)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_ChangeSkin:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)

	self.casterID = self.mainSkill.CasterID

	if self.subSkillQueue ~= nil and self.subSkillQueue.Size > 0 then
		logError("主动变身技能配置有误，不允许出现子技能========>> 战斗单位：{0}  技能: {1}", self.mainSkill.CasterID, self.mainSkill.SkillID)
	end
end

function BattleSkillHit_ChangeSkin:__DoSkillPrepare(callback)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, self.mainSkill.BeforeUpdateUnits, nil, function()
		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, self.mainSkill.AfterUpdateUnits, nil, function()
			BattleModule.WaitAllBattleUnitReady(function()
				BattleModule.battleScene:BattleUnitViewSkinPrepareJoinByTimeline(self.casterID)

				if callback ~= nil then
					callback()
				end
			end)
		end)
	end)
end

function BattleSkillHit_ChangeSkin:OnHit(hitEventArgs)
	return
end

function BattleSkillHit_ChangeSkin:__DoSkillEnd(callback)
	BattleModule.battleScene:BattleUnitSkinViewJoinBattleByTimeline(self.casterID)

	if callback ~= nil then
		callback()
	end
end

return BattleSkillHit_ChangeSkin

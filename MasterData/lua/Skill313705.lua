-- 天赋效果313705
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313705 = oo.class(SkillBase)
function Skill313705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill313705:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 313705
	self:SetProtect(SkillEffect[313705], caster, self.card, data, 3000)
end

-- 天赋效果313703
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313703 = oo.class(SkillBase)
function Skill313703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill313703:OnActionBegin(caster, target, data)
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
	-- 313703
	self:SetProtect(SkillEffect[313703], caster, self.card, data, 2000)
end

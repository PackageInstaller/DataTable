-- 天赋效果313704
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313704 = oo.class(SkillBase)
function Skill313704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill313704:OnActionBegin(caster, target, data)
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
	-- 313704
	self:SetProtect(SkillEffect[313704], caster, self.card, data, 2500)
end

-- 能量护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill324001 = oo.class(SkillBase)
function Skill324001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill324001:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 324001
	if self:Rand(2000) then
		self:AddSp(SkillEffect[324001], caster, target, data, 20)
	end
end

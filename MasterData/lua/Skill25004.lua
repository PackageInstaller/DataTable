-- 协击III级（怪物用）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25004 = oo.class(SkillBase)
function Skill25004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill25004:OnActionOver(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 25004
	if self:Rand(3000) then
		self:Help(SkillEffect[25004], caster, target, data, 2,2)
	end
end

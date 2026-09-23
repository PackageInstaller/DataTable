-- 控制词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000060070 = oo.class(SkillBase)
function Skill1000060070:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1000060070:OnAttackOver(caster, target, data)
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000060070
	if self:Rand(6500) then
		self:AlterBufferByID(SkillEffect[1000060070], caster, target, data, 3005,1)
	end
end

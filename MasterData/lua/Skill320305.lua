-- 程式崩溃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320305 = oo.class(SkillBase)
function Skill320305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill320305:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
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
	-- 8491
	local count91 = SkillApi:BuffCount(self, caster, target,2,4,50020)
	-- 8185
	if SkillJudger:Greater(self, caster, target, true,count91,0) then
	else
		return
	end
	-- 320305
	if self:Rand(10000) then
		self:AddBuff(SkillEffect[320305], caster, target, data, 500200302)
	end
end

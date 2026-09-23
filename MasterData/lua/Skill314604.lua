-- 能量螫刺
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314604 = oo.class(SkillBase)
function Skill314604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill314604:OnAttackOver(caster, target, data)
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
	-- 8327
	local erduan = SkillApi:GetValue(self, caster, target,2,"erduan")
	-- 8328
	if SkillJudger:Greater(self, caster, self.card, true,erduan,1) then
	else
		return
	end
	-- 314604
	self:HitAddBuff(SkillEffect[314604], caster, target, data, 6000,3004)
end

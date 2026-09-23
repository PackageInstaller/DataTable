-- 扭曲II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25202 = oo.class(SkillBase)
function Skill25202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill25202:OnAttackOver(caster, target, data)
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
	-- 25202
	self:HitAddBuff(SkillEffect[25202], caster, target, data, 2000,3201)
	-- 252010
	self:ShowTips(SkillEffect[252010], caster, self.card, data, 2,"封印",true,252010)
end

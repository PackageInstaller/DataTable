-- 恶魔之音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323601 = oo.class(SkillBase)
function Skill323601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill323601:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 323601
	if self:Rand(2000) then
		local r = self.card:Rand(4)+1
		if 1 == r then
			-- 323611
			self:HitAddBuff(SkillEffect[323611], caster, target, data, 10000,5004,2)
		elseif 2 == r then
			-- 323612
			self:HitAddBuff(SkillEffect[323612], caster, target, data, 10000,5104,2)
		elseif 3 == r then
			-- 323613
			self:HitAddBuff(SkillEffect[323613], caster, target, data, 10000,5707,2)
		elseif 4 == r then
			-- 323614
			self:HitAddBuff(SkillEffect[323614], caster, target, data, 10000,3006,2)
		end
	end
end

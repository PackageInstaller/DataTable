-- 乘风III级（怪物用）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24504 = oo.class(SkillBase)
function Skill24504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill24504:OnAfterHurt(caster, target, data)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 24504
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[24504], caster, self.card, data, 24504)
		-- 245010
		self:ShowTips(SkillEffect[245010], caster, self.card, data, 2,"乘风",true,245010)
	end
end

-- 第五章小怪被动二
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008015 = oo.class(SkillBase)
function Skill110008015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill110008015:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8094
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 110008015
	self:AddBuff(SkillEffect[110008015], caster, self.card, data, 20801)
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
	-- 208010
	self:ShowTips(SkillEffect[208010], caster, self.card, data, 2,"不屈",true,208010)
end

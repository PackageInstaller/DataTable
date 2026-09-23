-- 不屈III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20803 = oo.class(SkillBase)
function Skill20803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill20803:OnAttackOver(caster, target, data)
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
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 20803
	self:AddBuff(SkillEffect[20803], caster, self.card, data, 20803)
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
	-- 208010
	self:ShowTips(SkillEffect[208010], caster, self.card, data, 2,"不屈",true,208010)
end

-- 击杀目标时NP+20
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010122 = oo.class(SkillBase)
function Skill1100010122:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill1100010122:OnDeath(caster, target, data)
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
	-- 1100010122
	self:AddNp(SkillEffect[1100010122], caster, self.card, data, 20)
	-- 212010
	self:ShowTips(SkillEffect[212010], caster, self.card, data, 2,"收割",true,212010)
end

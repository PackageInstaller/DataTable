-- 破势II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21202 = oo.class(SkillBase)
function Skill21202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill21202:OnDeath(caster, target, data)
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
	-- 21202
	self:AddNp(SkillEffect[21202], caster, self.card, data, 7)
	-- 212010
	self:ShowTips(SkillEffect[212010], caster, self.card, data, 2,"收割",true,212010)
end

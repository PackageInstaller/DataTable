-- 双子宫-卡斯托
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984020701 = oo.class(SkillBase)
function Skill984020701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill984020701:OnAttackBegin(caster, target, data)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 984020702
	self:AddBuff(SkillEffect[984020702], caster, self.card, data, 984020702)
end

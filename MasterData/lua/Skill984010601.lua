-- 双子宫-波拉克斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984010601 = oo.class(SkillBase)
function Skill984010601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill984010601:OnAttackBegin(caster, target, data)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 984010702
	self:AddBuff(SkillEffect[984010702], caster, self.card, data, 984010702)
end

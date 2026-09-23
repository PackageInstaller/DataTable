-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000301 = oo.class(SkillBase)
function Skill984000301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill984000301:OnActionBegin(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 984000301
	self:DelBuffQuality(SkillEffect[984000301], caster, self.card, data, 2,9)
	-- 984000302
	self:AddBuff(SkillEffect[984000302], caster, self.card, data, 984000601)
end

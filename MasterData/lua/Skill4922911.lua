-- 突袭形态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4922911 = oo.class(SkillBase)
function Skill4922911:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4922911:OnBornSpecial(caster, target, data)
	-- 4922911
	self:AddBuff(SkillEffect[4922911], caster, self.card, data, 4922911)
end

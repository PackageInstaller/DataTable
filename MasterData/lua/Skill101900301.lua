-- 嘲讽挑衅
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101900301 = oo.class(SkillBase)
function Skill101900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101900301:DoSkill(caster, target, data)
	-- 101900301
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[101900301], caster, target, data, 5800,3001)
end

-- 技能7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90030701 = oo.class(SkillBase)
function Skill90030701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90030701:DoSkill(caster, target, data)
	-- 20001
	self.order = self.order + 1
	self:AddProgress(SkillEffect[20001], caster, target, data, 300)
	-- 4306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4306], caster, target, data, 4306)
	-- 4406
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4406], caster, target, data, 4406)
end

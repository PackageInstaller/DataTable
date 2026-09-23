-- 领空封锁
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801500401 = oo.class(SkillBase)
function Skill801500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801500401:DoSkill(caster, target, data)
	-- 4801511
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4801511], caster, target, data, 4204)
	-- 4801512
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4801512], caster, target, data, 4604)
end

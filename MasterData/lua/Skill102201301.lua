-- 逆行护盾（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102201301 = oo.class(SkillBase)
function Skill102201301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102201301:DoSkill(caster, target, data)
	-- 102201301
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[102201301], caster, target, data, 102200301,6,6)
end

-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100821 = oo.class(SkillBase)
function Skill912100821:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912100821:DoSkill(caster, target, data)
	-- 912104101
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 913000202
		self.order = self.order + 1
		self:HitAddBuff(SkillEffect[913000202], caster, target, data, 10000,5004)
	elseif 2 == r then
		-- 913000203
		self.order = self.order + 1
		self:HitAddBuff(SkillEffect[913000203], caster, target, data, 10000,5104)
	elseif 3 == r then
		-- 913000204
		self.order = self.order + 1
		self:HitAddBuff(SkillEffect[913000204], caster, target, data, 10000,5204)
	elseif 4 == r then
		-- 913000205
		self.order = self.order + 1
		self:HitAddBuff(SkillEffect[913000205], caster, target, data, 10000,5604)
	end
end

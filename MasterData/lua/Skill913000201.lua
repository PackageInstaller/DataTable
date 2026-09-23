-- 非常规拟态海生物·Ⅲ型_Mimic sea creature type Ⅲ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913000201 = oo.class(SkillBase)
function Skill913000201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913000201:DoSkill(caster, target, data)
	-- 913000201
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

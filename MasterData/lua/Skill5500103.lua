-- 溯源探查第三期ex修改技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500103 = oo.class(SkillBase)
function Skill5500103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill5500103:OnRoundBegin(caster, target, data)
	-- 5500103
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 55001031
		self:AddBuff(SkillEffect[55001031], caster, self.card, data, 55001031)
	elseif 2 == r then
		-- 55001032
		self:AddBuff(SkillEffect[55001032], caster, self.card, data, 55001032)
	elseif 3 == r then
		-- 55001033
		self:AddBuff(SkillEffect[55001033], caster, self.card, data, 55001033)
	elseif 4 == r then
		-- 55001034
		self:AddBuff(SkillEffect[55001034], caster, self.card, data, 55001034)
	end
end

-- 坚韧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100403 = oo.class(SkillBase)
function Skill4100403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4100403:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100403
	self:AddBuff(SkillEffect[4100403], caster, self.card, data, 4100403)
	-- 4100406
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4100406], caster, target, data, 4100406)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4100403:OnBornSpecial(caster, target, data)
	-- 4100406
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4100406], caster, target, data, 4100406)
	end
end

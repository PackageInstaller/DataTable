-- 莫拉鲁塔4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337802 = oo.class(SkillBase)
function Skill337802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337802:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337802
	local targets = SkillFilter:Group(self, caster, target, 3,6)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[337802], caster, target, data, 337802)
	end
end

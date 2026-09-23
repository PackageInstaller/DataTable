-- 裂空2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334301 = oo.class(SkillBase)
function Skill334301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334301:OnBorn(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 334301
	local targets = SkillFilter:Group(self, caster, target, 3,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[334301], caster, target, data, 334301)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill334301:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 334301
	local targets = SkillFilter:Group(self, caster, target, 3,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[334301], caster, target, data, 334301)
	end
end

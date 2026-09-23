-- 永境战域怪物buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6100001 = oo.class(SkillBase)
function Skill6100001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill6100001:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 61000001
	self:AddBuff(SkillEffect[61000001], caster, caster, data, 6100001)
end
-- 入场时
function Skill6100001:OnBorn(caster, target, data)
	-- 61000002
	self:LimitAddStep(SkillEffect[61000002], caster, target, data, 25)
end

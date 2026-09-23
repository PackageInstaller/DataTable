-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710100402 = oo.class(SkillBase)
function Skill710100402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill710100402:CanSummon()
	return self.card:CanSummon(10000014,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill710100402:DoSkill(caster, target, data)
	-- 40005
	self.order = self.order + 1
	self:Summon(SkillEffect[40005], caster, target, data, 10000014,1,{4,1},{progress=1001})
end

-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600501 = oo.class(SkillBase)
function Skill703600501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill703600501:CanSummon()
	return self.card:CanSummon(10000027,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill703600501:DoSkill(caster, target, data)
	-- 40019
	self.order = self.order + 1
	self:Summon(SkillEffect[40019], caster, target, data, 10000027,1,{4,1},{progress=1001})
end

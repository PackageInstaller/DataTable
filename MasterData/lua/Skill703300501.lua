-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703300501 = oo.class(SkillBase)
function Skill703300501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill703300501:CanSummon()
	return self.card:CanSummon(10000026,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill703300501:DoSkill(caster, target, data)
	-- 40018
	self.order = self.order + 1
	self:Summon(SkillEffect[40018], caster, target, data, 10000026,1,{4,1},{progress=1001})
end

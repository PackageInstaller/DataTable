-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780400501 = oo.class(SkillBase)
function Skill780400501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill780400501:CanSummon()
	return self.card:CanSummonUnite(10000038,1,{4,1},{progress=1010})
end
-- 执行技能
function Skill780400501:DoSkill(caster, target, data)
	-- 40033
	self.order = self.order + 1
	self:SummonUnite(SkillEffect[40033], caster, target, data, 10000038,1,{4,1},{progress=1010})
end

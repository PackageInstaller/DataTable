-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill799980501 = oo.class(SkillBase)
function Skill799980501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill799980501:CanSummon()
	return self.card:CanSummonUnite(10000030,1,{4,1},{progress=1010})
end
-- 执行技能
function Skill799980501:DoSkill(caster, target, data)
	-- 40029
	self.order = self.order + 1
	self:SummonUnite(SkillEffect[40029], caster, target, data, 10000030,1,{4,1},{progress=1010})
end

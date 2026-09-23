-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill799980401 = oo.class(SkillBase)
function Skill799980401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill799980401:CanSummon()
	return self.card:CanSummon(10000033,1,{4,1},{progress=100})
end
-- 执行技能
function Skill799980401:DoSkill(caster, target, data)
	-- 40027
	self.order = self.order + 1
	self:Summon(SkillEffect[40027], caster, target, data, 10000033,1,{4,1},{progress=100})
end

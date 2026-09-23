-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100400401 = oo.class(SkillBase)
function Skill100400401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill100400401:CanSummon()
	return self.card:CanSummon(10000022,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill100400401:DoSkill(caster, target, data)
	-- 40016
	self.order = self.order + 1
	self:Summon(SkillEffect[40016], caster, target, data, 10000022,1,{4,1},{progress=1001})
end

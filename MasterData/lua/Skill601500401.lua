-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601500401 = oo.class(SkillBase)
function Skill601500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill601500401:CanSummon()
	return self.card:CanSummon(10000031,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill601500401:DoSkill(caster, target, data)
	-- 40022
	self.order = self.order + 1
	self:Summon(SkillEffect[40022], caster, target, data, 10000031,1,{4,1},{progress=1001})
end

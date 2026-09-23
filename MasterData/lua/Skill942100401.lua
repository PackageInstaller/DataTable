-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942100401 = oo.class(SkillBase)
function Skill942100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill942100401:CanSummon()
	return self.card:CanSummon(10000032,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill942100401:DoSkill(caster, target, data)
	-- 40024
	self.order = self.order + 1
	self:Summon(SkillEffect[40024], caster, target, data, 10000032,1,{4,1},{progress=1001})
end

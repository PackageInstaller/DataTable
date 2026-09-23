-- 行进弹退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902100101 = oo.class(SkillBase)
function Skill902100101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902100101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 902100101
	self.order = self.order + 1
	self:AddProgress(SkillEffect[902100101], caster, target, data, -100)
end

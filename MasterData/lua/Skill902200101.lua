-- 修复弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902200101 = oo.class(SkillBase)
function Skill902200101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902200101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 902200101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[902200101], caster, target, data, 5702)
end

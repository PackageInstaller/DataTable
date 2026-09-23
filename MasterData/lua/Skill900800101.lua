-- 能量填充
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill900800101 = oo.class(SkillBase)
function Skill900800101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill900800101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900800201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900800201], caster, self.card, data, 900800201)
end

-- 红技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750200201 = oo.class(SkillBase)
function Skill750200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750200201:DoSkill(caster, target, data)
	-- 750200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750200201], caster, target, data, 750200202)
end
-- 行动结束
function Skill750200201:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 750200211
	self:AddBuffCount(SkillEffect[750200211], caster, self.card, data, 750200201,1,20)
end

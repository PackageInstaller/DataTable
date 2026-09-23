-- 红技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750200202 = oo.class(SkillBase)
function Skill750200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750200202:DoSkill(caster, target, data)
	-- 750200202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750200202], caster, target, data, 750200203)
end
-- 行动结束
function Skill750200202:OnActionOver(caster, target, data)
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
	-- 750200212
	self:AddBuffCount(SkillEffect[750200212], caster, self.card, data, 750200201,2,20)
end

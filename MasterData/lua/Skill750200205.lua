-- 红技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750200205 = oo.class(SkillBase)
function Skill750200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750200205:DoSkill(caster, target, data)
	-- 750200205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750200205], caster, target, data, 750200204)
end
-- 行动结束
function Skill750200205:OnActionOver(caster, target, data)
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
	-- 750200215
	self:AddBuffCount(SkillEffect[750200215], caster, self.card, data, 750200201,5,20)
end

-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700301309 = oo.class(SkillBase)
function Skill700301309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700301309:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageSpecial(SkillEffect[13004], caster, target, data, 0.25,4)
end
-- 行动结束
function Skill700301309:OnActionOver(caster, target, data)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	self:Cure(SkillEffect[8554], caster, self.card, data, 1,math.max(count22*0.08,0.08))
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	self:AddBuff(SkillEffect[8555], caster, self.card, data, 2150+count22)
end

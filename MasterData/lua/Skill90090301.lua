-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90090301 = oo.class(SkillBase)
function Skill90090301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90090301:OnCrit(caster, target)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AddNp(SkillEffect[70002], caster, caster, data, 10)
end
-- 执行技能
function Skill90090301:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end

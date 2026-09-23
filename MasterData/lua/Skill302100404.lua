-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302100404 = oo.class(SkillBase)
function Skill302100404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302100404:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[8378], caster, target, data, 2302)
end
-- 伤害前
function Skill302100404:OnBefourHurt(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if self:Rand(3500) then
		self:DelBufferGroup(SkillEffect[302100301], caster, target, data, 2,1)
	end
end

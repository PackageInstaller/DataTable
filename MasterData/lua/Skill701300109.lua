-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701300109 = oo.class(SkillBase)
function Skill701300109:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701300109:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[701300101], caster, target, data, 701300101)
end
-- 行动开始
function Skill701300109:OnActionBegin(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferType(SkillEffect[701300102], caster, target, data, 70130)
	end
end

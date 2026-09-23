-- 影鞘轰击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911400501 = oo.class(SkillBase)
function Skill911400501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911400501:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 行动结束
function Skill911400501:OnActionOver(caster, target, data)
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
	-- 911400502
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[911400502], caster, target, data, 2114)
	end
end

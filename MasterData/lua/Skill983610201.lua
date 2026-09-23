-- 摩羯座小怪1技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983610201 = oo.class(SkillBase)
function Skill983610201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983610201:DoSkill(caster, target, data)
	-- 983610206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983610206], caster, self.card, data, 983610206)
end
-- 行动结束
function Skill983610201:OnActionOver(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 983610211
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuffCount(SkillEffect[983610211], caster, target, data, 983610211,1,20)
	end
end

-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704200201 = oo.class(SkillBase)
function Skill704200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704200201:DoSkill(caster, target, data)
	-- 704200211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704200211], caster, target, data, 704200211)
end
-- 行动结束
function Skill704200201:OnActionOver(caster, target, data)
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
	-- 704200201
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[704200201], caster, target, data, 704200201)
	end
end
-- 行动结束2
function Skill704200201:OnActionOver2(caster, target, data)
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
	-- 704200221
	self:AddSp(SkillEffect[704200221], caster, self.card, data, 10)
end

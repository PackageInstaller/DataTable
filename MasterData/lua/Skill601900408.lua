-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900408 = oo.class(SkillBase)
function Skill601900408:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900408:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 回合开始时
function Skill601900408:OnRoundBegin(caster, target, data)
	local targets = SkillFilter:MinAttr(self, caster, target, 3,"hp",2)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[601900303], caster, target, data, 10000)
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AutoFight(SkillEffect[601900304], caster, self.card, data, nil)
end
-- 行动结束
function Skill601900408:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[601900305], caster, self.card, data, 1008)
end

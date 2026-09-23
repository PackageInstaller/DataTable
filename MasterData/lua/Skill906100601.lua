-- 钢体
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill906100601 = oo.class(SkillBase)
function Skill906100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill906100601:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害后
function Skill906100601:OnAfterHurt(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 906100601
	self:AddBuffCount(SkillEffect[906100601], caster, target, data, 906100601,1,10)
end
-- 回合开始时
function Skill906100601:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 906100602
	self:DelBufferForce(SkillEffect[906100602], caster, self.card, data, 906100601)
end
